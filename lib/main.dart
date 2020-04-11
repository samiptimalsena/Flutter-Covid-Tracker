import 'package:flutter/material.dart';
import 'api.dart';
import 'template.dart';
import 'countryView.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Corona Updates",
    initialRoute: '/',
    routes: {
      '/': (context) => Covid(),
      '/countryView': (context) =>
          Country(ModalRoute.of(context).settings.arguments),
    },
  ));
}

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  var totalData;
  var nepalData;
  var data;

  Future<Null> refreshList() async {
    await new Future.delayed(Duration(seconds: 2));
    setState(() {
      totalData = fetchTotalData();
      nepalData = fetchNepalData();
      getData().then((result){
        data=result;
      });
    });
    return null;
  }


  @override
  void initState() {
    super.initState();
    totalData = fetchTotalData();
    nepalData = fetchNepalData();
    getData().then((result) {
      setState(() {
        data=result;      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home),
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/countryView',
                          arguments: data);
                    },
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.green),
                  )),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: FutureBuilder<dynamic>(
                      future: totalData,
                      builder: (context, snapshots) {
                        if (snapshots.hasData) {
                          return Text("Data taken at " +
                              snapshots.data.timeStamp +
                              " GMT+0");
                        } else {
                          return Column(
                            children: <Widget>[CircularProgressIndicator()],
                          );
                        }
                      },
                    )),
              ],
            ),
            onRefresh: refreshList));
  }
}
