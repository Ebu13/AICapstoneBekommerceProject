// BuyerNavbar.jsx
import { AppBar, Toolbar, Typography, Button, Box, Container } from "@mui/material";
import { Link } from "react-router-dom";
const BuyerNavbar = () => {
  return (
    <AppBar position="static" sx={{ backgroundColor: "#FF6F00", color: "#FFFFFF" }}>
      <Container>
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Alıcı Paneli</Typography>
          <Box>
            <Button color="inherit" component={Link} to="/buyer">Ana Sayfa</Button>
            <Button color="inherit" component={Link} to="/buyer/orders">Siparişlerim</Button>
            <Button color="inherit" component={Link} to="/buyer/cart">Sepetim</Button>
            <Button color="inherit" component={Link} to="/buyer/profile">Profilim</Button>
            <Button color="inherit" component={Link} to="/buyer/favorites">Favorilerim</Button>
            <Button color="inherit" component={Link} to="/buyer/reviews">Yorumlarım</Button>
            <Button color="inherit" component={Link} to="/buyer/support">Canlı Destek (AI)</Button>
            <Button color="inherit" component={Link} to="/logout">Çıkış Yap</Button>
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
};
export default BuyerNavbar;
