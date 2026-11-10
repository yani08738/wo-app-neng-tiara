import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('wo_neng_tiara_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neng Tiara Dekorasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B3B6F),
          primary: const Color(0xFF1B3B6F),
        ),
        useMaterial3: true,
      ),
      home: const WOStepByStepApp(),
    );
  }
}

class WOStepByStepApp extends StatefulWidget {
  const WOStepByStepApp({super.key});

  @override
  State<WOStepByStepApp> createState() => _WOStepByStepAppState();
}

class _WOStepByStepAppState extends State<WOStepByStepApp> {
  // 0: Welcome, 1: Baju, 2: Dekor, 3: Input Jadwal, 4: Final Catatan
  int _halamanAktif = 0;

  final TextEditingController _pengantinCtrl = TextEditingController();
  DateTime _tglAcara = DateTime.now();
  String _selectedPJ = 'Tim A (Budi)';
  final List<String> _listPJ = ['Tim A (Budi)', 'Tim B (Andi)'];

  // Master Inventaris: 16 Baju Pengantin + 18 Set Dekorasi
  final List<Map<String, dynamic>> _inventaris = [
    // --- 16 KOLEKSI BAJU PENGANTIN ASLI ---
    {
      'id': 'BJ-01',
      'nama': 'Gaun Magenta Fuchsia Princess',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown mewah warna fuchsia/pink fanta dengan hijab & mahkota tiara anggun.',
      'img': 'assets/baju/baju_1.jpg',
    },
    {
      'id': 'BJ-02',
      'nama': 'Gaun Kebaya Baby Blue Siger',
      'kategori': 'Baju',
      'deskripsi': 'Gaun brokat biru muda elegan dengan mahkota siger bunga melati pengantin nusantara.',
      'img': 'assets/baju/baju_2.jpg',
    },
    {
      'id': 'BJ-03',
      'nama': 'Gaun Ballgown Ice Blue Tiara',
      'kategori': 'Baju',
      'deskripsi': 'Gaun pesta ballgown warna ice blue bertabur gliter mutiara dengan tiara klasik.',
      'img': 'assets/baju/baju_3.jpg',
    },
    {
      'id': 'BJ-04',
      'nama': 'Gaun Peacock Blue Muslimah',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown megah warna peacock teal muslimah berhijab payet mewah & mahkota permata.',
      'img': 'assets/baju/baju_4.jpg',
    },
    {
      'id': 'BJ-05',
      'nama': 'Gaun Hitam Emas Glamour',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown mewah warna hitam kombinasi bordir ranting emas kerajaan lengkap hijab mahkota.',
      'img': 'assets/baju/baju_5.jpg',
    },
    {
      'id': 'BJ-06',
      'nama': 'Set Couple Gaun Dusty Pink & Jas Soft Pink',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown mekar dusty pink penuh kilau gliter tiara dipadukan setelan jas soft pink senada.',
      'img': 'assets/baju/baju_6.jpg',
    },
    {
      'id': 'BJ-07',
      'nama': 'Gaun Akad Pure White Castle Princess',
      'kategori': 'Baju',
      'deskripsi': 'Gaun pengantin putih suci mekar gaya istana megah lengkap hijab bordir mutiara & tiara.',
      'img': 'assets/baju/baju_7.jpg',
    },
    {
      'id': 'BJ-08',
      'nama': 'Set Couple Gaun Ungu Plum & Jas Lavender',
      'kategori': 'Baju',
      'deskripsi': 'Gaun mewah gradasi ungu plum bertabur manik gliter lengan lonceng anggun dan jas lavender pria.',
      'img': 'assets/baju/baju_8.jpg',
    },
    {
      'id': 'BJ-09',
      'nama': 'Set Couple Gaun Rose Gold & Jas Pastel',
      'kategori': 'Baju',
      'deskripsi': 'Gaun pesta slim fit rose gold payet dipadukan jas pria pink pastel sangat cocok outdoor/resepsi.',
      'img': 'assets/baju/baju_9.jpg',
    },
    {
      'id': 'BJ-10',
      'nama': 'Set Couple Gaun Sky Blue & Jas Biru',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown biru periwinkle bertabur sequin kilau mewah dengan mahkota ratu dan jas pria senada.',
      'img': 'assets/baju/baju_10.jpg',
    },
    {
      'id': 'BJ-11',
      'nama': 'Set Kebaya Adat Sunda Siger & Beskap Putih',
      'kategori': 'Baju',
      'deskripsi': 'Kebaya brokat putih suci lengkap mahkota siger & ronce melati dipadukan beskap putih pria.',
      'img': 'assets/baju/baju_11.jpg',
    },
    {
      'id': 'BJ-12',
      'nama': 'Gaun Ruffle Ballgown Deep Purple Tiara',
      'kategori': 'Baju',
      'deskripsi': 'Gaun bertingkat ruffles warna deep purple anggun mewah dengan taburan manik berkilau & tiara.',
      'img': 'assets/baju/baju_12.jpg',
    },
    {
      'id': 'BJ-13',
      'nama': 'Gaun Ballgown Red Ruby Royal Glitter',
      'kategori': 'Baju',
      'deskripsi': 'Gaun pengantin merah ruby menyala penuh motif glitter kristal mewah dengan hijab & mahkota ratu.',
      'img': 'assets/baju/baju_13.jpg',
    },
    {
      'id': 'BJ-14',
      'nama': 'Gaun Pesta Emerald Green Glamour Tiara',
      'kategori': 'Baju',
      'deskripsi': 'Gaun pesta hijau emerald kilau payet permata lengkap ronce bunga mawar dan mahkota tiara.',
      'img': 'assets/baju/baju_14.jpg',
    },
    {
      'id': 'BJ-15',
      'nama': 'Gaun Ballgown Midnight Navy Starry Sky',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown megah warna navy bertabur kilau bintang malam dengan kerah off-shoulder permata & veil.',
      'img': 'assets/baju/baju_15.jpg',
    },
    {
      'id': 'BJ-16',
      'nama': 'Gaun Ballgown Choco Bronze Crystal Tiara',
      'kategori': 'Baju',
      'deskripsi': 'Gaun ballgown mewah warna cokelat bronze berpayet kristal berkilau lengkap hijab, veil & tiara.',
      'img': 'assets/baju/baju_16.jpg',
    },

    // --- 18 SET DEKORASI ASLI NENG TIARA DEKORASI ---
    {
      'id': 'DK-01',
      'nama': 'Pelaminan Modern Butterfly & Mirror Floor',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan megah lampu neon kupu-kupu kristal, backdrop sayap putih, panggung kaca & sofa kerang mewah.',
      'img': 'assets/dekor/dekor_1.jpg',
    },
    {
      'id': 'DK-02',
      'nama': 'Pelaminan Cinderella Castle Pastel Blue',
      'kategori': 'Dekorasi',
      'deskripsi': 'Dekorasi panggung istana kastil cinderella serba biru pastel & putih bunga hydrangea lengkap karpet kaca.',
      'img': 'assets/dekor/dekor_2.jpg',
    },
    {
      'id': 'DK-03',
      'nama': 'Paket Lengkap Royal Blue Gold 12 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan motif laser maroko mewah berlampu warm gold, panggung kaca bunga & set sofa pengantin.',
      'img': 'assets/dekor/dekor_3.jpg',
    },
    {
      'id': 'DK-04',
      'nama': 'Paket Lengkap Grand Chandelier 8m 9,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan grand 8 meter chandelier kristal gantung, tirai rumbai, gate lengkung bunga & lantai cermin.',
      'img': 'assets/dekor/dekor_4.jpg',
    },
    {
      'id': 'DK-05',
      'nama': 'Paket Lengkap Red Rose 6m 10 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan romantis 6 meter gapura mawar merah-putih lebat, ambient neon ungu, sofa kerang & lantai gold.',
      'img': 'assets/dekor/dekor_5.jpg',
    },
    {
      'id': 'DK-06',
      'nama': 'Paket Lengkap Plafon Gelombang 12,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan megah dengan plafon tenda gelombang kain, lampu kristal, panggung kaca bunga & sofa ganda.',
      'img': 'assets/dekor/dekor_6.jpg',
    },
    {
      'id': 'DK-07',
      'nama': 'Paket Lengkap Lilac Arch Modern 12,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan bernuansa lilac & putih dengan gapura bunga lengkung, ambient neon warm yellow & panggung kaca.',
      'img': 'assets/dekor/dekor_7.jpg',
    },
    {
      'id': 'DK-08',
      'nama': 'Paket Lengkap Sayap Kupu-Kupu Emas 9 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Backdrop pelaminan sayap kupu-kupu emas raksasa bercahaya, sofa putih elegan & standing flowers.',
      'img': 'assets/dekor/dekor_8.jpg',
    },
    {
      'id': 'DK-09',
      'nama': 'Paket Hemat Pelaminan Minimalis Neon 7,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan minimalis modern panel lengkung backlight neon warm gold, gapura mawar maroon & sofa kancing.',
      'img': 'assets/dekor/dekor_9.jpg',
    },
    {
      'id': 'DK-10',
      'nama': 'Paket Lengkap Blue Cloud 6m 10,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan 6 meter tema awan lengkung neon biru, bunga hydrangea biru-putih & jalan karpet kaca kristal.',
      'img': 'assets/dekor/dekor_10.jpg',
    },
    {
      'id': 'DK-11',
      'nama': 'Paket Simpel Elegan Butterfly Wings 7,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan sayap kupu-kupu lampu neon berlatar biru, gapura bunga custom & sofa klasik putih.',
      'img': 'assets/dekor/dekor_11.jpg',
    },
    {
      'id': 'DK-12',
      'nama': 'Paket Lengkap Plafon Flora & Cloud 12,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Plafon lingkaran flora hijau megah, backdrop awan berlampu biru, panggung kaca bunga & sofa ganda.',
      'img': 'assets/dekor/dekor_12.jpg',
    },
    {
      'id': 'DK-13',
      'nama': 'Paket Hemat Gold Leaves Filigree 7,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan ukir putih sayap daun emas elegan, rangkaian bunga warna-warni & sofa royal white.',
      'img': 'assets/dekor/dekor_13.jpg',
    },
    {
      'id': 'DK-14',
      'nama': 'Pelaminan Grand Fairytale Castle Sampang',
      'kategori': 'Dekorasi',
      'deskripsi': 'Tema istana megah kastil emas kerajaan, lampu kristal gantung dan jalan karpet bunga pengantin.',
      'img': 'assets/dekor/dekor_14.jpg',
    },
    {
      'id': 'DK-15',
      'nama': 'Pelaminan Luxury Curve Wave & Chandelier',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan terowongan kurva gelombang modern, chandelier kristal gantung, standing lamp & panggung bunga.',
      'img': 'assets/dekor/dekor_15.jpg',
    },
    {
      'id': 'DK-16',
      'nama': 'Paket Lengkap White Floral & Golden Palm 7,5 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan ukir putih megah kombinasi daun palem emas, taman bunga rimbun & kursi maharani.',
      'img': 'assets/dekor/dekor_16.jpg',
    },
    {
      'id': 'DK-17',
      'nama': 'Paket Pernikahan Minimalis White Floral Wall 7 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Dinding bunga putih elegan modern, ronce bunga gantung melengkung, sofa kerang & set meja jamuan.',
      'img': 'assets/dekor/dekor_17.jpg',
    },
    {
      'id': 'DK-18',
      'nama': 'Paket Lengkap Grand Luxury Curve 10m 12 Juta',
      'kategori': 'Dekorasi',
      'deskripsi': 'Pelaminan megah panjang 10 meter lengkungan neon hangat, ring bunga melingkar, chandelier & sofa royal.',
      'img': 'assets/dekor/dekor_18.jpg',
    },
  ];

