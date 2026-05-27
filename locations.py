from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import db, Location, ServiceProvider
from app.forms import LocationForm
from app.routes.auth import login_required

locations_bp = Blueprint('locations', __name__)

@locations_bp.route('/list')
def list_locations():
    """Display all locations"""
    locations = Location.query.all()
    services_count = {}
    
    # Count services for each location
    for location in locations:
        services_count[location.id] = ServiceProvider.query.filter_by(location_id=location.id).count()
    
    return render_template('locations.html',
                         locations=locations,
                         services_count=services_count,
                         is_logged_in='user_id' in session)

@locations_bp.route('/<int:location_id>', methods=['GET'])
def location_detail(location_id):
    """Show providers in a specific location with service filter"""
    location = Location.query.get_or_404(location_id)
    
    # Get all providers in this location
    providers = ServiceProvider.query.filter_by(location_id=location_id).all()
    
    # Filter by service if specified
    service_id = request.args.get('service_id')
    if service_id:
        providers = [p for p in providers if p.service_id == int(service_id)]
    
    # Get unique services available in this location
    services = set()
    for provider in ServiceProvider.query.filter_by(location_id=location_id).all():
        services.add(provider.service)
    
    return render_template('location_detail.html',
                         location=location,
                         providers=providers,
                         services=list(services),
                         selected_service=service_id,
                         is_logged_in='user_id' in session)