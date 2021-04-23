import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class CollagePage extends StatefulWidget {
  @override
  _CollagePageState createState() => _CollagePageState();
}

class _CollagePageState extends State<CollagePage> {
  ScreenshotController screenshotController = ScreenshotController();
  File _image1;
  File _image2;
  File _image3;

  Uint8List _imageFile;

  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();

  String caption = "";
  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    final pickedFile2 = await picker2.getImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    setState(() {
      if (pickedFile2 != null) {
        _image2 = File(pickedFile2.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3() async {
    final pickedFile3 = await picker3.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile3 != null) {
        _image3 = File(pickedFile3.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void reset() {
    setState(() {
      _image1 = null;
      _image2 = null;
      _image3 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    // var height = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _imageFile = null;
              screenshotController.capture().then((Uint8List image) async {
                //print("Capture Done");
                setState(() {
                  _imageFile = image;
                });
                await ImageGallerySaver.saveImage(
                    image); // Save image to gallery
                print("File Saved to Gallery");
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
        ],
        title: Text('Collage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (val) {
                caption = val;
              },
              decoration: InputDecoration(),
            ),
            Container(
              color: Colors.purple[100],
            ),
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  Text(
                    caption,
                    style: GoogleFonts.dancingScript(fontSize: 80),
                  ),
                  // Container(
                  //     child: new TextField(
                  //   decoration: new InputDecoration(hintText: 'Awesome'),
                  // )),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Container(
                        color: Colors.pink[50],
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 3)),
                          child: _image1 == null
                              ? IconButton(
                                  onPressed: getImage,
                                  icon: Icon(Icons.add),
                                )
                              : Image.file(_image1),
                          width: width,
                          transform: Matrix4.rotationZ(0.1),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(width: 2000),
                  Row(
                    children: [
                      SizedBox(width: 180),
                      Container(
                        color: Colors.pink[50],
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 3)),
                          child: _image2 == null
                              ? IconButton(
                                  onPressed: getImage2,
                                  icon: Icon(Icons.add),
                                )
                              : Image.file(_image2),
                          width: width,
                          transform: Matrix4.rotationZ(0.1),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Container(
                        color: Colors.pink[50],
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 3)),
                          child: _image3 == null
                              ? IconButton(
                                  onPressed: getImage3,
                                  icon: Icon(Icons.add),
                                )
                              : Image.file(_image3),
                          width: width,
                          transform: Matrix4.rotationZ(0.1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        tooltip: 'Pick Image',
        child: Icon(Icons.loop),
      ),
    );
  }
}