  final Set<String> _selectedBarang = {};
  List<Map<String, dynamic>> _jadwalBooking = [];

  late final Box _woBox;

  @override
  void initState() {
    super.initState();
    _woBox = Hive.box('wo_neng_tiara_box');
    _loadAllFromHive();

    // Auto-save nama pengantin langsung ke database Hive saat diketik
    _pengantinCtrl.addListener(() {
      _woBox.put('draft_pengantin', _pengantinCtrl.text);
    });
  }

  @override
  void dispose() {
    _pengantinCtrl.dispose();
    super.dispose();
  }

  // Membaca seluruh data (Pilihan Menu & Riwayat Jadwal) dari database Hive
  void _loadAllFromHive() {
    try {
      // 1. Muat pilihan menu / draft yang belum tersimpan
      var rawSelected = _woBox.get('selected_barang');
      if (rawSelected != null) {
        _selectedBarang.clear();
        for (var item in (rawSelected as List)) {
          _selectedBarang.add(item.toString());
        }
      }

      var draftPengantin = _woBox.get('draft_pengantin');
      if (draftPengantin != null) {
        _pengantinCtrl.text = draftPengantin.toString();
      }

      var draftTgl = _woBox.get('draft_tgl');
      if (draftTgl != null) {
        _tglAcara = DateTime.tryParse(draftTgl.toString()) ?? DateTime.now();
      }

      var draftPJ = _woBox.get('draft_pj');
      if (draftPJ != null && _listPJ.contains(draftPJ.toString())) {
        _selectedPJ = draftPJ.toString();
      }

      // 2. Muat riwayat jadwal booking yang sudah disimpan
      var rawJadwal = _woBox.get('jadwal_booking');
      if (rawJadwal != null) {
        _jadwalBooking = (rawJadwal as List)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }

      setState(() {});
    } catch (e) {
      debugPrint('Error load dari Hive: $e');
    }
  }

