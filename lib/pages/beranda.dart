import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gasku/cubits/daftar_pangkalan.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/widgets/filter_chip.dart';
import 'package:gasku/widgets/pangkalan_card.dart';

class MyBerandaPage extends StatefulWidget {
  const MyBerandaPage({super.key});

  @override
  State<MyBerandaPage> createState() => _MyBerandaPageState();
}

class _MyBerandaPageState extends State<MyBerandaPage> {
  bool _isSemuaSelected = true;
  bool _isTerbaikSelected = false;
  bool _isTerdekatSelected = false;

  @override
  Widget build(BuildContext context) {
    context.read<DaftarPangkalanCubit>().refresh();

    return Column(
      children: [
        FlutterCarousel(
          options: CarouselOptions(
            height: 210,
            enableInfiniteScroll: true,
            padEnds: false,
            viewportFraction: 1,
            autoPlay: true,
            showIndicator: true,
            slideIndicator: const CircularSlideIndicator(),
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  'https://awsimages.detik.net.id/visual/2022/01/28/infografis-ri-tajir-gas-alam-tapi-kok-impor-lpg_169.jpeg?w=650',
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(
                        width: 1.3,
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    hintText: 'Cari Pangkalan',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyFilterChip(
                      label: 'Semua',
                      isSelected: _isSemuaSelected,
                      onSelected: (_) {
                        setState(() {
                          _isSemuaSelected = true;
                          _isTerbaikSelected = false;
                          _isTerdekatSelected = false;
                        });
                      },
                    ),
                    MyFilterChip(
                      label: 'Terbaik',
                      isSelected: _isTerbaikSelected,
                      onSelected: (_) {
                        setState(() {
                          _isSemuaSelected = false;
                          _isTerbaikSelected = true;
                          _isTerdekatSelected = false;
                        });
                      },
                    ),
                    MyFilterChip(
                      label: 'Terdekat',
                      isSelected: _isTerdekatSelected,
                      onSelected: (_) {
                        setState(() {
                          _isSemuaSelected = false;
                          _isTerbaikSelected = false;
                          _isTerdekatSelected = true;
                        });
                      },
                    ),
                  ],
                ),
                BlocBuilder<DaftarPangkalanCubit, List<Pangkalan>>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.length,
                        itemBuilder: (context, i) {
                          return MyPangkalanCard(pangkalan: state[i]);
                        },
                      ),
                    );
                  },
                ),
                // Expanded(
                //   child: ListView(
                //     shrinkWrap: true,
                //     children: [
                //       MyPangkalanCard(
                //         pangkalan: Pangkalan(
                //           nama: 'Pangkalan LPG Rahmi',
                //           alamat:
                //               'Jl. Sultan Adam Komplek Mekar Sari Blok 24B, No.52',
                //           urlGambar:
                //               'https://pict-a.sindonews.net/dyn/850/pena/news/2020/10/14/194/196024/pertamina-pecat-pangkalan-elpiji-gas-3-kg-terbukti-nakal-fuk.jpg',
                //           rating: 7.4,
                //           harga: Rupiah(23000),
                //         ),
                //       ),
                //       MyPangkalanCard(
                //         pangkalan: Pangkalan(
                //           nama: 'Pangkalan H. Naim',
                //           alamat:
                //               'Jl. Banua Anyar Komp. 14 RT.10 RW.001 No.A98',
                //           urlGambar:
                //               'https://awsimages.detik.net.id/visual/2022/11/03/pangkalan-lpg-di-tangerang-selatan-2_169.jpeg?w=650',
                //           rating: 8.2,
                //           harga: Rupiah(25000),
                //         ),
                //       ),
                //       MyPangkalanCard(
                //         pangkalan: Pangkalan(
                //           nama: 'Pangkalan LPG Putra',
                //           alamat:
                //               'Jl. Bintara Komplek UWU Uwaw Blok 10A, No.35',
                //           urlGambar:
                //               'https://asset-2.tstatic.net/pontianak/foto/bank/images/cara-daftar-pangkalan-gas-lpg-3-kg-dan-cara-daftar-agen-gas-lpg-3-kg-login-kemitraanpertaminacom.jpg',
                //           rating: 7.4,
                //           harga: Rupiah(23000),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
