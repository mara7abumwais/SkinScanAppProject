import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      _isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* if (!_isCameraReady) {
      return Center(child: CircularProgressIndicator());
    }
*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: FloatingActionButton(
                  onPressed: () {
                    // Open the camera when the button is pressed
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CameraPreviewScreen(
                          cameraController: _controller,
                        ),
                      ),
                    );*/
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                  ),
                ),
              ),
              IconButton(onPressed: ()=>Navigator.pushNamed(context,'/scanResult'), icon: Icon(Icons.ads_click))
            ],
          ),
        ),
      )
    );
  }
}

class CameraPreviewScreen extends StatelessWidget {
  final CameraController cameraController;

  CameraPreviewScreen({required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Preview"),
      ),
      body: CameraPreview(cameraController),
    );
  }
}

