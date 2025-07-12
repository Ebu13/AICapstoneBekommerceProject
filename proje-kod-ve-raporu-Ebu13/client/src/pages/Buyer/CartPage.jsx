import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, Paper, List, ListItem, ListItemText, Button } from "@mui/material";

const cartItems = [
  { id: 1, name: "iPhone 14", price: "₺35.000" },
  { id: 2, name: "Nike Air Max", price: "₺3.500" },
];

const CartPage = () => {
  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Sepetim</Typography>
        <Paper sx={{ p: 2 }}>
          <List>
            {cartItems.map((item) => (
              <ListItem key={item.id} divider>
                <ListItemText primary={item.name} secondary={`Fiyat: ${item.price}`} />
              </ListItem>
            ))}
          </List>
          <Button variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>Satın Al</Button>
        </Paper>
      </Container>
    </div>
  );
};
export default CartPage;
