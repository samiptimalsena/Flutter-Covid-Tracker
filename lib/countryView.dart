import 'package:flutter/material.dart';
import 'api.dart';

class Country extends StatefulWidget {
  final dataList;
  Country(this.dataList);
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var data;


  @override
  void initState() {
    super.initState();
    data=widget.dataList;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Updates"),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Data>>(
                future: data,
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    snapshots.data.removeWhere((item)=>item.countryName=="");
                    var data=snapshots.data;
                    return DataTable(
                columns: [
                  DataColumn(label: Text("Country Name")),
                  DataColumn(label: Text("Total cases")),
                  DataColumn(label: Text("New cases")),
                  DataColumn(label: Text("Active cases")),
                  DataColumn(label: Text("Total Deaths")),
                  DataColumn(label: Text("New Deaths")),
                  DataColumn(label: Text("Total Recovered")),
                  DataColumn(label: Text("Serious/Critical")),
                ],
                rows: data.map((elements)=>DataRow(
                  cells: <DataCell>[
                     DataCell(Text(elements.countryName)),
                      DataCell(Text(elements.totalCases),),
                      DataCell(Text(elements.newCases),),
                       DataCell(Text(elements.activeCases),),
                        DataCell(Text(elements.totalDeaths),),
                         DataCell(Text(elements.newDeaths),),
                          DataCell(Text(elements.totalRecovered),),
                          DataCell(Text(elements.seriousCritical)),
                  ]
                )).toList(),
               /* rows:[
                   DataRow(cells: [
                  DataCell(Text(data[0].countryName)),
                      DataCell(Text(data[0].totalCases),),
                      DataCell(Text(data[0].newCases),),
                       DataCell(Text(data[0].activeCases),),
                        DataCell(Text(data[0].totalDeaths),),
                         DataCell(Text(data[0].newDeaths),),
                          DataCell(Text(data[0].totalRecovered),),
                          DataCell(Text(data[0].seriousCritical)),
                ]),]*/
              
                );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
