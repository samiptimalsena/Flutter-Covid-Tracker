import 'package:flutter/material.dart';
import 'api.dart';

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

class DataSource extends DataTableSource {
  var _data;
  DataSource(this._data);

  int _selectedCount = 0;

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow getRow(int index) {
    final Data elements = _data[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text(
        elements.countryName,
        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w500),
      )),
      DataCell(
        Text(
          elements.totalCases,
          style: row,
        ),
      ),
      DataCell(Text(elements.newCases, style: row)),
      DataCell(
        Text(elements.activeCases, style: row),
      ),
      DataCell(
        Text(elements.totalDeaths, style: row),
      ),
      DataCell(
        Text(elements.newDeaths, style: row),
      ),
      DataCell(
        Text(elements.totalRecovered, style: row),
      ),
      DataCell(Text(elements.seriousCritical, style: row)),
    ]);
  }
}


Widget colCont(Widget first, Widget second) {
  return Column(
    children: <Widget>[first, second],
  );
}

TextStyle col=TextStyle(
  fontSize: 13
);
TextStyle row= TextStyle(fontWeight: FontWeight.w500);




