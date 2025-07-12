// ProductsPage.jsx
import SellerNavbar from "./SellerNavbar";
import { Container, Typography, Paper, List, ListItem, ListItemText, Button } from "@mui/material";
import { Link } from "react-router-dom";

const products = [
  { id: 1, name: "iPhone 14", price: "₺35.000", stock: 10 },
  { id: 2, name: "Nike Air Max", price: "₺3.500", stock: 25 },
];

const ProductsPage = () => {
  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Ürünlerim</Typography>
        <Paper sx={{ p: 2 }}>
          <List>
            {products.map((product) => (
              <ListItem key={product.id} divider component={Link} to={`/seller/products/${product.id}`} style={{ textDecoration: 'none', color: 'inherit' }}>
                <ListItemText primary={product.name} secondary={`Fiyat: ${product.price} - Stok: ${product.stock}`} />
                <Button variant="outlined" color="primary">Düzenle</Button>
              </ListItem>
            ))}
          </List>
        </Paper>
      </Container>
    </div>
  );
};
export default ProductsPage;
