import { useState } from "react";
import {
  Container, Grid, TextField, Button, Card, CardContent, CardMedia, Typography,
  Paper, Slider, Checkbox, FormControlLabel, Select, MenuItem,
  FormControl, InputLabel, Chip, OutlinedInput, Box
} from "@mui/material";
import { Link } from "react-router-dom";
import GuestNavbar from "./GuestNavbar";

const categories = ["Elektronik", "Moda", "Ev_Yasam", "Spor", "Otomotiv", "Kozmetik"];
const brands = ["Apple", "Nike", "Samsung", "IKEA", "Adidas"];

const mockProducts = [
  {
    id: 1,
    name: "iPhone 14",
    price: 35000,
    stock: 5,
    brand: "Apple",
    imageUrl: "https://via.placeholder.com/300",
    category: "Elektronik",
    rating: 4.5,
    seller: "TeknoMarket",
    description: "Apple iPhone 14, güçlü işlemcisi ve gelişmiş kamerasıyla yeni nesil akıllı telefon deneyimi sunar.",
    inStock: true
  },
  {
    id: 2,
    name: "Nike Air Max",
    price: 3500,
    stock: 12,
    brand: "Nike",
    imageUrl: "https://via.placeholder.com/300",
    category: "Moda",
    rating: 4.2,
    seller: "ModaDükkan",
    description: "Nike Air Max spor ayakkabı, üstün konfor ve şık tasarımıyla öne çıkıyor.",
    inStock: true
  },
  {
    id: 3,
    name: "Samsung TV 55\"",
    price: 18000,
    stock: 3,
    brand: "Samsung",
    imageUrl: "https://via.placeholder.com/300",
    category: "Elektronik",
    rating: 4.7,
    seller: "TeknoMarket",
    description: "Samsung 55 inç 4K UHD Smart TV, canlı renkler ve akıllı özelliklerle sinema keyfi sunar.",
    inStock: true
  },
  {
    id: 4,
    name: "Ahşap Yemek Masası",
    price: 7200,
    stock: 7,
    brand: "IKEA",
    imageUrl: "https://via.placeholder.com/300",
    category: "Ev_Yasam",
    rating: 4.1,
    seller: "EvDekor",
    description: "Şık ve dayanıklı ahşap yemek masası, modern ev dekorasyonu için mükemmel bir seçimdir.",
    inStock: true
  },
  {
    id: 5,
    name: "Futbol Topu",
    price: 600,
    stock: 20,
    brand: "Adidas",
    imageUrl: "https://via.placeholder.com/300",
    category: "Spor",
    rating: 4.3,
    seller: "SporTime",
    description: "Profesyonel futbol topu, dayanıklı yapısı ve mükemmel denge özellikleri ile sahada üstün performans sağlar.",
    inStock: true
  }
];

