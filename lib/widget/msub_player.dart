import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MSubPlayer extends StatefulWidget {
  const MSubPlayer({super.key, required this.url});
  final String url;

  @override
  State<MSubPlayer> createState() => _MSubPlayerState();
}

class _MSubPlayerState extends State<MSubPlayer> {
  late VideoPlayerController controller;
  late Future<void> future;
  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    future = controller.initialize().then((_) {
      controller.play();
      controller.setLooping(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
