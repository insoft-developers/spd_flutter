import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:html_unescape/html_unescape_small.dart';

class HtmlLatexWidget extends StatelessWidget {
  final String html;
  final TextStyle? textStyle;

  const HtmlLatexWidget({
    super.key,
    required this.html,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    final regex = RegExp(r'\\\((.*?)\\\)', dotAll: true);

    final match = regex.firstMatch(html);

    if (match != null) {
      String latex = match.group(1)!;

      String text = html
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll(match.group(0)!, '');

      text = unescape.convert(text).trim();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text.isNotEmpty)
            Text(
              text,
              style: textStyle,
            ),
          const SizedBox(height: 10),
          Math.tex(latex),
        ],
      );
    }

    return Text(
      unescape.convert(
        html.replaceAll(RegExp(r'<[^>]*>'), ''),
      ),
      style: textStyle,
    );
  }
}