const GuestPage = () => {
  const [search, setSearch] = useState("");
  const [selectedCategories, setSelectedCategories] = useState([]);
  const [selectedBrands, setSelectedBrands] = useState([]);
  const [priceRange, setPriceRange] = useState([0, 50000]);
  const [minRating, setMinRating] = useState(0);
  const [onlyInStock, setOnlyInStock] = useState(false);
  const [sortOption, setSortOption] = useState("");

  const filteredProducts = mockProducts
    .filter(p =>
      p.name.toLowerCase().includes(search.toLowerCase()) &&
      (selectedCategories.length === 0 || selectedCategories.includes(p.category)) &&
      (selectedBrands.length === 0 || selectedBrands.includes(p.brand)) &&
      p.price >= priceRange[0] &&
      p.price <= priceRange[1] &&
      p.rating >= minRating &&
      (!onlyInStock || p.stock > 0)
    )
    .sort((a, b) => {
      if (sortOption === "priceLow") return a.price - b.price;
      if (sortOption === "priceHigh") return b.price - a.price;
      if (sortOption === "rating") return b.rating - a.rating;
      return 0;
    });

  return (
    <div>
      <GuestNavbar />
      <Container sx={{ mt: 4 }}>
        <Grid container spacing={3}>
          <Grid item xs={12} md={3}>
            <Paper sx={{ p: 2, mb: 2 }}>
              <TextField fullWidth label="Ara" value={search} onChange={(e) => setSearch(e.target.value)} />
            </Paper>
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle1">Fiyat Aralığı</Typography>
              <Slider value={priceRange} onChange={(e, newValue) => setPriceRange(newValue)} min={0} max={50000} valueLabelDisplay="auto" />
            </Paper>
            <Paper sx={{ p: 2, mb: 2 }}>
              <FormControl fullWidth>
                <InputLabel>Kategoriler</InputLabel>
                <Select multiple value={selectedCategories} onChange={(e) => setSelectedCategories(e.target.value)} input={<OutlinedInput label="Kategoriler" />} renderValue={(selected) => (<Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5 }}>{selected.map(value => (<Chip key={value} label={value} />))}</Box>)}>
                  {categories.map(category => (<MenuItem key={category} value={category}>{category.replace("_", " & ")}</MenuItem>))}
                </Select>
              </FormControl>
            </Paper>
            <Paper sx={{ p: 2, mb: 2 }}>
              <FormControl fullWidth>
                <InputLabel>Markalar</InputLabel>
                <Select multiple value={selectedBrands} onChange={(e) => setSelectedBrands(e.target.value)} input={<OutlinedInput label="Markalar" />} renderValue={(selected) => (<Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5 }}>{selected.map(value => (<Chip key={value} label={value} />))}</Box>)}>
                  {brands.map(brand => (<MenuItem key={brand} value={brand}>{brand}</MenuItem>))}
                </Select>
              </FormControl>
            </Paper>
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle1">Minimum Puan</Typography>
              <Slider value={minRating} onChange={(e, newValue) => setMinRating(newValue)} min={0} max={5} step={0.1} valueLabelDisplay="auto" />
            </Paper>
            <FormControlLabel control={<Checkbox checked={onlyInStock} onChange={(e) => setOnlyInStock(e.target.checked)} />} label="Sadece Stoktakiler" />
            <FormControl fullWidth sx={{ mt: 2 }}>
              <InputLabel>Sırala</InputLabel>
              <Select value={sortOption} onChange={(e) => setSortOption(e.target.value)} label="Sırala">
                <MenuItem value="">Varsayılan</MenuItem>
                <MenuItem value="priceLow">Fiyata Göre (Artan)</MenuItem>
                <MenuItem value="priceHigh">Fiyata Göre (Azalan)</MenuItem>
                <MenuItem value="rating">Puanlama</MenuItem>
              </Select>
            </FormControl>
          </Grid>

          <Grid item xs={12} md={9}>
            <Grid container spacing={3}>
              {filteredProducts.map(product => (
                <Grid item xs={12} sm={6} md={4} key={product.id}>
                  <Card sx={{ height: "100%", display: "flex", flexDirection: "column", boxShadow: 3, '&:hover': { boxShadow: 6 } }}>
                    <Link to={`/product/${product.id}`} style={{ textDecoration: "none", color: "inherit" }}>
                      <CardMedia component="img" image={product.imageUrl} height="200" alt={product.name} />
                      <CardContent>
                        <Typography variant="h6">{product.name}</Typography>
                        <Typography color="primary" fontWeight="bold">{`₺${product.price.toLocaleString()}`}</Typography>
                        <Typography variant="body2" color="text.secondary">Kategori: {product.category.replace("_", " & ")}</Typography>
                        <Typography variant="body2" color="text.secondary">Marka: {product.brand}</Typography>
                        <Typography variant="body2" color="text.secondary">Satıcı: {product.seller}</Typography>
                        <Typography variant="body2" color="text.secondary">Puan: {product.rating} ⭐</Typography>
                        <Typography variant="body2" color={product.stock > 0 ? "green" : "red"}>{product.stock > 0 ? "Stokta" : "Stokta Yok"}</Typography>
                      </CardContent>
                    </Link>
                    <Button variant="contained" fullWidth disabled={product.stock === 0}>Sepete Ekle</Button>
                  </Card>
                </Grid>
              ))}
            </Grid>
          </Grid>
        </Grid>
      </Container>
    </div>
  );
};

export default GuestPage;
