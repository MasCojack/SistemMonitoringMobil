import 'package:flutter/material.dart';

class UsageDetailScreen extends StatefulWidget {
  final String nama;
  final String alasan;
  final String jamKeluar;
  final String kontak;

  const UsageDetailScreen({
    super.key,
    required this.nama,
    required this.alasan,
    required this.jamKeluar,
    required this.kontak,
  });

  @override
  State<UsageDetailScreen> createState() => _UsageDetailScreenState();
}

class _UsageDetailScreenState extends State<UsageDetailScreen> {
  final TextEditingController jamKembaliController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catat Kembali Mobil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detail Penggunaan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.alasan),
                  const SizedBox(height: 4),
                  Text(widget.kontak),
                  const SizedBox(height: 4),
                  Text(
                    "Keluar: ${widget.jamKeluar}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Form Edit (Pengembalian)
            const Text(
              "Detail Pengembalian",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: jamKembaliController,
              decoration: const InputDecoration(
                labelText: "Jam Kembali",
                hintText: "--:--",
                suffixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  jamKembaliController.text =
                      "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                }
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: catatanController,
              maxLines: 3,
              maxLength: 500,
              decoration: const InputDecoration(
                labelText: "Catatan (Opsional)",
                hintText: "Kondisi kendaraan, kendala yang dialami, dll...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: simpan ke database / API update
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pengembalian berhasil dicatat!"),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Catat Pengembalian",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
