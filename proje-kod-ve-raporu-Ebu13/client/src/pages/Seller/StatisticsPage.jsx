import SellerNavbar from "./SellerNavbar";
import { Container, Typography, Paper, Grid, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Select, MenuItem } from "@mui/material";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, BarChart, Bar } from "recharts";
import { useState } from "react";

const salesData = [
  { month: "Ocak", sales: 12000 },
  { month: "Şubat", sales: 15000 },
  { month: "Mart", sales: 18000 },
  { month: "Nisan", sales: 20000 },
  { month: "Mayıs", sales: 22000 },
  { month: "Haziran", sales: 25000 },
];

const topProducts = [
  { id: 1, name: "iPhone 14", sales: 120 },
  { id: 2, name: "Nike Air Max", sales: 95 },
  { id: 3, name: "Samsung TV", sales: 80 },
  { id: 4, name: "MacBook Pro", sales: 75 },
  { id: 5, name: "Futbol Topu", sales: 60 },
];

const StatisticsPage = () => {
  const [timeRange, setTimeRange] = useState("6months");
  return (
    <div>
      <SellerNavbar />
      <Container sx={{ mt: 4 }}>
        <Typography variant="h4" gutterBottom>İstatistikler</Typography>
        
        {/* Satış Metrikleri */}
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Toplam Satışlar</Typography>
              <Typography variant="h4" color="primary">₺125,000</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Aylık Satış</Typography>
              <Typography variant="h4" color="secondary">₺15,000</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">Müşteri Memnuniyeti</Typography>
              <Typography variant="h4" color="success">%92</Typography>
            </Paper>
          </Grid>
          <Grid item xs={12} md={6}>
            <Paper sx={{ p: 3, textAlign: "center" }}>
              <Typography variant="h5">İade Oranı</Typography>
              <Typography variant="h4" color="error">%3</Typography>
            </Paper>
          </Grid>
        </Grid>
        
        {/* Satış Grafiği */}
        <Paper sx={{ mt: 4, p: 3 }}>
          <Typography variant="h5" gutterBottom>Satış Değişimi</Typography>
          <Select value={timeRange} onChange={(e) => setTimeRange(e.target.value)} sx={{ mb: 2 }}>
            <MenuItem value="6months">Son 6 Ay</MenuItem>
            <MenuItem value="1year">Son 1 Yıl</MenuItem>
          </Select>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={salesData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="month" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="sales" stroke="#FF6F00" strokeWidth={3} />
            </LineChart>
          </ResponsiveContainer>
        </Paper>
        
        {/* En Çok Satan Ürünler */}
        <Paper sx={{ mt: 4, p: 3 }}>
          <Typography variant="h5" gutterBottom>En Çok Satan Ürünler</Typography>
          <TableContainer>
            <Table>
              <TableHead>
                <TableRow>
                  <TableCell>Ürün Adı</TableCell>
                  <TableCell>Satış Sayısı</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {topProducts.map((product) => (
                  <TableRow key={product.id}>
                    <TableCell>{product.name}</TableCell>
                    <TableCell>{product.sales}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Paper>
      </Container>
    </div>
  );
};

export default StatisticsPage;