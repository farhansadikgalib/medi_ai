import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String webURL) async {
  final url = Uri.parse(webURL);
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
