import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gasku/cubits/daftar_pangkalan.dart';
import 'package:gasku/cubits/posisi_pengguna.dart';
import 'package:gasku/models/pangkalan.dart';
import 'package:gasku/utils/validasi_kedekatan_lokasi.dart';
import 'package:gasku/widgets/filter_chip.dart';
import 'package:gasku/widgets/pangkalan_card.dart';
import 'package:geolocator/geolocator.dart';

class MyBerandaPage extends StatefulWidget {
  const MyBerandaPage({super.key});

  @override
  State<MyBerandaPage> createState() => _MyBerandaPageState();
}

class _MyBerandaPageState extends State<MyBerandaPage> {
  bool _isSemuaSelected = true;
  bool _isTersediaSelected = false;
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    context.read<DaftarPangkalanCubit>().search(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(
                        width: 1.3,
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    hintText: 'Cari Pangkalan',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyFilterChip(
                      label: 'Semua',
                      isSelected: _isSemuaSelected,
                      onSelected: (_) {
                        setState(() {
                          _isSemuaSelected = true;
                          _isTersediaSelected = false;
                          _isTerdekatSelected = false;
                        });
                      },
                    ),
                    MyFilterChip(
                      label: 'Tersedia',
                      isSelected: _isTersediaSelected,
                      onSelected: (_) {
                        setState(() {
                          _isSemuaSelected = false;
                          _isTersediaSelected = true;
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
                          _isTersediaSelected = false;
                          _isTerdekatSelected = true;
                        });
                      },
                    ),
                  ],
                ),
                BlocBuilder<DaftarPangkalanCubit, List<Pangkalan>>(
                  builder: (context, state) {
                    if (_isTersediaSelected) {
                      final List<Pangkalan> daftarPangkalan = [];

                      for (Pangkalan pangkalan in state) {
                        if (pangkalan.stok > 0) daftarPangkalan.add(pangkalan);
                      }

                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: daftarPangkalan.length,
                          itemBuilder: (context, i) {
                            return MyPangkalanCard(
                              pangkalan: daftarPangkalan[i],
                            );
                          },
                        ),
                      );
                    }

                    if (_isTerdekatSelected) {
                      context.read<PosisiPenggunaCubit>().refresh();
                      return BlocBuilder<PosisiPenggunaCubit, Position?>(
                        builder: (context, posisiPengguna) {
                          if (posisiPengguna == null) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Center(
                                child: Text(
                                  'Silahkan nyalakan lokasi anda!',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            );
                          }

                          final List<Pangkalan> daftarPangkalan = [];

                          for (Pangkalan pangkalan in state) {
                            // print(validasiKedekatanLokasi(
                            //   context.read<PosisiPenggunaCubit>().coordinates!,
                            //   pangkalan.coordinates,
                            // ));
                            if (validasiKedekatanLokasi(
                              context.read<PosisiPenggunaCubit>().coordinates!,
                              pangkalan.coordinates,
                            )) daftarPangkalan.add(pangkalan);
                          }
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: daftarPangkalan.length,
                              itemBuilder: (context, i) {
                                return MyPangkalanCard(
                                  pangkalan: daftarPangkalan[i],
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
