// GuestNavbar.jsx
import { AppBar, Toolbar, Typography, Button, Box, Container } from "@mui/material";
import { Link } from "react-router-dom";
const GuestNavbar = () => {
  return (
    <AppBar position="sticky" sx={{ backgroundColor: "#FF6F00", color: "#FFFFFF" }}>
      <Container>
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>E-Ticaret Platformu</Typography>
          <Box>
            <Button color="inherit" component={Link} to="/">Ana Sayfa</Button>
            <Button color="inherit" component={Link} to="/login">Giriş Yap</Button>
            <Button color="inherit" component={Link} to="/register">Kayıt Ol</Button>
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
};
export default GuestNavbar;