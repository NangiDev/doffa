"use client"

import { useState } from 'react';
import { Box, Button, Card, CardContent, CardHeader, Collapse, IconButton, Typography } from '@mui/material';
import { LineChart } from '@mui/x-charts/LineChart';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';

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
    const [open, setOpen] = useState(true);

    const handleToggle = () => {
        setOpen(!open); // Toggle the collapse state
    };

    return (
        <Card sx={{ width: '100%' }}>
            <CardHeader
                title="Graph"
                action={
                    <IconButton onClick={handleToggle}>
                        <ExpandMoreIcon
                            sx={{
                                transform: open ? 'rotate(180deg)' : 'rotate(0deg)',
                                transition: 'transform 0.3s ease',
                            }}
                        />
                    </IconButton>
                }
            />
            <Collapse in={open}>
                <CardContent>
                    <Box sx={{ width: '100%', height: '150px' }}>
                        <LineChart
                            skipAnimation={true}
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
                    <Typography variant="body1" align="center" sx={{ marginTop: 2, marginBottom: 2 }}>
                        Showing last '1' month(s):
                    </Typography>
                    <Box sx={{ display: 'flex', marginTop: 2 }}>
                        <Button variant="contained" color="primary" sx={{ flexGrow: 1, marginRight: 1 }}>1</Button>
                        <Button variant="contained" color="primary" sx={{ flexGrow: 1, marginRight: 1 }}>3</Button>
                        <Button variant="contained" color="primary" sx={{ flexGrow: 1, marginRight: 1 }}>6</Button>
                        <Button variant="contained" color="primary" sx={{ flexGrow: 1 }}>12</Button>
                    </Box>
                </CardContent>
            </Collapse>
        </Card>
    );
}

export default Graph