import { Button } from "@/components/ui/button"
import Logo from '../logo/Logo'

const loginFitbit = () => {
    console.log("Test");
}

const Login = () => {
    return <>
        <Logo />
        <h1>Choose your platform</h1>
        <Button onClick={loginFitbit}>FITBIT</Button>
    </>
}

export default Login