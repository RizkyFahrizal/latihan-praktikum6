// Impor library yang diperlukan untuk membangun antarmuka pengguna (Flutter) dan melakukan permintaan HTTP (http)
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Impor library untuk konversi JSON

void main() {
  // Jalankan aplikasi menggunakan class MyApp
  runApp(const MyApp()); // Perintah: flutter run
}

// Definisikan class bernama Activity untuk mewakili data aktivitas
class Activity {
  String aktivitas; // Variabel String untuk menyimpan nama aktivitas
  String jenis; // Variabel String untuk menyimpan tipe aktivitas

  // Konstruktor untuk menginisialisasi objek Activity dengan parameter yang diperlukan
  Activity({required this.aktivitas, required this.jenis});

  // Konstruktor factory untuk membuat objek Activity dari map JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      aktivitas: json[
          'activity'], // Petakan key 'activity' di JSON ke properti 'aktivitas'
      jenis: json['type'], // Petakan key 'type' di JSON ke properti 'jenis'
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // Deklarasikan variabel Future untuk menyimpan data aktivitas yang diambil (awalnya null)
  late Future<Activity> futureActivity;

  // Definisikan URL titik akhir API untuk mengambil saran aktivitas
  String url = "https://www.boredapi.com/api/activity";

  // Fungsi untuk menginisialisasi objek Activity kosong (digunakan untuk keadaan awal)
  Future<Activity> init() async {
    return Activity(aktivitas: "", jenis: "");
  }

  // Fungsi untuk mengambil data aktivitas dari API
  Future<Activity> fetchData() async {
    // Lakukan permintaan GET HTTP ke URL yang ditentukan
    final response = await http.get(Uri.parse(url));

    // Periksa apakah kode status respons adalah 200 (OK)
    if (response.statusCode == 200) {
      // Parsing body respon JSON
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      // Throw exception jika respons tidak berhasil
      throw Exception('Gagal load'); // Pesan exception dalam Bahasa Indonesia
    }
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi futureActivity dengan objek Activity kosong saat aplikasi dimulai
    futureActivity = init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Widget aplikasi utama (MaterialApp)
        home: Scaffold(
      // Scaffold adalah layout dasar dari MaterialApp
      body: Center(
        // Widget Center untuk memusatkan konten secara vertikal
        child: Column(
            // Widget Column untuk mengatur widget anak secara vertikal
            mainAxisAlignment:
                MainAxisAlignment.center, // Pusatkan konten kolom
            children: [
              Padding(
                // Widget Padding untuk menambahkan ruang di sekitar tombol
                padding: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  // ElevatedButton untuk tombol timbul dengan bayangan
                  onPressed: () {
                    // Setel state untuk memicu rebuild dan mengambil kembali data aktivitas
                    setState(() {
                      futureActivity = fetchData();
                    });
                  },
                  child: Text("Saya bosan ..."), // Teks tombol
                ),
              ),
              FutureBuilder<Activity>(
                // Widget FutureBuilder untuk menangani pengambilan data asinkron
                future: futureActivity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Jika data tersedia, tampilkan aktivitas
                    return Center(
                        child: Column(
                            // Column untuk menampilkan aktivitas dan jenis
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(snapshot
                              .data!.aktivitas), // Tampilkan nama aktivitas
                          Text(
                              "Jenis: ${snapshot.data!.jenis}"), // Tampilkan jenis aktivitas
                        ]));
                  } else if (snapshot.hasError) {
                    // Jika ada kesalahan, tampilkan pesan kesalahan
                    return Text('${snapshot.error}');
                  }
                  // Tampilkan indikator progres saat data sedang diambil
                  return const CircularProgressIndicator();
                },
              ),
            ]),
      ),
    ));
  }
}
