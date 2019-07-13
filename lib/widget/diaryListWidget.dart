import 'package:flutter/material.dart';
import 'dart:ui';

class DiaryListWidget extends StatefulWidget {

  DiaryListWidget({
    Key key,
    @required this.calendarWidget,
    @required this.diaryListBuilder,
    this.needHiddenCalendar = false
  }): assert(calendarWidget != null),super(key: key);

  final bool needHiddenCalendar;
  final Widget calendarWidget;
  final SliverChildBuilderDelegate diaryListBuilder;

  @override
  _DiaryListWidgetState createState() => _DiaryListWidgetState();
}

class _DiaryListWidgetState extends State<DiaryListWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Offstage(
            offstage: widget.needHiddenCalendar,
            child: Container(
              height: 300,
              width: window.physicalSize.width,
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Container(
                    child: widget.calendarWidget,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverFixedExtentList(
              delegate: widget.diaryListBuilder,
              itemExtent: 60.0
          ),
        )
      ],
    );
  }
}
