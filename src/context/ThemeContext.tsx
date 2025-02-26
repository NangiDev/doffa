import { createContext, useContext, useEffect, useState } from "react";
import { lightTheme, darkTheme } from "../theme";

interface ThemeContextType {
    theme: "light" | "dark";
    colors: typeof lightTheme;
    toggleTheme: () => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider = ({ children }: { children: React.ReactNode }) => {
    const getInitialTheme = (): "light" | "dark" => {
        return (localStorage.getItem("theme") as "light" | "dark") || "light";
    };

    const [theme, setTheme] = useState<"light" | "dark">(getInitialTheme);
    const colors = theme === "dark" ? darkTheme : lightTheme;

    useEffect(() => {
        localStorage.setItem("theme", theme);
        document.documentElement.style.setProperty("--bg-color", colors.background);
        document.documentElement.style.setProperty("--text-color", colors.text);
        document.documentElement.style.setProperty("--primary-color", colors.primary);
    }, [theme, colors]);

    const toggleTheme = () => setTheme(theme === "dark" ? "light" : "dark");

    return (
        <ThemeContext.Provider value={{ theme, colors, toggleTheme }}>
            {children}
        </ThemeContext.Provider>
    );
};

export const useTheme = () => {
    const context = useContext(ThemeContext);
    if (!context) throw new Error("useTheme must be used within a ThemeProvider");
    return context;
};
