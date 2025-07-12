import React, { useState, useEffect } from "react";
import AdminNavbar from "./AdminNavbar";
import {
  Container, Typography, Box, Card, CardContent, CardMedia,
  Button, Dialog, DialogActions, DialogContent, DialogTitle,
  Pagination, List, ListItem, ListItemText, Divider
} from "@mui/material";
import { styled } from '@mui/system';
import api from '../../services/api';

// --- Stil tanımlamaları ---
const DialogPaper = styled('div')({
  borderRadius: '16px',
  padding: '20px',
  boxShadow: '0px 10px 30px rgba(0, 0, 0, 0.1)',
  backgroundColor: '#fff',
});

const DialogTitleStyled = styled(DialogTitle)({
  backgroundColor: '#1976d2',
  color: '#fff',
  fontWeight: 600,
  padding: '16px 24px',
  borderRadius: '10px 10px 0 0',
  fontSize: '1.2rem',
});

const DialogContentStyled = styled(DialogContent)({
  padding: '16px 24px',
});

const DialogActionsStyled = styled(DialogActions)({
  padding: '8px 24px 16px',
});

const CardStyled = styled(Card)({
  borderRadius: '12px',
  cursor: 'pointer',
  boxShadow: '0px 6px 12px rgba(0, 0, 0, 0.1)',
  '&:hover': {
    boxShadow: '0px 8px 16px rgba(0, 0, 0, 0.2)',
  },
  backgroundColor: '#f9f9f9',
});

const CardImageStyled = styled(CardMedia)({
  borderRadius: '12px',
  height: '140px',
  objectFit: 'cover',
});

// --- Ana bileşen ---
const ProductsPage = () => {
  const [products, setProducts] = useState([]);
  const [open, setOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchQuery, setSearchQuery] = useState("");
  const productsPerPage = 24;

  useEffect(() => {
    fetchProductsFromAPI();
  }, []);

  const fetchProductsFromAPI = async () => {
    try {
      const response = await api.getAllProducts();
      setProducts(response);
    } catch (error) {
      console.error("Ürünler alınırken hata oluştu:", error);
    }
  };

  const handlePageChange = (event, value) => {
    setCurrentPage(value);
  };

  const handleCardClick = (productId) => {
    const product = products.find((p) => p.id === productId);
    setSelectedProduct(product);
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
    setSelectedProduct(null);
  };

  // Arama filtreleme
  const filteredProducts = products.filter(product =>
    product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    product.seller.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const indexOfLastProduct = currentPage * productsPerPage;
  const indexOfFirstProduct = indexOfLastProduct - productsPerPage;
  const currentProducts = filteredProducts.slice(indexOfFirstProduct, indexOfLastProduct);
  const totalPages = Math.ceil(filteredProducts.length / productsPerPage);

  return (
    <div>
      <AdminNavbar />
      <Container sx={{ mt: 4 }}>
        {/* Başlık ve arama */}
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 3 }}>
          <Typography variant="h4">Ürün Yönetimi</Typography>
          <input
            type="text"
            placeholder="Ürün veya Satıcı Ara..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            style={{
              padding: '10px 16px',
              fontSize: '16px',
              borderRadius: '8px',
              border: '1px solid #ccc',
              minWidth: '250px'
            }}
          />
        </Box>

        {/* Ürün kartları */}
        <Box sx={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: 4 }}>
          {currentProducts.map((product) => (
            <CardStyled key={product.id} onClick={() => handleCardClick(product.id)}>
              <CardImageStyled component="img" image={product.imageUrl} alt={product.name} />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  {product.name}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  <strong>Fiyat:</strong> ₺{product.price.toFixed(2)}
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  <strong>Satıcı:</strong> {product.seller}
                </Typography>
              </CardContent>
            </CardStyled>
          ))}
        </Box>

        {/* Sayfalama */}
        <Box sx={{ display: 'flex', justifyContent: 'center', mt: 4 }}>
          <Pagination
            count={totalPages}
            page={currentPage}
            onChange={handlePageChange}
            color="primary"
          />
        </Box>

        {/* Detay Dialog */}
        <Dialog open={open} onClose={handleClose} maxWidth="md" fullWidth PaperComponent={DialogPaper}>
          <DialogTitleStyled>{selectedProduct?.name}</DialogTitleStyled>
          <DialogContentStyled>
            {selectedProduct && (
              <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '16px' }}>
                <CardImageStyled
                  component="img"
                  image={selectedProduct.imageUrl}
                  alt={selectedProduct.name}
                  sx={{ maxWidth: '300px', height: 'auto', borderRadius: '12px' }}
                />
                <Typography variant="h6" color="text.secondary">
                  <strong>Fiyat:</strong> ₺{selectedProduct.price.toFixed(2)}
                </Typography>
                <Typography variant="h6" color="text.secondary">
                  <strong>Satıcı:</strong> {selectedProduct.seller}
                </Typography>
                <Typography variant="body1" color="text.secondary">
                  <strong>Açıklama:</strong> {selectedProduct.description}
                </Typography>
                <Typography variant="body1" color="text.secondary">
                  <strong>Stok:</strong> {selectedProduct.stock}
                </Typography>
                <Typography variant="body1" color="text.secondary">
                  <strong>Kategori:</strong> {selectedProduct.category}
                </Typography>
                <Typography variant="body1" color="text.secondary">
                  <strong>Toplam Satış:</strong> {selectedProduct.totalSales}
                </Typography>

                <Typography variant="body1" color="text.secondary" sx={{ mt: 2 }}>
                  <strong>Yorumlar:</strong>
                </Typography>
                <List sx={{ maxHeight: '200px', overflowY: 'auto', width: '100%' }}>
                  {selectedProduct.reviews?.map((review) => (
                    <div key={review.id}>
                      <ListItem>
                        <ListItemText
                          primary={`${review.user} - ${review.createdAt}`}
                          secondary={review.comment}
                        />
                      </ListItem>
                      <Divider />
                    </div>
                  ))}
                </List>
              </Box>
            )}
          </DialogContentStyled>
          <DialogActionsStyled>
            <Button onClick={handleClose} color="primary" variant="contained">Kapat</Button>
          </DialogActionsStyled>
        </Dialog>
      </Container>
    </div>
  );
};

export default ProductsPage;
