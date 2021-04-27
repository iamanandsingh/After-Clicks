import 'dart:io';
import 'package:after_clicks/utils/filter_utils.dart';
import 'package:after_clicks/widgets/FiteredImageWidget.dart';
import 'package:after_clicks/widgets/filtered_image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:photofilters/photofilters.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';

class FilterImagePage extends StatefulWidget {
  @override
  _FilterImagePageState createState() => _FilterImagePageState();
}

class _FilterImagePageState extends State<FilterImagePage> {
  // final GlobalKey globalKey = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

  img.Image image;
  Uint8List _imageFile;

  Filter filter = presetFiltersList.first;

  Future pickImage() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      final imageBytes = File(image.path).readAsBytesSync();
      final newImage = img.decodeImage(imageBytes);
      setState(() {
        this.image = newImage;
      });
    } catch (e) {
      print("error");
    }

    FilterUtils.clearCache();
  }

  Widget buildFilters() {
    if (image == null) return Container();

    return Align(
      alignment: Alignment.bottomCenter,
      child: FilteredImageListWidget(
        filters: presetFiltersList,
        image: image,
        onChangedFilter: (filter) {
          setState(() {
            this.filter = filter;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double height = 450;

    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Image"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _imageFile = null;
              screenshotController.capture().then((Uint8List image) async {
                setState(() {
                  _imageFile = image;
                });
                await ImageGallerySaver.saveImage(image); // Save image to gallery
                print("File Saved to Gallery");
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image == null
                ? //ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       // minimumSize: Size(100, 150),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: new BorderRadius.circular(30.0),
                //       ),
                //     ),
                //     onPressed: pickImage,
                //     child: Text("Add Image"),
                //   )
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 55.0,
                      width: 400.0,
                      child: FloatingActionButton.extended(
                        onPressed: pickImage,
                        label: Text(
                          'Add Image',
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),
                        icon: const Icon(Icons.add_a_photo_rounded),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      FilteredImageWidget(
                        filter: filter,
                        image: image,
                        successBuilder: (imageBytes) => Screenshot(
                          controller: screenshotController,
                          child: Image.memory(imageBytes,
                              height: height, fit: BoxFit.fitHeight),
                        ),
                        errorBuilder: () => Container(height: height),
                        loadingBuilder: () => Container(
                          height: height,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(height: 100),
                      buildFilters(),
                    ],
                  ),
            _imageFile != null ? Image.memory(_imageFile) : Container(),
          ],
        ),
      ),
    );
  }
}
