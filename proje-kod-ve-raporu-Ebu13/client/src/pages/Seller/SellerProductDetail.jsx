// SellerProductDetail.jsx
import { useParams } from "react-router-dom";
import { Container, Typography, Card, CardContent, CardMedia, List, ListItem, ListItemText, Paper } from "@mui/material";
import SellerNavbar from "./SellerNavbar";

const products = [
  { id: 1, name: "iPhone 14", price: "₺35.000", stock: 10, image: "https://via.placeholder.com/300", description: "Apple iPhone 14, gelişmiş kamera ve güçlü işlemcisiyle..." },
  { id: 2, name: "Nike Air Max", price: "₺3.500", stock: 25, image: "https://via.placeholder.com/300", description: "Nike Air Max, mükemmel konfor sunan spor ayakkabı..." }
];

const reviews = [
  { id: 1, user: "Mehmet Kaya", rating: 5, comment: "Harika ürün, çok memnun kaldım!" },
  { id: 2, user: "Zeynep Yılmaz", rating: 4, comment: "Kaliteli ama kargo biraz gecikti." }
];

const SellerProductDetail = () => {
  const { id } = useParams();
  const product = products.find((p) => p.id === parseInt(id));

  if (!product) {
    return (
      <Container sx={{ mt: 5 }}>
        <Typography variant="h4" color="error">Ürün bulunamadı!</Typography>
      </Container>
    );
  }

  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Card sx={{ display: "flex", boxShadow: 4, p: 3 }}>
          <CardMedia component="img" image={product.image} alt={product.name} sx={{ width: 300, height: "auto", mr: 3 }} />
          <CardContent>
            <Typography variant="h4">{product.name}</Typography>
            <Typography variant="h5" color="primary" sx={{ fontWeight: "bold", mt: 2 }}>{product.price}</Typography>
            <Typography variant="body1" sx={{ mt: 2 }}>{product.description}</Typography>
            <Typography variant="body2" color="textSecondary" sx={{ mt: 2 }}>Stok: {product.stock} adet</Typography>
          </CardContent>
        </Card>

        <Paper sx={{ p: 3, mt: 4 }}>
          <Typography variant="h5" gutterBottom>Müşteri Yorumları</Typography>
          <List>
            {reviews.map((review) => (
              <ListItem key={review.id} divider>
                <ListItemText primary={`${review.user} - ${"⭐".repeat(review.rating)}`} secondary={review.comment} />
              </ListItem>
            ))}
          </List>
        </Paper>
      </Container>
    </div>
  );
};

export default SellerProductDetail;
