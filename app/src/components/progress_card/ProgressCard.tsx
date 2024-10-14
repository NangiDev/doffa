"use client"

import { useState } from 'react';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Grid from '@mui/material/Grid2';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { CardHeader, Collapse, IconButton } from '@mui/material';

export function ProgressCard() {
    const [open, setOpen] = useState(true);

    const handleToggle = () => {
        setOpen(!open); // Toggle the collapse state
    };

    const data = {
        days: 4,
        bmi: -0.08,
        kg: -0.3,
        fat: -0.16,
        lean: -0.14,
    };

    return (
        <Card sx={{ width: '100%' }}>
            <CardHeader
                title="Progress"
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
                        <Grid sx={{ display: 'flex', flexDirection: 'row', width: '100%' }}>
                            <Typography variant="h6" lineHeight={1.85} align="center" width={'100%'} >DAYS</Typography>
                            <Typography variant="h6" lineHeight={1.85} align="center" width={'100%'} >BMI</Typography>
                            <Typography variant="h6" lineHeight={1.85} align="center" width={'100%'} >KG</Typography>
                            <Typography variant="h6" lineHeight={1.85} align="center" width={'100%'} >FAT</Typography>
                            <Typography variant="h6" lineHeight={1.85} align="center" width={'100%'} >LEAN</Typography>
                        </Grid>
                        <Grid sx={{ display: 'flex', flexDirection: 'row', width: '100%' }}>
                            <Typography variant="body1" lineHeight={1.85} align="center" width={'100%'} >{data.days}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="center" width={'100%'} >{data.bmi}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="center" width={'100%'} >{data.kg}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="center" width={'100%'} >{data.fat}</Typography>
                            <Typography variant="body1" lineHeight={1.85} align="center" width={'100%'} >{data.lean}</Typography>
                        </Grid>
                    </Grid>
                </CardContent>
            </Collapse>
        </Card>
    )
}

export default ProgressCard