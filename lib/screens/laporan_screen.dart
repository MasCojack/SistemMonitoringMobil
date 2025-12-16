import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  bool isMingguan = true;

  final List<Map<String, dynamic>> pengemudi = [
    {"nama": "Pak Budi Santoso", "trip": 8, "jam": "24 jam"},
    {"nama": "Bu Sari Wulandari", "trip": 6, "jam": "18 jam"},
    {"nama": "Pak Ahmad Rizki", "trip": 5, "jam": "15 jam"},
    {"nama": "Bu Lestari", "trip": 4, "jam": "12 jam"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Laporan & Statistik',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Toggle Mingguan/Bulanan
            _buildShadowContainer(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => isMingguan = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMingguan
                            ? Colors.blue
                            : Colors.grey.shade200,
                        foregroundColor: isMingguan
                            ? Colors.white
                            : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Mingguan"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => isMingguan = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isMingguan
                            ? Colors.blue
                            : Colors.grey.shade200,
                        foregroundColor: !isMingguan
                            ? Colors.white
                            : Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Bulanan"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Total Trip dan Jam Operasi
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.directions_car,
                    "67",
                    "Total Trip Bulan Ini",
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.access_time,
                    "158",
                    "Total Jam Operasi",
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Grafik Pemakaian
            _buildChartSection(),

            const SizedBox(height: 20),

            // 🔹 Distribusi Keperluan (Pie Chart)
            _buildPieChartSection(),

            const SizedBox(height: 20),

            // 🔹 Pengemudi Teraktif
            _buildPengemudiTeraktif(),

            const SizedBox(height: 20),

            // 🔹 Export
            _buildExportSection(),
          ],
        ),
      ),
    );
  }

  // 🔹 Wrapper Container dengan shadow lembut
  Widget _buildShadowContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return _buildShadowContainer(
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    final isWeekly = isMingguan;
    final data = isWeekly
        ? [3.0, 5.0, 2.0, 4.0, 6.0, 1.0, 0.0]
        : [4.0, 5.5, 3.5, 6.0];
    final labels = isWeekly
        ? ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min']
        : ['Minggu 1', 'Minggu 2', 'Minggu 3', 'Minggu 4'];

    return _buildShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isWeekly ? "Pemakaian Mingguan" : "Pemakaian Bulanan",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < labels.length) {
                          return Text(
                            labels[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: List.generate(
                  data.length,
                  (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: data[i],
                        color: Colors.blue,
                        width: 18,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ),
              swapAnimationDuration: const Duration(milliseconds: 800),
              swapAnimationCurve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartSection() {
    final data = [
      {"label": "Kegiatan Sekolah", "value": 35.0, "color": Colors.blue},
      {"label": "Belanja Kebutuhan", "value": 25.0, "color": Colors.green},
      {"label": "Jemput Tamu", "value": 20.0, "color": Colors.orange},
      {"label": "Administrasi", "value": 15.0, "color": Colors.red},
      {"label": "Lainnya", "value": 5.0, "color": Colors.purple},
    ];

    return _buildShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Distribusi Keperluan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sections: data
                    .map(
                      (e) => PieChartSectionData(
                        color: e["color"] as Color,
                        value: (e["value"] as num).toDouble(),
                        title: '',
                        radius: 55,
                      ),
                    )
                    .toList(),
                centerSpaceRadius: 30,
                sectionsSpace: 2,
              ),
              swapAnimationDuration: const Duration(milliseconds: 900),
              swapAnimationCurve: Curves.easeOutCubic,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: e["color"] as Color,
                        ),
                        const SizedBox(width: 8),
                        Text("${e["label"]} - ${e["value"]}%"),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPengemudiTeraktif() {
    return _buildShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pengemudi Teraktif",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(pengemudi.length, (i) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    "${i + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                title: Text(pengemudi[i]["nama"]),
                subtitle: Text(pengemudi[i]["jam"]),
                trailing: Text(
                  "${pengemudi[i]["trip"]} trip",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
    return _buildShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Export Laporan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.table_chart, color: Colors.green),
                  label: const Text("Export Excel"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  label: const Text("Export PDF"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
