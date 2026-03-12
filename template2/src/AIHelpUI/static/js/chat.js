/**
 * AI Help Chat Interface
 * Handles chat UI interactions and API communication
 */

const CHAT_CONFIG = {
  endpoint: '/api/ai/query',
  configEndpoint: '/api/ai-help/config',
  maxMessages: 100,
  darkMode: true
};

let conversationId = generateConversationId();
let messageCount = 0;

/**
 * Initialize chat interface
 */
function initializeChat() {
  const form = document.getElementById('chat-form');
  const input = document.getElementById('question-input');
  
  form.addEventListener('submit', handleSubmit);
  
  // Auto-resize textarea
  input.addEventListener('input', function() {
    this.style.height = 'auto';
    this.style.height = (this.scrollHeight) + 'px';
  });
  
  // Shift+Enter for newline, Enter to send
  input.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      form.dispatchEvent(new Event('submit'));
    }
  });
  
  loadConfig();
}

/**
 * Load and display config on page load
 */
async function loadConfig() {
  try {
    const response = await fetch(CHAT_CONFIG.configEndpoint);
    const config = await response.json();
    
    // Update provider options based on available providers
    if (config.providers && Array.isArray(config.providers)) {
      const select = document.getElementById('provider-select');
      select.innerHTML = '';
      config.providers.forEach(provider => {
        const option = document.createElement('option');
        option.value = provider;
        option.textContent = provider.charAt(0).toUpperCase() + provider.slice(1);
        select.appendChild(option);
      });
    }
  } catch (e) {
    console.error('Failed to load config:', e);
  }
}

/**
 * Generate unique conversation ID
 */
