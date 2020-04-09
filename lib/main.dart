import 'package:flutter/material.dart';
import 'api.dart';
import 'template.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Corona Updates",
      home: Covid()));
}

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  var totalData;
  var nepalData;

  Future<Null> refreshList() async {
    await new Future.delayed(Duration(seconds: 2));
    setState(() {
      totalData = fetchTotalData();
      nepalData = fetchNepalData();
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    totalData = fetchTotalData();
    nepalData = fetchNepalData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.yellow[50],
        appBar: AppBar(
          title: Text("Covid Updates"),
          backgroundColor: Colors.lightGreen,
        ),
        body: RefreshIndicator(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                  padding: const EdgeInsets.only(bottom: 7.0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: textSection("COVID-19 CORONAVIRUS PANDEMIC",
                      Colors.black38, 20, 10, false),
                ),
                textSection("Total Cases:", Colors.blueGrey, 25, 35.0, false),
                future(totalData, 1, 35),
                textSection("Deaths:", Colors.black, 25, 20.0, false),
                future(totalData, 2, 35),
                textSection("Recovered:", Colors.black54, 25, 20.0, false),
                future(totalData, 3, 35),
                Container(
                  margin: EdgeInsets.only(top: height / 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/nepalFlag.png")),
                      textSection("Nepal", Colors.black87, 35, 0.0, false)
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        colCont(
                            textSection(
                                "Total Cases", Colors.black54, 20, 17.0, false),
                            future(nepalData, 1, 20)),
                        colCont(
                            textSection(
                                "Deaths", Colors.blueGrey, 20, 20.0, false),
                            future(nepalData, 2, 20)),
                        colCont(
                            textSection(
                                "Recovered", Colors.black54, 20, 20.0, false),
                            future(nepalData, 3, 20))
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                      child: OutlineButton(
                    child: Text("View by Country"),
                    onPressed: () {},
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.green),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(top:5.0),
                  child:FutureBuilder<dynamic>(
                    future:totalData,
                    builder: (context,snapshots){
                      if(snapshots.hasData ){
                        return Text("Data taken at "+"${snapshots.data.timeStamp}"+" GMT+0");
                      }else{
                        return Column(children: <Widget>[
                          CircularProgressIndicator()
                        ],);
                      }
                    },
                  )
                )
              ],
            ),
            onRefresh: refreshList));
  }
}

/*
FutureBuilder<Data>(
        future: data,
        builder: (context,snapshots){
          if(snapshots.hasData){
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
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
                rows: [
                  DataRow(cells: [
                    DataCell(Text(" ${snapshots.data.countryName}")),
                     DataCell(Text(" ${snapshots.data.totalCases}"),),
                      DataCell(Text("  ${snapshots.data.newCases}"),),
                       DataCell(Text(" ${snapshots.data.activeCases}"),),
                        DataCell(Text("  ${snapshots.data.totalDeaths}"),),
                         DataCell(Text(" ${snapshots.data.newDeaths}"),),
                          DataCell(Text(" ${snapshots.data.totalRecovered}"),),
                          DataCell(Text("${snapshots.data.seriousCritical}")),
                        
                  ])
                ],
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      )
 */
