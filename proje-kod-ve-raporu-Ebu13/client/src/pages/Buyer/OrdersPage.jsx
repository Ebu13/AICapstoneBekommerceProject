import { useState } from "react";
import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, Paper, List, ListItem, ListItemText, Button, Divider, Box } from "@mui/material";

const initialOrders = [
  { id: "12345", status: "Yolda", tracking: "ABC123456", carrier: "Yurtiçi Kargo", total: "₺2500", date: "2024-03-20", items: ["iPhone 14", "AirPods Pro"] },
  { id: "67890", status: "Teslim Edildi", tracking: "XYZ987654", carrier: "Aras Kargo", total: "₺1200", date: "2024-02-15", items: ["Nike Air Max"] },
];

const OrdersPage = () => {
  const [orders] = useState(initialOrders);

  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Siparişlerim</Typography>
        {orders.length === 0 ? (
          <Typography variant="body1">Henüz siparişiniz bulunmamaktadır.</Typography>
        ) : (
          <List>
            {orders.map((order) => (
              <Paper key={order.id} sx={{ p: 2, mb: 3, boxShadow: 3 }}>
                <ListItem divider>
                  <ListItemText
                    primary={`Sipariş #${order.id}`}
                    secondary={`Sipariş Tarihi: ${order.date} | Toplam: ${order.total}`}
                  />
                </ListItem>
                <Box sx={{ pl: 2, my: 1 }}>
                  <Typography variant="body2" color="textSecondary">Ürünler: {order.items.join(", ")}</Typography>
                  <Typography variant="body2" color="textSecondary">Kargo Durumu: {order.status}</Typography>
                  {order.status !== "Teslim Edildi" && (
                    <Typography variant="body2" color="textSecondary">Kargo Takip: {order.tracking} ({order.carrier})</Typography>
                  )}
                </Box>
                <Divider sx={{ my: 2 }} />
                <Box sx={{ display: "flex", justifyContent: "flex-end" }}>
                  <Button variant="outlined" color="primary">Sipariş Detayları</Button>
                </Box>
              </Paper>
            ))}
          </List>
        )}
      </Container>
    </div>
  );
};

export default OrdersPage;
