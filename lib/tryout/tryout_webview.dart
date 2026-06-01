import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TryoutWebview extends StatefulWidget {
  const TryoutWebview({Key? key}) : super(key: key);

  @override
  State<TryoutWebview> createState() => _TryoutWebviewState();
}

class _TryoutWebviewState extends State<TryoutWebview> {
  double _progress = 0;
  late InAppWebViewController webView;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tryout Via Website",
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri.uri(Uri.parse("https://bimbelgenzi.com"))),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                )),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                _progress = progress / 100;
              });
            },
          ),
          _progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
