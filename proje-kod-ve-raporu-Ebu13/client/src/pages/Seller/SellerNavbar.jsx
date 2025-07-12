// SellerNavbar.jsx
import { AppBar, Toolbar, Typography, Button, Box, Container } from "@mui/material";
import { Link } from "react-router-dom";

const SellerNavbar = () => {
  return (
    <AppBar position="static" sx={{ backgroundColor: "#FF6F00", color: "#FFFFFF" }}>
      <Container>
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Satıcı Paneli</Typography>
          <Box>
            <Button color="inherit" component={Link} to="/seller">Ana Sayfa</Button>
            <Button color="inherit" component={Link} to="/seller/products">Ürünlerim</Button>
            <Button color="inherit" component={Link} to="/seller/earnings">Kazançlarım</Button>
            <Button color="inherit" component={Link} to="/seller/statistics">İstatistikler</Button>
            <Button color="inherit" component={Link} to="/seller/orders">Sipariş ve Kargo Yönetimi</Button>
            <Button color="inherit" component={Link} to="/seller/support">Canlı Destek (AI)</Button>
            <Button color="inherit" component={Link} to="/seller/profile">Profilim</Button> {/* Eklendi */}
            <Button color="inherit" component={Link} to="/logout">Çıkış Yap</Button>
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
};
export default SellerNavbar;
