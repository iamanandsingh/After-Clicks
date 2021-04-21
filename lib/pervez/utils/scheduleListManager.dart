import 'package:after_clicks/pervez/utils/ScheduleSG.dart';

List<ScheduleSG> mScheduleListObj = [];

class ScheduleListManager{

  void addDatatoList(ScheduleSG mScheduleSG){
     mScheduleListObj.add(mScheduleSG);
     // Sorting
     mScheduleListObj.sort((a, b) => a.timeDiff.compareTo(b.timeDiff));
  }
}

ScheduleListManager mScheduleListManagerObj = ScheduleListManager();