import { useState, useEffect } from "react";
import {
  Container, Grid, TextField, Button, Card, CardContent, CardMedia, Typography, Box,
  Select, MenuItem, FormControl, InputLabel, Paper, Slider, Checkbox, FormControlLabel
} from "@mui/material";
import { Link } from "react-router-dom";
import BuyerNavbar from "./BuyerNavbar";
import api from "../../services/api"; // api.js'yi import ettik

const categories = ['Elektronik', 'Moda', 'Ev_Yasam', 'Spor', 'Otomotiv', 'Kozmetik'];
const brands = ['Apple', 'Samsung', 'Nike', 'Adidas', 'IKEA', "L'Oreal"];

const BuyerPage = () => {
  const [search, setSearch] = useState("");
  const [category, setCategory] = useState("");
  const [priceRange, setPriceRange] = useState([0, 200000]);
  const [brand, setBrand] = useState("");
  const [rating, setRating] = useState(0);
  const [inStock, setInStock] = useState(false);
  const [sort, setSort] = useState("");

  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const filters = {
          search,
          category,
          minPrice: priceRange[0],
          maxPrice: priceRange[1],
          brand,
          rating,
          inStock,
          sort
        };
        const response = await api.getAllProducts(filters);
        setProducts(response);
      } catch (error) {
        console.error("Error fetching products:", error);
      }
    };

    fetchProducts();
  }, [search, category, priceRange, brand, rating, inStock, sort]);

  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Grid container spacing={3}>
          {/* Filtre Paneli */}
          <Grid item xs={12} md={3}>
            <Paper
              sx={{
                p: 3,
                boxShadow: 4,
                borderRadius: 2,
                position: "sticky",
                top: 80,
                maxHeight: "85vh",
                overflowY: "auto",
                scrollbarWidth: "thin",
                "&::-webkit-scrollbar": { width: "6px" },
                "&::-webkit-scrollbar-thumb": {
                  backgroundColor: "#ccc",
                  borderRadius: "4px",
                },
              }}
            >
              <Typography variant="h6" sx={{ fontWeight: "bold", color: "#FF6F00", mb: 2 }}>
                Filtrele
              </Typography>

              <TextField
                fullWidth
                variant="outlined"
                label="Ürün Ara"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                sx={{ mb: 2 }}
              />

              <FormControl fullWidth sx={{ mb: 2 }}>
                <InputLabel>Kategori</InputLabel>
                <Select value={category} onChange={(e) => setCategory(e.target.value)}>
                  <MenuItem value="">Tümü</MenuItem>
                  {categories.map(cat => (
                    <MenuItem key={cat} value={cat}>{cat.replace("_", " & ")}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              <Typography variant="body1" sx={{ fontWeight: "bold", mt: 2 }}>
                Fiyat Aralığı
              </Typography>
              <Slider
                value={priceRange}
                onChange={(e, newValue) => setPriceRange(newValue)}
                valueLabelDisplay="auto"
                min={0}
                max={200000}
                sx={{ color: "#FF6F00" }}
              />

              <Typography variant="body1" sx={{ fontWeight: "bold", mt: 2 }}>
                Minimum Puan
              </Typography>
              <Slider
                value={rating}
                onChange={(e, newValue) => setRating(newValue)}
                valueLabelDisplay="auto"
                min={0}
                max={5}
                step={0.5}
                sx={{ color: "#FF6F00" }}
              />

              <FormControl fullWidth sx={{ mb: 2 }}>
                <InputLabel>Marka</InputLabel>
                <Select value={brand} onChange={(e) => setBrand(e.target.value)}>
                  <MenuItem value="">Tümü</MenuItem>
                  {brands.map((b) => (
                    <MenuItem key={b} value={b}>{b}</MenuItem>
                  ))}
                </Select>
              </FormControl>

              <FormControlLabel
                control={<Checkbox checked={inStock} onChange={(e) => setInStock(e.target.checked)} />}
                label="Sadece stoktakileri göster"
              />

              <FormControl fullWidth sx={{ mt: 2 }}>
                <InputLabel>Sırala</InputLabel>
                <Select value={sort} onChange={(e) => setSort(e.target.value)}>
                  <MenuItem value="">Varsayılan</MenuItem>
                  <MenuItem value="priceLow">Fiyata Göre (Artan)</MenuItem>
                  <MenuItem value="priceHigh">Fiyata Göre (Azalan)</MenuItem>
                  <MenuItem value="rating">Puana Göre</MenuItem>
                </Select>
              </FormControl>
            </Paper>
          </Grid>

          {/* Ürünler */}
          <Grid item xs={12} md={9}>
            <Grid container spacing={3}>
              {products.length === 0 ? (
                <Typography variant="h6" sx={{ m: 3 }}>Uygun ürün bulunamadı.</Typography>
              ) : (
                products.map((product) => (
                  <Grid item xs={12} sm={6} md={4} key={product.id}>
                    <Card sx={{ boxShadow: 3, '&:hover': { boxShadow: 6 } }}>
                      <Link to={`/product/${product.id}`} style={{ textDecoration: "none", color: "inherit" }}>
                        <CardMedia component="img" height="200" image={product.image} alt={product.name} />
                        <CardContent>
                          <Typography variant="h6">{product.name}</Typography>
                          <Typography variant="body1" color="primary" sx={{ fontWeight: "bold", mt: 1 }}>
                            ₺{product.price.toLocaleString()}
                          </Typography>
                          <Typography variant="body2" color="textSecondary">Puan: {product.rating} ⭐</Typography>
                        </CardContent>
                      </Link>
                      <Button variant="contained" fullWidth sx={{ borderRadius: 0 }}>
                        Sepete Ekle
                      </Button>
                    </Card>
                  </Grid>
                ))
              )}
            </Grid>
          </Grid>
        </Grid>
      </Container>
    </div>
  );
};

export default BuyerPage;
