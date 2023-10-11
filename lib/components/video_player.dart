import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  const VideoPlayer(
    this.videoId, {
    super.key,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: true,
    );
  }
}
