import "./App.css";
import DatePicker from "./components/DatePicker";
import Logo from "./components/Logo";
import { ThemeToggle } from "./components/ThemeToggle";
import { useTheme } from "./context/ThemeContext"; // Import useTheme hook
import ExpandingCard from './components/ExpandingCard';
import { Stack } from "@mui/material";

function App() {
  const { theme } = useTheme(); // Get current theme

  return (
    <Stack
      className={`app ${theme}`}
      direction={"column"}
      justifyContent={"center"}
      alignItems={"center"}
      spacing={"2em"}
    >
      <ThemeToggle />
      <Logo />
      <Stack
        direction={{ xs: 'column', sm: 'row' }}
        spacing={{ xs: 2, sm: 4 }}
        justifyContent={"center"}
        alignItems={"center"}
      >
        <DatePicker title="Start Date" />
        <DatePicker title="Stop Date" />
      </Stack>
      <ExpandingCard title="Graph">
        Graph
      </ExpandingCard>
      <ExpandingCard title="Data">
        Graph
      </ExpandingCard>
      <ExpandingCard title="Progress">
        Graph
      </ExpandingCard>
    </Stack >
  );
}

export default App;
