import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath; // Path to the video file or URL
  const CustomVideoPlayer({super.key, required this.videoPath});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player with the provided video path
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is initialized
      });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background image (e.g., the present)
          Image.asset(
            'assets/images/present.png', // Replace with your image path
            width: 200, // Set the desired width
            height: 200, // Set the desired height
            fit: BoxFit.cover,
          ),
          // Play button overlay
          if (!_controller.value.isPlaying)
            Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
          // Video player (hidden behind the image until played)
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
        ],
      ),
    );
  }
}
