const timeEl = document.getElementById('currentTime');
const dateEl = document.getElementById('currentDate');
const tempEl = document.getElementById('temp');
const descEl = document.getElementById('description');
const statusDot = document.getElementById('statusDot');
const statusText = document.getElementById('statusText');
const refreshBtn = document.getElementById('refreshBtn');

// Weather Mapping (Open-Meteo codes to readable descriptions)
const weatherCodes = {
    0: 'Clear sky',
    1: 'Mainly clear',
    2: 'Partly cloudy',
    3: 'Overcast',
    45: 'Fog',
    48: 'Depositing rime fog',
    51: 'Light drizzle',
    53: 'Moderate drizzle',
    55: 'Dense drizzle',
    61: 'Slight rain',
    63: 'Moderate rain',
    65: 'Heavy rain',
    71: 'Slight snow',
    73: 'Moderate snow',
    75: 'Heavy snow',
    95: 'Thunderstorm',
};

// Update Time and Date
function updateTime() {
    const now = new Date();
    
    // Time: HH:MM:SS
    timeEl.textContent = now.toLocaleTimeString('en-GB', { 
        hour: '2-digit', 
        minute: '2-digit', 
        second: '2-digit',
        hour12: false 
    });

    // Date: Weekday, Month Day, Year
    dateEl.textContent = now.toLocaleDateString('en-GB', { 
        weekday: 'long', 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
    });
}

// Update Application Status
function updateStatus(isHealthy, message) {
    statusText.textContent = `System: ${message}`;
    if (isHealthy) {
        statusDot.classList.remove('error');
    } else {
        statusDot.classList.add('error');
    }
}

// Fetch Weather Data
async function fetchWeather(lat, lon) {
    try {
        const response = await fetch(`https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`);
        
        if (!response.ok) throw new Error('API Error');
        
        const data = await response.json();
        const weather = data.current_weather;
        
        tempEl.textContent = `${Math.round(weather.temperature)}°C`;
        descEl.textContent = weatherCodes[weather.weathercode] || 'Cloudy';
        
        updateStatus(true, 'Healthy');
        
    } catch (error) {
        console.error('Error fetching weather:', error);
        descEl.textContent = 'Error loading weather';
        updateStatus(false, 'API Failure');
    }
}

// Get Location
function getLocation() {
    descEl.textContent = 'Locating...';
    updateStatus(true, 'Locating...');
    
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                const { latitude, longitude } = position.coords;
                fetchWeather(latitude, longitude);
            },
            (error) => {
                console.warn('Geolocation access denied, using Barcelona as fallback.');
                // Fallback to Barcelona
                fetchWeather(41.3851, 2.1734);
            }
        );
    } else {
        descEl.textContent = 'Geo not supported';
        updateStatus(false, 'Browser Error');
    }
}

// Initialize
setInterval(updateTime, 1000);
updateTime();
getLocation();

refreshBtn.addEventListener('click', getLocation);
