from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import db, Service, ServiceProvider, Location
from app.forms import ServiceProviderForm
from app.routes.auth import login_required

services_bp = Blueprint('services', __name__)

@services_bp.route('/list')
def list_services():
    """Display all services"""
    services = Service.query.all()
    locations = Location.query.all()
    return render_template('categories.html', 
                         services=services,
                         locations=locations,
                         is_logged_in='user_id' in session)

@services_bp.route('/<int:service_id>', methods=['GET', 'POST'])
def service_detail(service_id):
    """Show providers for a specific service with location filter"""
    service = Service.query.get_or_404(service_id)
    locations = Location.query.all()
    
    # Get all providers for this service
    providers = ServiceProvider.query.filter_by(service_id=service_id).all()
    
    # Filter by location if specified
    location_id = request.args.get('location_id')
    if location_id:
        providers = [p for p in providers if p.location_id == int(location_id)]
    
    return render_template('service_detail.html',
                         service=service,
                         providers=providers,
                         locations=locations,
                         selected_location=location_id,
                         is_logged_in='user_id' in session)

@services_bp.route('/add-provider', methods=['GET', 'POST'])
@login_required
def add_provider():
    """User can add a service provider"""
    form = ServiceProviderForm()
    form.service_id.choices = [(s.id, s.name) for s in Service.query.all()]
    form.location_id.choices = [(l.id, l.name) for l in Location.query.all()]
    
    if form.validate_on_submit():
        provider = ServiceProvider(
            service_id=form.service_id.data,
            location_id=form.location_id.data,
            provider_name=form.provider_name.data,
            contact_info=form.contact_info.data,
            email=form.email.data,
            description=form.description.data,
            rating=form.rating.data or 0.0
        )
        
        db.session.add(provider)
        db.session.commit()
        
        flash('Service provider added successfully!', 'success')
        return redirect(url_for('main.home'))
    
    return render_template('add_provider.html', form=form, is_logged_in='user_id' in session)