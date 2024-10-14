"use client"

import { Box } from '@mui/material';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFnsV3'
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { MobileDatePicker } from '@mui/x-date-pickers/MobileDatePicker';
import { enGB } from 'date-fns/locale';


const DatePicker = ({ title }: { title: string }) => {
    return (
        <LocalizationProvider
            dateAdapter={AdapterDateFns}
            adapterLocale={enGB}>
            <Box sx={{ display: 'flex', justifyContent: 'center', mt: 2, width: '100%', }}>
                <MobileDatePicker
                    sx={{ width: '100%' }}
                    label={title}
                    closeOnSelect={true}
                    displayWeekNumber={true}
                    orientation="portrait"
                    value={new Date()}
                />
            </Box>
        </LocalizationProvider>
    );
}

export default DatePicker