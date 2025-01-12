//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({required this.urlLabel, required this.url, super.key});

  final String urlLabel;
  final String url;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        minimumSize: const Size(0, 0),
        textStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(decoration: TextDecoration.underline),
      ),
      onPressed: () {
        _launchUrl(url);
      },
      child: Text(urlLabel),
    );
  }
}
