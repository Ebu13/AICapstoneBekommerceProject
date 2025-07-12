import axios from "axios";

const API_URL = "http://localhost:8081/api";

const authHeader = () => ({
  headers: {
    Authorization: `Bearer ${localStorage.getItem("userToken")}`,
  },
});

// Auth İşlemleri
export const loginUser = (email, password) =>
  axios
    .post(`${API_URL}/auth/login`, { email, password })
    .then((res) => res.data);

export const logoutUser = () =>
  axios.post(`${API_URL}/auth/logout`, {}, authHeader()).then(() => {
    localStorage.removeItem("userToken");
    return true;
  });

export const registerUser = (name, email, password, role) =>
  axios
    .post(`${API_URL}/auth/register`, { name, email, password, role })
    .then((res) => res.data);

// Kullanıcı İşlemleri
export const getUserById = (id) =>
  axios.get(`${API_URL}/users/${id}`, authHeader()).then((res) => res.data);

export const getAllUsers = () =>
  axios.get(`${API_URL}/users`, authHeader()).then((res) => res.data);

export const deleteUser = (id) =>
  axios.delete(`${API_URL}/users/${id}`, authHeader()).then(() => true);

// ✅ Yeni: Kullanıcı güncelleme işlemi
export const updateUser = (id, updatedUser) =>
  axios
    .put(`${API_URL}/users/${id}`, updatedUser, authHeader())
    .then((res) => res.data);

// Yeni: Ürünleri çekme işlemi
export const getAllProducts = () =>
  axios
    .get(`${API_URL}/adminproducts`, authHeader())
    .then((res) => res.data);

// Default Export
export default {
  loginUser,
  logoutUser,
  registerUser,
  getUserById,
  getAllUsers,
  deleteUser,
  updateUser,
  getAllProducts, // Ürünleri alacak yeni fonksiyonu ekledik
};
