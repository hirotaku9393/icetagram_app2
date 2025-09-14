import {Controller} from "@hotwired/stimulus"
import {
    Chart as ChartJS,
    RadialLinearScale,
    PointElement,
    LineElement,
    Filler,
    Tooltip,
    Legend,
} from "chart.js";


ChartJS.register(
    RadialLinearScale,
    PointElement,
    LineElement,
    Filler,
    Tooltip,
    Legend
);

export default class extends Controller {
    static values = { 
        chartData: Array,
        labels: Array
    }
    static targets = ["canvas"]

    connect() {
        console.log('=== Ice Cream Chart Controller Debug ===')
        console.log('Ice cream chart controller connected')
        console.log('Chart.js available:', typeof Chart !== 'undefined')
        console.log('Controller element:', this.element)
        console.log('Canvas target available:', this.hasCanvasTarget)
        console.log('Canvas target element:', this.canvasTarget)
        console.log('Chart data value:', this.chartDataValue)
        console.log('Labels value:', this.labelsValue)
        this.drawChart()
    }

    chartDataValueChanged() {
        console.log('Chart data value changed:', this.chartDataValue)
        this.drawChart()
    }

    drawChart() {
        console.log('=== Drawing Chart ===')
        console.log('Has canvas target:', this.hasCanvasTarget)
        console.log('Chart data length:', this.chartDataValue?.length)       
        if (!this.hasCanvasTarget || !this.chartDataValue?.length) return

        this.destroyChart()
        
        const labels = this.labelsValue || ["甘さ", "爽やかさ", "濃厚さ", "カロリー", "具材の充実感"]
        
        this.chart = new Chart(this.canvasTarget, {
        type: "radar",
        data: {
            labels,
            datasets: [{
            data: this.chartDataValue,
            backgroundColor: "rgba(255,165,0,0.2)",  
            borderColor: "rgba(255,165,0,1)", 
            borderWidth: 2
            }]
        },
        options: { 
            responsive: true, 
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: { 
            r: { 
                min: 0, 
                max: 5, 
                ticks: { stepSize: 1 } 
            } 
            } 
        }
        })
    }

    destroyChart() {
        if (this.chart) {
        this.chart.destroy()
        }
    }

    disconnect() {
        this.destroyChart()
    }
}