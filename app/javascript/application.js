// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Chart from 'chart.js/auto';  
window.Chart = Chart; 
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()