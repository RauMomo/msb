import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumericButton extends StatefulWidget {
  final ValueChanged<int> quantityValue;
  final int min;
  final int max;
  NumericButton({Key key, this.quantityValue, this.min = 1, this.max = 20})
      : super(key: key);
  _NumericButtonState createState() => _NumericButtonState();
}

class _NumericButtonState extends State<NumericButton> {
  @override
  int counter = 1;
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      GestureDetector(
        onTap: () {
          setState(() {
            if (counter > widget.min) {
              counter--;
            }
          });
          widget.quantityValue(counter);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.remove,
            color: Theme.of(context).accentColor,
            size: 30.0,
          ),
        ),
      ),
      // IconButton(
      //   padding: EdgeInsets.all(1.0),
      //   icon: Icon(
      //     Icons.remove,
      //     color: Theme.of(context).accentColor,
      //   ),
      //   iconSize: 17.0,
      //   color: Theme.of(context).primaryColor,
      //   alignment: Alignment.topRight,
      //   onPressed: () {
      //     setState(() {
      //       if (counter > widget.min) {
      //         counter--;
      //       }
      //       widget.quantityValue(counter);
      //     });
      //   },
      // ),
      Text(
        '$counter',
        style: TextStyle(
          fontFamily: "Segoe_UI_Bold",
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      // IconButton(
      //   padding: EdgeInsets.all(1.0),
      //   icon: Icon(
      //     Icons.add,
      //     color: Theme.of(context).accentColor,
      //   ),
      //   iconSize: 17.0,
      //   color: Theme.of(context).primaryColor,
      //   alignment: Alignment.topRight,
      //   onPressed: () {
      //     setState(() {
      //       if (counter < widget.max) {
      //         counter++;
      //       }
      //       widget.quantityValue(counter);
      //     });
      //   },
      // )
      GestureDetector(
        onTap: () {
          setState(() {
            if (counter < widget.max) {
              counter++;
            }
          });
          widget.quantityValue(counter);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
            size: 30.0,
          ),
        ),
      ),
    ]));
  }
}
