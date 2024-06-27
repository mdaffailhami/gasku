import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Gagal membuka $url');
  }
}
