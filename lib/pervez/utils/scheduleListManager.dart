import 'package:after_clicks/pervez/utils/scheduleSG.dart';

List<scheduleSG> mScheduleListObj = [];

class scheduleListManager{

  void addDatatoList(scheduleSG mScheduleSG){
     mScheduleListObj.add(mScheduleSG);
     // Sorting
     mScheduleListObj.sort((a, b) => a.timeDiff.compareTo(b.timeDiff));
  }
}

scheduleListManager mScheduleListManagerObj = scheduleListManager();