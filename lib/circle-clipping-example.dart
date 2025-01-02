import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MaskedVideoExample extends StatefulWidget {
  const MaskedVideoExample({super.key}) : super();

  @override
  State<MaskedVideoExample> createState() => _MaskedVideoExampleState();
}

class _MaskedVideoExampleState extends State<MaskedVideoExample> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setVolume(0);
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: ClipOval(
        child: SizedBox(
          width: 200,
          height: 200,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
