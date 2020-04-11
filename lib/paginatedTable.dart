import 'package:flutter/material.dart';
import 'template.dart';
import 'api.dart';

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

class PDataTable extends StatelessWidget{
  final List<Data> data;
  final Color color;
  PDataTable(this.data,this.color);
 
  @override
  Widget build(BuildContext context){
    return  PaginatedDataTable(
                      rowsPerPage: 10,
                      columnSpacing: 10,
                      dataRowHeight: 46,
                      header: Text("Current Pandemic Counts",style: TextStyle(color: color),),
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
                    );
  }
}