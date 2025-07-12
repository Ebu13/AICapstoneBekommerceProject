import { useState } from "react";
import {
  TextField,
  Button,
  Container,
  Typography,
  Box,
  MenuItem,
  Select,
  InputLabel,
  FormControl,
} from "@mui/material";
import { Link } from "react-router-dom";
import { registerUser } from "../../services/api";

const RegisterPage = () => {
  const [name, setName] = useState(""); // name state'ini ekledik
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [role, setRole] = useState("BUYER");

  const handleRegister = async (e) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      alert("Şifreler uyuşmuyor!");
      return;
    }

    try {
      const data = await registerUser(name, email, password, role); // name parametresini ekledik
      console.log("Kayıt başarılı:", data);
      alert("Kayıt başarılı! Giriş yapabilirsiniz.");
    } catch (err) {
      console.log("Kayıt hatası:", err);
      alert("Kayıt sırasında bir hata oluştu.");
    }
  };

  return (
    <Container maxWidth="sm">
      <Box sx={{ mt: 5, p: 3, boxShadow: 3, bgcolor: "white", borderRadius: 2 }}>
        <Typography variant="h5" gutterBottom>
          Kayıt Ol
        </Typography>
        <form onSubmit={handleRegister}>
          <TextField
            fullWidth
            label="Adınız"
            margin="normal"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
          <TextField
            fullWidth
            label="E-posta"
            margin="normal"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          <TextField
            fullWidth
            label="Şifre"
            type="password"
            margin="normal"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          <TextField
            fullWidth
            label="Şifre Tekrar"
            type="password"
            margin="normal"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
          />
          <FormControl fullWidth margin="normal">
            <InputLabel id="role-label">Rol</InputLabel>
            <Select
              labelId="role-label"
              value={role}
              label="Rol"
              onChange={(e) => setRole(e.target.value)}
              required
            >
              <MenuItem value="BUYER">Alıcı</MenuItem>
              <MenuItem value="SELLER">Satıcı</MenuItem>
            </Select>
          </FormControl>
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            sx={{ mt: 2 }}
          >
            Kayıt Ol
          </Button>
        </form>
        <Typography variant="body2" sx={{ mt: 2 }}>
          Zaten hesabınız var mı? <Link to="/login">Giriş Yap</Link>
        </Typography>
      </Box>
    </Container>
  );
};

export default RegisterPage;
