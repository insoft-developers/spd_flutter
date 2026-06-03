import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:html_unescape/html_unescape_small.dart';

class HtmlLatexWidget extends StatelessWidget {
  final String html;
  final TextStyle? textStyle;

  const HtmlLatexWidget({
    Key? key,
    required this.html,
    this.textStyle,
  }) : super(key: key);

  bool _isBlockFormula(String latex) {
    return latex.length > 40 ||
        latex.contains(r'\frac') ||
        latex.contains(r'\sqrt') ||
        latex.contains(r'\sum') ||
        latex.contains(r'\int') ||
        latex.contains(r'\lim') ||
        latex.contains('\n');
  }

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();

    String content = html;

    // Handle CKEditor HTML
    content = content
        .replaceAll(
          RegExp(r'<br\s*/?>', caseSensitive: false),
          '\n',
        )
        .replaceAll(
          RegExp(r'</p>', caseSensitive: false),
          '\n',
        )
        .replaceAll(
          RegExp(r'<p[^>]*>', caseSensitive: false),
          '',
        )
        .replaceAll(
          RegExp(r'</div>', caseSensitive: false),
          '\n',
        )
        .replaceAll(
          RegExp(r'<div[^>]*>', caseSensitive: false),
          '',
        );

    // Decode HTML entity
    content = unescape.convert(content);

    final regex = RegExp(
      r'\\\((.*?)\\\)',
      dotAll: true,
    );

    List<Widget> blocks = [];
    List<InlineSpan> currentInline = [];

    int lastEnd = 0;

    void flushInline() {
      if (currentInline.isEmpty) return;

      blocks.add(
        RichText(
          text: TextSpan(
            style: textStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
            children: List.from(currentInline),
          ),
        ),
      );

      currentInline.clear();
    }

    for (final match in regex.allMatches(content)) {
      String before = content.substring(lastEnd, match.start);

      // bersihkan tag html yang tersisa
      before = before.replaceAll(
        RegExp(r'<[^>]+>'),
        '',
      );

      if (before.isNotEmpty) {
        currentInline.add(
          TextSpan(text: before),
        );
      }

      final latex = (match.group(1) ?? '').trim();

      if (_isBlockFormula(latex)) {
        flushInline();

        blocks.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                latex,
                textStyle: textStyle,
              ),
            ),
          ),
        );
      } else {
        currentInline.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Math.tex(
              latex,
              mathStyle: MathStyle.text,
              textStyle: textStyle,
            ),
          ),
        );
      }

      lastEnd = match.end;
    }

    String remaining = content.substring(lastEnd);

    remaining = remaining.replaceAll(
      RegExp(r'<[^>]+>'),
      '',
    );

    if (remaining.isNotEmpty) {
      currentInline.add(
        TextSpan(text: remaining),
      );
    }

    flushInline();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks,
    );
  }
}