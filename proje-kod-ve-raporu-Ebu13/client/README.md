# Client - E-Ticaret Projesi (Frontend)

Bu proje, React ile geliştirilen bir e-ticaret platformunun ön yüzüdür. Backend Spring Boot, veritabanı PostgreSQL ve mobil uygulama Flutter ile geliştirilmektedir.

## 📂 Dizin Yapısı

```
client/
│── public/         # Statik dosyalar (favicon, manifest vb.)
│── src/            # Tüm kaynak kodları
│   ├── components/ # Ortak bileşenler (Navbar, Footer, Button vb.)
│   ├── pages/      # Sayfalar (Buyer, Seller, Admin, Guest)
│   ├── routes/     # Sayfa yönlendirme (React Router)
│   ├── services/   # API çağrıları (Axios)
│   ├── context/    # Global state yönetimi (Auth, User Context vb.)
│   ├── hooks/      # Özel React Hook'ları
│   ├── utils/      # Yardımcı fonksiyonlar (Tarih, Format vb.)
│   ├── App.jsx     # Ana uygulama bileşeni
│   ├── main.jsx    # React giriş noktası
│── package.json    # Bağımlılıklar ve betikler
│── vite.config.js  # Vite yapılandırma dosyası
```

## 📌 Klasör Açıklamaları

- **components/** → Projede birden fazla yerde kullanılabilecek bileşenler (Navbar, Footer vb.).
- **pages/** → Kullanıcı rollerine göre ayrılmış sayfalar (Buyer, Seller, Admin, Guest).
- **routes/** → Sayfa yönlendirme ve React Router ayarları.
- **services/** → API çağrıları (Spring Boot ile bağlantılar).
- **context/** → Global state yönetimi (Kullanıcı oturumu, yetkilendirme vb.).
- **hooks/** → Özel React Hook'ları (API çağrıları, veri yönetimi vb.).
- **utils/** → Yardımcı fonksiyonlar (Tarih formatlama, doğrulamalar vb.).

## 🚀 Projeyi Çalıştırma

1. Bağımlılıkları yükle:
   ```sh
   npm install
   ```
2. Projeyi başlat:
   ```sh
   npm run dev
   ```
3. Tarayıcıda aç: **http://localhost:5173**

## 📌 Notlar
- Tailwind CSS kullanılmıyor. Klasik CSS veya UI kütüphaneleri tercih edilebilir.
- Backend, Spring Boot ile geliştirilmektedir.
- Veritabanı olarak PostgreSQL kullanılacaktır.

---

Bu proje yapısını ihtiyacına göre genişletebilirsin. 🚀