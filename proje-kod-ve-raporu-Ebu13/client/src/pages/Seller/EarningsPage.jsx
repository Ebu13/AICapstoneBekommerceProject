import SellerNavbar from "./SellerNavbar";
import { Container, Typography, Paper } from "@mui/material";

const EarningsPage = () => {
  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Kazançlarım</Typography>
        <Paper sx={{ p: 3, textAlign: "center" }}>
          <Typography variant="h5">Toplam Kazanç: ₺75.500</Typography>
          <Typography variant="body1" color="textSecondary">Bu ayki kazancınız: ₺15.000</Typography>
        </Paper>
      </Container>
    </div>
  );
};
export default EarningsPage;