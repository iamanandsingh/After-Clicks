import 'dart:io';
import 'package:after_clicks/utils/filter_utils.dart';
import 'package:after_clicks/widgets/FiteredImageWidget.dart';
import 'package:after_clicks/widgets/filtered_image_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:photofilters/photofilters.dart';

class SoloPage extends StatefulWidget {
  @override
  _SoloPageState createState() => _SoloPageState();
}

class _SoloPageState extends State<SoloPage> {
  img.Image image;

  Filter filter = presetFiltersList.first;

  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    final imageBytes = File(image.path).readAsBytesSync();
    final newImage = img.decodeImage(imageBytes);
    FilterUtils.clearCache();

    setState(() {
      this.image = newImage;
    });
  }

  Widget buildFilters() {
    if (image == null) return Container();

    return FilteredImageListWidget(
      filters: presetFiltersList,
      image: image,
      onChangedFilter: (filter) {
        setState(() {
          this.filter = filter;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double height = 450;

    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Solo"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                filter = presetFiltersList[8];
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: image == null
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // minimumSize: Size(100, 150),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: pickImage,
                        child: Text("Add Image"),
                      )
                    : Column(
                        children: [
                          FilteredImageWidget(
                            filter: filter,
                            image: image,
                            successBuilder: (imageBytes) => Image.memory(
                                imageBytes,
                                height: height,
                                fit: BoxFit.fitHeight),
                            errorBuilder: () => Container(height: height),
                            loadingBuilder: () => Container(
                              height: height,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          const SizedBox(height: 12),
                          buildFilters(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
