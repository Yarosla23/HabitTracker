// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"
import Chart from "chart.js"

const config = {
    type: 'doughnut',
    data: data,
    options: {
        plugins: {
            customCanvasBackgroundColor: {
                color: 'lightGreen',
            }
        }
    },
    plugins: [plugin],
};

const data = {
    labels: [
        'Red',
        'Blue',
        'Yellow'
    ],
    datasets: [{
        label: 'My First Dataset',
        data: [300, 50, 100],
        backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
            'rgb(255, 205, 86)'
        ],
        hoverOffset: 4
    }]
};

const plugin = {
    id: 'customCanvasBackgroundColor',
    beforeDraw: (chart, args, options) => {
        const { ctx } = chart;
        ctx.save();
        ctx.globalCompositeOperation = 'destination-over';
        ctx.fillStyle = options.color || '#99ffff';
        ctx.fillRect(0, 0, chart.width, chart.height);
        ctx.restore();
    }
};
