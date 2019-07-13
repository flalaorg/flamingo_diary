import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  PageController _pageController;
  double needHiddenPerviousIcon = 1.0;
  dynamic needHiddenNextIcon = 1.0;

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
                    icon: Icon(Icons.navigate_before),
                    label: Text(""),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text("${DateTime.now().year}年${position + 1}月"),
                  ),
                ),
                Opacity(
                  opacity: needHiddenNextIcon,
                  child: FlatButton.icon(
                      onPressed: () => nextMonth(position),
                      icon: Icon(Icons.navigate_next),
                      label: Text("")),
                )
              ],
            )
          ],
        ),
    );
  }

  void previousMonth(int index) {
    setState(() {
      if (index > 0)
        _pageController.animateToPage(index - 1, duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    });
  }

  void nextMonth(int index) {
    setState(() {
      if(index < 11)
        _pageController.animateToPage(index + 1, duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    });
  }
}