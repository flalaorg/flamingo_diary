
class CalendarSwitch {

  CalendarSwitch._internal();

  factory CalendarSwitch.getInstance() => CalendarSwitch._internal();

  int everyMonthToDayNum(int index) {
    int temp;
    switch (index) {
      case 1: case 3: case 5: case 7: case 8: case 10: case 12:
        temp = 31;
        break;
      case 2:
        DateTime.now().year % 4 == 0 ? temp = 29 : temp = 28;
        break;
      case 4: case 6: case 9: case 11:
        temp = 30;
        break;
    }

    return temp;
  }

  bool isMonth(int month) => month == DateTime.now().month ? true : false;

  bool isToday(int day) =>  day == DateTime.now().day
      ? true : false;
}