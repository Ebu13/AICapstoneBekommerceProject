import { useState } from "react";
import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, Grid, Card, CardContent, CardMedia, Button } from "@mui/material";

const initialFavorites = [
  { id: 1, name: "iPhone 14", price: "₺35.000", image: "https://via.placeholder.com/200" },
  { id: 2, name: "Nike Air Max", price: "₺3.500", image: "https://via.placeholder.com/200" },
  { id: 3, name: "Samsung TV 55\"", price: "₺18.000", image: "https://via.placeholder.com/200" },
];

const FavoritesPage = () => {
  const [favorites, setFavorites] = useState(initialFavorites);

  const removeFavorite = (id) => {
    setFavorites(favorites.filter((item) => item.id !== id));
  };

  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Favorilerim</Typography>
        {favorites.length === 0 ? (
          <Typography variant="body1">Favori ürününüz bulunmamaktadır.</Typography>
        ) : (
          <Grid container spacing={3}>
            {favorites.map((item) => (
              <Grid item xs={12} sm={6} md={4} key={item.id}>
                <Card sx={{ boxShadow: 3, transition: "0.3s", "&:hover": { boxShadow: 6 } }}>
                  <CardMedia component="img" height="200" image={item.image} alt={item.name} />
                  <CardContent>
                    <Typography variant="h6">{item.name}</Typography>
                    <Typography variant="body1" color="primary" sx={{ fontWeight: "bold", mt: 1 }}>{item.price}</Typography>
                  </CardContent>
                  <Button variant="contained" color="primary" fullWidth>Sepete Ekle</Button>
                  <Button variant="outlined" color="error" fullWidth onClick={() => removeFavorite(item.id)}>Favorilerden Kaldır</Button>
                </Card>
              </Grid>
            ))}
          </Grid>
        )}
      </Container>
    </div>
  );
};

export default FavoritesPage;
