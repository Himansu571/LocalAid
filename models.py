from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    bookmarks = db.relationship('Bookmark', backref='user', lazy=True, cascade='all, delete-orphan')
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    def __repr__(self):
        return f'<User {self.username}>'


class Service(db.Model):
    __tablename__ = 'services'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), unique=True, nullable=False)
    description = db.Column(db.Text, nullable=True)
    icon = db.Column(db.String(50), default='wrench')  # Bootstrap icon class
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    providers = db.relationship('ServiceProvider', backref='service', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Service {self.name}>'


class Location(db.Model):
    __tablename__ = 'locations'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    description = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    providers = db.relationship('ServiceProvider', backref='location', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Location {self.name}>'


class ServiceProvider(db.Model):
    __tablename__ = 'service_providers'
    
    id = db.Column(db.Integer, primary_key=True)
    service_id = db.Column(db.Integer, db.ForeignKey('services.id'), nullable=False)
    location_id = db.Column(db.Integer, db.ForeignKey('locations.id'), nullable=False)
    provider_name = db.Column(db.String(150), nullable=False)
    contact_info = db.Column(db.String(15), nullable=False)  # Phone number
    email = db.Column(db.String(120), nullable=True)
    rating = db.Column(db.Float, default=0.0)
    description = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    bookmarks = db.relationship('Bookmark', backref='provider', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<ServiceProvider {self.provider_name}>'


class Bookmark(db.Model):
    __tablename__ = 'bookmarks'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    provider_id = db.Column(db.Integer, db.ForeignKey('service_providers.id'), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Bookmark {self.user_id} - {self.provider_id}>'