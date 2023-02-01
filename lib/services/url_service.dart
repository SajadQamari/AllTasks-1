import 'package:url_launcher/url_launcher.dart';

Future<void> luncher(String url) async {
    final Uri uriPath = Uri.parse(url);
    _launchUrl(uriPath);
  }
  Future<void> _launchUrl(myurl) async {
  if (!await launchUrl(myurl)) {
    throw Exception('Could not launch');
  }
  }
  Future<void>sendEmail(String url) async {
    final Uri uriPath = Uri(scheme: 'mailto',path:url);
    _launchUrl(uriPath);
  }
