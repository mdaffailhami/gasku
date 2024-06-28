import 'package:flutter/material.dart';
import 'package:gasku/widgets/faq_list_tile.dart';
import 'package:gasku/widgets/pengajuan_pangkalan_list_tile.dart';

class MyPengajuanPangkalanPage extends StatelessWidget {
  const MyPengajuanPangkalanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pengajuan Pangkalan',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyPengajuanPangkalanListTile(
                title: 'Pendaftaran Menjadi Pengecer',
                body:
                    'Dalam mempersiapkan menjadi agen gas elpiji, berikut ini adalah persyaratan dan dokumen yang dibutuhkan untuk mendaftar.',
              ),
              MyPengajuanPangkalanListTile(
                title:
                    '1. Persiapkan Syarat dan Berkas yang Perlu Disiapkan untuk Menjadi Agen Resmi Elpiji',
                body: '''● Hasil scan KTP
● NPWP Perusahaan
● Bukti penguasaan lahan
● Bukti saldo rekening yang akan diperlukan dalam melengkapi isian data dalam aplikasi online
● Akta pendirian perusahaan (PT/Koperasi), SIUP, dan TDP
● Bukti saldo rekening atas nama pemilik/badan usaha
● Fotokopi bukti kepemilikan atas usaha sejenis jika ada, Misalnya: agen LPG PSO, Pangkalan LPG, dsb
● Fotokopi bukti kerja sama dengan PT. Pertamina jika ada, Misalnya: bukti sebagai pangkalan LPG PSO termasuk sumber agen penyuplai, agen LPG, SPBE, dsb
● Dokumen pendukung seperti kepemilikan tanah dan pelengkap lainnya''',
              ),
              MyPengajuanPangkalanListTile(
                title:
                    '2. Penuhi Persyaratan Keagenan LPG 3 Kg dan Menandatangani Kontrak',
                body:
                    '''Setelah itu calon agen akan melakukan pendaftaran sebagai agen resmi elpiji 3 kg.

Adapun agen belum langsung dapat beroperasi sebelum dinyatakan sudah memenuhi syarat.

Operasional agen LPG 3 kg harus sesuai dengan SOP PT Pertamina.
Nantinya para pekerja wajib bekerja sesuai dengan etika standar PT Pertamina.

Hal-hal mengenai perekrutan dan pengadaan karyawan merupakan tanggung jawab agen resmi itu sendiri.''',
              ),
              MyPengajuanPangkalanListTile(
                title: '3. Penuhi Syarat Perizinan Agen Gas Elpiji 3 Kg',
                body:
                    '''● Memiliki akte pendirian Badan Usaha (PT/Koperasi) yang mendapatkan pengesahan dari instansi berwenang
● NPWP atau Nomor Pokok Wajib Pajak
● Surat Referensi Bank
● SIUP atau Surat Izin Usaha Perdagangan
● TDP atau Tanda Daftar Perusahaan bagi Badan Hukum
● Izin Gangguan dan/atau SITU atau Surat Izin Tempat Usaha mengacu kepada ketentuan Pemda setempat
● Surat Izin Mendirikan Bangunan (IMB)
● Surat Keterangan Catatan Kepolisian (SKCK) dari Kepolisian setempat untuk semua Direktur dan Komisaris yang tercantum dalam akta perusahaan.
● Susunan Kepengurusan dan Jumlah Karyawan. Daftar Pangkalan dan Outlet LPG 3 kg beserta Kontrak Perjanjian antara agen dan pangkalan.
● Surat Pernyataan diatas kertas bermaterai''',
              ),
              MyPengajuanPangkalanListTile(
                title: '4. Memenuhi Syarat Sarana dan Fasilitas',
                body:
                    '''Tempat usaha atau gudang dilengkapi ventilasi dan sarana fasilitas sesuai ketentuan PT Pertamina/HSE yakni:
● Ventilasi maksimal 30 cm diatas permukaaan lantai gudang dan 40 persen dari luasan gudang.
● Lantai gudang setinggi bak Truck (panggung) yang dapat diakses langsung untuk loading / unloading tabung dari dan ke dalam armada angkut.
● Gudang terbuat dari bahan yang tidak mudah terbakar dan tidak menimbulkan percikan api apabila bersinggungan dengan tabung.
● Dilengkapi dengan Gas Detector.
● Dilengkapi peralatan listrik explotion proof.
● Jarak penyimpanan tabung terhadap pagar tembok dan outlet minimal 3 m.
● Penumpukan tabung maksimal 4 tumpuk isi dan 5 tumpuk kosong''',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
