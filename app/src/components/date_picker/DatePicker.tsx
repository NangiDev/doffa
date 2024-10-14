"use client"

import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFnsV3'
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { MobileDatePicker } from '@mui/x-date-pickers/MobileDatePicker';
import { enGB } from 'date-fns/locale';


const DatePicker = ({ title }: { title: string }) => {
    return (
        <LocalizationProvider
            dateAdapter={AdapterDateFns}
            adapterLocale={enGB}>
            <MobileDatePicker
                label={title}
                closeOnSelect={true}
                displayWeekNumber={true}
                orientation='portrait'
                value={new Date()} />
        </LocalizationProvider>
    );
}

export default DatePicker