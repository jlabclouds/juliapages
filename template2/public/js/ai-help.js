/**
 * AIHelpMe Integration - Client-side JavaScript
 * 
 * Provides flexible AI-powered help widget with switchable UI styles and scopes.
 * Supports: chat, qa-panel, suggestions, and hybrid UI styles
 * Can be toggled between docs-only and full-site help contexts
 */

class AIHelpWidget {
    constructor() {
        this.config = null;
        this.isOpen = false;
        this.messages = [];
        this.currentStyle = 'chat';
        this.currentPosition = 'bottom-right';
        this.isLoading = false;
        
        this.init();
    }
    
    /**
     * Initialize the AI Help widget
     */
    async init() {
        try {
            // Fetch configuration from backend with timeout
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 2000);
            
            try {
                const response = await fetch('/api/ai-help/config', { signal: controller.signal });
                this.config = await response.json();
            } catch (fetchError) {
                // If fetch fails, use default config
                console.warn('Could not fetch AI Help config, using defaults:', fetchError);
                this.config = {
                    ui_style: 'chat',
                    ui_position: 'bottom-right',
                    ui_theme: 'auto',
                    help_scope: 'docs-only',
                    help_enabled: true,
                    ai_provider: 'placeholder'
                };
            } finally {
                clearTimeout(timeoutId);
            }
            
            if (!this.config.help_enabled) {
                console.log('AI Help is disabled');
                return;
            }
            
            this.currentStyle = this.config.ui_style;
            this.currentPosition = this.config.ui_position;
            
            // Create widget DOM elements
            this.createWidgetDOM();
            this.attachEventListeners();
            
            console.log(`AI Help initialized with style: ${this.currentStyle}, position: ${this.currentPosition}`);
        } catch (error) {
            console.error('Failed to initialize AI Help widget:', error);
            // Still try to create widget with defaults even if config fetch completely fails
            this.config = {
                ui_style: 'chat',
                ui_position: 'bottom-right',
                ui_theme: 'auto',
                help_scope: 'docs-only',
                help_enabled: true,
                ai_provider: 'placeholder'
            };
            this.createWidgetDOM();
            this.attachEventListeners();
        }
    }
    
    /**
     * Create the widget DOM structure based on UI style
     */
    createWidgetDOM() {
        // Create container
        const container = document.createElement('div');
        container.id = 'ai-help-container';
        container.className = `ai-help-${this.currentStyle} ai-help-${this.currentPosition}`;
        container.setAttribute('data-theme', this.config.ui_theme);
        
        if (this.currentStyle === 'chat') {
            container.innerHTML = this.createChatUI();
        } else if (this.currentStyle === 'qa-panel') {
            container.innerHTML = this.createQAPanelUI();
        } else if (this.currentStyle === 'suggestions') {
            container.innerHTML = this.createSuggestionsUI();
        } else if (this.currentStyle === 'hybrid') {
            container.innerHTML = this.createHybridUI();
        }
        
        document.body.appendChild(container);
    }
    
    /**
     * Create chat-style UI
     */
    createChatUI() {
        return `
            <div class="ai-help-widget ai-help-chat">
                <div class="ai-help-header">
                    <h3>AI Help</h3>
                    <button class="ai-help-close" aria-label="Close help">×</button>
                    <button class="ai-help-settings" aria-label="Settings">⚙️</button>
                </div>
                <div class="ai-help-messages"></div>
                <div class="ai-help-input-area">
                    <textarea 
                        class="ai-help-input" 
                        placeholder="Ask me anything..." 
                        rows="2"></textarea>
                    <button class="ai-help-send" aria-label="Send message">Send</button>
                </div>
                <div class="ai-help-fab">
                    <button class="ai-help-fab-btn" aria-label="Open AI Help" title="AI Help">💬</button>
                </div>
            </div>
        `;
    }
    
    /**
     * Create Q&A panel UI
     */
    createQAPanelUI() {
        return `
            <div class="ai-help-widget ai-help-qa-panel">
                <div class="ai-help-header">
                    <h3>Ask a Question</h3>
                    <button class="ai-help-close" aria-label="Close help">×</button>
                </div>
                <div class="ai-help-question-area">
                    <input 
                        type="text" 
                        class="ai-help-question-input" 
                        placeholder="What do you want to know?" />
                    <button class="ai-help-ask-btn">Ask</button>
                </div>
                <div class="ai-help-answer-area"></div>
                <div class="ai-help-fab">
                    <button class="ai-help-fab-btn" aria-label="Open AI Help" title="AI Help">❓</button>
                </div>
            </div>
        `;
    }
    
    /**
     * Create suggestions UI
     */
    createSuggestionsUI() {
        return `
            <div class="ai-help-widget ai-help-suggestions">
                <div class="ai-help-header">
                    <h3>Help Suggestions</h3>
                    <button class="ai-help-close" aria-label="Close help">×</button>
                </div>
                <div class="ai-help-suggestions-area">
                    <p>Ask a question to get relevant suggestions</p>
                </div>
                <div class="ai-help-input-area">
                    <input 
                        type="text" 
                        class="ai-help-input" 
                        placeholder="Ask for suggestions..." />
                    <button class="ai-help-send">Search</button>
                </div>
                <div class="ai-help-fab">
                    <button class="ai-help-fab-btn" aria-label="Open AI Help" title="AI Help">💡</button>
                </div>
            </div>
        `;
    }
    
    /**
     * Create hybrid UI (chat + suggestions)
     */
    createHybridUI() {
        return `
            <div class="ai-help-widget ai-help-hybrid">
                <div class="ai-help-header">
                    <h3>AI Assistant</h3>
                    <button class="ai-help-close" aria-label="Close help">×</button>
                    <button class="ai-help-settings" aria-label="Settings">⚙️</button>
                </div>
                <div class="ai-help-tabs">
                    <button class="ai-help-tab active" data-tab="chat">Chat</button>
                    <button class="ai-help-tab" data-tab="suggestions">Suggestions</button>
                </div>
                <div class="ai-help-messages" id="chat-tab"></div>
                <div class="ai-help-suggestions-area" id="suggestions-tab" style="display: none;"></div>
                <div class="ai-help-input-area">
                    <textarea 
                        class="ai-help-input" 
                        placeholder="Ask me anything..." 
                        rows="2"></textarea>
                    <button class="ai-help-send">Send</button>
                </div>
                <div class="ai-help-fab">
                    <button class="ai-help-fab-btn" aria-label="Open AI Help" title="AI Help">🤖</button>
                </div>
            </div>
        `;
    }
    
    /**
     * Attach event listeners
     */
    attachEventListeners() {
        const container = document.getElementById('ai-help-container');
        
        // FAB (Floating Action Button) click
        const fabBtn = container.querySelector('.ai-help-fab-btn');
        if (fabBtn) {
            fabBtn.addEventListener('click', () => this.toggleWidget());
        }
        
        // Close button
        const closeBtn = container.querySelector('.ai-help-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => this.close());
        }
        
        // Send/Ask button
        const sendBtn = container.querySelector('.ai-help-send');
        if (sendBtn) {
            sendBtn.addEventListener('click', () => this.sendQuery());
        }
        
        // Input field - Enter to send
        const input = container.querySelector('.ai-help-input, .ai-help-question-input');
        if (input) {
            input.addEventListener('keypress', (e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    this.sendQuery();
                }
            });
        }
        
        // Tab switching for hybrid UI
        const tabs = container.querySelectorAll('.ai-help-tab');
        tabs.forEach(tab => {
            tab.addEventListener('click', (e) => this.switchTab(e.target.dataset.tab));
        });
        
        // Settings button
        const settingsBtn = container.querySelector('.ai-help-settings');
        if (settingsBtn) {
            settingsBtn.addEventListener('click', () => this.showSettings());
        }
    }
    
    /**
     * Toggle widget visibility
     */
    toggleWidget() {
        if (this.isOpen) {
            this.close();
        } else {
            this.open();
        }
    }
    
    /**
     * Open the widget
     */
    open() {
        const container = document.getElementById('ai-help-container');
        if (container) {
            container.classList.add('open');
            this.isOpen = true;
        }
    }
    
    /**
     * Close the widget
     */
    close() {
        const container = document.getElementById('ai-help-container');
        if (container) {
            container.classList.remove('open');
            this.isOpen = false;
        }
    }
    
    /**
     * Send query to backend AI help API
     */
    async sendQuery() {
        const container = document.getElementById('ai-help-container');
        const input = container.querySelector('.ai-help-input, .ai-help-question-input');
        
        const query = input.value.trim();
        if (!query) return;
        
        // Get page context
        const pageContext = this.extractPageContext();
        
        // Display user message (chat only)
        if (this.currentStyle === 'chat' || this.currentStyle === 'hybrid') {
            this.addMessage('user', query);
        }
        
        // Show loading state
        this.setLoading(true);
        
        try {
            // Send to backend
            const response = await fetch('/api/ai-help', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    query: query,
                    context: pageContext
                })
            });
            
            const data = await response.json();
            
            if (data.success) {
                this.displayResponse(data.response);
                input.value = '';
            } else {
                this.addMessage('error', data.error || 'Failed to get response');
            }
        } catch (error) {
            console.error('Error sending query:', error);
            this.addMessage('error', 'Connection error. Please try again.');
        } finally {
            this.setLoading(false);
        }
    }
    
    /**
     * Extract current page context based on help scope
     */
    extractPageContext() {
        let context = '';
        
        if (this.config.help_scope === 'docs-only') {
            // Extract only documentation content
            const docContent = document.querySelector('main') || document.querySelector('.content');
            if (docContent) {
                context = docContent.innerText.substring(0, 2000); // Limit length
            }
        } else if (this.config.help_scope === 'full-site') {
            // Include page title and broader context
            const title = document.title || 'Unknown Page';
            const mainContent = document.querySelector('main') || document.querySelector('.content');
            const contentText = mainContent ? mainContent.innerText.substring(0, 1000) : '';
            context = `Page: ${title}\n${contentText}`;
        }
        
        return context;
    }
    
    /**
     * Display response from AI
     */
    displayResponse(response) {
        if (this.currentStyle === 'chat' || this.currentStyle === 'hybrid') {
            this.addMessage('ai', response);
        } else if (this.currentStyle === 'qa-panel') {
            const answerArea = document.querySelector('.ai-help-answer-area');
            if (answerArea) {
                answerArea.innerHTML = `<div class="ai-help-answer">${this.escapeHtml(response)}</div>`;
            }
        } else if (this.currentStyle === 'suggestions') {
            const suggestionsArea = document.querySelector('.ai-help-suggestions-area');
            if (suggestionsArea) {
                suggestionsArea.innerHTML = `<div class="ai-help-suggestion">${this.escapeHtml(response)}</div>`;
            }
        }
    }
    
    /**
     * Add message to chat (chat and hybrid styles)
     */
    addMessage(role, content) {
        const messagesArea = document.querySelector('.ai-help-messages');
        if (!messagesArea) return;
        
        const messageEl = document.createElement('div');
        messageEl.className = `ai-help-message ai-help-message-${role}`;
        messageEl.innerHTML = `<div class="ai-help-message-content">${this.escapeHtml(content)}</div>`;
        
        messagesArea.appendChild(messageEl);
        messagesArea.scrollTop = messagesArea.scrollHeight;
        
        this.messages.push({ role, content, timestamp: new Date() });
    }
    
    /**
     * Set loading state
     */
    setLoading(loading) {
        this.isLoading = loading;
        const sendBtn = document.querySelector('.ai-help-send');
        if (sendBtn) {
            sendBtn.disabled = loading;
            sendBtn.innerText = loading ? 'Loading...' : 'Send';
        }
    }
    
    /**
     * Switch tabs in hybrid UI
     */
    switchTab(tabName) {
        const chatTab = document.getElementById('chat-tab');
        const suggestionsTab = document.getElementById('suggestions-tab');
        const tabs = document.querySelectorAll('.ai-help-tab');
        
        tabs.forEach(tab => tab.classList.remove('active'));
        
        if (tabName === 'chat') {
            chatTab.style.display = 'block';
            suggestionsTab.style.display = 'none';
            event.target.classList.add('active');
        } else if (tabName === 'suggestions') {
            chatTab.style.display = 'none';
            suggestionsTab.style.display = 'block';
            event.target.classList.add('active');
        }
    }
    
    /**
     * Show settings panel for switching UI style and help scope
     */
    showSettings() {
        const settingsHTML = `
            <div class="ai-help-settings-panel">
                <h4>AI Help Settings</h4>
                <div class="ai-help-setting">
                    <label for="ui-style-select">UI Style:</label>
                    <select id="ui-style-select">
                        <option value="chat" ${this.currentStyle === 'chat' ? 'selected' : ''}>Chat</option>
                        <option value="qa-panel" ${this.currentStyle === 'qa-panel' ? 'selected' : ''}>Q&A Panel</option>
                        <option value="suggestions" ${this.currentStyle === 'suggestions' ? 'selected' : ''}>Suggestions</option>
                        <option value="hybrid" ${this.currentStyle === 'hybrid' ? 'selected' : ''}>Hybrid</option>
                    </select>
                </div>
                <div class="ai-help-setting">
                    <label for="help-scope-select">Help Scope:</label>
                    <select id="help-scope-select">
                        <option value="docs-only" ${this.config.help_scope === 'docs-only' ? 'selected' : ''}>Docs Only</option>
                        <option value="full-site" ${this.config.help_scope === 'full-site' ? 'selected' : ''}>Full Site</option>
                    </select>
                </div>
                <button id="apply-settings" class="ai-help-btn-primary">Apply Settings</button>
            </div>
        `;
        
        // Insert settings panel
        const container = document.getElementById('ai-help-container');
        const existingSettings = container.querySelector('.ai-help-settings-panel');
        if (existingSettings) {
            existingSettings.remove();
        } else {
            const settingsDiv = document.createElement('div');
            settingsDiv.innerHTML = settingsHTML;
            container.appendChild(settingsDiv);
            
            document.getElementById('apply-settings').addEventListener('click', 
                () => this.applySettings());
        }
    }
    
    /**
     * Apply settings changes
     */
    applySettings() {
        const newStyle = document.getElementById('ui-style-select').value;
        const newScope = document.getElementById('help-scope-select').value;
        
        // Update environment variables (in practice, these would be persisted)
        if (newStyle !== this.currentStyle) {
            console.log(`Switching UI style from ${this.currentStyle} to ${newStyle}`);
            this.currentStyle = newStyle;
            // Would reload widget in production
        }
        
        if (newScope !== this.config.help_scope) {
            console.log(`Switching help scope from ${this.config.help_scope} to ${newScope}`);
            this.config.help_scope = newScope;
        }
        
        alert('Settings would be applied. In production, these would persist.');
    }
    
    /**
     * Utility: Escape HTML to prevent XSS
     */
    escapeHtml(text) {
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.replace(/[&<>"']/g, m => map[m]);
    }
}

// Initialize widget when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        window.aiHelpWidget = new AIHelpWidget();
    });
} else {
    window.aiHelpWidget = new AIHelpWidget();
}
