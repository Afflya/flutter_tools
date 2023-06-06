import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tools/scope_functions.dart';

import 'package:flutter_tools/src/svg/fake_html.dart' if (dart.library.html) 'dart:html' as html;
import 'package:flutter_tools/src/svg/fake_ui.dart' if (dart.library.html) 'dart:ui' as ui;

// ignore: avoid_classes_with_only_static_members
class PlatformSvg {
  static final Random _random = Random();

  static Widget string(
    String svgString, {
    double width = 24,
    double height = 24,
    String? hashCode,
    Color? color,
  }) {
    if (kIsWeb) {
      hashCode ??= String.fromCharCodes(List<int>.generate(128, (i) => _random.nextInt(256)));
      ui.platformViewRegistry.registerViewFactory('img-svg-$hashCode', (int viewId) {
        final String base64 = base64Encode(utf8.encode(svgString));
        final String base64String = 'data:image/svg+xml;base64,$base64';
        final html.ImageElement element =
            html.ImageElement(src: base64String, height: width.toInt(), width: width.toInt());
        return element;
      });
      return Container(
        width: width,
        height: width,
        alignment: Alignment.center,
        child: HtmlElementView(
          viewType: 'img-svg-$hashCode',
        ),
      );
    }
    return SvgPicture.string(svgString);
  }

  static Widget asset(
    String assetName, {
    double width = 24,
    double height = 24,
    BoxFit fit = BoxFit.contain,
    Color? color,
    String? semanticsLabel,
  }) {
    if (kIsWeb) {
      return Image.network(
        assetName,
        width: width,
        height: height,
        fit: fit,
        color: color,
        semanticLabel: semanticsLabel,
      );
      // final String hashCode =
      //     assetName.replaceAll('/', '-').replaceAll('.', '-');
      // return FutureBuilder(
      //     future: rootBundle.loadString(assetName),
      //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      //       if (snapshot.hasData) {
      //         return string(snapshot.data,
      //             width: width, height: height, hashCode: hashCode);
      //       } else if (snapshot.hasError) {
      //         return SizedBox(
      //           width: width,
      //           height: width,
      //         );
      //       } else {
      //         return SizedBox(
      //           width: width,
      //           height: width,
      //         );
      //       }
      //     });
    }

    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color?.let((it) => ColorFilter.mode(color, BlendMode.srcIn)),
      semanticsLabel: semanticsLabel,
    );
  }
}
