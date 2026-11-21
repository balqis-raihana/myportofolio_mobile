# MyPortfolio Mobile

[![Flutter CI](https://github.com/balqis-raihana/myportofolio_mobile/actions/workflows/ci.yml/badge.svg)](https://github.com/balqis-raihana/myportofolio_mobile/actions/workflows/ci.yml)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.47.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.13.x-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Aplikasi mobile lintas platform yang dibangun menggunakan Flutter dan Material Design 3. Proyek ini berfungsi sebagai klien mobile untuk ekosistem portofolio pribadi yang dikembangkan pada mata kuliah Pemrograman Berbasis Platform (CSGE602022) di Fakultas Ilmu Komputer, Universitas Indonesia (Gasal 2026/2027).

---

## Developer Profile

| Attribute | Information |
| :--- | :--- |
| **Name** | Balqis Raihana |
| **NPM** | 2506625981 |
| **Class** | PBP A |
| **Program** | SI Sistem Informasi, Fakultas Ilmu Komputer, Universitas Indonesia |
| **Repository** | [balqis-raihana/myportofolio_mobile](https://github.com/balqis-raihana/myportofolio_mobile) |

---

## Project Overview

Repositori ini memuat implementasi klien mobile Flutter yang dikembangkan bertahap dari Tugas 7 (fondasi antarmuka dan kartu aksi) hingga Tugas 8 (navigasi multi-halaman, drawer, dan formulir data edukasi).

### Key Features

1. **Modular Architecture**:
   - Memisahkan inisialisasi aplikasi pada `lib/main.dart`, halaman antarmuka pada `lib/screens/`, dan komponen dapat dipakai ulang pada `lib/widgets/`.
   - Menggunakan `StatelessWidget` untuk halaman statis dan `StatefulWidget` untuk formulir dinamis.

2. **Developer Profile Cards (`InfoCard`)**:
   - Menampilkan NPM, Nama, dan Kelas secara horizontal dengan pembagian proporsi layar adaptif.

3. **Action Cards & Navigation (`ItemCard`)**:
   - Tombol aksi dengan palet warna khusus:
     - Lihat Experience (Indigo)
     - Lihat Coursework (Teal)
     - Tambah Item (Amber)
     - Tambah Edukasi (Biru)
     - Logout (Merah)
   - Umpan balik sentuhan menggunakan `InkWell` dan notifikasi `SnackBar`.

4. **Education Form & Data Validation**:
   - Halaman input data edukasi (`EducationFormPage`) yang memvalidasi isian teks, dropdown jenjang, batasan tahun masuk/lulus, dan rentang IPK.
   - Dialog konfirmasi (`AlertDialog`) yang menampilkan ringkasan data setelah seluruh input dinyatakan valid.

5. **Navigation Drawer (`LeftDrawer`)**:
   - Drawer terpadu yang dapat diakses dari halaman utama maupun halaman formulir.

---

## Project Directory Structure

```text
myportofolio_mobile/
├── .github/
│   └── workflows/
│       └── ci.yml               # GitHub Actions workflow for linting and test suite
├── android/                     # Android native project files
├── ios/                         # iOS native project files
├── web/                         # Web platform configuration
├── lib/
│   ├── main.dart                # Application entry point & theme setup
│   ├── models/
│   │   └── education_entry.dart # Education data model
│   ├── screens/
│   │   ├── menu.dart            # Main portfolio dashboard
│   │   ├── project_form.dart    # Project form (Tutorial 09)
│   │   └── education_form.dart  # Education form (Tugas 8)
│   └── widgets/
│       ├── left_drawer.dart     # Shared navigation drawer
│       └── project_card.dart    # Action cards & homepage models
├── test/
│   └── widget_test.dart         # Widget smoke tests
├── analysis_options.yaml        # Dart analyzer & linter rules
└── pubspec.yaml                 # Project manifest & dependencies
```

---

## Getting Started

### Prerequisites

- Flutter SDK (>= 3.19.0)
- Dart SDK (bundled with Flutter)
- Google Chrome browser or Android Studio / Emulator

### Running the Project

1. Klon repositori:
   ```bash
   git clone https://github.com/balqis-raihana/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

2. Unduh dependensi:
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi di Chrome:
   ```bash
   flutter run -d chrome
   ```

4. Jalankan aplikasi di emulator / perangkat Android:
   ```bash
   flutter run
   ```

---

## Code Quality & Testing

Jalankan analisis statis:
```bash
flutter analyze
```

Jalankan widget test:
```bash
flutter test
```

---

## Pertanyaan Reflektif

### Tugas 7

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   *Jawab:*  
   *Widget tree* adalah hierarki pohon objek yang merepresentasikan seluruh struktur antarmuka aplikasi Flutter. Hampir seluruh elemen di Flutter merupakan widget, baik berupa elemen visual (seperti `Text`, `Card`, `Icon`), layout (`Column`, `Row`, `Padding`), maupun interaksi (`InkWell`, `GestureDetector`).

   Hubungan *parent-child* bekerja mengikuti prinsip *"constraints go down, sizes go up, parent sets position"*:
   - **Parent**: Mengirim batasan ukuran (*min/max width & height*) ke widget anaknya.
   - **Child**: Menentukan ukurannya sendiri di dalam batas tersebut dan mengembalikannya ke parent.
   - **Parent**: Menentukan posisi koordinat child pada layar. Rebuild pada parent akan mengevaluasi ulang subtree di bawahnya secara efisien.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   *Jawab:*  
   - `MaterialApp`: Root widget pembungkus konfigurasi tema Material 3 dan routing dasar.
   - `Scaffold`: Struktur halaman dasar penampung `appBar`, `body`, dan `drawer`.
   - `AppBar`: Bilah navigasi atas penampil judul halaman.
   - `SingleChildScrollView`: Membuat konten dapat digulir dan mencegah galat render overflow saat layar terbatas atau keyboard muncul.
   - `Padding`: Memberikan jarak di sekeliling widget anak.
   - `Column` & `Row`: Menyusun widget secara vertikal (`Column`) dan horizontal (`Row`).
   - `Center`: Memposisikan widget anak tepat di tengah area yang tersedia.
   - `Text`: Menampilkan teks berformat.
   - `Card`: Wadah berdesain Material dengan sudut melengkung dan elevasi.
   - `Container`: Kotak styling serbaguna penentu ukuran, margin, atau dekorasi.
   - `SizedBox`: Pengatur jarak tetap antar-elemen.
   - `GridView.count`: Menampilkan kisi kartu 3 kolom pada halaman utama.
   - `Material`: Menyediakan kanvas warna latar dan efek visual sentuhan.
   - `InkWell`: Pendeteksi sentuhan (*tap gesture*) dengan efek riak air Material (*ripple*).
   - `Icon`: Menampilkan ikon grafis dari Material Icons.
   - `SnackBar`: Notifikasi mengambang saat tombol ditekan.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   *Jawab:*  
   `MaterialApp` adalah widget konfigurasi utama yang menyediakan sistem Material Design ke seluruh aplikasi:
   - Menyediakan tema global (`ThemeData`, `ColorScheme`).
   - Menyediakan `Navigator` untuk mengelola routing dan tumpukan halaman.
   - Menyediakan konfigurasi `Localizations`, `Directionality`, dan integrasi aksesibilitas OS.
   - Memungkinkan akses layer overlay seperti `ScaffoldMessenger` dan `showDialog`.

   Widget ini dijadikan root karena sebagian besar widget Material (seperti `Scaffold`, `TextField`, dan `AppBar`) mewajibkan adanya InheritedWidget dasar dari `MaterialApp`.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   *Jawab:*  
   - **`StatelessWidget`**: Bersifat immutable (statis). Tidak memiliki state internal yang berubah sepanjang siklus hidupnya. Dipakai saat UI hanya bergantung pada data tetap atau parameter dari parent (misalnya kartu profil, teks label, ikon).
   - **`StatefulWidget`**: Memiliki objek pendamping `State` yang mutable (dinamis). State dapat diperbarui kapan saja menggunakan `setState()`. Dipakai saat UI harus merespons perubahan interaksi langsung (misalnya formulir input, checkbox, animasi, dropdown).

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   *Jawab:*  
   `BuildContext` adalah penanda lokasi suatu widget di dalam hierarki widget tree. Objek ini penting karena memungkinkan widget anak mencari dan membaca data dari widget leluhurnya (*ancestor*) tanpa *prop drilling*.
   
   Contoh di dalam metode `build`:
   - `Theme.of(context)`: Mengambil warna primer tema untuk `AppBar`.
   - `MediaQuery.of(context)`: Membaca dimensi layar untuk menghitung lebar `InfoCard`.
   - `ScaffoldMessenger.of(context)`: Menampilkan `SnackBar` saat tombol ditekan.

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   *Jawab:*  
   - **Hot Reload (`r`)**: Menyuntikkan kode baru ke Dart VM dan memanggil ulang `build()` tanpa mematikan aplikasi dan mempertahankan state yang ada.
   - **Hot Restart (`R`)**: Memuat ulang kode sekaligus menghancurkan dan menginisialisasi ulang seluruh state dari fungsi `main()`.

   Hot reload tidak dapat diandalkan ketika:
   - Mengubah inisialisasi pada fungsi `main()` atau metode `initState()`.
   - Mengubah variabel static/global.
   - Mengubah kelas dari `StatelessWidget` ke `StatefulWidget` (atau sebaliknya).
   - Menambahkan dependensi baru di `pubspec.yaml` (perlu `flutter pub get` dan Full Restart).
   - Mengubah kode native Android/iOS (perlu Full Restart).

---

### Tugas 8

1. **Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.**

   *Jawab:*  
   - **`Navigator.push()`**: Menambahkan rute baru ke posisi teratas tumpukan (*navigation stack*). Halaman sebelumnya tetap tersimpan di bawah tumpukan, sehingga tombol *back* bawaan perangkat dapat digunakan untuk kembali ke halaman sebelumnya.
   - **`Navigator.pushReplacement()`**: Menghapus rute yang sedang aktif di tumpukan dan menggantikannya dengan rute baru. Halaman lama dibuang dari stack, sehingga tombol *back* tidak akan membawa pengguna kembali ke halaman yang digantikan.
   - **`Navigator.pop()`**: Menghapus rute teratas dari tumpukan untuk menutup halaman atau dialog yang sedang aktif dan kembali ke halaman tepat di bawahnya.

   **Metode yang digunakan untuk membuka formulir dari kartu aksi:**  
   Menggunakan `Navigator.push()` pada callback `onTap` di `ItemCard` (`lib/widgets/project_card.dart`). Dengan `push()`, halaman formulir ditumpuk di atas `MyHomePage`, sehingga tombol back bawaan perangkat dapat langsung mengembalikan pengguna ke halaman utama.

   **Bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama:**  
   Pada `LeftDrawer` (`lib/widgets/left_drawer.dart`), opsi menu *Home* menggunakan:
   ```dart
   Navigator.pushReplacement(
     context,
     MaterialPageRoute(builder: (context) => MyHomePage()),
   );
   ```
   Metode `pushReplacement()` menggantikan halaman formulir yang sedang aktif dengan instans baru `MyHomePage()`. Hal ini mencegah terjadinya penumpukan halaman yang berlebihan di memori saat pengguna sering berpindah antarhalaman melalui drawer, sekaligus memastikan halaman utama langsung terbuka kembali.

2. **Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

   *Jawab:*  
   - **Konsistensi Struktur:** `Scaffold` bertindak sebagai template standar tata letak Material Design di setiap halaman (`MyHomePage`, `ProjectFormPage`, dan `EducationFormPage`). Dengan memasang komponen `AppBar` di slot atas dan menyematkan instance `LeftDrawer()` yang sama pada slot `drawer` di setiap halaman, pengguna selalu melihat hierarki navigasi, tombol hamburger, dan tata letak yang identik tanpa perlu mendesain ulang navigasi per halaman.
   - **Contoh Penggunaan Warna Tema:**  
     Warna tema primer aplikasi (`Colors.indigo`) didefinisikan secara terpusat pada `ThemeData` di `lib/main.dart` melalui `seedColor: Colors.indigo`. Warna ini diterapkan konsisten di berbagai halaman:
     1. Pada `AppBar` di `lib/screens/education_form.dart` dan `lib/screens/project_form.dart` melalui `backgroundColor: Theme.of(context).colorScheme.primary`.
     2. Pada latar belakang `DrawerHeader` di `lib/widgets/left_drawer.dart` (`color: Colors.indigo`).
     3. Pada tombol "Simpan" di form edukasi dan kartu menu "Lihat Experience" di `MyHomePage` (`Colors.indigo.shade600`).

3. **Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

   *Jawab:*  
   - **Alasan Pemilihan Tata Letak Formulir:**  
     Formulir edukasi disusun secara vertikal di dalam `Column` dengan orientasi atas-ke-bawah (*top-to-bottom*). Tata letak ini dipilih karena mengikuti alur membaca alami manusia saat mengisikan data berurutan: dari identitas institusi, jurusan, jenjang, tahun, hingga nilai dan deskripsi. Khusus untuk atribut yang saling berpasangan dan ringkas (*Tahun Masuk* dan *Tahun Lulus*), digunakan widget `Row` dengan `Expanded` agar hemat tempat dan tersaji sejajar.
   - **Peran Widget Pengatur Jarak (`SizedBox`):**  
     `SizedBox(height: 16)` dan `SizedBox(width: 12)` memberikan ruang kosong pemisah (*whitespace*) yang terukur antar-field input. Ini mencegah antarmuka terasa padat dan menghindarkan kesalahan sentuh (*mis-click*) pada layar sentuh ponsel.
   - **Peran Widget Penggulir (`SingleChildScrollView`):**  
     Membungkus seluruh form agar halaman dapat digulir secara vertikal. Ketika keyboard virtual muncul atau aplikasi dijalankan pada layar perangkat sempit, tinggi layar yang tersisa akan menyusut drastis. Tanpa `SingleChildScrollView`, Flutter akan memicu error `RenderFlex overflowed`. Dengan widget ini, pengguna tetap dapat menggulir halaman hingga ke tombol "Simpan" paling bawah dengan mulus.

4. **Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

   *Jawab:*  
   - **Peran Ketiga Komponen:**
     - **`GlobalKey<FormState>` (`_formKey`)**: Kunci unik yang memberikan akses langsung ke status internal widget `Form` (`FormState`) dari luar widget tersebut.
     - **`validator`**: Fungsi logika pada masing-masing field (`TextFormField`) yang mengevaluasi apakah nilai teks masukan memenuhi syarat. Fungsi ini mengembalikan pesan kesalahan jika tidak valid, atau `null` jika valid.
     - **`_formKey.currentState!.validate()`**: Dipanggil saat tombol "Simpan" ditekan untuk memicu eksekusi seluruh fungsi `validator` pada form secara serentak. Jika ada minimal satu field tidak valid, form akan menampilkan teks pesan error merah di bawah field terkait dan menghentikan alur penyimpanan data.
   - **Contoh Nilai yang Ditolak:**  
     Pada field **Tahun Masuk**, nilai `"abc"`, `"1850"`, atau `"2500"` akan ditolak oleh validasi dengan pesan `"Tahun tidak valid."`, serta nilai spasi kosong `"   "` akan ditolak dengan pesan `"Wajib diisi."`.
   - **Mengapa Jenis Input / Papan Ketik Saja Belum Cukup:**  
     Mengatur `keyboardType: TextInputType.number` hanya menyodorkan tampilan keypad angka ke pengguna sebagai bantuan kenyamanan input. Pengaturan ini **tidak menjamin keabsahan data** karena:
     1. Pengguna tetap bisa menempelkan teks huruf melalui fitur *paste/clipboard*.
     2. Di perangkat web atau desktop dengan keyboard fisik, pengguna tetap bebas mengetikkan karakter alfanumerik apa pun.
     3. Papan ketik angka tidak dapat membatasi logika rentang nilai logis bisnis (misalnya tahun masuk harus berupa 4 digit antara 1900–2100, atau nilai IPK yang harus berada di antara 0.00 hingga 4.00). Oleh karena itu, validasi logika programatis melalui `validator` mutlak diperlukan.

---

## AI Disclosure

Dalam pengerjaan **Tugas Individu 7 dan Tugas Individu 8**, saya menggunakan AI (Google DeepMind / Gemini) sebagai alat bantu interaktif untuk eksplorasi rancangan arsitektur, refaktorisasi kode, penyusunan alur CI/CD, dan penelusuran galat.

### Rincian Bantuan AI:
1. **Tugas 7 (Dasar Flutter & Arsitektur Modular)**:
   - Membantu pemisahan `lib/menu.dart` dari `lib/main.dart` agar struktur kode modular.
   - Mengusulkan penambahan atribut `Color color` langsung pada kelas model `ItemHomepage` untuk menghindari logika percabangan pewarnaan yang berulang.
   - Membantu penyusunan alur kerja GitHub Actions (`.github/workflows/ci.yml`).

2. **Tugas 8 (Navigation, Form, & Validation)**:
   - Membantu menyusun kerangka awal formulir `EducationFormPage` di `lib/screens/education_form.dart` dengan komponen `GlobalKey<FormState>`, input fields, dan `AlertDialog`.
   - Membantu penambahan opsi routing drawer pada `lib/widgets/left_drawer.dart` dan tombol aksi pada `lib/widgets/project_card.dart`.

### Analisis Keterbatasan AI & Perbaikan Mandiri:
Meskipun AI membantu mempercepat pembuatan kerangka kode awal, terdapat kendala dan keterbatasan teknis yang memerlukan intervensi langsung secara mandiri:
- **Unused Import & Analyzer Warning**: Kode yang dihasilkan sempat menyisakan `import 'package:myportofolio_mobile/screens/education_form.dart';` pada `lib/screens/menu.dart` padahal navigasi ditangani di `lib/widgets/project_card.dart`. Hal ini menyebabkan peringatan saat `flutter analyze`. Saya membersihkan unused import tersebut secara manual hingga analisis statis benar-benar clean (0 issues).
- **Penyesuaian Widget Smoke Test**: Perubahan penambahan kartu "Tambah Edukasi" di halaman utama sempat belum tercermin di `test/widget_test.dart`. Saya memperbarui berkas pengujian agar memverifikasi keberadaan teks `'Tambah Edukasi'` sehingga pipeline pengujian widget lulus tanpa galat.
- **Validasi Logika Bisnis Formulir**: Papan ketik angka bawaan Flutter (`TextInputType.number`) tidak mencegah pengguna mengosongkan input atau menempelkan teks non-angka dari clipboard. Saya memastikan setiap input memiliki logika validator khusus (penolakan spasi kosong, batas minimal/maksimal tahun 1900–2100, dan batasan rentang IPK 0.00–4.00).

---

## License

This project is distributed under the [MIT License](LICENSE).