  // Menyimpan draft pilihan barang/tanggal/PJ ke Hive
  void _saveDraftToHive() {
    try {
      _woBox.put('selected_barang', _selectedBarang.toList());
      _woBox.put('draft_pengantin', _pengantinCtrl.text);
      _woBox.put('draft_tgl', _formatDate(_tglAcara));
      _woBox.put('draft_pj', _selectedPJ);
    } catch (e) {
      debugPrint('Error simpan draft ke Hive: $e');
    }
  }

  // Menyimpan jadwal booking permanen ke database Hive
  void _saveJadwalToHive() {
    try {
      _woBox.put('jadwal_booking', _jadwalBooking);
    } catch (e) {
      debugPrint('Error simpan jadwal ke Hive: $e');
    }
  }

  String _formatDate(DateTime d) =>
      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  // Widget Pembantu untuk menampilkan Gambar (Asset lokal maupun URL Network)
  Widget _buildItemImage(String imgPath, {double? height, double? width, BoxFit fit = BoxFit.contain}) {
    if (imgPath.startsWith('http://') || imgPath.startsWith('https://')) {
      return Image.network(
        imgPath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (ctx, err, st) => _imagePlaceholder(imgPath, height, width),
      );
    } else {
      return Image.asset(
        imgPath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (ctx, err, st) => _imagePlaceholder(imgPath, height, width),
      );
    }
  }

