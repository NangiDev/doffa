import Logo from '../logo/Logo'
import DatePicker from '../date_picker/DatePicker'
import Graph from '../graph/Graph'
import DataCard from '../data_card/DataCard'
import ProgressCard from '../progress_card/ProgressCard'
import Ratio from '../ratio/Ratio'

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