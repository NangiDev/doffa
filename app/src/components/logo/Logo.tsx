import doffaLogo from '/prism.svg'
import './Logo.css'

export function Logo() {
    return <>
        <div>
            <img src={doffaLogo} className="logo" alt="Vite logo" />
        </div>
        <h1>DOFFA</h1>
    </>
}