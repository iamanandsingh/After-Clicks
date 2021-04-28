import 'package:after_clicks/pervez/utils/notificationPlugin.dart';
import 'package:after_clicks/pervez/utils/scheduleListManager.dart';
import 'package:after_clicks/pervez/utils/scheduleSG.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:after_clicks/utils/routes.dart';

class ScheduleP extends StatefulWidget {

  final String _caption;
  final String _hashtags;
  final DateTime _dateTime;
  final TimeOfDay _timeOfDay;
  final File _image;
  final String _imagePath;
  ScheduleP(this._caption, this._hashtags, this._dateTime, this._timeOfDay, this._image, this._imagePath);

  @override
  _SchedulePState createState() => _SchedulePState(_caption,_hashtags,_dateTime,_timeOfDay,_image,_imagePath);
}

class _SchedulePState extends State<ScheduleP> {

  String _captionF;
  String _hashtagF;
  DateTime _dateTimeF;
  TimeOfDay _timeOfDayF;
  File _imageF;
  String _imagePathF;
  var _timeDiff;
  var _completeTime;

  _SchedulePState(this._captionF, this._hashtagF,this._dateTimeF,this._timeOfDayF, this._imageF, this._imagePathF){
    _completeTime = new DateTime(_dateTimeF.year, _dateTimeF.month, _dateTimeF.day,
        _timeOfDayF.hour, _timeOfDayF.minute);
    _timeDiff = _completeTime.difference(DateTime.now()).inSeconds;
  }

  @override
  void initState(){
    super.initState();
    mNotificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  onNotificationClick(String payload){
    print('Payload $payload');
    Navigator.pushNamed(context, MyRoutes.schedule);
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
      iconTheme: IconThemeData(
      ),
      title: Text(
        'Preview',
        style: TextStyle(
        ),
      ),
    );
  }

  Widget _middleP(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              child: Image.file(_imageF),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey[100])
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _captionF != null ? "$_captionF \n\n $_hashtagF" : "$_hashtagF",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "${DateFormat('MMMM').format(_dateTimeF)} ${_dateTimeF.day}, ${_dateTimeF.year}, at ${_timeOfDayF.hour}:${_timeOfDayF.minute}",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomP(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: () async{
            int _count = await mNotificationPlugin.getPendingNotificationCount();
            await mNotificationPlugin.scheduleNotification(_timeDiff, _captionF);
            ScheduleSG mScheduleSG = ScheduleSG(_count, _captionF, _hashtagF, _dateTimeF, _timeOfDayF, _imageF, _imagePathF, _timeDiff, _completeTime);
            mScheduleListManagerObj.addDatatoList(mScheduleSG);
            Navigator.popUntil(context, ModalRoute.withName('/schedule'));
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
