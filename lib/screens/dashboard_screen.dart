import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sistem_monitoring_mobil/widgets/catat_kembali_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.onNavigate});

  final void Function(int index) onNavigate;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _currentDateTime = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeTime() {
    initializeDateFormatting('id_ID', null)
        .then((_) {
          _updateDateTime();
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            _updateDateTime();
          });
        })
        .catchError((e) {
          debugPrint('Error initializing date formatting: $e');
          _updateDateTime();
        });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final date = DateFormat("EEEE, d MMMM yyyy", "id_ID").format(now);
    final time = DateFormat("HH:mm").format(now);
    setState(() {
      _currentDateTime = "$date - $time";
    });
  }

  // HEADER BARU (AppBar 3 Baris + Ikon)
  PreferredSizeWidget _buildHeader() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      toolbarHeight: 90,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(width: 6),
              Text(
                "Monitoring Mobil",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            "YPP Subulul Huda",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            _currentDateTime,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // STAT CARD
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // QUICK ACTION BUTTON
  Widget _buildQuickAction(
    String text,
    Color color,
    IconData icon,
    VoidCallback? onPressed,
  ) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // SEDANG DIGUNAKAN CARD
  Widget _buildUsedCard() {
    bool isUsed = true;

    if (!isUsed) {
      return Container(
        padding: const EdgeInsets.all(16),
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
            Icon(Icons.check_circle_outline, color: Colors.green.shade600),
            const SizedBox(width: 8),
            const Text(
              "Semua Mobil Tersedia Saat Ini",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              const Text(
                "Sedang Digunakan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bu Sari Wulandari",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Keluar: 13:30",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("Belanja kebutuhan kantin sekolah"),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showCatatKembaliPopup(context);
                    },

                    icon: const Icon(Icons.logout, size: 18),
                    label: const Text("Catat Kembali"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HISTORY CARD
  Widget _buildHistoryCard(
    String name,
    String desc,
    String keluar,
    String kembali,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Keluar: $keluar", style: const TextStyle(fontSize: 13)),
              if (kembali.isNotEmpty)
                Text(
                  "Kembali: $kembali",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: _buildHeader(), // <-- HEADER BARU
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildStatCard(
                          "Mobil Tersedia",
                          "1",
                          Icons.directions_car,
                          Colors.green,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          "Sedang Digunakan",
                          "1",
                          Icons.access_time,
                          Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // QUICK ACTION
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Aksi Cepat",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildQuickAction(
                                "Catat Pemakaian",
                                Colors.blue.shade600,
                                Icons.add_circle_outline,
                                () => widget.onNavigate(1),
                              ),
                              const SizedBox(width: 12),
                              _buildQuickAction(
                                "Catat Kembali",
                                Colors.green.shade600,
                                Icons.check_circle_outline,
                                () {
                                  showCatatKembaliPopup(
                                    context,
                                  ); // <-- ini harus sesuai nama fungsi di file dialog
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _buildUsedCard(),

                    const SizedBox(height: 20),

                    // HISTORY
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Riwayat Hari Ini",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => widget.onNavigate(2),
                                child: Text(
                                  "Lihat Semua",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          _buildHistoryCard(
                            "Pak Budi Santoso",
                            "Antar siswa olimpiade matematika",
                            "08:00",
                            "12:00",
                            "Selesai",
                            Colors.green.shade500,
                          ),
                          _buildHistoryCard(
                            "Bu Sari Wulandari",
                            "Belanja kebutuhan kantin sekolah",
                            "13:30",
                            "",
                            "Berlangsung",
                            Colors.orange.shade500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
