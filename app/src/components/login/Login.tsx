import { Button } from "@/components/ui/button"
import { Logo } from '../logo/Logo'
import './Login.css'

const loginFitbit = () => {
    console.log("Test");
}

export function Login() {
    return <>
        <Logo></Logo>
        <h1>Choose your platform</h1>
        <Button onClick={loginFitbit}>FITBIT</Button>
    </>
}