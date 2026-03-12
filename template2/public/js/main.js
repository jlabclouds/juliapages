/* Main JavaScript file for MyTemplate */

document.addEventListener('DOMContentLoaded', function() {
    console.log('MyTemplate loaded');
    
    // Initialize sidebar toggle
    initSidebarToggle();
    
    // Initialize smooth scrolling
    initSmoothScroll();
    
    // Initialize code highlighting
    initCodeHighlight();
    
    // Initialize event listeners
    initializeEventListeners();
    
    // Check API health
    checkHealth();
}, false);

/**
 * Initialize sidebar toggle functionality
 */
function initSidebarToggle() {
    const toggleBtn = document.getElementById('sidebar-toggle');
    const sidebar = document.querySelector('.sidebar');
    
    if (!toggleBtn || !sidebar) return;
    
    toggleBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        sidebar.classList.toggle('open');
    });
    
    // Close sidebar when clicking outside
    document.addEventListener('click', function(e) {
        if (sidebar.classList.contains('open') && 
            !sidebar.contains(e.target) && 
            !toggleBtn.contains(e.target)) {
            sidebar.classList.remove('open');
        }
    });
    
    // Close sidebar when a link is clicked
    sidebar.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', function() {
            // Only close if it's not an external link
            if (!link.target || link.target !== '_blank') {
                sidebar.classList.remove('open');
            }
        });
    });
}

/**
 * Initialize smooth scrolling for anchor links
 */
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });
}

/**
 * Initialize code highlighting
 */
function initCodeHighlight() {
    // Add copy button to code blocks
    document.querySelectorAll('pre').forEach(block => {
        const copyBtn = document.createElement('button');
        copyBtn.className = 'copy-btn';
        copyBtn.textContent = 'Copy';
        copyBtn.addEventListener('click', function() {
            const code = block.querySelector('code');
            const text = code.textContent;
            navigator.clipboard.writeText(text).then(() => {
                copyBtn.textContent = 'Copied!';
                setTimeout(() => {
                    copyBtn.textContent = 'Copy';
                }, 2000);
            });
        });
        block.appendChild(copyBtn);
    });
}

/**
 * Fetch data from API endpoint
 * @param {string} endpoint - API endpoint path
 * @returns {Promise} JSON response
 */
async function fetchAPI(endpoint) {
    try {
        const response = await fetch(endpoint);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return await response.json();
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

/**
 * Get application version
 */
async function getVersion() {
    try {
        const data = await fetchAPI('/api/version');
        console.log(`MyTemplate v${data.version} running on Julia ${data.julia_version}`);
        return data;
    } catch (error) {
        console.error('Failed to fetch version:', error);
    }
}

/**
 * Check API health
 */
async function checkHealth() {
    try {
        const data = await fetchAPI('/api/health');
        console.log('API Health:', data.status);
        return data;
    } catch (error) {
        console.error('Health check failed:', error);
    }
}

/**
 * Add event listeners to interactive elements
 */
function initializeEventListeners() {
    // Update on scroll
    window.addEventListener('scroll', function() {
        const sidebar = document.querySelector('.sidebar');
        if (sidebar && window.scrollY > 50) {
            sidebar.style.boxShadow = '4px 0 12px rgba(0, 0, 0, 0.15)';
        } else if (sidebar) {
            sidebar.style.boxShadow = '2px 0 8px rgba(0, 0, 0, 0.1)';
        }
    });
}

// Export functions for external use
window.MyTemplate = {
    fetchAPI,
    getVersion,
    checkHealth
};
