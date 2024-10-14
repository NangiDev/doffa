import { Card, CardContent, Stack, Typography } from '@mui/material';
import Logo from '../logo/Logo'
import Button from '@mui/material/Button';

const loginFitbit = () => {
    console.log("Login Fitbit");
}

const loginWithings = () => {
    console.log("Login Withings");
}

const Login = () => {
    return <>
        <Logo />
        <Card>
            <CardContent>
                <Typography variant="h5" sx={{ marginBottom: 2 }}>
                    Choose your platform
                </Typography>
                <Stack direction='column' spacing={2} alignItems="center">
                    <Button variant="contained" onClick={loginFitbit}>
                        FITBIT
                    </Button>
                    <Button variant="contained" onClick={loginWithings}>
                        WITHINGS
                    </Button>
                </Stack>
            </CardContent>
        </Card>
    </>
}

export default Login