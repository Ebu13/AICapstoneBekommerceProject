import SellerNavbar from "./SellerNavbar";
import {
  Container,
  Typography,
  TextField,
  Button,
  Paper,
  Box,
  Card,
  CardContent,
  CardMedia,
  Grid,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  IconButton,
  Rating
} from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";
import { useState } from "react";
import axios from "axios";

const SellerSupport = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");
  const [openDialog, setOpenDialog] = useState(false);
  const [productData, setProductData] = useState([]);
  const [imageFile, setImageFile] = useState(null); // Yeni: seçilen dosya
  const [imagePreview, setImagePreview] = useState(null); // Yeni: önizleme için

  // Fotoğraf seçilince çağrılır
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    setImageFile(file);
    setImagePreview(URL.createObjectURL(file));
  };

  // Gönderme fonksiyonu, hem text hem de image gönderme için
  const handleSendMessage = async () => {
    if (input.trim() === "" && !imageFile) return;

    if (imageFile) {
      // Fotoğraf yüklenecek, burada dosyayı bir API'ye yollayıp URL alman gerekir.
      // Örnek olarak, base64 encode yapıp URL olarak kullanıyoruz (backend buna hazır değilse değiştirmelisin).
      const reader = new FileReader();
      reader.onloadend = async () => {
        const base64data = reader.result;

        // Fotoğraf URL'si olarak base64 gönderebiliriz (ya da gerçek upload sonrası URL)
        const userMessage = { sender: "seller", text: "[Görsel gönderildi]" };
        setMessages((prev) => [...prev, userMessage]);

        try {
          const response = await axios.post("http://127.0.0.1:5000/chat", {
            message: base64data,  // Burada gerçek URL ya da base64 gönderiliyor
          });

          // Aynı ürün ayrıştırma kodun
          const productPattern = /🛍️ (.+?) \(([\d.]+) ⭐ \/ (\d+) yorum\)\s*🔗 Resim: (.+?)\s*📝 (.+?)\s*📦 Ürün ID: (\d+)/g;
          const products = [...response.data.response.matchAll(productPattern)];

          if (products.length > 0) {
            const formattedProducts = products.map(([, name, rating, reviewCount, imageUrl, description, id]) => ({
              name,
              rating,
              reviewCount,
              imageUrl,
              description,
              id,
            }));

            setProductData(formattedProducts);

            const previewMessage = {
              sender: "bot",
              text: "__PRODUCTS__",
            };

            setMessages((prev) => [...prev, previewMessage]);
          } else {
            setMessages((prev) => [
              ...prev,
              { sender: "bot", text: response.data.response },
            ]);
          }
        } catch (error) {
          console.error("API hatası:", error);
          setMessages((prev) => [
            ...prev,
            { sender: "bot", text: "Maalesef şu anda hizmet veremiyoruz. Lütfen daha sonra tekrar deneyin." },
          ]);
        }

        setImageFile(null);
        setImagePreview(null);
      };
      reader.readAsDataURL(imageFile);

    } else {
      // Sadece metin varsa mevcut kod
      const userMessage = { sender: "seller", text: input };
      setMessages((prev) => [...prev, userMessage]);
      const currentInput = input;
      setInput("");

      try {
        const response = await axios.post("http://127.0.0.1:5000/chat", {
          message: currentInput,
        });

        const productPattern = /🛍️ (.+?) \(([\d.]+) ⭐ \/ (\d+) yorum\)\s*🔗 Resim: (.+?)\s*📝 (.+?)\s*📦 Ürün ID: (\d+)/g;
        const products = [...response.data.response.matchAll(productPattern)];

        if (products.length > 0) {
          const formattedProducts = products.map(([, name, rating, reviewCount, imageUrl, description, id]) => ({
            name,
            rating,
            reviewCount,
            imageUrl,
            description,
            id,
          }));

          setProductData(formattedProducts);

          const previewMessage = {
            sender: "bot",
            text: "__PRODUCTS__",
          };

          setMessages((prev) => [...prev, previewMessage]);
        } else {
          setMessages((prev) => [
            ...prev,
            { sender: "bot", text: response.data.response },
          ]);
        }

      } catch (error) {
        console.error("API hatası:", error);
        setMessages((prev) => [
          ...prev,
          { sender: "bot", text: "Maalesef şu anda hizmet veremiyoruz. Lütfen daha sonra tekrar deneyin." },
        ]);
      }
    }
  };

  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Canlı Destek (AI)</Typography>

        <Paper sx={{ p: 3, height: 400, overflowY: "auto", bgcolor: "#f9f9f9" }}>
          {messages.map((msg, index) => (
            <Box key={index} sx={{ textAlign: msg.sender === "seller" ? "right" : "left", my: 2 }}>
              {msg.sender === "bot" && msg.text === "__PRODUCTS__" ? (
                <Button
                  variant="outlined"
                  onClick={() => setOpenDialog(true)}
                  sx={{ textTransform: "none" }}
                >
                  Ürün önerilerini görmek için tıklayın
                </Button>
              ) : (
                <Typography
                  variant="body1"
                  sx={{
                    display: "inline-block",
                    padding: 1,
                    maxWidth: "70%",
                    wordBreak: "break-word",
                    bgcolor: msg.sender === "seller" ? "#FF6F00" : "#eeeeee",
                    color: msg.sender === "seller" ? "white" : "black",
                    borderRadius: 2,
                  }}
                >
                  {msg.text}
                </Typography>
              )}
            </Box>
          ))}
        </Paper>

        {/* Görsel yükleme alanı */}
        <Box sx={{ mt: 2, mb: 2 }}>
          <input
            accept="image/*"
            type="file"
            onChange={handleImageChange}
            id="upload-photo"
            style={{ display: "none" }}
          />
          <label htmlFor="upload-photo">
            <Button variant="contained" component="span">
              Fotoğraf Yükle
            </Button>
          </label>

          {imagePreview && (
            <Box sx={{ mt: 1 }}>
              <img
                src={imagePreview}
                alt="Seçilen"
                style={{ maxWidth: "200px", maxHeight: "150px", borderRadius: 8 }}
              />
              <Button color="error" onClick={() => { setImageFile(null); setImagePreview(null); }} sx={{ ml: 1 }}>
                Kaldır
              </Button>
            </Box>
          )}
        </Box>

        <Box sx={{ display: "flex", mt: 2 }}>
          <TextField
            fullWidth
            value={input}
            onChange={(e) => setInput(e.target.value)}
            label="Bir mesaj yazın..."
            onKeyPress={(e) => {
              if (e.key === "Enter") handleSendMessage();
            }}
            disabled={!!imageFile} // Fotoğraf seçiliyse metin girişini kapat (opsiyonel)
          />
          <Button variant="contained" color="primary" onClick={handleSendMessage} sx={{ ml: 1 }}>
            Gönder
          </Button>
        </Box>
      </Container>

      <Dialog open={openDialog} onClose={() => setOpenDialog(false)} maxWidth="md" fullWidth>
        <DialogTitle sx={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          Ürün Önerileri
          <IconButton onClick={() => setOpenDialog(false)}>
            <CloseIcon />
          </IconButton>
        </DialogTitle>
        <DialogContent dividers>
          <Grid container spacing={2} sx={{ mt: 1 }}>
            {productData.map(({ name, rating, reviewCount, imageUrl, description, id }, idx) => (
              <Grid item xs={12} sm={6} md={4} key={idx}>
                <Card sx={{ height: "100%", display: "flex", flexDirection: "column" }}>
                  <CardMedia
                    component="img"
                    image={imageUrl}
                    alt={name}
                    height="200"
                    sx={{ objectFit: "cover" }}
                  />
                  <CardContent>
                    <Typography variant="h6" gutterBottom>{name}</Typography>
                    <Rating
                      name="read-only"
                      value={parseFloat(rating)}
                      precision={0.1}
                      readOnly
                      size="small"
                    />
                    <Typography variant="body2" color="text.secondary">
                      {reviewCount} yorum
                    </Typography>
                    <Typography variant="body2" sx={{ mt: 1 }}>
                      {description}
                    </Typography>
                    <Typography variant="caption" color="text.secondary">
                      Ürün ID: {id}
                    </Typography>
                    <Button
                      variant="contained"
                      color="secondary"
                      sx={{ mt: 2 }}
                      onClick={() => alert(`Ürün ${id} satın alındı (simülasyon).`)}
                    >
                      Satın Al
                    </Button>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenDialog(false)}>Kapat</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default SellerSupport;
