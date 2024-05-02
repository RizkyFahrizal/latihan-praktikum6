import 'package:flutter/material.dart'; // Import library untuk membangun UI (Antarmuka Pengguna) - Perintah: flutter pub get
import 'package:http/http.dart'
    as http; // Import library untuk melakukan request HTTP - Perintah: flutter pub get
import 'dart:convert'; // Import library untuk konversi JSON - Perintah: tidak perlu perintah tambahan

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Widget MaterialApp untuk aplikasi Flutter
      home: Scaffold(
        // Widget Scaffold untuk struktur dasar layout aplikasi
        appBar: AppBar(
          // Widget AppBar untuk bagian header aplikasi
          title: Text('University Data'), // Judul aplikasi
        ),
        body: UniversityList(), // Menampilkan widget UniversityList pada body
      ),
    );
  }
}

class UniversityList extends StatefulWidget {
  @override
  _UniversityListState createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  List<dynamic> universities = []; // List untuk menyimpan data universitas

  @override
  void initState() {
    super.initState();
    fetchData(); // Panggil fungsi fetchData saat widget dibuat
  }

  Future<void> fetchData() async {
    // Fungsi untuk mengambil data universitas dari API
    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=Indonesia')); // Kirim request GET ke API

    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(
            response.body); // Update state dengan data yang di-decode dari JSON
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Widget ListView.builder untuk menampilkan list secara efisien
      itemCount:
          universities.length, // Jumlah item sesuai dengan data universitas
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          // Widget ListTile untuk menampilkan item berupa list tile
          title: Text(universities[index]
              ['name']), // Judul list tile (nama universitas)
          subtitle: Text(universities[index]['web_pages']
              [0]), // Subjudul list tile (website universitas)
          onTap: () {
            // Implement your desired action when an item is tapped.
          },
        );
      },
    );
  }
}
