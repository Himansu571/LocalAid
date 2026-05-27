from flask import Blueprint, render_template, session, redirect, url_for, flash
from app.models import db, User, Bookmark, ServiceProvider
from app.routes.auth import login_required

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/')
@login_required
def user_dashboard():
    """User dashboard page"""
    user_id = session.get('user_id')
    user = User.query.get(user_id)

    # Get user's bookmarks (with providers via relationship)
    bookmarks = Bookmark.query.filter_by(user_id=user_id).all()

    return render_template(
        'dashboard.html',
        user=user,
        bookmarks=bookmarks,
        bookmarks_count=len(bookmarks),
        is_logged_in=True
    )


@dashboard_bp.route('/bookmark/<int:provider_id>', methods=['POST'])
@login_required
def add_bookmark(provider_id):
    """Add provider to bookmarks"""
    user_id = session.get('user_id')
    
    # Check if already bookmarked
    existing = Bookmark.query.filter_by(user_id=user_id, provider_id=provider_id).first()
    if existing:
        flash('Already bookmarked!', 'info')
        return redirect(url_for('main.home'))
    
    # Check if provider exists
    provider = ServiceProvider.query.get_or_404(provider_id)
    
    bookmark = Bookmark(user_id=user_id, provider_id=provider_id)
    db.session.add(bookmark)
    db.session.commit()
    
    flash('Added to bookmarks!', 'success')
    return redirect(url_for('dashboard.user_dashboard'))

@dashboard_bp.route('/bookmark/<int:bookmark_id>/delete', methods=['POST'])
@login_required
def delete_bookmark(bookmark_id):
    """Remove provider from bookmarks"""
    user_id = session.get('user_id')
    
    bookmark = Bookmark.query.get_or_404(bookmark_id)
    
    # Check ownership
    if bookmark.user_id != user_id:
        flash('Unauthorized!', 'danger')
        return redirect(url_for('main.home'))
    
    db.session.delete(bookmark)
    db.session.commit()
    
    flash('Removed from bookmarks!', 'success')
    return redirect(url_for('dashboard.user_dashboard'))