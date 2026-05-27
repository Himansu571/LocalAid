from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, TextAreaField, SelectField, SubmitField, IntegerField, FloatField
from wtforms.validators import DataRequired, Email, EqualTo, ValidationError, Length, Optional, Regexp
from app.models import User

class LoginForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')

class SignupForm(FlaskForm):
    username = StringField('Username', validators=[
        DataRequired(),
        Length(min=4, max=80, message='Username must be between 4 and 80 characters')
    ])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[
        DataRequired(),
        Length(min=6, message='Password must be at least 6 characters')
    ])
    confirm_password = PasswordField('Confirm Password', validators=[
        DataRequired(),
        EqualTo('password', message='Passwords must match')
    ])
    submit = SubmitField('Sign Up')
    
    def validate_email(self, field):
        if User.query.filter_by(email=field.data).first():
            raise ValidationError('Email already registered.')
    
    def validate_username(self, field):
        if User.query.filter_by(username=field.data).first():
            raise ValidationError('Username already taken.')

class AdminLoginForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Admin Login')

class ServiceForm(FlaskForm):
    name = StringField('Service Name', validators=[DataRequired(), Length(min=2, max=120)])
    description = TextAreaField('Description', validators=[Optional()])
    icon = StringField('Icon Class (Bootstrap Icons)', validators=[Optional()])
    submit = SubmitField('Save Service')

class LocationForm(FlaskForm):
    name = StringField('Location Name', validators=[DataRequired(), Length(min=2, max=100)])
    description = TextAreaField('Description', validators=[Optional()])
    submit = SubmitField('Save Location')

class ServiceProviderForm(FlaskForm):
    provider_name = StringField('Provider Name', validators=[DataRequired(), Length(min=2, max=150)])
    service_id = SelectField('Service', coerce=int, validators=[DataRequired()])
    location_id = SelectField('Location', coerce=int, validators=[DataRequired()])
    contact_info = StringField('Phone Number', validators=[
        DataRequired(),
        Regexp(r'^\d{10}$', message='Phone number must be 10 digits')
    ])
    email = StringField('Email', validators=[Optional(), Email()])
    description = TextAreaField('Description', validators=[Optional()])
    rating = FloatField('Rating', validators=[Optional()])
    submit = SubmitField('Save Provider')

class SearchForm(FlaskForm):
    location = SelectField('Location', coerce=int, validators=[DataRequired()])
    submit = SubmitField('Search')