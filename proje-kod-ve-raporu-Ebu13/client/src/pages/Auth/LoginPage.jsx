// LoginPage.js
import { useState } from "react";
import { TextField, Button, Container, Typography, Box } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { loginUser } from "../../services/api"; // api.js'den loginUser metodunu import ettik

const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const data = await loginUser(email, password);
      const { token } = data;

      localStorage.setItem("userToken", token);

      const payload = JSON.parse(atob(token.split(".")[1]));
      const userRole = payload.role;

      if (userRole === "ADMIN") {
        navigate("/admin");
      } else if (userRole === "SELLER") {
        navigate("/seller");
      } else if (userRole === "BUYER") {
        navigate("/buyer");
      } else {
        setError("Bilinmeyen rol!");
      }
    } catch (err) {
      setError("Giriş başarısız! Lütfen bilgilerinizi kontrol edin. " + err.message);
      console.log(err);
    }
  };

  return (
    <Container maxWidth="sm">
      <Box sx={{ mt: 5, p: 3, boxShadow: 3, bgcolor: "white", borderRadius: 2 }}>
        <Typography variant="h5" gutterBottom>Giriş Yap</Typography>
        {error && <Typography color="error">{error}</Typography>}
        <form onSubmit={handleLogin}>
          <TextField fullWidth label="E-posta" margin="normal" value={email} onChange={(e) => setEmail(e.target.value)} required />
          <TextField fullWidth label="Şifre" type="password" margin="normal" value={password} onChange={(e) => setPassword(e.target.value)} required />
          <Button type="submit" fullWidth variant="contained" color="primary" sx={{ mt: 2 }}>Giriş Yap</Button>
        </form>
        <Typography variant="body2" sx={{ mt: 2 }}>
          Hesabınız yok mu? <a href="/register">Kayıt Ol</a>
        </Typography>
      </Box>
    </Container>
  );
};

export default LoginPage;
