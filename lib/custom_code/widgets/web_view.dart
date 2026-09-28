// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({
    super.key,
    this.width,
    this.height,
    required this.link,
  });

  final double? width;
  final double? height;
  final String link;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            _applyTheme();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
  }

  Future<void> _applyTheme() async {
    try {
      final theme = FlutterFlowTheme.of(context);
      final bgColor = _colorToHex(theme.primaryBackground);
      final textColor = _colorToHex(theme.primaryText);

      await _controller.runJavaScript('''
        document.documentElement.style.background = '$bgColor';
        document.body.style.background = '$bgColor';
        document.body.style.color = '$textColor';

        var existingStyle = document.getElementById('ff-theme-style');
        if (existingStyle) {
          existingStyle.remove();
        }

        var style = document.createElement('style');
        style.id = 'ff-theme-style';
        style.innerHTML = 'body, p, div, span, h1, h2, h3, h4, h5, h6, li, a { color: $textColor !important; }';
        document.head.appendChild(style);
        document.body.style.margin = '0';
      ''');
    } catch (_) {}
  }

  String _colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  @override
  Widget build(BuildContext context) {
    _applyTheme();
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
