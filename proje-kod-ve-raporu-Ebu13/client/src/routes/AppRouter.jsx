// AppRouter.jsx
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import BuyerPage from "../pages/Buyer/BuyerPage";
import OrdersPage from "../pages/Buyer/OrdersPage";
import CartPage from "../pages/Buyer/CartPage";
import ProfilePage from "../pages/Buyer/ProfilePage";
import FavoritesPage from "../pages/Buyer/FavoritesPage";
import ReviewsPage from "../pages/Buyer/ReviewsPage";
import SupportPage from "../pages/Buyer/SupportPage";
import SellerPage from "../pages/Seller/SellerPage";
import ProductsPage from "../pages/Seller/ProductsPage";
import SellerProductDetail from "../pages/Seller/SellerProductDetail"; // Ürün detay sayfası
import SellerOrdersAndShipping from "../pages/Seller/SellerOrdersAndShipping";
import SellerSupport from "../pages/Seller/SellerSupport";
import EarningsPage from "../pages/Seller/EarningsPage";
import StatisticsPage from "../pages/Seller/StatisticsPage";
import SellerProfile from "../pages/Seller/SellerProfile";
import AdminPage from "../pages/Admin/AdminPage";
import UsersPage from "../pages/Admin/UsersPage";
import AdminProductsPage from "../pages/Admin/ProductsPage";
import AdminOrdersPage from "../pages/Admin/OrdersPage";
import AnalyticsPage from "../pages/Admin/AnalyticsPage";
import GuestPage from "../pages/Guest/GuestPage";
import ProductDetail from "../pages/Guest/ProductDetail";
import LoginPage from "../pages/Auth/LoginPage";
import RegisterPage from "../pages/Auth/RegisterPage";
import LogoutPage from "../pages/Auth/LogoutPage";

const AppRouter = () => {
  return (
    <Router>
      <Routes>
        {/* Misafir Kullanıcı */}
        <Route path="/" element={<GuestPage />} />
        <Route path="/product/:id" element={<ProductDetail />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />

        {/* Alıcı */}
        <Route path="/buyer" element={<BuyerPage />} />
        <Route path="/buyer/orders" element={<OrdersPage />} />
        <Route path="/buyer/cart" element={<CartPage />} />
        <Route path="/buyer/profile" element={<ProfilePage />} />
        <Route path="/buyer/favorites" element={<FavoritesPage />} />
        <Route path="/buyer/reviews" element={<ReviewsPage />} />
        <Route path="/buyer/support" element={<SupportPage />} />

        {/* Satıcı */}
        <Route path="/seller" element={<SellerPage />} />
        <Route path="/seller/products" element={<ProductsPage />} />
        <Route path="/seller/products/:id" element={<SellerProductDetail />} /> {/* Yeni eklenen ürün detay sayfası */}
        <Route path="/seller/orders" element={<SellerOrdersAndShipping />} />
        <Route path="/seller/earnings" element={<EarningsPage />} />
        <Route path="/seller/statistics" element={<StatisticsPage />} />
        <Route path="/seller/support" element={<SellerSupport />} />
        <Route path="/seller/profile" element={<SellerProfile />} /> 

        {/* Admin */}
        <Route path="/admin" element={<AdminPage />} />
        <Route path="/admin/users" element={<UsersPage />} />
        <Route path="/admin/products" element={<AdminProductsPage />} />
        <Route path="/admin/orders" element={<AdminOrdersPage />} />
        <Route path="/admin/analytics" element={<AnalyticsPage />} />

        {/* Çıkış */}
        <Route path="/logout" element={<LogoutPage />} />
      </Routes>
    </Router>
  );
};

export default AppRouter;
