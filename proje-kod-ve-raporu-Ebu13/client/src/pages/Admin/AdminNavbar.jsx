// AdminNavbar.jsx
import { AppBar, Toolbar, Typography, Button, Box, Container } from "@mui/material";
import { Link } from "react-router-dom";
const AdminNavbar = () => {
  return (
    <AppBar position="static" sx={{ backgroundColor: "#FF6F00", color: "#FFFFFF" }}>
      <Container>
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>Admin Paneli</Typography>
          <Box>
            <Button color="inherit" component={Link} to="/admin">Ana Sayfa</Button>
            <Button color="inherit" component={Link} to="/admin/users">Kullanıcı Yönetimi</Button>
            <Button color="inherit" component={Link} to="/admin/products">Ürün Yönetimi</Button>
            <Button color="inherit" component={Link} to="/admin/orders">Sipariş Yönetimi</Button>
            <Button color="inherit" component={Link} to="/admin/analytics">Detaylı Analizler</Button>
            <Button color="inherit" component={Link} to="/logout">Çıkış Yap</Button>
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
};
export default AdminNavbar;