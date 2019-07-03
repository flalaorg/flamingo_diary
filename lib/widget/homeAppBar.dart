import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart' as Diagnostics;

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {

  HomeAppBar({
    Key key,
    this.title,
    this.height = 56.0,
    this.elevation = .5,
    this.searchController,
    this.leading,
    this.searchIcon = Icons.search,
    this.calendarIcon = Icons.calendar_today,
    this.onClickCalendarIcon,
    this.inputFormatter
  }): super(key: key);

  final Text title;
  final double height;
  //阴影
  final double elevation;
  final Widget leading;
  final TextEditingController searchController;
  final IconData searchIcon;
  final IconData calendarIcon;
  final VoidCallback onClickCalendarIcon;
  final List<TextInputFormatter> inputFormatter;


  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _HomeAppBarState extends State<HomeAppBar> {

  bool needShow = true;

  @override
  Widget build(BuildContext context) {

    void _handleDrawerButton() {
      Scaffold.of(context).openDrawer();
    }

    Text _title = widget.title ?? Text("wow");

    Widget leading = widget.leading;
    if (leading == null) {
      leading = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButton,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(widget.height),
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: <Widget>[
                  leading,
                  Expanded(
                    flex: 3,
                    child: _title,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                needShow = !needShow;
                              });
                              print(needShow.toString());
                            }
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: needShow,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0
                        ),
                        controller: widget.searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: 0.1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 5.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(widget.calendarIcon),
                            onPressed: widget.onClickCalendarIcon
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
