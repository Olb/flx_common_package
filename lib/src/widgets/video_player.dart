import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flx_common_package/common.dart';

class VideoPage extends StatefulWidget {
  VideoPage(this.videoUrl);
  final String videoUrl;

  @override
  _VideoPageState createState() => _VideoPageState(videoUrl);
}

class _VideoPageState extends State<VideoPage> {
  final String videoUrl;
  VideoPlayerController _controller;
  bool _isPlaying = false;
  VoidCallback listener;

  _VideoPageState(this.videoUrl) {
    listener = () {
      print('In player: Video Url - $videoUrl');
      final dur = _controller.value.duration;
      final pos = _controller.value.position;
      // This is a check to see if they are close to the end or not
      if ((dur - pos) <= Duration(seconds: 5)) {
        print('Enough time elapsed');
        print('Total time: $dur\nCurrent position: $pos\n');
      }
      print('Total time: $dur\nCurrent position: $pos\n');
      final bool isPlaying = _controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    };
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    try {
      _controller = VideoPlayerController.network(
        videoUrl,
      )
        ..addListener(listener)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _controller.play();
          });
        }).catchError((er) {
          setState(() {
            loadError = true;
          });
          scaffoldState.currentState.showSnackBar(SnackBar(
            content: Text(
              'Error loading video.',
              style: TextStyle(fontSize: 22.0),
            ),
          ));
        });
    } catch (e) {
      print(e);
    }
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
      _controller.pause();
      _controller.dispose();
    }
    super.deactivate();
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  bool loadError = false;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      key: scaffoldState,
      body: Container(
        color: Colors.black,
        child: _videoWidget(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: loadError == true
            ? _errorFloatingActionButton()
            : _playFloatingActionButton(),
      ),
    );

    return Container(
      child: scaffold,
    );
  }

  Widget _errorFloatingActionButton() {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(Icons.backspace),
    );
  }

  Widget _playFloatingActionButton() {
    return FloatingActionButton(
      onPressed:
      _controller.value.isPlaying ? _controller.pause : _controller.play,
      child: Icon(
        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
    );
  }

  Widget _videoWidget() {
    if (loadError) {
      return Center(
        child: Text(
          'Could not loading video. Tap button or swipe back to exit.',
          style: TextStyle(color: Colors.red, fontSize: 26.0),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Container(
                  color: Colors.black, child: VideoPlayer(_controller)),
            )
                : Container(
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                bufferedColor: Colors.white,
                playedColor: Colors.green,
              ),
              padding: EdgeInsets.all(14.0),
            ),
          ),
          Center(
            child: _controller.value.isBuffering
                ? LoadingDialog.showProgressIndicator()
                : null,
          )
        ],
      );
    }
  }
}
