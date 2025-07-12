import { useEffect, useState } from "react";
import AdminNavbar from "./AdminNavbar";
import {
  Container,
  Typography,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Button,
  TextField,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  CircularProgress,
  Snackbar,
  Alert,
  Stack,
  MenuItem,
} from "@mui/material";
import api from "../../services/api";

const UsersPage = () => {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [snackbar, setSnackbar] = useState({ open: false, message: "", severity: "info" });

  const [editModalOpen, setEditModalOpen] = useState(false);
  const [addModalOpen, setAddModalOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState({ id: null, name: "", email: "", role: "" });
  const [newUser, setNewUser] = useState({ name: "", email: "", password: "", role: "" });

  const [currentPage, setCurrentPage] = useState(1); // Aktif sayfa
  const [usersPerPage] = useState(20); // Sayfa başına kullanıcı sayısı

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const data = await api.getAllUsers();
      setUsers(data);
    } catch (error) {
      console.error("Kullanıcılar yüklenirken hata oluştu:", error);
      showSnackbar("Kullanıcılar yüklenemedi", "error");
    } finally {
      setLoading(false);
    }
  };

  const handleEditOpen = (user) => {
    setSelectedUser(user);
    setEditModalOpen(true);
  };

  const handleEditClose = () => {
    setEditModalOpen(false);
  };

  const handleEditSave = async () => {
    try {
      const updatedUser = await api.updateUser(selectedUser.id, selectedUser);
      setUsers((prev) => prev.map((u) => (u.id === updatedUser.id ? updatedUser : u)));
      showSnackbar("Kullanıcı güncellendi", "success");
    } catch (error) {
      console.error("Güncelleme hatası:", error);
      showSnackbar("Kullanıcı güncellenemedi", "error");
    } finally {
      handleEditClose();
    }
  };

  const handleAddOpen = () => {
    setAddModalOpen(true);
  };

  const handleAddClose = () => {
    setAddModalOpen(false);
    setNewUser({ name: "", email: "", password: "", role: "" });
  };

  const handleAddSave = async () => {
    try {
      const createdUser = await api.registerUser(newUser.name, newUser.email, newUser.password, newUser.role);
      setUsers((prev) => [...prev, createdUser]);
      showSnackbar("Kullanıcı eklendi", "success");
    } catch (error) {
      console.error("Kullanıcı eklenirken hata oluştu:", error);
      showSnackbar("Kullanıcı eklenemedi", "error");
    } finally {
      handleAddClose();
    }
  };

  const handleChange = (e) => {
    setSelectedUser({ ...selectedUser, [e.target.name]: e.target.value });
  };

  const handleNewUserChange = (e) => {
    setNewUser({ ...newUser, [e.target.name]: e.target.value });
  };

  const showSnackbar = (message, severity = "info") => {
    setSnackbar({ open: true, message, severity });
  };

  const handleCloseSnackbar = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  const filteredUsers = users.filter(
    (user) =>
      user.name.toLowerCase().includes(search.toLowerCase()) ||
      user.email.toLowerCase().includes(search.toLowerCase())
  );

  // Sayfa numarasına göre kullanıcıları al
  const indexOfLastUser = currentPage * usersPerPage;
  const indexOfFirstUser = indexOfLastUser - usersPerPage;
  const currentUsers = filteredUsers.slice(indexOfFirstUser, indexOfLastUser);

  const totalPages = Math.ceil(filteredUsers.length / usersPerPage);

  const handlePageChange = (direction) => {
    if (direction === "next" && currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    } else if (direction === "prev" && currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <div>
      <AdminNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>
          Kullanıcı Yönetimi
        </Typography>

        <Stack direction="row" spacing={2} mb={2}>
          <TextField
            label="Ara (isim/e-posta)"
            variant="outlined"
            fullWidth
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <Button variant="contained" color="primary" onClick={handleAddOpen}>
            Kullanıcı Ekle
          </Button>
        </Stack>

        {loading ? (
          <CircularProgress />
        ) : (
          <TableContainer component={Paper}>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>İsim</TableCell>
                  <TableCell>E-posta</TableCell>
                  <TableCell>Rol</TableCell>
                  <TableCell align="right">İşlemler</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {currentUsers.length > 0 ? (
                  currentUsers.map((user) => (
                    <TableRow key={user.id}>
                      <TableCell>{user.name}</TableCell>
                      <TableCell>{user.email}</TableCell>
                      <TableCell>{user.role}</TableCell>
                      <TableCell align="right">
                        <Button variant="outlined" color="primary" size="small" onClick={() => handleEditOpen(user)}>
                          Düzenle
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))
                ) : (
                  <TableRow>
                    <TableCell colSpan={4} align="center">
                      Kullanıcı bulunamadı.
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
        )}

        {/* Sayfalama Kontrolleri */}
        <Stack direction="row" justifyContent="center" spacing={2} mt={2}>
          <Button
            variant="outlined"
            disabled={currentPage === 1}
            onClick={() => handlePageChange("prev")}
          >
            Önceki
          </Button>
          <Typography variant="body1">
            Sayfa {currentPage} / {totalPages}
          </Typography>
          <Button
            variant="outlined"
            disabled={currentPage === totalPages}
            onClick={() => handlePageChange("next")}
          >
            Sonraki
          </Button>
        </Stack>

        {/* Kullanıcı Düzenleme Modalı */}
        <Dialog open={editModalOpen} onClose={handleEditClose}>
          <DialogTitle>Kullanıcıyı Düzenle</DialogTitle>
          <DialogContent>
            <TextField
              autoFocus
              margin="dense"
              label="İsim"
              name="name"
              fullWidth
              variant="outlined"
              value={selectedUser.name}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="E-posta"
              name="email"
              fullWidth
              variant="outlined"
              value={selectedUser.email}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="Rol"
              name="role"
              select
              fullWidth
              value={selectedUser.role}
              onChange={handleChange}
            >
              <MenuItem value="ADMIN">Admin</MenuItem>
              <MenuItem value="SELLER">Satıcı</MenuItem>
              <MenuItem value="BUYER">Alıcı</MenuItem>
            </TextField>
          </DialogContent>
          <DialogActions>
            <Button onClick={handleEditClose}>İptal</Button>
            <Button onClick={handleEditSave} variant="contained" color="primary">
              Kaydet
            </Button>
          </DialogActions>
        </Dialog>

        {/* Kullanıcı Ekleme Modalı */}
        <Dialog open={addModalOpen} onClose={handleAddClose}>
          <DialogTitle>Yeni Kullanıcı Ekle</DialogTitle>
          <DialogContent>
            <TextField
              autoFocus
              margin="dense"
              label="İsim"
              name="name"
              fullWidth
              variant="outlined"
              value={newUser.name}
              onChange={handleNewUserChange}
            />
            <TextField
              margin="dense"
              label="E-posta"
              name="email"
              fullWidth
              variant="outlined"
              value={newUser.email}
              onChange={handleNewUserChange}
            />
            <TextField
              margin="dense"
              label="Şifre"
              name="password"
              type="password"
              fullWidth
              variant="outlined"
              value={newUser.password}
              onChange={handleNewUserChange}
            />
            <TextField
              margin="dense"
              label="Rol"
              name="role"
              select
              fullWidth
              value={newUser.role}
              onChange={handleNewUserChange}
            >
              <MenuItem value="ADMIN">Admin</MenuItem>
              <MenuItem value="SELLER">Satıcı</MenuItem>
              <MenuItem value="BUYER">Alıcı</MenuItem>
            </TextField>
          </DialogContent>
          <DialogActions>
            <Button onClick={handleAddClose}>İptal</Button>
            <Button onClick={handleAddSave} variant="contained" color="primary">
              Kaydet
            </Button>
          </DialogActions>
        </Dialog>

        {/* Snackbar */}
        <Snackbar
          open={snackbar.open}
          autoHideDuration={3000}
          onClose={handleCloseSnackbar}
          anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
        >
          <Alert onClose={handleCloseSnackbar} severity={snackbar.severity} sx={{ width: "100%" }}>
            {snackbar.message}
          </Alert>
        </Snackbar>
      </Container>
    </div>
  );
};

export default UsersPage;
