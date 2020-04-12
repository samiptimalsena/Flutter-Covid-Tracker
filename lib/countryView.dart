import 'package:flutter/material.dart';
import 'paginatedTable.dart';
import 'api.dart';

class Country extends StatefulWidget {
  final dataList;
  Country(this.dataList);
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var data;

  Future<Null> refreshList() async{
    await new Future.delayed(Duration(seconds: 2));
    getData().then((result){
      setState(() {
        data=result;
      });
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    data = widget.dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Updates"),
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(data));
            },
          )
        ],
      ),
      body: RefreshIndicator(
              onRefresh: refreshList,
              child: ListView(
          children: <Widget>[PDataTable(data, Colors.green)],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<List<Data>> {
  List<Data> data;
  DataSearch(this.data);
  var suggestionList;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.white,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(children:[PDataTable(suggestionList,Colors.green)]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     suggestionList = query.isEmpty
        ? data
        : data
            .where((item) =>
                item.countryName.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView(
      children: <Widget>[PDataTable(suggestionList, Colors.green)],
    );
  }
}
