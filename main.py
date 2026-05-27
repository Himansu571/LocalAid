from flask import Blueprint, render_template, request, jsonify, session, redirect, url_for
from app.models import db, Service, Location, ServiceProvider
from sqlalchemy import or_

main_bp = Blueprint('main', __name__)

# Default services
DEFAULT_SERVICES = [
    {'name': 'Plumber', 'icon': 'droplet'},
    {'name': 'Electrician', 'icon': 'lightning-charge'},
    {'name': 'Tutor', 'icon': 'book'},
    {'name': 'Doctor', 'icon': 'heart'},
    {'name': 'Driver', 'icon': 'car-front'},
    {'name': 'Beauty Salon', 'icon': 'scissors'},
    {'name': 'Auto Service', 'icon': 'tools'},
    {'name': 'Home Cleaning', 'icon': 'house-check'}
]

# Default locations
DEFAULT_LOCATIONS = ['Puri', 'Cuttack', 'Bhubaneswar', 'Rourkela', 'Balasore', 'Sambalpur', 'Berhampur', 'Jajpur']

@main_bp.route('/')
def home():
    # Initialize default data if not exists
    if Service.query.count() == 0:
        for service_data in DEFAULT_SERVICES:
            service = Service(name=service_data['name'], icon=service_data['icon'])
            db.session.add(service)
        db.session.commit()
    
    if Location.query.count() == 0:
        for location_name in DEFAULT_LOCATIONS:
            location = Location(name=location_name)
            db.session.add(location)
        db.session.commit()
    
    # Get statistics
    services_count = Service.query.count()
    locations_count = Location.query.count()
    providers_count = ServiceProvider.query.count()
    
    # Get featured providers
    featured_providers = ServiceProvider.query.order_by(ServiceProvider.rating.desc()).limit(6).all()
    
    locations = Location.query.all()
    
    return render_template('home.html', 
                         services_count=services_count,
                         locations_count=locations_count,
                         providers_count=providers_count,
                         featured_providers=featured_providers,
                         locations=locations,
                         is_logged_in='user_id' in session)

@main_bp.route('/search', methods=['GET', 'POST'])
def search():
    locations = Location.query.all()
    services = Service.query.all()
    results = []
    
    if request.method == 'POST':
        location_id = request.form.get('location_id')
        
        if location_id:
            results = ServiceProvider.query.filter_by(location_id=location_id).all()
    
    return render_template('search.html', 
                         locations=locations,
                         services=services,
                         results=results,
                         is_logged_in='user_id' in session)

@main_bp.route('/about')
def about():
    return render_template('about.html', is_logged_in='user_id' in session)

@main_bp.route('/contact')
def contact():
    return render_template('contact.html', is_logged_in='user_id' in session)