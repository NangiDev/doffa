"use client"

import { useState } from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { CardHeader, Collapse, createTheme, IconButton, ThemeProvider } from '@mui/material';
import { useTheme } from '../context/ThemeContext';

interface ExpandingCardProps {
    title: string;
    children: React.ReactNode;
}

const ExpandingCard = ({ title, children }: ExpandingCardProps) => {
    const [open, setOpen] = useState(true);
    const { theme } = useTheme(); // Get theme from context

    // Define MUI theme based on the current theme
    const cardTheme = createTheme({
        palette: {
            mode: theme, // 'light' or 'dark'
            primary: {
                main: "#4288f5", // Your primary color
            },
            background: {
                default: theme === "dark" ? "#212121" : "#ffffff",
                paper: theme === "dark" ? "#333333" : "#f9f9f9",
            },
            text: {
                primary: theme === "dark" ? "#ffffff" : "#212121",
            },
        },
    });

    const handleToggle = () => {
        setOpen(!open); // Toggle the collapse state
    };

    return (
        <ThemeProvider theme={cardTheme}>
            <Card
                variant="outlined"
                sx={{
                    width: "100%",
                    backgroundColor: theme === "dark" ? "#333333" : "#ffffff",
                    color: theme === "dark" ? "#ffffff" : "#212121",
                    borderRadius: "8px",
                    "& .MuiInputBase-input": {
                        color: theme === "dark" ? "#ffffff" : "#212121",
                    },
                }}
            >
                <CardHeader
                    title={title}
                    action={
                        <IconButton onClick={handleToggle}>
                            <ExpandMoreIcon
                                sx={{
                                    transform: open ? 'rotate(180deg)' : 'rotate(0deg)',
                                }}
                            />
                        </IconButton>
                    }
                />
                <Collapse in={open}>
                    <CardContent>
                        {children}
                    </CardContent>
                </Collapse>
            </Card>
        </ThemeProvider >
    )
}

export default ExpandingCard