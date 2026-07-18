import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class GoogleDrivePdfWeb extends StatefulWidget {
  final String fileId;

  const GoogleDrivePdfWeb({
    super.key,
    required this.fileId,
  });

  @override
  State<GoogleDrivePdfWeb> createState() => _GoogleDrivePdfWebState();
}

class _GoogleDrivePdfWebState extends State<GoogleDrivePdfWeb> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();

    _viewType =
        'google-drive-pdf-${widget.fileId}-${identityHashCode(this)}';

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final previewUrl =
            'https://drive.google.com/file/d/${widget.fileId}/preview';

        final iframe = web.HTMLIFrameElement()
          ..src = previewUrl
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.border = 'none'
          ..style.margin = '0'
          ..style.padding = '0';

        /*
         * Membatasi iframe:
         * - script tetap berjalan agar Google Preview dapat tampil
         * - tidak memberikan allow-downloads
         * - tidak memberikan allow-popups
         */
        iframe.setAttribute(
          'sandbox',
          'allow-scripts allow-same-origin allow-forms',
        );

        iframe.setAttribute(
          'referrerpolicy',
          'no-referrer',
        );

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: HtmlElementView(
            viewType: _viewType,
          ),
        ),

        /*
         * Menutupi toolbar bagian atas Google Drive,
         * tempat tombol download dan buka tab biasanya muncul.
         */
        
      ],
    );
  }
}