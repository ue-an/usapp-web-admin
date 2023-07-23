import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:web_tut/2.0/screens/activity_log/components/pdf_invoice_service.dart';

class Iframe extends StatelessWidget {
  Iframe() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframe', (int viewId) {
      var iframe = html.IFrameElement();
      iframe.src = 'http://www.africau.edu/images/default/sample.pdf';
      return iframe;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        width: size.width,
        height: size.height - 60,
        child: HtmlElementView(viewType: 'iframe'));
  }
}
