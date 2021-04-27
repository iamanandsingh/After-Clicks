import 'package:after_clicks/pervez/utils/scheduleSG.dart';

List<ScheduleSG> mScheduleListObj = [];

class ScheduleListManager{

  void addDatatoList(ScheduleSG mScheduleSG){
     mScheduleListObj.add(mScheduleSG);
     // Sorting
     mScheduleListObj.sort((a, b) => a.timeDiff.compareTo(b.timeDiff));
     print(mScheduleListObj.toString());
  }
}

ScheduleListManager mScheduleListManagerObj = ScheduleListManager();