function generateConversationId() {
  return `conv_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}

/**
 * Handle form submission
 */
async function handleSubmit(e) {
  e.preventDefault();
  
  const input = document.getElementById('question-input');
  const question = input.value.trim();
  
  if (!question) return;
  
  // Add user message to UI
  addMessageToChat('user', question);
  input.value = '';
  input.style.height = 'auto';
  
  // Show loading state
  showLoadingMessage();
  
  try {
    const provider = document.getElementById('provider-select').value;
    const enableSearch = document.getElementById('enable-search').checked;
    
    const response = await fetch(CHAT_CONFIG.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        question: question,
        provider: provider,
        search: enableSearch,
        conversation_id: conversationId
      })
    });
    
    const data = await response.json();
    
    if (!response.ok) {
      throw new Error(data.error || 'Request failed');
    }
    
    // Remove loading message
    removeLoadingMessage();
    
    // Add AI response
    addMessageToChat('assistant', data.answer, {
      sources: data.sources,
      provider: data.provider,
      tokensUsed: data.tokens_used
    });
    
  } catch (error) {
    removeLoadingMessage();
    addMessageToChat('error', `Error: ${error.message}`);
  }
}

/**
 * Add message to chat UI
 */
function addMessageToChat(role, content, metadata = {}) {
  const messagesDiv = document.getElementById('chat-messages');
  
  // Remove welcome message if it's the first message
  if (messageCount === 0) {
    const welcome = messagesDiv.querySelector('.welcome');
    if (welcome) welcome.remove();
  }
  
  const messageEl = document.createElement('div');
  messageEl.className = `message ${role}`;
  
  let html = `
    <div class="message-avatar">
      ${role === 'user' ? '👤' : role === 'assistant' ? '🤖' : '⚠️'}
    </div>
    <div class="message-content">
      <div class="message-text">${sanitizeHtml(content)}</div>
  `;
  
  // Add sources if available
  if (metadata.sources && metadata.sources.length > 0) {
    html += '<div class="message-sources"><strong>Sources:</strong><ul>';
    metadata.sources.forEach(source => {
      html += `<li>${sanitizeHtml(source)}</li>`;
    });
    html += '</ul></div>';
  }
  
  // Add metadata
  if (metadata.provider || metadata.tokensUsed) {
    html += '<div class="message-meta"><small>';
    if (metadata.provider) html += `Provider: ${metadata.provider} • `;
    if (metadata.tokensUsed) html += `Tokens: ${metadata.tokensUsed}`;
    html += '</small></div>';
  }
  
  html += '</div>';
  messageEl.innerHTML = html;
  
  messagesDiv.appendChild(messageEl);
  messageCount++;
  
  // Scroll to bottom
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
  
  // Limit message history
  if (messageCount > CHAT_CONFIG.maxMessages) {
    const first = messagesDiv.querySelector('.message');
    if (first) first.remove();
    messageCount--;
  }
}

/**
 * Show loading message
 */
function showLoadingMessage() {
  const messagesDiv = document.getElementById('chat-messages');
  const loadingEl = document.createElement('div');
  loadingEl.id = 'loading-message';
  loadingEl.className = 'message assistant loading';
  loadingEl.innerHTML = `
    <div class="message-avatar">🤖</div>
    <div class="message-content">
      <div class="loading-dots">
        <span></span><span></span><span></span>
      </div>
    </div>
  `;
  messagesDiv.appendChild(loadingEl);
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

/**
 * Remove loading message
 */
function removeLoadingMessage() {
  const loading = document.getElementById('loading-message');
  if (loading) loading.remove();
}

/**
 * Load conversation from session storage
 */
function loadConversation() {
  const saved = sessionStorage.getItem('aihelp_conversation');
  if (saved) {
    try {
      const data = JSON.parse(saved);
      conversationId = data.id;
      data.messages.forEach(msg => {
        addMessageToChat(msg.role, msg.content, msg.metadata || {});
      });
    } catch (e) {
      console.error('Failed to load conversation:', e);
    }
  }
}

/**
 * Save conversation to session storage
 */
function saveConversation() {
  const messages = [];
  document.querySelectorAll('.message').forEach(el => {
    const role = el.classList.contains('user') ? 'user' : 
                 el.classList.contains('error') ? 'error' : 'assistant';
    const text = el.querySelector('.message-text')?.textContent || '';
    messages.push({ role, content: text, metadata: {} });
  });
  
  sessionStorage.setItem('aihelp_conversation', JSON.stringify({
    id: conversationId,
    messages: messages,
    timestamp: new Date().toISOString()
  }));
}

/**
 * Ask a quick question
 */
function askQuestion(question) {
  document.getElementById('question-input').value = question;
  document.getElementById('chat-form').dispatchEvent(new Event('submit'));
}

/**
 * Sanitize HTML to prevent XSS
 */
function sanitizeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML
    .replace(/\n/g, '<br>')
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/__(.*?)__/g, '<em>$1</em>')
    .replace(/\[(.*?)\]\((.*?)\)/g, '<a href="$2" target="_blank">$1</a>');
}

// Auto-save on message add
const originalAddMessageToChat = addMessageToChat;
window.addMessageToChat = function(...args) {
  originalAddMessageToChat(...args);
  saveConversation();
};
  const loadingEl = document.createElement('div');
  loadingEl.id = 'loading-message';
  loadingEl.className = 'message assistant loading';
  loadingEl.innerHTML = `
    <div class="message-avatar">🤖</div>
    <div class="message-content">
      <div class="loading-dots">
        <span></span><span></span><span></span>
      </div>
    </div>
  `;
  messagesDiv.appendChild(loadingEl);
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

/**
 * Remove loading message
 */
function removeLoadingMessage() {
  const loading = document.getElementById('loading-message');
  if (loading) loading.remove();
}

/**
 * Quick question helper
 */
function askQuestion(question) {
  const input = document.getElementById('question-input');
  input.value = question;
  input.focus();
  document.getElementById('chat-form').dispatchEvent(new Event('submit'));
}

/**
 * Load previous conversation
 */
function loadConversation() {
  // Try to load from localStorage
  const saved = localStorage.getItem(`conversation_${conversationId}`);
  if (saved) {
    const messages = JSON.parse(saved);
    messages.forEach(msg => {
      addMessageToChat(msg.role, msg.content, msg.metadata || {});
    });
  }
}

/**
 * Sanitize HTML to prevent XSS
 */
function sanitizeHtml(html) {
  const div = document.createElement('div');
  div.textContent = html;
  return div.innerHTML;
}

/**
 * Save chat to localStorage
 */
function saveChat() {
  const messages = [];
  document.querySelectorAll('.chat-messages .message').forEach(msg => {
    const role = msg.className.split(' ')[1];
    const content = msg.querySelector('.message-text')?.textContent || '';
    messages.push({ role, content });
  });
  localStorage.setItem(`conversation_${conversationId}`, JSON.stringify(messages));
}

// Auto-save periodically
setInterval(saveChat, 10000);
