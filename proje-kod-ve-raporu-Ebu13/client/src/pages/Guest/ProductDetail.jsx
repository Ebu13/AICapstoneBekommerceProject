import { useParams } from "react-router-dom";
import { useState } from "react";
import {
  Container, Typography, Card, CardMedia, CardContent,
  Button, Box, Divider, Paper, Rating, TextField
} from "@mui/material";
import GuestNavbar from "./GuestNavbar";

const products = [
  {
    id: 1,
    name: "iPhone 14",
    price: 35000,
    stock: 5,
    brand: "Apple",
    image: "https://via.placeholder.com/300",
    category: "Elektronik",
    rating: 4.5,
    description: "Apple iPhone 14, güçlü işlemcisi ve gelişmiş kamerasıyla yeni nesil akıllı telefon deneyimi sunar."
  },
  {
    id: 2,
    name: "Nike Air Max",
    price: 3500,
    stock: 12,
    brand: "Nike",
    image: "https://via.placeholder.com/300",
    category: "Moda",
    rating: 4.2,
    description: "Nike Air Max spor ayakkabı, üstün konfor ve şık tasarımıyla öne çıkıyor."
  },
  {
    id: 3,
    name: "Samsung TV 55\"",
    price: 18000,
    stock: 3,
    brand: "Samsung",
    image: "https://via.placeholder.com/300",
    category: "Elektronik",
    rating: 4.7,
    description: "Samsung 55 inç 4K UHD Smart TV, canlı renkler ve akıllı özelliklerle sinema keyfi sunar."
  },
  {
    id: 4,
    name: "Ahşap Yemek Masası",
    price: 7200,
    stock: 7,
    brand: "IKEA",
    image: "https://via.placeholder.com/300",
    category: "Ev & Yaşam",
    rating: 4.1,
    description: "Şık ve dayanıklı ahşap yemek masası, modern ev dekorasyonu için mükemmel bir seçimdir."
  },
  {
    id: 5,
    name: "Futbol Topu",
    price: 600,
    stock: 20,
    brand: "Adidas",
    image: "https://via.placeholder.com/300",
    category: "Spor",
    rating: 4.3,
    description: "Profesyonel futbol topu, dayanıklı yapısı ve mükemmel denge özellikleri ile sahada üstün performans sağlar."
  }
];

const initialReviews = {
  1: [{ user: "Mehmet Y.", rating: 5, comment: "Mükemmel telefon, hızlı kargo!" }],
  2: [{ user: "Ayşe D.", rating: 4, comment: "Rahat ama biraz pahalı" }],
  3: [{ user: "Can K.", rating: 5, comment: "Görüntü kalitesi harika, tavsiye ederim" }],
  4: [{ user: "Zeynep L.", rating: 4, comment: "Ahşap kalitesi güzel ama montaj zor" }],
  5: [{ user: "Ali T.", rating: 4, comment: "Sahada iyi ama daha dayanıklı olabilirdi" }]
};

const ProductDetail = () => {
  const { id } = useParams();
  const productId = Number(id);
  const product = products.find((p) => p.id === productId);

  const [reviews, setReviews] = useState(initialReviews[productId] || []);
  const [newReview, setNewReview] = useState({ user: "", rating: 3, comment: "" });

  const handleAddReview = () => {
    if (newReview.user.trim() && newReview.comment.trim()) {
      setReviews([...reviews, newReview]);
      setNewReview({ user: "", rating: 3, comment: "" });
    }
  };

  if (!product) {
    return (
      <Container sx={{ mt: 5 }}>
        <Typography variant="h4" color="error">Ürün bulunamadı!</Typography>
      </Container>
    );
  }

  return (
    <div>
      <GuestNavbar />
      <Container sx={{ mt: 5 }}>
        <Card sx={{ display: "flex", p: 3, boxShadow: 4 }}>
          <CardMedia component="img" image={product.image} alt={product.name} sx={{ width: 400, height: "auto", mr: 3 }} />
          <CardContent>
            <Typography variant="h4" gutterBottom>{product.name}</Typography>
            <Typography variant="h6" color="textSecondary" sx={{ mb: 1 }}>Marka: {product.brand}</Typography>
            <Typography variant="h5" color="primary" sx={{ fontWeight: "bold", mb: 2 }}>₺{product.price.toLocaleString()}</Typography>
            <Typography variant="body1" sx={{ mb: 2 }}>{product.description}</Typography>
            <Typography variant="body2" color="textSecondary" sx={{ mb: 2 }}>Kategori: {product.category}</Typography>
            <Typography variant="body2" color="textSecondary">Stok Durumu: {product.stock > 0 ? "Stokta Var" : "Stokta Yok"}</Typography>
            <Box sx={{ display: "flex", alignItems: "center", mt: 2 }}>
              <Rating value={product.rating} precision={0.1} readOnly />
              <Typography variant="body2" sx={{ ml: 1 }}>({product.rating})</Typography>
            </Box>
            <Box sx={{ mt: 3 }}>
              <Button variant="contained" color="primary" sx={{ mr: 2 }}>Sepete Ekle</Button>
              <Button variant="outlined" color="secondary">Favorilere Ekle</Button>
            </Box>
          </CardContent>
        </Card>

        {/* Yorumlar */}
        <Divider sx={{ my: 4 }} />
        <Typography variant="h5" gutterBottom>Ürün Yorumları</Typography>
        <Paper sx={{ p: 3, mb: 4 }}>
          {reviews.length === 0 ? (
            <Typography variant="body1" color="textSecondary">Henüz yorum yapılmamış.</Typography>
          ) : (
            reviews.map((review, index) => (
              <Box key={index} sx={{ mb: 2 }}>
                <Typography variant="body1" sx={{ fontWeight: "bold" }}>{review.user}</Typography>
                <Rating value={review.rating} readOnly />
                <Typography variant="body2">{review.comment}</Typography>
                <Divider sx={{ my: 1 }} />
              </Box>
            ))
          )}
        </Paper>

        {/* Yorum Formu */}
        <Paper sx={{ p: 3 }}>
          <Typography variant="h6" gutterBottom>Yorum Yap</Typography>
          <TextField fullWidth label="Adınız" value={newReview.user} onChange={(e) => setNewReview({ ...newReview, user: e.target.value })} sx={{ mb: 2 }} />
          <Rating value={newReview.rating} onChange={(e, newValue) => setNewReview({ ...newReview, rating: newValue })} sx={{ mb: 2 }} />
          <TextField fullWidth label="Yorumunuz" multiline rows={3} value={newReview.comment} onChange={(e) => setNewReview({ ...newReview, comment: e.target.value })} sx={{ mb: 2 }} />
          <Button variant="contained" color="primary" onClick={handleAddReview}>Gönder</Button>
        </Paper>
      </Container>
    </div>
  );
};

export default ProductDetail;
