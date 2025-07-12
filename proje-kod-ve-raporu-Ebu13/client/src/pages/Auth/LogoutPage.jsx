// LogoutPage.js
import { useEffect } from "react";
import { Container, Typography, CircularProgress } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { logoutUser } from "../../services/api"; // api.js'den logoutUser metodunu import ettik

const LogoutPage = () => {
  const navigate = useNavigate();

  useEffect(() => {
    const logout = async () => {
      try {
        await logoutUser();
        localStorage.clear();
        navigate("/"); // Ana sayfaya yönlendir
      } catch (err) {
        console.log("Çıkış işlemi başarısız: ", err);
        navigate("/"); // Hata durumunda ana sayfaya yönlendir
      }
    };

    logout(); // Çıkışı başlat
  }, [navigate]);

  return (
    <Container sx={{ mt: 5, textAlign: "center" }}>
      <Typography variant="h4" gutterBottom>Çıkış Yapılıyor...</Typography>
      <CircularProgress sx={{ mt: 3 }} />
      <Typography variant="body1" sx={{ mt: 2 }}>Lütfen bekleyin, yönlendiriliyorsunuz.</Typography>
    </Container>
  );
};

export default LogoutPage;
