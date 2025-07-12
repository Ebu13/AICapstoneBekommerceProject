import BuyerNavbar from "./BuyerNavbar";
import { Container, Typography, List, ListItem, ListItemText } from "@mui/material";

const ReviewsPage = () => {
  return (
    <div>
      <BuyerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>Yorumlarım</Typography>
        <List>
          <ListItem divider>
            <ListItemText primary="iPhone 14" secondary="Çok memnun kaldım! ⭐⭐⭐⭐⭐" />
          </ListItem>
        </List>
      </Container>
    </div>
  );
};
export default ReviewsPage;