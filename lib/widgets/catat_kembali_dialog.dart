import 'package:flutter/material.dart';

class CatatKembaliDialog extends StatefulWidget {
  final String nama;
  final String keperluan;
  final String telp;
  final String jamKeluar;

  const CatatKembaliDialog({
    super.key,
    required this.nama,
    required this.keperluan,
    required this.telp,
    required this.jamKeluar,
  });

  @override
  State<CatatKembaliDialog> createState() => _CatatKembaliDialogState();
}

class _CatatKembaliDialogState extends State<CatatKembaliDialog> {
  TimeOfDay? selectedTime;
  final TextEditingController noteC = TextEditingController();

  String get jamKembaliStr {
    if (selectedTime == null) return "--:--";
    return selectedTime!.format(context);
  }

  Duration get durasi {
    try {
      final keluar = _parseTime(widget.jamKeluar);
      final kembali = selectedTime == null
          ? _parseTime(widget.jamKeluar)
          : _parseTime(selectedTime!.format(context));
      return kembali.difference(keluar);
    } catch (_) {
      return Duration.zero;
    }
  }

  DateTime _parseTime(String t) {
    final parts = t.split(":");
    return DateTime(2025, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }

  String _formatDuration(Duration d) {
    if (d.inMinutes < 1) return "0 menit";
    final jam = d.inHours;
    final menit = d.inMinutes % 60;
    if (jam == 0) return "$menit menit";
    return "$jam jam $menit menit";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Catat Kembali Mobil",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // PEMAKAIAN CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Pemakaian yang Akan Dikembalikan",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Keluar: ${widget.jamKeluar}",
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(widget.keperluan),
                        const SizedBox(height: 6),
                        Text(
                          widget.telp,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // DETAIL PENGEMBALIAN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detail Pengembalian",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),

                  const Text("Jam Kembali"),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (t != null) setState(() => selectedTime = t);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(jamKembaliStr),
                          const Icon(Icons.access_time),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Text("Catatan (Opsional)"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: noteC,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText:
                          "Kondisi kendaraan, kendala yang dialami, dll...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // RINGKASAN
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _summaryRow("Jam Keluar:", widget.jamKeluar),
                        _summaryRow("Jam Kembali:", jamKembaliStr),
                        const SizedBox(height: 6),
                        _summaryRow(
                          "Total Durasi:",
                          _formatDuration(durasi),
                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: kirim data ke Firestore nanti
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Catat Pengembalian",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// Fungsi pemanggil — PASTIKAN NAMANYA persis ini
Future<void> showCatatKembaliPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return CatatKembaliDialog(
        nama: "Bu Sari Wulandari",
        keperluan: "Belanja kebutuhan kantin sekolah",
        telp: "081234567890",
        jamKeluar: "13:30",
      );
    },
  );
}
