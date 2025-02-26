import DarkModeIcon from "@mui/icons-material/DarkMode";
import LightModeIcon from "@mui/icons-material/LightMode";
import { IconButton } from "@mui/material";
import { useTheme } from "../context/ThemeContext";

export const ThemeToggle = () => {
    const { theme, toggleTheme } = useTheme();

    return (
        <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
            <IconButton onClick={toggleTheme} title="Toggle Theme" color="primary">
                {theme === "dark" ? <LightModeIcon /> : <DarkModeIcon />}
            </IconButton>
        </div>
    );
};