  Widget _imagePlaceholder(String path, double? height, double? width) {
    String fileName = path.split('/').last;
    return Container(
      height: height,
      width: width,
      color: const Color(0xFFF0F5FA),
      padding: const EdgeInsets.all(6),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checkroom, size: (height != null && height < 60) ? 18 : 36, color: const Color(0xFF1B3B6F)),
            if (height == null || height >= 60) ...[
              const SizedBox(height: 4),
              Text(
                fileName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                'Pasang foto di folder assets',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // Aturan Rule R-02 & R-03 (Laundry H+1 khusus Baju)
  Map<String, dynamic> _cekStatusBarang(Map<String, dynamic> item) {
    String tglPilih = _formatDate(_tglAcara);
    String tglBesok = _formatDate(_tglAcara.add(const Duration(days: 1)));

    for (var b in _jadwalBooking) {
      if (b['status'] == 'Selesai') continue;
      List barangDipakai = b['barang'];
      if (barangDipakai.contains(item['id'])) {
        // Cek hari H acara yang sama
        if (b['tgl_acara'] == tglPilih) {
          return {'tersedia': false, 'label': 'Terpakai Hari H (R-02)'};
        }
        // Khusus Baju: Cek buffer laundry H+1
        if (item['kategori'] == 'Baju') {
          if (b['tgl_buffer'] == tglPilih) {
            return {'tersedia': false, 'label': 'Laundry H+1 (R-03)'};
          }
          if (b['tgl_acara'] == tglBesok) {
            return {'tersedia': false, 'label': 'Bentrok Jadwal Besok'};
          }
        }
      }
    }
    return {'tersedia': true, 'label': 'Tersedia'};
  }

  void _showMsg(String msg, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: warna, duration: const Duration(seconds: 3)),
    );
  }

  void _simpanJadwal() {
    String nama = _pengantinCtrl.text.trim();
    String tglPilih = _formatDate(_tglAcara);
    String tglBuffer = _formatDate(_tglAcara.add(const Duration(days: 1)));

    if (nama.isEmpty) {
      _showMsg('Harap isi Nama Pengantin & Lokasi Acara!', Colors.orange);
      return;
    }

    if (_selectedBarang.isEmpty) {
      _showMsg('Pilih minimal 1 Baju atau Dekorasi!', Colors.orange);
      return;
    }

    // Rule R-01: Validasi Konflik Tim PJ
    bool konflikPJ = _jadwalBooking.any((b) =>
        b['status'] != 'Selesai' &&
        b['tgl_acara'] == tglPilih &&
        b['pj'] == _selectedPJ);

    if (konflikPJ) {
      _showMsg('DITOLAK (Rule R-01): $_selectedPJ sudah bertugas di tanggal $tglPilih!', Colors.red);
      return;
    }

    // Validasi Ketersediaan Semua Barang Terpilih
    for (var idBarang in _selectedBarang) {
      var barang = _inventaris.firstWhere((e) => e['id'] == idBarang);
      var status = _cekStatusBarang(barang);
      if (status['tersedia'] == false) {
        _showMsg('DITOLAK: ${barang['nama']} sedang ${status['label']} pada tanggal $tglPilih!', Colors.red);
        return;
      }
    }

    setState(() {
      _jadwalBooking.insert(0, {
        'pengantin': nama,
        'tgl_acara': tglPilih,
        'tgl_buffer': tglBuffer,
        'pj': _selectedPJ,
        'barang': _selectedBarang.toList(),
        'status': 'Aktif / Terkunci',
      });
      _pengantinCtrl.clear();
      _selectedBarang.clear();
      _halamanAktif = 4; // Beralih ke Halaman Catatan Final
    });

    _saveDraftToHive(); // Bersihkan draft pilihan di Hive karena sudah disimpan
    _saveJadwalToHive(); // Simpan riwayat booking permanen ke database Hive
    _showMsg('Jadwal berhasil disimpan permanen! Baju otomatis Laundry hingga $tglBuffer (R-03).', Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _halamanAktif == 0
          ? null
          : AppBar(
              title: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('💍 Neng Tiara Dekorasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              backgroundColor: const Color(0xFF1B3B6F),
              foregroundColor: Colors.white,
              elevation: 2,
              actions: [
                TextButton.icon(
                  onPressed: () => setState(() => _halamanAktif = 4),
                  icon: const Icon(Icons.receipt_long, color: Colors.white, size: 18),
                  label: Text('Catatan (${_jadwalBooking.length})', style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
      body: _buildHalaman(),
      bottomNavigationBar: _halamanAktif == 0
          ? null
          : NavigationBar(
              selectedIndex: _halamanAktif - 1,
              onDestinationSelected: (idx) => setState(() => _halamanAktif = idx + 1),
              indicatorColor: const Color(0xFFD6E4F0),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.checkroom), label: '1. Baju'),
                NavigationDestination(icon: Icon(Icons.deck), label: '2. Dekor'),
                NavigationDestination(icon: Icon(Icons.edit_calendar), label: '3. Jadwal'),
                NavigationDestination(icon: Icon(Icons.fact_check), label: '4. Catatan'),
              ],
            ),
    );
  }

  Widget _buildHalaman() {
    switch (_halamanAktif) {
      case 0:
        return _halamanWelcome();
      case 1:
        return _halamanKatalog('Baju', 'Katalog Baju Pengantin', 'Pilih dari 16 koleksi gaun & baju pengantin:', 2);
      case 2:
        return _halamanKatalog('Dekorasi', 'Katalog Set Dekorasi Pelaminan', 'Pilih set pelaminan mewah Neng Tiara Dekorasi:', 3);
      case 3:
        return _halamanInputJadwal();
      case 4:
        return _halamanFinalCatatan();
      default:
        return _halamanWelcome();
    }
  }

  // HALAMAN 0: WELCOME SCREEN (TEMA BIRU ELEGAN & INFORMASI KARTU NAMA)
  Widget _halamanWelcome() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F1E36), Color(0xFF1B3B6F), Color(0xFF27496D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Card(
              elevation: 12,
              shadowColor: Colors.black54,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Header Bar
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      color: const Color(0xFF0F1E36),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.diamond_outlined, color: Color(0xFFD4AF37), size: 18),
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'NENG TIARA MAKE UP DEKORASI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Konten Utama Kartu Nama
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWide = constraints.maxWidth > 500;
                          return Column(
                            children: [
                              if (isWide)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFotoProfilPengantin(width: 190, height: 260),
                                    const SizedBox(width: 20),
                                    Expanded(child: _buildInfoKontakDanSlogan()),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    _buildFotoProfilPengantin(width: 170, height: 225),
                                    const SizedBox(height: 18),
                                    _buildInfoKontakDanSlogan(),
                                  ],
                                ),

                              const SizedBox(height: 24),

                              // Tombol Utama "Lihat Koleksi Baju"
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1B3B6F),
                                    foregroundColor: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                                  label: const Text(
                                    'Lihat Koleksi Baju',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  onPressed: () => setState(() => _halamanAktif = 1),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Foto Profil Pengantin Wanita dari Kartu Nama (assets/baju/baju_16.jpg)
  Widget _buildFotoProfilPengantin({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1B3B6F).withOpacity(0.18), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/baju/baju_16.jpg',
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, st) => Container(
            color: const Color(0xFFEBF3FC),
            child: const Icon(Icons.person, size: 60, color: Color(0xFF1B3B6F)),
          ),
        ),
      ),
    );
  }

  // Rincian Kontak & Slogan Sesuai Kartu Nama
  Widget _buildInfoKontakDanSlogan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Alamat
        _buildKontakItem(
          icon: Icons.location_on_rounded,
          iconColor: Colors.redAccent,
          label: 'Alamat:',
          value: 'Dsn. Bates, Ds. Bancelok, Kec. Jrengik, Kab. Sampang Madura',
        ),
        const SizedBox(height: 12),

        // No. WA
        _buildKontakItem(
          icon: Icons.phone_rounded,
          iconColor: const Color(0xFF25D366),
          label: 'No. WA:',
          value: '0821-3937-9385',
        ),
        const SizedBox(height: 12),

        // Tiktok
        _buildKontakItem(
          icon: Icons.music_note_rounded,
          iconColor: const Color(0xFF0F1E36),
          label: 'Tiktok:',
          value: 'Neng Tiara Make Up Dekorasi (Sampang)',
        ),
        const SizedBox(height: 16),

        // Slogan Kartu Nama
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1B3B6F).withOpacity(0.25)),
          ),
          child: Row(
            children: const [
              Icon(Icons.auto_awesome, color: Color(0xFFD4AF37), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '“Wujudkan Wedding Impianmu Start From 7.000.000”',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF0F1E36),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKontakItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color(0xFFEBF3FC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F1E36)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Dialog untuk melihat foto gaun/dekorasi secara full & zoomable
  void _showDetailFoto(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480, maxHeight: 660),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(item['nama'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                backgroundColor: const Color(0xFF1B3B6F),
                foregroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFF1E1E1E),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.8,
                    maxScale: 3.5,
                    child: Center(
                      child: _buildItemImage(item['img'], fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(item['deskripsi'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B3B6F),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.check),
                        label: Text(_selectedBarang.contains(item['id']) ? 'Batal Pilih' : 'Pilih Ini'),
                        onPressed: () {
                          Navigator.pop(ctx);
                          setState(() {
                            if (_selectedBarang.contains(item['id'])) {
                              _selectedBarang.remove(item['id']);
                            } else {
                              _selectedBarang.add(item['id']);
                            }
                          });
                          _saveDraftToHive();
                        },
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

  // HALAMAN 1 & 2: KATALOG BAJU (16 ITEM) & DEKORASI (18 ITEM)
  Widget _halamanKatalog(String kategori, String judul, String subjudul, int nextStep) {
    List<Map<String, dynamic>> daftar = _inventaris.where((e) => e['kategori'] == kategori).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(judul, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F1E36))),
                    const SizedBox(height: 2),
                    Text(subjudul, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                icon: const Icon(Icons.calendar_month, size: 16),
                label: Text('Tgl: ${_formatDate(_tglAcara)}', style: const TextStyle(fontSize: 12)),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _tglAcara,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => _tglAcara = picked);
                    _saveDraftToHive();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 560;
              int crossAxisCount = isMobile ? 1 : (constraints.maxWidth < 900 ? 2 : 3);
              double cardHeight = isMobile ? 385 : 420;
              double imgHeight = isMobile ? 250 : 240;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: cardHeight,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: daftar.length,
                itemBuilder: (context, i) {
                  var item = daftar[i];
                  var status = _cekStatusBarang(item);
                  bool tersedia = status['tersedia'] == true;
                  bool dipilih = _selectedBarang.contains(item['id']);

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: dipilih ? 5 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: dipilih ? const Color(0xFF1B3B6F) : Colors.transparent, width: 2.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _showDetailFoto(item),
                          child: Stack(
                            children: [
                              Container(
                                height: imgHeight,
                                width: double.infinity,
                                color: const Color(0xFFF0F5FA),
                                alignment: Alignment.center,
                                child: _buildItemImage(item['img'], height: imgHeight, width: double.infinity, fit: BoxFit.contain),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Chip(
                                  label: Text(status['label'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                  backgroundColor: tersedia ? Colors.green.shade700 : Colors.red.shade700,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(item['id'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.fullscreen, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['nama'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F1E36)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(item['deskripsi'],
                                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: dipilih ? const Color(0xFF1B3B6F) : Colors.grey.shade200,
                                    foregroundColor: dipilih ? Colors.white : Colors.black87,
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: tersedia
                                      ? () {
                                          setState(() {
                                            if (dipilih) {
                                              _selectedBarang.remove(item['id']);
                                            } else {
                                              _selectedBarang.add(item['id']);
                                            }
                                          });
                                          _saveDraftToHive();
                                        }
                                      : null,
                                  child: Text(dipilih ? 'Dipilih ✓' : 'Pilih Ini', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B6F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.arrow_forward),
              label: Text(kategori == 'Baju' ? 'Lanjut ke Pilih Dekorasi' : 'Lanjut ke Pengisian Jadwal'),
              onPressed: () => setState(() => _halamanAktif = nextStep),
            ),
          ),
        ],
      ),
    );
  }

  // HALAMAN 3: INPUT JADWAL
  Widget _halamanInputJadwal() {
    List<Map<String, dynamic>> itemTerpilih = _inventaris.where((e) => _selectedBarang.contains(e['id'])).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Langkah 3: Pencatatan Jadwal Acara', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F1E36))),
              const SizedBox(height: 16),
              TextField(
                controller: _pengantinCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengantin & Lokasi Acara',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isSmall = constraints.maxWidth < 420;
                  if (isSmall) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.calendar_today, size: 18),
                            label: Text('Tgl Acara: ${_formatDate(_tglAcara)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _tglAcara,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null) {
                                setState(() => _tglAcara = picked);
                                _saveDraftToHive();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _selectedPJ,
                          decoration: const InputDecoration(labelText: 'Tim PJ (R-01)', border: OutlineInputBorder(), isDense: true),
                          items: _listPJ.map((pj) => DropdownMenuItem(value: pj, child: Text(pj))).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedPJ = val);
                              _saveDraftToHive();
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today),
                            label: Text('Tgl: ${_formatDate(_tglAcara)}'),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _tglAcara,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                              );
                              if (picked != null) {
                                setState(() => _tglAcara = picked);
                                _saveDraftToHive();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedPJ,
                            decoration: const InputDecoration(labelText: 'Tim PJ (R-01)', border: OutlineInputBorder(), isDense: true),
                            items: _listPJ.map((pj) => DropdownMenuItem(value: pj, child: Text(pj))).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedPJ = val);
                                _saveDraftToHive();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Text('Barang Terpilih (${itemTerpilih.length}):', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F1E36))),
              const SizedBox(height: 6),
              if (itemTerpilih.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Belum ada baju atau dekorasi yang dipilih.', style: TextStyle(color: Colors.grey)),
                ),
              ...itemTerpilih.map((item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _buildItemImage(item['img'], width: 40, height: 40, fit: BoxFit.cover),
                    ),
                    title: Text('${item['id']} - ${item['nama']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text('${item['kategori']} • ${item['deskripsi']}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () {
                        setState(() => _selectedBarang.remove(item['id']));
                        _saveDraftToHive();
                      },
                    ),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3B6F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.lock),
                  label: const Text('Simpan & Kunci Jadwal'),
                  onPressed: _simpanJadwal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HALAMAN 4: FINAL CATATAN
  Widget _halamanFinalCatatan() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 10,
            children: [
              const Text('Langkah 4: Final Catatan (Rule R-04)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F1E36))),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_jadwalBooking.isNotEmpty)
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      icon: const Icon(Icons.delete_sweep, size: 16),
                      label: const Text('Reset', style: TextStyle(fontSize: 12)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Hapus Semua Jadwal?'),
                            content: const Text('Seluruh riwayat jadwal booking yang tersimpan akan dihapus.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  setState(() => _jadwalBooking.clear());
                                  _saveJadwalToHive();
                                  _showMsg('Semua jadwal booking berhasil dibersihkan.', Colors.orange.shade800);
                                },
                                child: const Text('Hapus Semua'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  const SizedBox(width: 4),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B3B6F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    onPressed: () => setState(() => _halamanAktif = 1),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Booking Baru', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_jadwalBooking.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(30), child: Text('Belum ada jadwal tersimpan.'))),
          ..._jadwalBooking.asMap().entries.map((entry) {
            int idx = entry.key;
            var b = entry.value;
            bool selesai = b['status'] == 'Selesai';
            List<Map<String, dynamic>> detailBarang = _inventaris.where((e) => (b['barang'] as List).contains(e['id'])).toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '💍 ${b['pengantin']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F1E36)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(
                              label: Text(selesai ? 'Selesai' : 'Aktif', style: const TextStyle(color: Colors.white, fontSize: 11)),
                              backgroundColor: selesai ? Colors.grey : const Color(0xFF1B3B6F),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                              tooltip: 'Hapus Booking',
                              onPressed: () {
                                setState(() => _jadwalBooking.removeAt(idx));
                                _saveJadwalToHive();
                                _showMsg('Jadwal booking berhasil dihapus.', Colors.orange.shade800);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Text('📅 Acara: ${b['tgl_acara']} | 🧺 Laundry H+1 (R-03): ${b['tgl_buffer']}'),
                    Text('👷 Tim PJ: ${b['pj']}'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detailBarang.map((item) {
                        return Container(
                          constraints: const BoxConstraints(maxWidth: 220, minWidth: 140),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: _buildItemImage(item['img'], width: 35, height: 35, fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 6),
                              Expanded(child: Text(item['nama'], style: const TextStyle(fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    if (!selesai)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700, foregroundColor: Colors.white),
                          onPressed: () {
                            setState(() => _jadwalBooking[idx]['status'] = 'Selesai');
                            _saveJadwalToHive();
                            _showMsg('Rule R-04 Aktif: Barang kembali ke gudang!', Colors.green.shade700);
                          },
                          child: const Text('Selesai Acara / Kembali Gudang (R-04)'),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
