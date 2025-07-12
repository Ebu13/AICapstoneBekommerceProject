import { ThemeProvider, createTheme } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import { Container, Box } from "@mui/material";
import AppRouter from "./routes/AppRouter";
import "bootstrap/dist/css/bootstrap.min.css";

const theme = createTheme({
  palette: {
    primary: { main: "#FF6F00" }, // Turuncu
    secondary: { main: "#FFFFFF" }, // Beyaz
    background: { default: "#F5F5F5", paper: "#FFFFFF" }, // Açık Gri & Beyaz
    text: { primary: "#333", secondary: "#666" },
  },
  typography: {
    fontFamily: "Roboto, sans-serif",
  },
});

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Box sx={{ backgroundColor: theme.palette.background.default, minHeight: "100vh" }}>
        <Container maxWidth="lg" sx={{ py: 4 }}>
          <AppRouter />
        </Container>
      </Box>
    </ThemeProvider>
  );
}

export default App;
