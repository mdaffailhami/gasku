import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gasku/widgets/filter_chip.dart';
import 'package:gasku/widgets/pangkalan_card.dart';

class MyBerandaPage extends StatefulWidget {
  const MyBerandaPage({super.key});

  @override
  State<MyBerandaPage> createState() => _MyBerandaPageState();
}

class _MyBerandaPageState extends State<MyBerandaPage> {
  bool _isTerdekatSelected = true;
  bool _isTermurahSelected = false;
  bool _isTersediaSelected = false;

  @override
  Widget build(BuildContext context) {
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
                return Image.asset(
                  'assets/akane.png',
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    hintText: 'Cari Pangkalan',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyFilterChip(
                      label: 'Terdekat',
                      isSelected: _isTerdekatSelected,
                      onSelected: (value) {
                        setState(() => _isTerdekatSelected = value);
                      },
                    ),
                    MyFilterChip(
                      label: 'Termurah',
                      isSelected: _isTermurahSelected,
                      onSelected: (value) {
                        setState(() => _isTermurahSelected = value);
                      },
                    ),
                    MyFilterChip(
                      label: 'Tersedia',
                      isSelected: _isTersediaSelected,
                      onSelected: (value) {
                        setState(() => _isTersediaSelected = value);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      MyPangkalanCard(),
                      MyPangkalanCard(),
                      MyPangkalanCard(),
                      MyPangkalanCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
