import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({required this.camera, Key? key}) : super(key: key);
  final CameraDescription camera;
// comment
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.low);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context, imageFiles);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.initialize(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(child: CameraPreview(controller));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.image),
        onPressed: () async {
          final imageFile = await controller.takePicture();
          imageFiles.add(File(imageFile.path));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
