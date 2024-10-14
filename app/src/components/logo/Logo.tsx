"use client"
import doffaLogo from '/prism.svg'
import { Box, Typography } from '@mui/material';

const Logo = () => {
    return (
        <Box display="flex"
            flexDirection="column"
            justifyContent="center"
            alignItems="center"
            textAlign="center">
            <Box component="img"
                src={doffaLogo}
                alt="Prism Doffa Logo"
                sx={{ width: 100, height: 100 }} />
            <Typography variant="h3" sx={{ fontWeight: 'bold', marginBottom: 2 }}>
                DOFFA
            </Typography>
        </Box>
    );
}

export default Logo