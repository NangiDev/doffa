import { useTheme } from "../context/ThemeContext";
import { IconButton } from "@mui/material";
import DarkModeIcon from "@mui/icons-material/DarkMode";
import LightModeIcon from "@mui/icons-material/LightMode";

export const ThemeToggle = () => {
    const { theme, toggleTheme, colors } = useTheme();

    return (
        <IconButton onClick={toggleTheme} title="Toggle Theme" style={{ color: colors.primary }}>
            {theme === "dark" ? <LightModeIcon /> : <DarkModeIcon />}
        </IconButton>
    );
};
