import 'package:flutter/material.dart';
import 'api.dart';
import 'template.dart';

class Country extends StatefulWidget {
  final dataList;
  Country(this.dataList);
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var data;
  var forSearch;
  var _searchHandler=TextEditingController();
  Widget _appBarTitle=Text("Covid Updates");
  Icon _actionIcon=Icon(Icons.search);

  Future<Null> refreshList() async{
     await new Future.delayed(Duration(seconds:2));
    setState(() {
       data=fetchData();
    });
  }
  void _searchButtonPressed(){
    if(this._actionIcon.icon==Icons.search){
      setState(() {
        _appBarTitle=Container(
          height: 35,
          width: 220,
          child: TextField(
            controller: _searchHandler,
            style: TextStyle(color: Colors.black54),
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.white38),
               borderRadius: BorderRadius.circular(20)
              ),
              prefixIcon: Icon(Icons.search),
              prefixStyle: TextStyle(color: Colors.grey)
            ),
          ),
        );
        _actionIcon=Icon(Icons.close);
      });
    }else{
      setState(() {
        _appBarTitle=Text("Covid Updates");
        _actionIcon=Icon(Icons.search);
        _searchHandler.clear();
      });
    }
  }

  _CountryState(){
    _searchHandler.addListener(
      (){List<Data> tempList=[];
        if(_searchHandler.text.isNotEmpty){
          var _searchedText=_searchHandler.text;
          for (var i = 0; i < data.length; i++) {
            if(forSearch[i].countryName.toLowerCase().contains(_searchedText.toLowerCase())){
              tempList.add(forSearch[i]);
            }
          }
          setState(() {
            data=tempList;
          });}   
        else{
          setState(() {
            tempList=forSearch;
          data=tempList;
          });
        }
      }
    );
  }

  @override
  void initState() {
    super.initState();
    data = widget.dataList;
    forSearch=widget.dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: _actionIcon,
            onPressed: (){
              _searchButtonPressed();
            },
          )
        ],
      ),
      body: RefreshIndicator(
          onRefresh: refreshList,
              child: ListView(
          children: <Widget>[
                PaginatedDataTable(
                      rowsPerPage: 10,
                      columnSpacing: 10,
                      dataRowHeight: 46,
                      header: Text("Current Pandemic Counts",style: TextStyle(color: Colors.green),),
                      columns: [
                        DataColumn(label: Text("Country Name", style: col)),
                        DataColumn(label: Text("Total cases", style: col)),
                        DataColumn(label: Text("New cases", style: col)),
                        DataColumn(label: Text("Active cases", style: col)),
                        DataColumn(label: Text("Total Deaths", style: col)),
                        DataColumn(label: Text("New Deaths", style: col)),
                        DataColumn(label: Text("Total Recovered", style: col)),
                        DataColumn(label: Text("Serious/Critical", style: col)),
                      ],
                      source: DataSource(data),
                    )
          ],
        ),
      ),
    );
  }
}
