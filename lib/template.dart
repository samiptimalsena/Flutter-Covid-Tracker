import 'package:flutter/material.dart';

Widget textSection(
    String text, Color textColor, double size, double marg, bool bold) {
  return Container(
    margin: new EdgeInsets.only(top: marg),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "Roboto",
            fontSize: size,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            color: textColor),
      ),
    ),
  );
}

Widget future(dynamic getFuture, int condition, double size) {
  return FutureBuilder<dynamic>(
      future: getFuture,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          switch (condition) {
            case 1:
              return textSection(
                  snapshots.data.totalCases, Colors.black38, size, 0.0, true);
              break;
            case 2:
              return textSection(
                  snapshots.data.totalDeaths, Colors.black54, size, 5.0, true);
              break;
            case 3:
              return textSection(
                  snapshots.data.totalRecovered, Colors.green, size, 5.0, true);
              break;
            case 4:
              return textSection(
                  snapshots.data.newCases, Colors.black45, size, 5.0, true);
              break;
            default:
              return textSection(
                  snapshots.data.newDeaths, Colors.black, size, 5.0, true);
          }
        } else {
          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
        }
      });
}

Widget colCont(Widget first, Widget second) {
  return Column(
    children: <Widget>[first, second],
  );
}




