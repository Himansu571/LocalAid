from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import db, Service, Location, ServiceProvider, User
from app.forms import AdminLoginForm, ServiceForm, LocationForm
from functools import wraps

admin_bp = Blueprint('admin', __name__)

# Fixed admin credentials
ADMIN_EMAIL = 'admin@localaid.com'
ADMIN_PASSWORD = 'hima@123'

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'admin_id' not in session:
            flash('Admin login required.', 'warning')
            return redirect(url_for('admin.admin_login'))
        return f(*args, **kwargs)
    return decorated_function

@admin_bp.route('/login', methods=['GET', 'POST'])
def admin_login():
    """Admin login page with fixed credentials"""
    form = AdminLoginForm()
    
    if form.validate_on_submit():
        if form.email.data == ADMIN_EMAIL and form.password.data == ADMIN_PASSWORD:
            session['admin_id'] = 'admin'
            session['admin_email'] = ADMIN_EMAIL
            flash('Admin login successful!', 'success')
            return redirect(url_for('admin.admin_dashboard'))
        else:
            flash('Invalid admin credentials.', 'danger')
    
    return render_template('admin/admin_login.html', form=form, is_logged_in='user_id' in session)

@admin_bp.route('/dashboard')
@admin_required
def admin_dashboard():
    """Admin dashboard with statistics"""
    services_count = Service.query.count()
    locations_count = Location.query.count()
    providers_count = ServiceProvider.query.count()
    users_count = User.query.count()
    
    recent_providers = ServiceProvider.query.order_by(ServiceProvider.created_at.desc()).limit(5).all()
    
    return render_template('admin/admin_dashboard.html',
                         services_count=services_count,
                         locations_count=locations_count,
                         providers_count=providers_count,
                         users_count=users_count,
                         recent_providers=recent_providers,
                         is_logged_in='user_id' in session)

# ===== SERVICE MANAGEMENT =====
@admin_bp.route('/services')
@admin_required
def manage_services():
    """List all services"""
    services = Service.query.all()
    return render_template('admin/manage_services.html', services=services, is_logged_in='user_id' in session)

@admin_bp.route('/services/add', methods=['GET', 'POST'])
@admin_required
def add_service():
    """Add new service"""
    form = ServiceForm()
    if form.validate_on_submit():
        # Check if service already exists
        existing = Service.query.filter_by(name=form.name.data).first()
        if existing:
            flash('Service already exists!', 'warning')
            return redirect(url_for('admin.manage_services'))
        
        service = Service(
            name=form.name.data,
            description=form.description.data,
            icon=form.icon.data or 'wrench'
        )
        db.session.add(service)
        db.session.commit()
        
        flash('Service added successfully!', 'success')
        return redirect(url_for('admin.manage_services'))
    
    return render_template('admin/add_service.html', form=form, is_logged_in='user_id' in session)

@admin_bp.route('/services/<int:service_id>/edit', methods=['GET', 'POST'])
@admin_required
def edit_service(service_id):
    """Edit existing service"""
    service = Service.query.get_or_404(service_id)
    form = ServiceForm()
    
    if form.validate_on_submit():
        service.name = form.name.data
        service.description = form.description.data
        service.icon = form.icon.data or 'wrench'
        
        db.session.commit()
        flash('Service updated successfully!', 'success')
        return redirect(url_for('admin.manage_services'))
    elif request.method == 'GET':
        form.name.data = service.name
        form.description.data = service.description
        form.icon.data = service.icon
    
    return render_template('admin/edit_service.html', form=form, service=service, is_logged_in='user_id' in session)

@admin_bp.route('/services/<int:service_id>/delete', methods=['POST'])
@admin_required
def delete_service(service_id):
    """Delete service"""
    service = Service.query.get_or_404(service_id)
    
    # Delete associated providers
    ServiceProvider.query.filter_by(service_id=service_id).delete()
    
    db.session.delete(service)
    db.session.commit()
    
    flash('Service deleted successfully!', 'success')
    return redirect(url_for('admin.manage_services'))

# ===== LOCATION MANAGEMENT =====
@admin_bp.route('/locations')
@admin_required
def manage_locations():
    """List all locations"""
    locations = Location.query.all()
    return render_template('admin/manage_locations.html', locations=locations, is_logged_in='user_id' in session)

@admin_bp.route('/locations/add', methods=['GET', 'POST'])
@admin_required
def add_location():
    """Add new location"""
    form = LocationForm()
    if form.validate_on_submit():
        # Check if location already exists
        existing = Location.query.filter_by(name=form.name.data).first()
        if existing:
            flash('Location already exists!', 'warning')
            return redirect(url_for('admin.manage_locations'))
        
        location = Location(
            name=form.name.data,
            description=form.description.data
        )
        db.session.add(location)
        db.session.commit()
        
        flash('Location added successfully!', 'success')
        return redirect(url_for('admin.manage_locations'))
    
    return render_template('admin/add_location.html', form=form, is_logged_in='user_id' in session)

@admin_bp.route('/locations/<int:location_id>/edit', methods=['GET', 'POST'])
@admin_required
def edit_location(location_id):
    """Edit existing location"""
    location = Location.query.get_or_404(location_id)
    form = LocationForm()
    
    if form.validate_on_submit():
        location.name = form.name.data
        location.description = form.description.data
        
        db.session.commit()
        flash('Location updated successfully!', 'success')
        return redirect(url_for('admin.manage_locations'))
    elif request.method == 'GET':
        form.name.data = location.name
        form.description.data = location.description
    
    return render_template('admin/edit_location.html', form=form, location=location, is_logged_in='user_id' in session)

@admin_bp.route('/locations/<int:location_id>/delete', methods=['POST'])
@admin_required
def delete_location(location_id):
    """Delete location"""
    location = Location.query.get_or_404(location_id)
    
    # Delete associated providers
    ServiceProvider.query.filter_by(location_id=location_id).delete()
    
    db.session.delete(location)
    db.session.commit()
    
    flash('Location deleted successfully!', 'success')
    return redirect(url_for('admin.manage_locations'))

@admin_bp.route('/logout')
def admin_logout():
    """Admin logout"""
    session.pop('admin_id', None)
    session.pop('admin_email', None)
    flash('Admin logout successful!', 'info')
    return redirect(url_for('admin.admin_login'))
