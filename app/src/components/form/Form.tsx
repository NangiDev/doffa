import { Logo, DatePicker, Graph, DataCard, ProgressCard, Ratio } from '../Components'

const Form = () => {
    return <>
        <Logo />
        <div>
            <DatePicker />
            <DatePicker />
        </div>
        <Graph />
        <div>
            <DataCard />
            <ProgressCard />
        </div>
        <Ratio />
    </>
}

export default Form