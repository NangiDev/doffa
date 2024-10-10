import doffaLogo from '/prism.svg'
import './Logo.css'

const Logo = () => {
    return <>
        <div>
            <img src={doffaLogo} className='logo' alt="Prism Doffa logo" />
        </div>
        <h1>DOFFA</h1>
    </>
}

export default Logo