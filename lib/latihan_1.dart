import 'dart:convert'; // Impor library 'dart:convert' untuk operasi JSON

void main() {
  // Definisikan string JSON awal yang mewakili data satu mahasiswa
  String jsonString = '''
    {
      "nama": "Muhammad Rizky Fahrizal",
      "npm": 22082010041,
      "prodi": "Sistem Informasi",
      "list_ip": ["3.82", "3.75", "3.89"]
    }
  ''';

  // Konversi string JSON ke Map menggunakan jsonDecode
  Map<String, dynamic> mhsJson =
      jsonDecode(jsonString); // Perintah: dart analyze

  // Buat list of Map<String, dynamic> untuk representasi mahasiswa baru
  List<Map<String, dynamic>> mahasiswaBaru = [
    {
      "nama": "Budi Raharjo",
      "npm": 22082010042,
      "prodi": "Informatika",
      "list_ip": ["3.95", "3.80", "3.91"]
    },
    {
      "nama": "Citra Dewi",
      "npm": 22082010043,
      "prodi": "Sains Data",
      "list_ip": ["3.38", "3.55", "3.82"]
    },
    {
      "nama": "Dimas Satrio",
      "npm": 22082010044,
      "prodi": "Sistem Informasi",
      "list_ip": ["3.79", "3.92", "3.65"]
    }
  ];

  // Tambahkan mahasiswa baru ke array 'mahasiswa' di map mhsJson
  mhsJson['mahasiswa'] = [mhsJson] + mahasiswaBaru; // Perintah: dart analyze

  // Iterasi melalui setiap mahasiswa di array 'mahasiswa'
  for (Map<String, dynamic> mahasiswa in mhsJson['mahasiswa']) {
    print("======================="); // Cetak pembatas untuk setiap mahasiswa

    // Cetak nama, NPM, dan program mahasiswa
    print("Nama: ${mahasiswa['nama']}");
    print("NPM: ${mahasiswa['npm']}");
    print("Prodi: ${mahasiswa['prodi']}");

    // Inisialisasi variabel counter untuk indeks semester
    int no = 1;

    // Iterasi melalui list IP mahasiswa
    for (String ipString in mahasiswa['list_ip']) {
      print("IP Semester $no = $ipString"); // Cetak IP untuk setiap semester
      no++; // Inkrementasi counter semester
    }

    // Hitung dan cetak IPK mahasiswa
    double totalIPK = 0;
    for (String ipString in mahasiswa['list_ip']) {
      double ip = double.parse(ipString);
      totalIPK += ip;
    }
    double ipk = totalIPK / mahasiswa['list_ip'].length;
    String roundedIpk = ipk.toStringAsFixed(2);

    print("IPK: $roundedIpk");
    print("======================="); // Cetak pembatas untuk setiap mahasiswa
  }
}
