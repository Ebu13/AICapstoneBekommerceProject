import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, TextField, Button, Paper, Box } from "@mui/material";
import { useState } from "react";
import axios from "axios";

const SupportPage = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");
  const [imageFile, setImageFile] = useState(null);
  const [imagePreview, setImagePreview] = useState(null);

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    setImageFile(file);
    setImagePreview(URL.createObjectURL(file));
  };

  const handleSendMessage = async () => {
    if (input.trim() === "" && !imageFile) return;

    if (imageFile) {
      const reader = new FileReader();
      reader.onloadend = async () => {
        const base64data = reader.result;

        const userMessage = { sender: "user", text: "[Görsel gönderildi]" };
        setMessages((prev) => [...prev, userMessage]);

        try {
          const response = await axios.post("http://127.0.0.1:5000/chat", {
            message: base64data,
          });

          const botMessage = { sender: "bot", text: response.data.response || "Yanıt alınamadı." };
          setMessages((prev) => [...prev, botMessage]);
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
      const userMessage = { sender: "user", text: input };
      setMessages((prev) => [...prev, userMessage]);
      const currentInput = input;
      setInput("");

      try {
        const response = await axios.post("http://127.0.0.1:5000/chat", {
          message: currentInput,
        });

        const botMessage = { sender: "bot", text: response.data.response || "Yanıt alınamadı." };
        setMessages((prev) => [...prev, botMessage]);
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
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Canlı Destek (AI)</Typography>
        <Paper sx={{ p: 3, height: 400, overflowY: "auto", bgcolor: "#f9f9f9" }}>
          {messages.map((msg, index) => (
            <Box
              key={index}
              sx={{
                textAlign: msg.sender === "user" ? "right" : "left",
                my: 1,
              }}
            >
              <Typography
                variant="body1"
                sx={{
                  display: "inline-block",
                  padding: 1,
                  bgcolor: msg.sender === "user" ? "#FF6F00" : "#e0e0e0",
                  color: msg.sender === "user" ? "white" : "black",
                  borderRadius: 2,
                }}
              >
                {msg.text}
              </Typography>
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
              <Button
                color="error"
                onClick={() => {
                  setImageFile(null);
                  setImagePreview(null);
                }}
                sx={{ ml: 1 }}
              >
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
            disabled={!!imageFile} // Fotoğraf seçiliyse metin girişini kapat (opsiyonel)
            onKeyPress={(e) => {
              if (e.key === "Enter") handleSendMessage();
            }}
          />
          <Button variant="contained" color="primary" onClick={handleSendMessage} sx={{ ml: 1 }}>
            Gönder
          </Button>
        </Box>
      </Container>
    </div>
  );
};

export default SupportPage;
