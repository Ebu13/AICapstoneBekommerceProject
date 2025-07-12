import AdminNavbar from "./AdminNavbar";
import { Container, Typography } from "@mui/material";

const AdminPage = () => {
  return (
    <div>
      <AdminNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Admin Paneli</Typography>
        <Typography variant="body1">Buradan kullanıcıları, ürünleri ve siparişleri yönetebilirsiniz.</Typography>
      </Container>
    </div>
  );
};
export default AdminPage;