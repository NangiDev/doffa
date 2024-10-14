"use client"

import { useState } from 'react';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Grid from '@mui/material/Grid2';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { CardHeader, Collapse, IconButton } from '@mui/material';

export function DataCard() {
    const [open, setOpen] = useState(true);

    const handleToggle = () => {
        setOpen(!open); // Toggle the collapse state
    };

    const data = {
        date1: '2024-10-07',
        date2: '2024-10-11',
        bmi: [22.54, 22.46],
        kg: [83.1, 82.8],
        fat: [14.25, 14.09],
        lean: [68.85, 68.71],
    };

    return (
        <Card sx={{ width: '100%' }}>
            <CardHeader
                title="Data"
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
                    <Grid container>
                        <Grid sx={{
                            display: 'flex', flexDirection: 'column',
                            width: { xs: '35%', sm: '25%' },
                        }}>
                            <Typography variant="body1" lineHeight={1.85} align="right">{data.date1}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="right">{data.bmi[0]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="right">{data.kg[0]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="right">{data.fat[0]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="right">{data.lean[0]}</Typography>
                        </Grid>
                        <Grid sx={{
                            display: 'flex', flexDirection: 'column',
                            width: { xs: '30%', sm: '50%' },
                        }}>
                            <Typography variant="h6" lineHeight={1.5} align="center">DATE</Typography>
                            <Typography variant="h6" lineHeight={1.5} align="center">BMI</Typography>
                            <Typography variant="h6" lineHeight={1.5} align="center">KG</Typography>
                            <Typography variant="h6" lineHeight={1.5} align="center">FAT</Typography>
                            <Typography variant="h6" lineHeight={1.5} align="center">LEAN</Typography>
                        </Grid>
                        <Grid sx={{
                            display: 'flex', flexDirection: 'column',
                            width: { xs: '35%', sm: '25%' },
                        }}>
                            <Typography variant="body1" lineHeight={1.85} align="left">{data.date2}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="left">{data.bmi[1]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="left">{data.kg[1]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="left">{data.fat[1]}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="left">{data.lean[1]}</Typography>
                        </Grid>
                    </Grid>
                </CardContent>
            </Collapse>
        </Card>
    )
}

export default DataCard