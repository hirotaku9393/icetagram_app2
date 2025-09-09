// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chart.js/auto"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()