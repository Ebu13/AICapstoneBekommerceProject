import { useState } from "react";
import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, TextField, Button, Box, List, ListItem, ListItemText, Paper, Dialog, DialogActions, DialogContent, DialogTitle, IconButton } from "@mui/material";
import EditIcon from "@mui/icons-material/Edit";
import AddIcon from "@mui/icons-material/Add";

const ProfilePage = () => {
  const [name, setName] = useState("Ali Veli");
  const [email, setEmail] = useState("ali@example.com");
  const [phone, setPhone] = useState("555-123-4567");
  const [addresses, setAddresses] = useState([
    { id: 1, title: "Ev", detail: "İstanbul, Türkiye" },
    { id: 2, title: "İş", detail: "Ankara, Türkiye" },
  ]);
  
  const [open, setOpen] = useState(false);
  const [selectedAddress, setSelectedAddress] = useState({ id: null, title: "", detail: "" });

  // Profil güncelleme işlemi
  const handleUpdate = () => {
    alert("Profil güncellendi!");
  };

  // Modal aç/kapat
  const handleOpen = (address = { id: null, title: "", detail: "" }) => {
    setSelectedAddress(address);
    setOpen(true);
  };
  const handleClose = () => setOpen(false);

  // Adres ekleme/düzenleme işlemi
  const handleSaveAddress = () => {
    if (selectedAddress.id) {
      setAddresses((prev) =>
        prev.map((addr) => (addr.id === selectedAddress.id ? selectedAddress : addr))
      );
    } else {
      setAddresses((prev) => [...prev, { ...selectedAddress, id: prev.length + 1 }]);
    }
    handleClose();
  };

  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        {/* Profil Bilgileri */}
        <Typography variant="h4" gutterBottom>Profilim</Typography>
        <Paper sx={{ p: 3, mb: 4 }}>
          <Box sx={{ display: "flex", flexDirection: "column", gap: 2 }}>
            <TextField label="Ad Soyad" value={name} onChange={(e) => setName(e.target.value)} fullWidth />
            <TextField label="E-posta" type="email" value={email} onChange={(e) => setEmail(e.target.value)} fullWidth />
            <TextField label="Telefon Numarası" value={phone} onChange={(e) => setPhone(e.target.value)} fullWidth />
            <Button variant="contained" color="primary" onClick={handleUpdate}>Bilgileri Güncelle</Button>
          </Box>
        </Paper>

        {/* Adreslerim Bölümü */}
        <Typography variant="h5" gutterBottom>Adreslerim</Typography>
        <Paper sx={{ p: 2 }}>
          <List>
            {addresses.map((address) => (
              <ListItem key={address.id} divider>
                <ListItemText primary={address.title} secondary={address.detail} />
                <IconButton color="primary" onClick={() => handleOpen(address)}>
                  <EditIcon />
                </IconButton>
              </ListItem>
            ))}
          </List>
          <Button
            variant="contained"
            color="secondary"
            startIcon={<AddIcon />}
            onClick={() => handleOpen()}
            sx={{ mt: 2 }}
          >
            Yeni Adres Ekle
          </Button>
        </Paper>
      </Container>

      {/* Adres Düzenleme Modal'ı */}
      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>{selectedAddress.id ? "Adresi Düzenle" : "Yeni Adres Ekle"}</DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            label="Adres Başlığı"
            value={selectedAddress.title}
            onChange={(e) => setSelectedAddress({ ...selectedAddress, title: e.target.value })}
            sx={{ mb: 2 }}
          />
          <TextField
            fullWidth
            label="Adres Detayı"
            value={selectedAddress.detail}
            onChange={(e) => setSelectedAddress({ ...selectedAddress, detail: e.target.value })}
            multiline
            rows={3}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} color="error">İptal</Button>
          <Button onClick={handleSaveAddress} color="primary">Kaydet</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default ProfilePage;
