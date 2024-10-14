"use client"

import { Box, Typography } from '@mui/material';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';

export function Ratio() {
    return (
        <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', width: '100%' }}>
            <Card sx={{ backgroundColor: '#1976d2', color: "white" }}>
                <CardHeader
                    title="Ratio"
                />
                <CardContent>
                    <Typography variant="h3" align="center">47/53</Typography>
                </CardContent>
            </Card>
        </Box >
    )
}

export default Ratio