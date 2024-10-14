"use client"

import { useState } from 'react';
import { Box, Typography, Card, CardContent, CardHeader, Tooltip, IconButton, Dialog, DialogTitle, DialogContent, DialogActions, Button } from '@mui/material';
import HelpOutlineIcon from '@mui/icons-material/HelpOutline';

export function Ratio() {
    const [dialogOpen, setDialogOpen] = useState(false); // State to control dialog visibility
    const [tooltipOpen, setTooltipOpen] = useState(false); // State to control tooltip visibility

    const handleDialogOpen = () => {
        setDialogOpen(true);
    };

    const handleDialogClose = () => {
        setDialogOpen(false);
    };

    const handleTooltipOpen = () => {
        setTooltipOpen(true);
    };

    const handleTooltipClose = () => {
        setTooltipOpen(false);
    };

    return (
        <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', width: '100%' }}>
            <Card sx={{ backgroundColor: '#1976d2', color: "white" }}>
                <CardHeader
                    title={
                        <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', width: '100%' }}>
                            <Typography variant="h6" sx={{ textAlign: 'center', flexGrow: 1 }}>
                                Ratio
                            </Typography>
                            <Tooltip
                                title="How is this calculated?"
                                open={tooltipOpen}
                                onClose={handleTooltipClose}
                                onOpen={handleTooltipOpen}
                                arrow
                                disableHoverListener // Disable hover behavior for touch devices
                            >
                                <IconButton
                                    sx={{ color: 'white', padding: 0, marginLeft: -2 }}
                                    onClick={handleDialogOpen} // Opens the dialog on tap
                                >
                                    <HelpOutlineIcon fontSize="small" />
                                </IconButton>
                            </Tooltip>
                        </Box>
                    }
                />
                <CardContent>
                    <Typography variant="h3" align="center">47/53</Typography>
                </CardContent>
            </Card>

            <Dialog open={dialogOpen} onClose={handleDialogClose}>
                <DialogTitle>Calculation Details</DialogTitle>
                <DialogContent>
                    <Typography>
                        The ratio is calculated based on the following metrics:
                    </Typography>
                    <ul>
                        <li>Metric 1: Explanation</li>
                        <li>Metric 2: Explanation</li>
                        <li>Metric 3: Explanation</li>
                    </ul>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleDialogClose} color="primary">
                        Close
                    </Button>
                </DialogActions>
            </Dialog>
        </Box>
    )
}

export default Ratio;
