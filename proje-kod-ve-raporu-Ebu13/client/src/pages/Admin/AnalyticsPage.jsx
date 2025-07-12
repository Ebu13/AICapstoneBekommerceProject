import AdminNavbar from "./AdminNavbar";
import { Container, Typography, Grid, Paper } from "@mui/material";

const AnalyticsPage = () => {
  return (
    <div>
      <AdminNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Detaylı Analizler</Typography>
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Toplam Satışlar</Typography>
              <Typography variant="h4" color="primary">₺500,000</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Toplam Sipariş Sayısı</Typography>
              <Typography variant="h4" color="secondary">12,345</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Aktif Kullanıcılar</Typography>
              <Typography variant="h4" color="success">8,250</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">İade Oranı</Typography>
              <Typography variant="h4" color="error">%5.2</Typography>
            </Paper>
          </Grid>
        </Grid>
      </Container>
    </div>
  );
};
export default AnalyticsPage;