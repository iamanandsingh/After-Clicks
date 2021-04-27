import 'dart:io';
import 'package:after_clicks/pervez/hashAndCap.dart';
import 'package:after_clicks/pervez/utils/notificationPlugin.dart';
import 'package:after_clicks/pervez/utils/scheduleListManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class SchedulePage extends StatefulWidget {

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  @override
  void initState() {
    super.initState();
  }

  File _image;
  String _imagePath; //

  Future getImage() async{
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path; //
        _image = File(pickedFile.path);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HashAndCap(_image, _imagePath)));
      } else {
        print('No image selected.');
      }
    });
  }

  _onShare(BuildContext context, var imagePath, String text, String subject) async {
    try{
      await Share.shareFiles(
        [imagePath],
        text: text,
        subject: subject,);
    }catch (e) {
      print("Exception:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topP(),
      body: _middleP(),
      bottomNavigationBar: _bottomP(),
    );
  }

  Widget _topP(){
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      title: Text(
        'Schedule',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  Widget _middleP(){
    return ListView.builder(
      itemCount: mScheduleListObj.length,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
          child: Card(
            child: ListTile(
                onTap: (){
                  String capHas = mScheduleListObj[index].caption + "\n\n" + mScheduleListObj[index].hash;
                  Clipboard.setData(new ClipboardData(text: capHas));
                  _onShare(context, mScheduleListObj[index].imagePath, capHas, mScheduleListObj[index].hash);
                },
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.white,
                            backgroundImage: Image.file(mScheduleListObj[index].image).image,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            mScheduleListObj[index].caption,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children: [
                          mScheduleListObj[index].completeTime.difference(DateTime.now()).inSeconds > 0 ?
                          Text(
                              "${DateFormat('MMMM').format(mScheduleListObj[index].date)} ${mScheduleListObj[index].date.day}, ${mScheduleListObj[index].date.year}, at ${mScheduleListObj[index].time.hour}:${mScheduleListObj[index].time.minute}"
                          ) : Text (
                            'Time to Post!'
                          ),
                          TextButton(
                            onPressed: (){
                              mNotificationPlugin.cancelNotification(mScheduleListObj[index].timeDiff);
                              mScheduleListObj.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(Icons.delete_outline),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
        );
      }
    );
  }

  Widget _bottomP(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 55.0,
        width: 55.0,
        child: FloatingActionButton.extended(
          onPressed: (){
            hashtagP = '';
            getImage();
          },
          label: const Text(
              'New',
            style: TextStyle(
              fontSize: 15.0
            ),
          ),
          icon: const Icon(Icons.add_a_photo_rounded),
        ),
      ),
    );
  }
}