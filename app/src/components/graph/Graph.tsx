"use client"

import { Box } from '@mui/material';
import { LineChart } from '@mui/x-charts/LineChart';

const uData = [4000, 3000, 2000, 2780, 1890, 2390, 3490];
const xLabels = [
    'Page A',
    'Page B',
    'Page C',
    'Page D',
    'Page E',
    'Page F',
    'Page G',
];

const Graph = () => {
    return (
        <Box sx={{ width: '100%', height: '150px' }}>
            <LineChart
                margin={{
                    left: 5,
                    right: 5,
                    top: 5,
                    bottom: 5,
                }}
                leftAxis={null}
                bottomAxis={null}
                series={[{
                    data: uData,
                    area: true,
                    showMark: true,
                    color: '#1976d2',
                }]}
                xAxis={[{
                    scaleType: 'point',
                    data: xLabels,
                    label: '',
                }]}
                yAxis={[{
                    label: '',
                }]}
            />
        </Box>
    );
}

export default Graph