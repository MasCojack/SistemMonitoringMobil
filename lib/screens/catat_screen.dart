import 'package:flutter/material.dart';

class CatatScreen extends StatefulWidget {
  const CatatScreen({super.key});

  @override
  State<CatatScreen> createState() => _CatatScreenState();
}

class _CatatScreenState extends State<CatatScreen> {
  final _formKey = GlobalKey<FormState>();

  String? namaPengemudi;
  String? noTelepon;
  String? keperluan;
  String? jamKeluar;
  String? estimasiKembali;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          "Catat Pemakaian Mobil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card mobil
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Icon(
                      Icons.directions_car,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Mobil Operasional",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tersedia - B 1234 ABC",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Pengemudi
                    const Text("Nama Pengemudi"),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Masukkan nama lengkap",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onSaved: (val) => namaPengemudi = val,
                    ),
                    const SizedBox(height: 16),

                    // No Telepon
                    const Text("No. Telepon"),
                    const SizedBox(height: 6),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "08xx xxxx xxxx",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onSaved: (val) => noTelepon = val,
                    ),
                    const SizedBox(height: 16),

                    // Keperluan
                    const Text("Keperluan"),
                    const SizedBox(height: 6),
                    TextFormField(
                      maxLines: 3,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: "Jelaskan keperluan penggunaan mobil...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onSaved: (val) => keperluan = val,
                    ),
                    const SizedBox(height: 16),

                    // Jam Keluar & Estimasi Kembali
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Jam Keluar"),
                              const SizedBox(height: 6),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "--:--",
                                  suffixIcon: const Icon(Icons.access_time),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Estimasi Kembali"),
                              const SizedBox(height: 6),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "--:--",
                                  suffixIcon: const Icon(Icons.access_time),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Tombol Catat
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Catat Pemakaian",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
