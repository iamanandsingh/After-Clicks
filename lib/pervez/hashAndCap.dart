import 'package:after_clicks/pervez/selectHashtags.dart';
import 'package:flutter/material.dart';
import 'package:after_clicks/pervez/schedule.dart';
import 'dart:io';

String hashtagP = '';

class HashAndCap extends StatefulWidget {

  final File _image;
  final String _imagePath; //
  HashAndCap(this._image, this._imagePath);

  @override
  _HashAndCapState createState() => _HashAndCapState(_image, _imagePath);
}

class _HashAndCapState extends State<HashAndCap> {

  File imageP;
  String _imagePathP; //
  _HashAndCapState(this.imageP, this._imagePathP);

  DateTime dateTimeP;
  TimeOfDay timeOfDayP;
  String captionP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topP(),
      body: _middle(),
      bottomNavigationBar: _bottomP(),
    );
  }

  Widget _topP(){
    return AppBar(
      iconTheme: IconThemeData(
      ),
      title: Text(
        'New Post',
      ),
      elevation: 0.0,
    );
  }

  Widget _middle(){
    return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            backgroundImage: Image.file(imageP).image,
          ),
          SizedBox(height: 10.0),
          TextField(
            onChanged: (enteredCaption){
              captionP = enteredCaption;
            },
            decoration: InputDecoration(
                labelText: 'Write a caption...'
            ),
          ),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.blueGrey[100])
              ),
            ),
            child: Center(
                child: TextButton(
                  child: Text(
                    'Add Hashtags',
                    style: TextStyle(
                        fontSize: 20,
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SelectHash()), ).then((value) => setState(() {}));

                  },
                )
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.blueGrey[100])
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Text(
                hashtagP,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _bottomP(){
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.blueGrey[100])
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextButton(
              child: Text(
                'Schedule',
                style: TextStyle(
                    fontSize: 20.0,
                ),
              ),
              onPressed: (){
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030)
                ).then((date){
                  setState(() {
                    dateTimeP = date;
                    if(dateTimeP != null && timeOfDayP != null){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ScheduleP(captionP, hashtagP,dateTimeP,timeOfDayP,imageP,_imagePathP)));
                    }
                  });
                });
                showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()
                ).then((time){
                  setState(() {
                    timeOfDayP = time;
                  });
                });
              }
          ),
        ],
      ),
    );
  }
}
