# MyPortfolio Mobile 📱

[![Flutter CI](https://github.com/balqis-raihana/myportofolio_mobile/actions/workflows/ci.yml/badge.svg)](https://github.com/balqis-raihana/myportofolio_mobile/actions/workflows/ci.yml)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.47.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.13.x-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Aplikasi mobile lintas platform modern yang dibangun menggunakan **Flutter** dan **Material Design 3**. Proyek ini berfungsi sebagai klien mobile resmi untuk ekosistem portofolio pribadi yang dikembangkan pada mata kuliah **Pemrograman Berbasis Platform (CSGE602022)** di **Fakultas Ilmu Komputer, Universitas Indonesia (Gasal 2026/2027)**.

---

## 👤 Identitas Pengembang

| Atribut | Informasi |
| :--- | :--- |
| **Nama** | Balqis Raihana |
| **NPM** | 2506625981 |
| **Kelas** | PBP A |
| **Program Studi** | S1 Sistem Informasi, Fakultas Ilmu Komputer, Universitas Indonesia |
| **Repositori** | [balqis-raihana/myportofolio_mobile](https://github.com/balqis-raihana/myportofolio_mobile) |

---

## 🎯 Gambaran Proyek & Target Tugas

Repositori ini memuat implementasi **Tugas Individu 7 (Basic Flutter)**, yang melanjutkan dan memperluas fondasi arsitektur dari **Tutorial 08**. Aplikasi ini menjadi fondasi antarmuka klien mobile yang nantinya akan berinteraksi langsung dengan backend portofolio berbasis Django REST Framework (DRF).

### Fitur Utama & Sorotan Implementasi

1. **Arsitektur Modular & Kode Bersih (*Clean Code*)**:
   - Memisahkan secara tegas inisialisasi aplikasi serta tema global pada `lib/main.dart` dari tata letak antarmuka utama pada `lib/menu.dart`.
   - Menggunakan `StatelessWidget` untuk `MyHomePage` guna mengoptimalkan efisiensi memori dan siklus hidup aplikasi, karena status visual halaman menu utama bersifat tetap.
   - Mengisolasi komponen antarmuka menjadi widget modular yang dapat digunakan kembali (*reusable widgets*): `InfoCard` dan `ItemCard`.

2. **Kartu Identitas Profil Pemilik (`InfoCard`)**:
   - Menampilkan tiga kartu informasi identitas resmi pemilik: **NPM**, **Nama**, dan **Kelas** yang tersusun secara horizontal dan seimbang.
   - Menggunakan perhitungan lebar adaptif berbasis proporsi layar perangkat (`MediaQuery.of(context).size.width / 3.5`).
   - Dilengkapi sudut melengkung halus (`BorderRadius.circular(12)`), teks yang rata tengah (*center-aligned*), serta efek elevasi bayangan 2.0 unit.

3. **Matriks Tombol Menu Aksi Portofolio (`ItemCard`)**:
   - Merepresentasikan bagian portofolio yang telah dibangun pada tugas-tugas sebelumnya dengan palet warna khusus:
     - 💼 **Lihat Experience** — *Palet Indigo* (`Colors.indigo.shade600`)
     - 🎓 **Lihat Coursework** — *Palet Teal* (`Colors.teal.shade600`)
     - ➕ **Tambah Item** — *Palet Amber* (`Colors.amber.shade800`)
     - 🚪 **Logout** — *Palet Merah* (`Colors.red.shade700`)
   - Memanfaatkan model data berorientasi objek (`ItemHomepage`) yang menampung atribut `name`, `icon`, dan `color`, sehingga eliminasi percabangan logika warna (`if-else`) yang redundan tercapai secara elegan.

4. **Umpan Balik Visual Interaktif (`SnackBar`)**:
   - Menyediakan efek riak air sentuhan sentral (*material ink ripple*) menggunakan widget `InkWell`.
   - Menampilkan notifikasi bilah mengambang (*floating SnackBar*) saat kartu ditekan: `Kamu telah menekan tombol [Nama Tombol]!`.
   - Warna latar notifikasi disinkronkan secara dinamis dengan warna kartu tombol yang bersangkutan.

5. **Otomasi CI/CD & Kualitas Kode**:
   - Menerapkan pengujian otomatis menggunakan **GitHub Actions** (`.github/workflows/ci.yml`) yang menjalankan analisis statis (`flutter analyze --no-fatal-infos`) dan pengujian widget smoke tests (`flutter test`) pada setiap proses `push` maupun `pull request`.

---

## 📂 Struktur Direktori Proyek

```text
myportofolio_mobile/
├── .github/
│   └── workflows/
│       └── ci.yml               # Alur otomasi CI untuk pengujian sintaks & widget test
├── android/                     # Berkas proyek native pembungkus Android & Gradle
├── ios/                         # Berkas proyek native pembungkus iOS
├── web/                         # Berkas kompilasi dan konfigurasi statis web
├── lib/
│   ├── main.dart                # Titik masuk utama aplikasi & konfigurasi tema Material 3
│   └── menu.dart                # Tampilan dashboard utama, InfoCard, ItemCard & model ItemHomepage
├── test/
│   └── widget_test.dart         # Pengujian smoke test untuk validasi komponen antarmuka
├── analysis_options.yaml        # Konfigurasi linter dan aturan gaya penulisan kode Dart
└── pubspec.yaml                 # Manifes dependensi, pustaka eksternal, dan metadata proyek
```

---

## 🚀 Panduan Menjalankan Proyek

### Prasyarat Sistem

Pastikan perangkat kamu telah terpasang:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi $\ge$ 3.19.0)
- [Dart SDK](https://dart.dev/get-dart) (otomatis terpasang bersama Flutter)
- Peramban Google Chrome (untuk target eksekusi web) atau Android Studio beserta build-tools SDK

### Langkah Menjalankan Aplikasi

1. **Klon repositori proyek:**
   ```bash
   git clone https://github.com/balqis-raihana/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

2. **Pasang seluruh dependensi:**
   ```bash
   flutter pub get
   ```

3. **Periksa perangkat yang terdeteksi:**
   ```bash
   flutter devices
   ```

4. **Jalankan aplikasi di Google Chrome (paling disarankan untuk sesi lab/pengembangan):**
   ```bash
   flutter run -d chrome
   ```

5. **Jalankan aplikasi di Emulator atau Perangkat Fisik Android:**
   ```bash
   flutter run
   ```

---

## 🧪 Pengujian Kualitas Kode

Jalankan analisis statis untuk memastikan kode mematuhi konvensi resmi Dart:
```bash
flutter analyze
```

Jalankan rangkaian pengujian otomatis (*widget tests*):
```bash
flutter test
```

---

## 📝 Pertanyaan Reflektif

### Tugas 7

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   *Jawab:*  
   *Widget tree* (pohon widget) adalah struktur data hierarkis berakar (*tree structure*) yang merepresentasikan seluruh susunan antarmuka pengguna (UI) pada aplikasi Flutter. Di Flutter berlaku filosofi bahwa hampir segala sesuatu adalah widget (*everything is a widget*)—mulai dari elemen visual seperti teks, ikon, kartu, dan tombol, hingga elemen penata letak (*layout*) dan struktural seperti padding, kolom, baris, maupun pendeteksi gestur.

   Hubungan induk-anak (*parent-child relationship*) bekerja berdasarkan prinsip komposisi dan pembagian tugas yang dikenal dengan aturan *"constraints go down, sizes go up, parent sets position"*:
   - **Widget Induk (*Parent*)**: Memberikan batasan ukuran (*constraints*, mencakup lebar dan tinggi minimum serta maksimum) ke widget anak di bawahnya. Widget induk dapat menampung satu anak tunggal melalui properti `child` (seperti `Container`, `Padding`, `Center`, `Card`) atau banyak anak sekaligus melalui properti `children` (seperti `Column`, `Row`, `GridView`).
   - **Widget Anak (*Child*)**: Menerima batasan tersebut dari induknya, menentukan dimensi ukurannya sendiri yang sah di dalam batasan yang diberikan, lalu melaporkan ukurannya kembali ke induk. Widget induk kemudian menentukan letak posisi (*coordinates*) anak tersebut pada layar. Ketika suatu widget induk direkonstruksi (*rebuild*), seluruh sub-pohon (*subtree*) yang berada di bawahnya akan dievaluasi ulang secara efisien oleh framework.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   *Jawab:*  
   Berikut adalah daftar lengkap widget yang diimplementasikan pada proyek ini beserta fungsinya:
   - **`MaterialApp`**: Widget root aplikasi yang membungkus keseluruhan fungsionalitas Material Design, sistem navigasi (*routing*), lokalisasi, dan tema global aplikasi.
   - **`Scaffold`**: Menyediakan kerangka struktural visual dasar Material Design pada suatu halaman, seperti slot `appBar`, `body`, `floatingActionButton`, dan pengelolaan overlay `SnackBar`.
   - **`AppBar`**: Menampilkan bilah navigasi di bagian atas halaman aplikasi yang memuat judul (*title*), gaya tipografi, dan warna latar belakang.
   - **`SingleChildScrollView`**: Membungkus konten agar dapat digulir (*scrollable*) dalam satu arah vertikal, mencegah terjadinya galat *render overflow* saat konten melebihi dimensi layar perangkat atau saat keyboard virtual aktif.
   - **`Padding`**: Memberikan jarak atau ruang kosong (*inset spacing*) di sekeliling widget anaknya agar antarmuka tidak menempel rapat pada tepi layar.
   - **`Column`**: Menata dan menyusun daftar widget anak (*children*) secara vertikal dari atas ke bawah.
   - **`Row`**: Menata dan menyusun daftar widget anak (*children*) secara horizontal dari kiri ke kanan.
   - **`Center`**: Menempatkan widget anaknya tepat di titik tengah horizontal dan vertikal ruang yang tersedia.
   - **`Text`**: Menampilkan untaian teks ke layar dengan konfigurasi gaya tertentu seperti ukuran font, bobot tebal (*fontWeight*), warna, dan perataan (*textAlign*).
   - **`Card`**: Komponen lembar permukaan Material berdesain kartu yang memiliki sudut melengkung dan efek bayangan kedalaman (*elevation*) untuk mengelompokkan informasi terkait.
   - **`Container`**: Widget serbaguna untuk mengatur dimensi (*width*, *height*), ruang dalam (*padding*), dekorasi, dan batasan ukuran elemen.
   - **`SizedBox`**: Kotak dengan dimensi pasti yang digunakan untuk memberikan jarak pemisah yang konsisten antar-elemen tanpa dekorasi visual tambahan.
   - **`GridView.count`**: Menampilkan daftar widget anak dalam bentuk kisi dua dimensi dengan jumlah kolom tetap (`crossAxisCount: 3`) serta jarak antar-kartu (`crossAxisSpacing` dan `mainAxisSpacing`).
   - **`Material`**: Komponen dasar sistem Material Design yang bertanggung jawab menggambar warna latar permukaan kartu, bentuk kurva sudut (*borderRadius*), dan menjadi kanvas bagi efek sentuh *ripple*.
   - **`InkWell`**: Menyediakan pendeteksi gestur sentuhan dengan efek umpan balik riak air (*material splash / ink ripple*) saat kartu ditekan oleh pengguna melalui callback `onTap`.
   - **`Icon`**: Merender simbol glif grafis dari pustaka Material Icons (seperti `Icons.work_outline`, `Icons.school_outlined`, `Icons.add_circle_outline`, `Icons.logout`).
   - **`SnackBar`**: Bilah pesan notifikasi ringan yang muncul melayang (*floating*) di bagian bawah layar untuk memberikan konfirmasi aksi kepada pengguna setelah menekan tombol.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   *Jawab:*  
   Widget `MaterialApp` adalah widget konfigurator tingkat tertinggi (*top-level convenience widget*) yang memperkenalkan seluruh infrastruktur pendukung desain Material Google ke dalam aplikasi Flutter.

   Fungsi utamanya meliputi:
   - **Menyediakan Tema Global (`ThemeData`)**: Mengatur skema warna (`colorScheme`), tipografi, gaya komponen, dan mode tampilan (*light/dark mode* atau Material 3) yang diwariskan ke seluruh widget di bawahnya melalui `Theme.of(context)`.
   - **Manajemen Navigasi dan Rute (`Navigator` & `routes`)**: Menyediakan `Navigator` terintegrasi untuk mengelola tumpukan perpindahan halaman (*route stack*).
   - **Pondasi Aksesibilitas dan Lokalisasi**: Menangani arah penulisan teks (*LTR / RTL*), terjemahan multibahasa, dan integrasi fitur aksesibilitas sistem operasi.
   - **Overlay dan Messaging Layer**: Memungkinkan pemanggilan dialog, *bottom sheet*, dan notifikasi bar melalui `ScaffoldMessenger.of(context)`.

   `MaterialApp` umumnya digunakan sebagai root widget karena sebagian besar widget inti Flutter (seperti `Scaffold`, `AppBar`, `Card`, `InkWell`, dan `TextField`) membutuhkan layanan inheren (*inherited widgets*) yang disediakan oleh `MaterialApp` (seperti `Directionality`, `MediaQuery`, dan `Localizations`). Tanpa `MaterialApp` (atau padanan Cupertino-nya, `CupertinoApp`), widget-widget Material tersebut akan melemparkan exception karena ketiadaan konfigurasi dasar sistem.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   *Jawab:*  
   Perbedaan mendasar antara keduanya terletak pada kemampuan menyimpan dan memutasi status internal (*state*) selama siklus hidup widget:

   | Aspek | `StatelessWidget` | `StatefulWidget` |
   | :--- | :--- | :--- |
   | **Sifat Status (State)** | Statis / Tidak dapat berubah (*Immutable*). Nilai konfigurasi bersifat final setelah diinisialisasi. | Dinamis / Dapat berubah (*Mutable*). Memiliki objek pendamping `State` yang hidup sepanjang siklus widget. |
   | **Metode Utama** | Hanya memiliki metode `Widget build(BuildContext context)`. | Memiliki metode `createState()` yang mengembalikan kelas `State` terpisah yang mengimplementasikan metode `build()`. |
   | **Pemicu Re-render** | Hanya direkonstruksi jika widget induknya memicu rebuild dengan argumen konfigurasi baru. | Dapat memicu render ulang kapan saja secara lokal menggunakan fungsi `setState()`. |
   | **Konsumsi Memori** | Sangat ringan, cepat, dan efisien. | Memerlukan overhead memori lebih untuk melacak siklus hidup objek `State`. |

   **Kapan memilih `StatelessWidget`:**  
   Pilihlah saat tampilan antarmuka hanya bergantung pada data statis atau konfigurasi awal yang dioper dari widget induk tanpa ada perubahan nilai internal sepanjang halaman terbuka (contoh: halaman portofolio, kartu profil identitas, label teks, tombol navigasi statis).

   **Kapan memilih `StatefulWidget`:**  
   Pilihlah saat komponen antarmuka harus merespons perubahan interaksi dinamis secara langsung di dalam widget tersebut (contoh: form input pengguna dengan validasi langsung, penghitung klik *counter*, saklar toggle, checkbox, animasi interaktif, atau saat menunggu respons data dari pemanggilan API backend secara asinkron).

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   *Jawab:*  
   `BuildContext` adalah sebuah objek penanda lokasi (*handle*) yang merepresentasikan letak atau posisi spesifik suatu widget di dalam hierarki *widget tree* aplikasi. Setiap kali Flutter mengeksekusi metode `build()`, parameter `BuildContext` diinjeksikan secara otomatis untuk widget yang bersangkutan.

   **Mengapa penting:**  
   Flutter menganut konsep arsitektur pohon widget. Komponen anak sering kali membutuhkan informasi lingkungan atau data yang disediakan oleh widget leluhurnya (*ancestor widgets*). `BuildContext` bertindak sebagai "peta koordinat" yang memungkinkan widget membaca konteks sekitarnya tanpa perlu melakukan passing parameter secara manual (*prop drilling*).

   **Penggunaannya di dalam metode `build`:**
   - **Mengambil Dimensi Layar (`MediaQuery`)**:  
     Digunakan untuk merespons ukuran layar perangkat secara proporsional:  
     `MediaQuery.of(context).size.width / 3.5` (pada `InfoCard`).
   - **Mengakses Tema Aplikasi (`Theme`)**:  
     Digunakan untuk membaca palet warna global:  
     `Theme.of(context).colorScheme.primary` (pada `AppBar`).
   - **Menampilkan Notifikasi (`ScaffoldMessenger`)**:  
     Mencari `ScaffoldMessenger` terdekat di atas widget tree untuk menampilkan `SnackBar`:  
     `ScaffoldMessenger.of(context).showSnackBar(...)` (pada aksi tap `ItemCard`).

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   *Jawab:*  
   **Konsep Hot Reload:**  
   Hot reload adalah fitur produktivitas unggulan pada Flutter yang memanfaatkan mesin virtual Dart (*Dart VM*) dalam mode kompilasi *Just-In-Time* (JIT). Saat pengembang menyimpan perubahan kode sumber, Flutter hanya menyuntikkan (*inject*) berkas kode sumber yang baru diperbarui langsung ke dalam Dart VM yang sedang berjalan, kemudian merekonstruksi widget tree dari metode `build()` tanpa mematikan aplikasi dan **tanpa mereset status aplikasi (*state-preserving*)**.

   **Perbedaan Hot Reload vs Hot Restart:**
   - **Hot Reload (`r` di terminal)**: Berjalan dalam hitungan milidetik (< 1 detik). Kode baru dimuat ulang, tetapi semua variabel state yang sedang aktif (misalnya nilai form, posisi scroll, atau data yang sudah dimuat) tetap dipertahankan.
   - **Hot Restart (`R` di terminal)**: Berjalan sedikit lebih lama (~1-3 detik). Kode baru dimuat ulang dan seluruh state aplikasi dihancurkan serta diinisialisasi ulang dari fungsi `main()` (mirip dengan me-refresh halaman web).

   **Kapan Hot Reload TIDAK bisa diandalkan dan harus menggunakan Hot Restart / Full Restart:**
   - **Mengubah fungsi `main()` atau inisialisasi awal**: Hot reload tidak mengeksekusi ulang fungsi `main()`, sehingga perubahan konfigurasi awal aplikasi memerlukan hot restart.
   - **Mengubah deklarasi variabel global atau variabel `static`**: Hot reload mempertahankan nilai variabel yang sudah ada di memori.
   - **Mengubah konstruktor atau logika `initState()`**: Siklus `initState()` pada `StatefulWidget` hanya dipanggil sekali saat widget pertama kali dibuat; hot reload tidak akan menjalankannya kembali.
   - **Mengubah struktur hierarki kelas**: Mengubah `StatelessWidget` menjadi `StatefulWidget` (atau sebaliknya) memerlukan hot restart.
   - **Menambahkan dependensi baru di `pubspec.yaml` atau aset gambar**: Memerlukan eksekusi `flutter pub get` dan *Full Restart* (*stop debugging* lalu `flutter run` ulang).
   - **Mengubah kode native (Android Gradle / iOS Pods / Manifest)**: Memerlukan *Full Restart* karena perubahan tersebut harus dikompilasi ulang oleh compiler native (Gradle/Xcode).

---

## 🤖 Transparansi & Keterbukaan Penggunaan AI (AI Disclosure)

Dalam pengerjaan **Tugas Individu 7**, saya menggunakan AI (Google DeepMind / Gemini) sebagai alat bantu *pair-programming* interaktif untuk eksplorasi arsitektur, refaktorisasi kode bersih (*clean code*), penyusunan alur CI/CD, dan penelusuran galat (*troubleshooting*).

### Rincian Bantuan AI:
1. **Perancangan Arsitektur Modular**:
   - Membantu menyusun pemisahan berkas `lib/menu.dart` dari `lib/main.dart` agar memenuhi prinsip rekayasa perangkat lunak (*Separation of Concerns*).
   - Mengusulkan penambahan atribut `Color color` langsung pada kelas model `ItemHomepage` untuk menghindari logika pewarnaan yang berulang (*redundant*) menggunakan banyak percabangan `if-else` atau `switch-case`.
2. **Penyusunan Otomasi Pipeline CI/CD**:
   - Membantu penulisan berkas alur kerja GitHub Actions (`.github/workflows/ci.yml`) untuk menjalankan analisis sintaksis `flutter analyze` dan pengujian widget `flutter test` secara otomatis pada server pengujian Ubuntu.
3. **Penyusunan Pertanyaan Reflektif**:
   - Memberikan tinjauan komprehensif terhadap konsep teknis Flutter (Widget Tree, `BuildContext`, State Management, dan siklus rendering JIT/AOT).

### Analisis Kritis Keterbatasan AI & Perbaikan Manual Mandiri:
Meskipun AI sangat membantu dalam mempercepat penyusunan kerangka kode, terdapat sejumlah keterbatasan teknis nyata yang membutuhkan analisis dan intervensi mandiri:
- **Ketidaktepatan Deteksi Lokasi SDK**: AI sempat mengalami galat saat memanggil proses Flutter daemon karena variabel lingkungan sistem mengarah ke jalur yang tidak sesuai (`C:\Users\Balqis\develop\...`). Saya mengidentifikasi folder instalasi SDK yang aktif (`C:\develop\flutter`) dan memperbaikinya.
- **Kegagalan Pipeline CI di GitHub Actions**: Konfigurasi bawaan perintah `flutter analyze` di server GitHub Actions menganggap peringatan deprecation level `info` sebagai galat fatal (*build failure*). Saya memperbaiki alur tersebut dengan menambahkan argumen `--no-fatal-infos` pada langkah alur kerja serta menambahkan aturan penanganan galat pada `analysis_options.yaml`.
- **RenderFlex Overflow pada Widget Test**: Kode bawaan template `widget_test.dart` mengalami kegagalan uji karena masih mencari elemen kalkulator counter bawaan dan mendeteksi adanya *RenderFlex overflow* pada dimensi layar pengujian sempit. Saya melakukan refaktorisasi dengan membungkus halaman utama menggunakan `SingleChildScrollView` dan memperbarui ekspektasi pengujian widget agar sesuai dengan komponen kartu dan tombol portofolio pribadi.

---

## 📄 Lisensi

Proyek ini didistribusikan secara terbuka di bawah lisensi [MIT License](LICENSE).
