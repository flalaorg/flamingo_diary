import 'package:flutter/material.dart';

class SizeImageLoadWidget extends StatefulWidget {

  SizeImageLoadWidget({
    Key key,
    this.width = 50.0,
    this.height = 50.0,
    this.placeholder = "null",
    @required this.image
  }): super(key: key);

  final double width;
  final double height;
  final String placeholder;
  final String image;

  @override
  _SizeImageLoadWidgetState createState() => _SizeImageLoadWidgetState();
}

class _SizeImageLoadWidgetState extends State<SizeImageLoadWidget> {
  @override
  Widget build(BuildContext context) =>
      SizedBox(
        width: widget.width,
        height: widget.height,
        child: FadeInImage.assetNetwork(
            placeholder: widget.placeholder,
            image: widget.image
        ),
      );
}
