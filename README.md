# Toko App

Toko App adalah aplikasi demonstrasi toko online yang dibuat menggunakan Flutter. Aplikasi ini menampilkan alur dasar belanja: pengguna masuk, melihat dan mencari produk, membuka detail produk, memasukkan produk ke keranjang, lalu mencoba proses checkout. Antarmukanya menggunakan aksen warna oranye dan komponen Material 3.

## Fitur

- Splash screen selama dua detik sebelum halaman login.
- Login sederhana menggunakan username dan password.
- Proteksi halaman menggunakan pengalihan rute berdasarkan status login.
- Beranda dengan daftar produk dan navigasi ke detail.
- Pencarian produk berdasarkan nama.
- Detail produk dengan foto, deskripsi, harga, dan tombol tambah ke keranjang.
- Keranjang belanja dengan jumlah produk dan total harga.
- Checkout demonstrasi yang mengosongkan keranjang setelah tombol pembayaran ditekan.
- Halaman profil dengan informasi akun dan tombol keluar.
- Navigasi bawah dengan tab Beranda, Cari, Keranjang, dan Profil.
- Tampilan responsif dan aset foto produk lokal.

## Teknologi

- Flutter dan Dart
- Material 3
- `go_router` untuk navigasi berbasis URL
- `ChangeNotifier` untuk status autentikasi dan keranjang
- Flutter Test untuk pengujian

## Menjalankan aplikasi

Pastikan Flutter SDK yang sesuai dengan batas SDK proyek tersedia, lalu jalankan:

```bash
flutter pub get
flutter run -d chrome
```

Untuk menjalankan pada perangkat Android yang terhubung:

```bash
flutter devices
flutter run -d <device-id>
```

Pastikan USB debugging aktif pada perangkat Android. Untuk menjalankan semua pengujian dan pemeriksaan analisis:

```bash
flutter test
flutter analyze
```

## Alur aplikasi dan navigasi

Rute awal aplikasi adalah `/splash`. Splash screen menampilkan identitas Toko App selama dua detik, kemudian berpindah ke `/login`. Rute aplikasi diatur dalam `lib/router/app_router.dart`.

| Rute | Halaman | Keterangan |
| --- | --- | --- |
| `/splash` | Splash | Halaman pembuka aplikasi |
| `/login` | Login | Halaman masuk; dapat menampilkan tujuan awal pada parameter `from` |
| `/home` | Beranda | Daftar produk dan pintasan pencarian |
| `/home/product/:id` | Detail produk | Detail produk yang dibuka dari Beranda |
| `/search` | Cari | Pencarian dan daftar hasil produk |
| `/search/product/:id` | Detail produk | Detail produk yang dibuka dari Cari |
| `/cart` | Keranjang | Produk yang telah ditambahkan |
| `/cart/checkout` | Checkout | Ringkasan dan simulasi pembayaran |
| `/profile` | Profil | Informasi pengguna dan tombol keluar |

### Proteksi halaman dan login

`AuthState` menyimpan username dan status login sementara selama aplikasi berjalan. Router mendengarkan perubahan `AuthState` melalui `refreshListenable`. Jika pengguna yang belum login membuka halaman privat, fungsi `redirect` mengarahkannya ke login dan menyimpan URL tujuan pada parameter `from`. Setelah login, router mengevaluasi ulang status dan mengarahkan pengguna ke tujuan awal tersebut, atau ke `/home` jika tidak ada tujuan yang tersimpan.

Form login hanya memeriksa bahwa username dan password tidak kosong. Proyek ini belum menggunakan server, basis data pengguna, atau verifikasi kredensial sungguhan. Status login juga tidak disimpan setelah aplikasi ditutup.

### Navigasi tab

Empat tab utama dikelola menggunakan `StatefulShellRoute.indexedStack`. Setiap tab memiliki cabang navigasi sendiri sehingga state halaman tab, seperti teks pencarian, dipertahankan ketika pengguna berpindah tab.

Rute detail menerima ID produk dari URL. Dengan demikian, halaman detail dapat dituju melalui rute seperti `/home/product/3` atau `/search/product/3`.

## Data dan foto produk

Data contoh produk didefinisikan di `lib/models/product.dart`. Foto disimpan sebagai aset lokal di `assets/products/` dan didaftarkan pada `pubspec.yaml`.

| ID | Produk | Foto |
| --- | --- | --- |
| 1 | Sepatu Lari | `assets/products/sepatu-lari.png` |
| 2 | Tas Ransel | `assets/products/tas-ransel.png` |
| 3 | Jam Tangan | `assets/products/jam-tangan.png` |
| 4 | Headphone | `assets/products/headphone.png` |
| 5 | Botol Minum | `assets/products/botol-minum.png` |

Foto digunakan pada kartu produk dan halaman detail. Harga ditampilkan dalam format Rupiah menggunakan fungsi `formatRupiah`.

## Pengelolaan state dan batasan

- `AuthState` mengelola login dan logout menggunakan `ChangeNotifier`.
- `CartState` menyimpan daftar produk, jumlah item, dan total harga menggunakan `ChangeNotifier`.
- Data autentikasi serta keranjang hanya berada di memori; keduanya kembali kosong saat aplikasi dimulai ulang.
- Tombol pembayaran hanya menjalankan simulasi: keranjang dikosongkan dan pesan keberhasilan ditampilkan. Belum ada pembayaran, alamat pengiriman, atau integrasi layanan eksternal.
- Daftar produk merupakan data statis untuk demonstrasi, bukan katalog dari API.

## Struktur direktori utama

```text
lib/
  main.dart                 # Inisialisasi aplikasi dan tema
  models/product.dart       # Model, data contoh, dan format harga
  router/app_router.dart    # Definisi rute dan pengalihan login
  state/auth_state.dart     # Status autentikasi
  state/cart_state.dart     # Status keranjang
  widgets/product_card.dart # Kartu produk yang digunakan bersama
  pages/                    # Splash, login, beranda, cari, dan halaman lain
assets/products/            # Lima foto produk lokal
test/widget_test.dart       # Pengujian aset dan alur splash ke login
```

## Pengujian

`test/widget_test.dart` memeriksa bahwa setiap produk menggunakan aset foto yang sesuai dan dapat memuat aset tersebut, serta memastikan splash screen beralih ke halaman login. Jalankan pengujian dengan `flutter test`.
