import { Chart, registerables, ChartOptions } from 'chart.js';
Chart.register(...registerables); // Register all necessary components

// Data for the chart
const data = {
    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
    datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
            'rgba(255, 99, 132, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
    }]
};

// Configuration for the chart
const config = {
    type: 'bar' as const, // Specify the chart type explicitly
    data: data,
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    } as ChartOptions // Cast options to ChartOptions
};

// Create the chart
const myChart = new Chart(
    document.getElementById('myChart') as HTMLCanvasElement,
    config
);

// Example to update the chart with new data from an input
document.getElementById('updateButton')?.addEventListener('click', () => {
    const inputValue = Number((document.getElementById('dataInput') as HTMLInputElement).value);
    if (!isNaN(inputValue)) {
        myChart.data.datasets[0].data.push(inputValue); // Add new data
        myChart.update(); // Refresh the chart
    }
});
