// stimulus がchart.jsを使ってレーダーチャートを描画するコントローラー
import {Controller} from "@hotwired/stimulus"
// chart.jsの必要なコンポーネント(機能）をインポート
import {
    Chart as ChartJS,
    RadialLinearScale,
    PointElement,
    LineElement,
    Filler,
    Tooltip,
    Legend,
} from "chart.js";

// インポートしたコンポーネントをChartJSに登録
ChartJS.register(
    RadialLinearScale,
    PointElement,
    LineElement,
    Filler,
    Tooltip,
    Legend
);

//このexportで、html側からこのコントローラーを使用できるようにする
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
        
        const labels = this.labelsValue || ["甘さ", "爽やかさ", "濃厚さ", "カロリー", "具材のリッチさ"]
        
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