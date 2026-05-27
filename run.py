import os
import sys

# Add current directory to Python path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

from app import create_app, db
from app.models import User, Service, Location, ServiceProvider

# Create Flask app instance
app = create_app(os.environ.get('FLASK_ENV', 'development'))

@app.shell_context_processor
def make_shell_context():
    """Make models available in Flask shell"""
    return {
        'db': db,
        'User': User,
        'Service': Service,
        'Location': Location,
        'ServiceProvider': ServiceProvider
    }

@app.errorhandler(404)
def not_found_error(error):
    """Handle 404 errors"""
    return {'error': 'Page not found'}, 404

@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    db.session.rollback()
    return {'error': 'Internal server error'}, 500

if __name__ == '__main__':
    print("\n" + "="*60)
    print("🚀 LocalAid Flask Application Starting")
    print("="*60)
    print("\n📍 Visit: http://localhost:5000")
    print("🔐 Admin: http://localhost:5000/admin/login")
    print("📧 Admin Email: admin@localaid.com")
    print("🔑 Admin Password: Admin@123")
    print("\n" + "="*60 + "\n")
    
    app.run(
        debug=True,
        host='0.0.0.0',
        port=5000,
        use_reloader=True
    )