"use client"
import Stack from '@mui/material/Stack';
import { Logo, DatePicker, DataCard, ProgressCard, Ratio, Graph } from '../Components'

const Form = () => {
    return <>
        <Stack spacing={2}>
            <Logo />
            <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2}>
                <DatePicker title="Start Date" />
                <DatePicker title="Stop Date" />
            </Stack>
            <Graph />
            <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2}>
                <DataCard />
                <ProgressCard />
            </Stack>
            <Ratio />
        </Stack>
    </>
}

export default Form