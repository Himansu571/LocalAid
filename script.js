// script.js - Main JavaScript for LocalAid

document.addEventListener('DOMContentLoaded', function() {
    // Dark Mode Toggle
    const darkModeToggle = document.getElementById('darkModeToggle');
    const isDarkMode = localStorage.getItem('darkMode') === 'true';
    
    if (isDarkMode) {
        document.body.classList.add('dark-mode');
    }
    
    if (darkModeToggle) {
        darkModeToggle.addEventListener('click', function() {
            document.body.classList.toggle('dark-mode');
            const isNowDark = document.body.classList.contains('dark-mode');
            localStorage.setItem('darkMode', isNowDark);
        });
    }
    
    // Form Validation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });
    
    // Bootstrap Tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Smooth Scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });
    
    // Close alerts automatically after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(function() {
            alert.style.animation = 'fadeOut 0.3s ease';
            setTimeout(function() {
                alert.remove();
            }, 300);
        }, 5000);
    });
});

// Active Navigation Link
document.addEventListener('DOMContentLoaded', function() {
    const currentLocation = location.pathname;
    const navLinks = document.querySelectorAll('.navbar-nav a');
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentLocation) {
            link.parentElement.classList.add('active');
        }
    });
});

// Show/Hide Password
function togglePasswordVisibility(inputId) {
    const input = document.getElementById(inputId);
    if (input) {
        input.type = input.type === 'password' ? 'text' : 'password';
    }
}

// Format Phone Number
function formatPhoneNumber(input) {
    let value = input.value.replace(/\D/g, '');
    if (value.length > 10) {
        value = value.slice(0, 10);
    }
    input.value = value;
}

// Search Functionality
function performSearch() {
    const searchInput = document.getElementById('searchInput');
    const searchQuery = searchInput ? searchInput.value.toLowerCase() : '';
    // Search logic can be implemented here
    console.log('Searching for:', searchQuery);
}

// Bookmark Provider
function bookmarkProvider(providerId) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = `/dashboard/bookmark/${providerId}`;
    document.body.appendChild(form);
    form.submit();
}

// Delete Bookmark
function deleteBookmark(bookmarkId) {
    if (confirm('Are you sure you want to remove this bookmark?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `/dashboard/bookmark/${bookmarkId}/delete`;
        document.body.appendChild(form);
        form.submit();
    }
}

// Loading Spinner
function showLoadingSpinner() {
    const spinner = document.createElement('div');
    spinner.className = 'spinner fixed-top mt-5';
    spinner.id = 'loadingSpinner';
    document.body.appendChild(spinner);
}

function hideLoadingSpinner() {
    const spinner = document.getElementById('loadingSpinner');
    if (spinner) {
        spinner.remove();
    }
}

// Validate Email
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Validate Phone Number
function validatePhoneNumber(phone) {
    const phoneRegex = /^\d{10}$/;
    return phoneRegex.test(phone);
}

// Format Currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-IN', {
        style: 'currency',
        currency: 'INR'
    }).format(amount);
}

// Debounce Function
function debounce(func, delay) {
    let timeoutId;
    return function(...args) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => func(...args), delay);
    };
}

// Filter providers by location
function filterByLocation(locationId) {
    const form = document.createElement('form');
    form.method = 'GET';
    form.action = window.location.pathname;
    
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'location_id';
    input.value = locationId;
    
    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
}

// Filter providers by service
function filterByService(serviceId) {
    const form = document.createElement('form');
    form.method = 'GET';
    form.action = window.location.pathname;
    
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'service_id';
    input.value = serviceId;
    
    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
}

// Initialize Bootstrap Components
function initializeBootstrap() {
    // Initialize popovers
    const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    popoverTriggerList.map(function(popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
}

// Fade Out Animation
const style = document.createElement('style');
style.textContent = `
    @keyframes fadeOut {
        from {
            opacity: 1;
        }
        to {
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Export functions if needed for testing
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        formatPhoneNumber,
        validateEmail,
        validatePhoneNumber,
        formatCurrency,
        debounce,
        filterByLocation,
        filterByService
    };
}