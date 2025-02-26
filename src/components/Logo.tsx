"use client"
import doffaLogoDark from '/opt_prism_dark.svg'
import doffaLogoLight from '/opt_prism_light.svg'
import { Box, Stack, Typography } from '@mui/material';
import { useTheme } from '../context/ThemeContext';

const Logo = () => {
    const { theme } = useTheme();

    return (
        <Stack
            direction={"row"}
            justifyContent={"center"}
            alignItems={"center"}
            padding={"1em"}
            gap={"1em"}
        >
            <Box
                component="img"
                src={theme === "dark" ? doffaLogoLight : doffaLogoDark}
                alt="Prism Doffa Logo"
                width="5em"
                height="auto"
            />
            <Typography
                variant="h3"
                sx={{ fontWeight: 'bold' }}
            >
                DOFFA
            </Typography>
        </Stack>
    );
}

export default Logo