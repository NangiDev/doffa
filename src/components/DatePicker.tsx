import dayjs from "dayjs";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { MobileDatePicker } from "@mui/x-date-pickers/MobileDatePicker";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import { useTheme } from "../context/ThemeContext";

interface DatePickerProps {
    title: string;
}

const DatePicker = ({ title }: DatePickerProps) => {
    const { theme } = useTheme(); // Get theme from context

    // Define MUI theme based on the current theme
    const datePickerTheme = createTheme({
        palette: {
            mode: theme, // 'light' or 'dark'
            primary: {
                main: "#4288f5", // Your primary color
            },
            background: {
                default: theme === "dark" ? "#212121" : "#ffffff",
                paper: theme === "dark" ? "#333333" : "#f9f9f9",
            },
            text: {
                primary: theme === "dark" ? "#ffffff" : "#212121",
            },
        },
    });

    return (
        <ThemeProvider theme={datePickerTheme}>
            <LocalizationProvider
                dateAdapter={AdapterDayjs}
                adapterLocale="en-gb"
            >
                <MobileDatePicker
                    label={title}
                    closeOnSelect={true}
                    displayWeekNumber={true}
                    orientation="portrait"
                    value={dayjs(new Date())}
                    sx={{
                        backgroundColor: theme === "dark" ? "#333333" : "#ffffff",
                        color: theme === "dark" ? "#ffffff" : "#212121",
                        borderRadius: "8px",
                        "& .MuiInputBase-input": {
                            color: theme === "dark" ? "#ffffff" : "#212121",
                        },
                    }}
                />
            </LocalizationProvider>
        </ThemeProvider>
    );
}

export default DatePicker;