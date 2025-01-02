import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: ImageShaderText()),
    );
  }
}

class ImageShaderText extends StatelessWidget {
  const ImageShaderText({super.key});

  Future<ui.Image> _loadImage() async {
    final data = await rootBundle.load('assets/image.png');
    return decodeImageFromList(data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final image = snapshot.data!;
        return Center(
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return ImageShader(
                image,
                TileMode.clamp,
                TileMode.clamp,
                (Matrix4.identity()
                      ..scale(
                        bounds.width / image.width,
                        bounds.height / image.height,
                      ))
                    .storage,
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hello World',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
