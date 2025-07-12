import AdminNavbar from "./AdminNavbar";
import { Container, Typography, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Button } from "@mui/material";

const orders = [
  { id: 1, buyer: "Ali Veli", total: "₺2500", status: "Hazırlanıyor", carrier: "Yurtiçi Kargo", tracking: "1234567890" },
  { id: 2, buyer: "Ayşe Demir", total: "₺1200", status: "Kargoya Verildi", carrier: "Aras Kargo", tracking: "987654321" },
];

const OrdersPage = () => {
  return (
    <div>
      <AdminNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Sipariş Yönetimi</Typography>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Sipariş ID</TableCell>
                <TableCell>Alıcı</TableCell>
                <TableCell>Tutar</TableCell>
                <TableCell>Durum</TableCell>
                <TableCell>Kargo Firması</TableCell>
                <TableCell>Takip No</TableCell>
                <TableCell>İşlemler</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {orders.map((order) => (
                <TableRow key={order.id}>
                  <TableCell>{order.id}</TableCell>
                  <TableCell>{order.buyer}</TableCell>
                  <TableCell>{order.total}</TableCell>
                  <TableCell>{order.status}</TableCell>
                  <TableCell>{order.carrier}</TableCell>
                  <TableCell>{order.tracking}</TableCell>
                  <TableCell>
                    <Button variant="outlined" color="primary">Düzenle</Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Container>
    </div>
  );
};
export default OrdersPage;