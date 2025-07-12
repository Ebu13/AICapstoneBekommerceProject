import { useState } from "react";
import SellerNavbar from "./SellerNavbar";
import { Container, Typography, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Button, Select, MenuItem, TextField, Dialog, DialogActions, DialogContent, DialogTitle, Box } from "@mui/material";

// Örnek sipariş verileri
const initialOrders = [
  { id: 1, customer: "Ali Veli", product: "iPhone 14", price: "₺35.000", status: "Kargoya Verildi", tracking: "1234567890", carrier: "Yurtiçi Kargo", note: "Hassas ürün, dikkatli taşınmalı", deliveryDate: "2024-03-20", shippingCost: "₺50", history: ["Hazırlanıyor", "Kargoya Verildi"] },
  { id: 2, customer: "Ayşe Demir", product: "Nike Air Max", price: "₺3.500", status: "Hazırlanıyor", tracking: "-", carrier: "-", note: "", deliveryDate: "2024-03-25", shippingCost: "₺30", history: ["Hazırlanıyor"] },
];

const SellerOrdersAndShipping = () => {
  const [orders, setOrders] = useState(initialOrders);
  const [selectedOrder, setSelectedOrder] = useState(null);
  const [open, setOpen] = useState(false);

  const handleOpen = (order) => {
    setSelectedOrder(order);
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
    setSelectedOrder(null);
  };

  const handleSave = () => {
    setOrders((prevOrders) =>
      prevOrders.map((order) =>
        order.id === selectedOrder.id
          ? { ...selectedOrder, history: [...selectedOrder.history, selectedOrder.status] }
          : order
      )
    );
    handleClose();
  };

  const getNextStatusOptions = (history) => {
    if (history.includes("Teslim Edildi")) return [];
    if (history.includes("Kargoya Verildi")) return ["Teslim Edildi"];
    if (history.includes("Hazırlanıyor")) return ["Kargoya Verildi"];
    return ["Hazırlanıyor"];
  };

  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Sipariş ve Kargo Yönetimi</Typography>
        <TableContainer component={Paper} sx={{ mb: 3 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Sipariş ID</TableCell>
                <TableCell>Müşteri</TableCell>
                <TableCell>Ürün</TableCell>
                <TableCell>Fiyat</TableCell>
                <TableCell>Kargo Durumu</TableCell>
                <TableCell>Kargo Firması</TableCell>
                <TableCell>Takip Numarası</TableCell>
                <TableCell>Teslim Tarihi</TableCell>
                <TableCell>Kargo Ücreti</TableCell>
                <TableCell>İşlemler</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {orders.map((order) => (
                <TableRow key={order.id}>
                  <TableCell>{order.id}</TableCell>
                  <TableCell>{order.customer}</TableCell>
                  <TableCell>{order.product}</TableCell>
                  <TableCell>{order.price}</TableCell>
                  <TableCell>{order.status}</TableCell>
                  <TableCell>{order.carrier}</TableCell>
                  <TableCell>{order.tracking}</TableCell>
                  <TableCell>{order.deliveryDate}</TableCell>
                  <TableCell>{order.shippingCost}</TableCell>
                  <TableCell>
                    <Button 
                      variant="contained" 
                      color="primary" 
                      size="small" 
                      onClick={() => handleOpen(order)}
                      disabled={order.status === "Teslim Edildi"}
                    >Düzenle</Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>

        {/* Düzenleme Modal'ı */}
        <Dialog open={open} onClose={handleClose}>
          <DialogTitle>Siparişi Düzenle</DialogTitle>
          <DialogContent>
            <Typography variant="body1" sx={{ mb: 2 }}>Müşteri: {selectedOrder?.customer}</Typography>
            <Typography variant="body1" sx={{ mb: 2 }}>Ürün: {selectedOrder?.product}</Typography>
            <Typography variant="body1" sx={{ mb: 2 }}>Fiyat: {selectedOrder?.price}</Typography>
            <Select
              fullWidth
              value={selectedOrder?.status || ""}
              onChange={(e) => setSelectedOrder({ ...selectedOrder, status: e.target.value })}
              sx={{ mb: 2 }}
            >
              {getNextStatusOptions(selectedOrder?.history || []).map((status) => (
                <MenuItem key={status} value={status}>{status}</MenuItem>
              ))}
            </Select>
            <Select
              fullWidth
              value={selectedOrder?.carrier || ""}
              onChange={(e) => setSelectedOrder({ ...selectedOrder, carrier: e.target.value })}
              sx={{ mb: 2 }}
            >
              <MenuItem value="-">-</MenuItem>
              <MenuItem value="Yurtiçi Kargo">Yurtiçi Kargo</MenuItem>
              <MenuItem value="Aras Kargo">Aras Kargo</MenuItem>
              <MenuItem value="MNG Kargo">MNG Kargo</MenuItem>
              <MenuItem value="PTT Kargo">PTT Kargo</MenuItem>
            </Select>
            <TextField
              fullWidth
              label="Takip Numarası"
              value={selectedOrder?.tracking || ""}
              onChange={(e) => setSelectedOrder({ ...selectedOrder, tracking: e.target.value })}
              sx={{ mb: 2 }}
            />
            <TextField
              fullWidth
              label="Sipariş Notu"
              multiline
              rows={2}
              value={selectedOrder?.note || ""}
              onChange={(e) => setSelectedOrder({ ...selectedOrder, note: e.target.value })}
              sx={{ mb: 2 }}
            />
            <Typography variant="body2" sx={{ mt: 2 }}>Geçmiş Durumlar: {selectedOrder?.history?.join(" → ")}</Typography>
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose} color="error">İptal</Button>
            <Button onClick={handleSave} color="primary">Kaydet</Button>
          </DialogActions>
        </Dialog>
      </Container>
    </div>
  );
};

export default SellerOrdersAndShipping;
