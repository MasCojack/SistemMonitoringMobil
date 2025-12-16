import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  String selectedTanggal = 'Hari Ini (15 Jan)';
  String searchQuery = '';

  /// 🔹 Data dummy per tanggal
  final Map<String, List<Map<String, dynamic>>> riwayatPerTanggal = {
    'Hari Ini (15 Jan)': [
      {
        'nama': 'Pak Budi Santoso',
        'telepon': '081234567891',
        'keperluan': 'Antar siswa olimpiade matematika ke venue kompetisi',
        'jamKeluar': '08:00',
        'jamKembali': '12:00',
        'durasi': '4 jam 0 menit',
        'status': 'Selesai',
      },
      {
        'nama': 'Bu Sari Wulandari',
        'telepon': '081234567890',
        'keperluan': 'Belanja kebutuhan kantin sekolah',
        'jamKeluar': '13:30',
        'jamKembali': '-',
        'durasi': '-',
        'status': 'Berlangsung',
      },
    ],
    'Kemarin (14 Jan)': [
      {
        'nama': 'Pak Rahmat Hadi',
        'telepon': '081222333444',
        'keperluan': 'Mengantar tamu pondok ke terminal',
        'jamKeluar': '09:00',
        'jamKembali': '10:30',
        'durasi': '1 jam 30 menit',
        'status': 'Selesai',
      },
    ],
    '13 Jan': [
      {
        'nama': 'Bu Dina Kartika',
        'telepon': '081555666777',
        'keperluan': 'Menjemput perlengkapan lomba dari percetakan',
        'jamKeluar': '10:00',
        'jamKembali': '-',
        'durasi': '-',
        'status': 'Berlangsung',
      },
      {
        'nama': 'Pak Agus Setiawan',
        'telepon': '081888999000',
        'keperluan': 'Perjalanan ke dinas pendidikan kabupaten',
        'jamKeluar': '07:30',
        'jamKembali': '11:00',
        'durasi': '3 jam 30 menit',
        'status': 'Selesai',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 🔹 Ambil data berdasarkan tanggal yang dipilih
    final selectedList = selectedTanggal == 'Semua'
        ? riwayatPerTanggal.values.expand((list) => list).toList()
        : (riwayatPerTanggal[selectedTanggal] ?? []);

    // 🔹 Filter pencarian
    final filteredList = selectedList.where((item) {
      final query = searchQuery.toLowerCase();
      return item['nama'].toLowerCase().contains(query) ||
          item['keperluan'].toLowerCase().contains(query);
    }).toList();

    final total = selectedList.length;
    final selesai = selectedList.where((e) => e['status'] == 'Selesai').length;
    final berlangsung = selectedList
        .where((e) => e['status'] == 'Berlangsung')
        .length;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Pemakaian',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Dropdown & Search dalam Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Tanggal',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTanggal,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'Hari Ini (15 Jan)',
                            child: Text('Hari Ini (15 Jan)'),
                          ),
                          DropdownMenuItem(
                            value: 'Kemarin (14 Jan)',
                            child: Text('Kemarin (14 Jan)'),
                          ),
                          DropdownMenuItem(
                            value: '13 Jan',
                            child: Text('13 Jan'),
                          ),
                          DropdownMenuItem(
                            value: 'Semua',
                            child: Text('Semua'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedTanggal = value!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cari Pengemudi atau Keperluan',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Ketik nama atau keperluan...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Jika tidak ada data
            if (filteredList.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tidak Ada Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tidak ditemukan hasil pencarian',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            else
              // 🔹 Semua riwayat dalam 1 card besar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: filteredList.map((item) {
                    final isSelesai = item['status'] == 'Selesai';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['nama'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelesai
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item['status'],
                                style: TextStyle(
                                  color: isSelesai
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['telepon'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['keperluan'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoColumn('Jam Keluar', item['jamKeluar']),
                              _buildInfoColumn(
                                'Jam Kembali',
                                item['jamKembali'],
                              ),
                              _buildInfoColumn(
                                'Durasi Pemakaian',
                                item['durasi'],
                              ),
                            ],
                          ),
                        ),
                        if (item != filteredList.last)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 20),

            // 🔹 Ringkasan bawah (tampilkan hanya jika ada data)
            if (filteredList.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRingkasanItem(
                          'Total Pemakaian',
                          total,
                          Colors.blue,
                        ),
                        _buildRingkasanItem('Selesai', selesai, Colors.green),
                        _buildRingkasanItem(
                          'Berlangsung',
                          berlangsung,
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value),
      ],
    );
  }

  Widget _buildRingkasanItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
