// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Chart from 'chart.js/auto';  
import "./user_dropdown.js";
import "./preview.js";
import "./entrypoints/calorie_selector";
window.Chart = Chart; 
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

console.log('Application.js loaded')
console.log('Chart.js available:', typeof Chart !== 'undefined')
console.log('Chart.js global:', typeof window.Chart !== 'undefined')