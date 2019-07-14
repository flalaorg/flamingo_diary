import 'package:flutter/material.dart';
import 'package:flamingo_diary/util/calendarSwitch.dart';

typedef SingleCallBack = void Function(int month, int day);

class CalendarWidget extends StatefulWidget {

  CalendarWidget({Key key, this.dayClickListener}): super(key: key);

  final SingleCallBack dayClickListener;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  PageController _pageController;
  double needHiddenPerviousIcon = 1.0;
  dynamic needHiddenNextIcon = 1.0;
  int selectMonth = DateTime.now().month;
  int selectDay = DateTime.now().day;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: DateTime.now().month - 1
    );

    _pageController.addListener(() {
      setState(() {
        _pageController.page.toInt() == 0 ? needHiddenPerviousIcon = 0.0 : needHiddenPerviousIcon = 1.0;
        _pageController.page.toInt() == 11 ? needHiddenNextIcon = 0.0 : needHiddenNextIcon = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 12,
      controller: _pageController,
      itemBuilder: (context, position) =>
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Opacity(
                    opacity: needHiddenPerviousIcon,
                    child: FlatButton.icon(
                      onPressed: () => previousMonth(position),
                      icon: Icon(Icons.navigate_before, color: Colors.red[300],),
                      label: Text(""),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text("${DateTime.now().year}年${position + 1}月", style: TextStyle(color: Colors.red[300]),),
                    ),
                  ),
                  Opacity(
                    opacity: needHiddenNextIcon,
                    child: FlatButton.icon(
                        onPressed: () => nextMonth(position),
                        icon: Icon(Icons.navigate_next, color: Colors.red[300]),
                        label: Text("")),
                  )
                ],
              ),
              Divider(
                height: 0.5,
                color: Colors.red[300],
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Center(
                    child: GridView.builder(
                      itemCount: CalendarSwitch.getInstance().everyMonthToDayNum(position + 1),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: CalendarSwitch.getInstance().isSelectDay(position + 1, index + 1)
                                  ? Colors.red[300] : Colors.transparent,
                              child: Text((index + 1).toString(), style: TextStyle(
                                  color: CalendarSwitch.getInstance().isSelectDay(position + 1, index + 1)
                                      ? Colors.white : Colors.red[300]),),
                            ),
                            onTap: () {
                              setDefaultClickListener(position + 1, index + 1);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }

  void previousMonth(int index) {
    setState(() {
      if (index > 0)
        _pageController.animateToPage(index - 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  void nextMonth(int index) {
    setState(() {
      if(index < 11)
        _pageController.animateToPage(index + 1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  void setDefaultClickListener(innerMonth, innerDay) {
    if (widget.dayClickListener == null) {
      setState(() {
        selectMonth = innerMonth;
        selectDay = innerDay;
      });
    } else {
      widget.dayClickListener(innerMonth, innerDay);
    }
  }

  bool isSelectDay(int month, int day) => selectMonth == month && selectDay == day ? true : false;
}