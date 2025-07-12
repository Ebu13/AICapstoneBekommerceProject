// SellerProfile.jsx
import { useState } from "react";
import SellerNavbar from "./SellerNavbar";
import { Container, Typography, TextField, Button, Box, List, ListItem, ListItemText, Paper, Dialog, DialogActions, DialogContent, DialogTitle, IconButton } from "@mui/material";
import EditIcon from "@mui/icons-material/Edit";
import AddIcon from "@mui/icons-material/Add";

const SellerProfile = () => {
  const [name, setName] = useState("Satıcı Adı");
  const [email, setEmail] = useState("satici@example.com");
  const [open, setOpen] = useState(false);
  const [address, setAddress] = useState("İstanbul, Türkiye");

  const handleUpdate = () => {
    alert("Profil güncellendi!");
  };

  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Profilim</Typography>
        <Paper sx={{ p: 3, mb: 4 }}>
          <Box sx={{ display: "flex", flexDirection: "column", gap: 2 }}>
            <TextField label="Ad Soyad" value={name} onChange={(e) => setName(e.target.value)} fullWidth />
            <TextField label="E-posta" value={email} onChange={(e) => setEmail(e.target.value)} fullWidth />
            <Button variant="contained" color="primary" onClick={handleUpdate}>Güncelle</Button>
          </Box>
        </Paper>

        {/* Adreslerim */}
        <Typography variant="h5" gutterBottom>Mağaza Adresim</Typography>
        <Paper sx={{ p: 2 }}>
          <List>
            <ListItem divider>
              <ListItemText primary="Adres" secondary={address} />
              <IconButton onClick={() => setOpen(true)}><EditIcon /></IconButton>
            </ListItem>
          </List>
        </Paper>

        {/* Adres Güncelleme Dialog */}
        <Dialog open={open} onClose={() => setOpen(false)}>
          <DialogTitle>Adres Güncelle</DialogTitle>
          <DialogContent>
            <TextField fullWidth label="Yeni Adres" value={address} onChange={(e) => setAddress(e.target.value)} />
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setOpen(false)} color="secondary">İptal</Button>
            <Button onClick={() => { setOpen(false); alert("Adres güncellendi!"); }} color="primary">Kaydet</Button>
          </DialogActions>
        </Dialog>
      </Container>
    </div>
  );
};
export default SellerProfile;
