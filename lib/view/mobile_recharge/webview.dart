import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteView extends StatefulWidget {
  final String url;
  final String title;

  const WebsiteView({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<WebsiteView> createState() => _WebsiteViewState();
}

class _WebsiteViewState extends State<WebsiteView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}