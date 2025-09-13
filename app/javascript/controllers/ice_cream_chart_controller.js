import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';  

export default class extends Controller {
    static values = { 
        chartData: Array,
        labels: Array
    }
    static targets = ["canvas"]

    connect() {
        this.drawChart()
    }

    chartDataValueChanged() {
        this.drawChart()
    }

    drawChart() {
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