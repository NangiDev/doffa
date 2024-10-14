import { Card, CardContent, Typography } from '@mui/material';
import Logo from '../logo/Logo'
import Button from '@mui/material/Button';

const loginFitbit = () => {
    console.log("Test");
}

const Login = () => {
    return <>
        <Logo />
        <Card>
            <CardContent>
                <Typography variant="h4" sx={{ marginBottom: 2 }}>
                    Choose your platform
                </Typography>
                <Button variant="contained" onClick={loginFitbit}>FITBIT</Button>
            </CardContent>
        </Card>
    </>
}

export default Login