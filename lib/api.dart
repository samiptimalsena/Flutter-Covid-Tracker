import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  String countryName;
  String totalCases;
  String newCases;
  String activeCases;
  String totalDeaths;
  String newDeaths;
  String totalRecovered;
  String seriousCritical;

  Data(
      {this.countryName,
      this.totalCases,
      this.newCases,
      this.activeCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecovered,
      this.seriousCritical});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      countryName: json["latest_stat_by_country"][0]["country_name"],
      totalCases: json["latest_stat_by_country"][0]["total_cases"]  ,
      newCases: json["latest_stat_by_country"][0]["new_cases"],
      activeCases: json["latest_stat_by_country"][0]["active_cases"],
      totalDeaths: json["latest_stat_by_country"][0]["total_deaths"],
      newDeaths: json["latest_stat_by_country"][0]["new_deaths"],
      totalRecovered: json["latest_stat_by_country"][0]["total_recovered"],
      seriousCritical: json["latest_stat_by_country"][0]["serious_critical"],
    );
  }

  factory Data.fromJson2(Map<String, dynamic> json) {
    return Data(
      countryName: json["country_name"],
      totalCases: json["cases"],
      newCases: json["new_cases"],
      activeCases: json["active_cases"],
      totalDeaths: json["deaths"],
      newDeaths: json["new_deaths"],
      totalRecovered: json["total_recovered"],
      seriousCritical: json["serious_critical"],
    );
  }
}

class TotalData {
  String totalCases;
  String totalDeaths;
  String totalRecovered;
  String newCases;
  String newDeaths;
  String timeStamp;

  TotalData(
      {this.totalCases,
      this.totalDeaths,
      this.totalRecovered,
      this.newCases,
      this.newDeaths,
      this.timeStamp});

  factory TotalData.fromJson(Map<String, dynamic> json) {
    return TotalData(
        totalCases: json["total_cases"],
        totalDeaths: json["total_deaths"],
        totalRecovered: json["total_recovered"],
        newCases: json["new_cases"],
        newDeaths: json["new_deaths"],
        timeStamp: json["statistic_taken_at"]);
  }
}

Future<Data> fetchNepalData() async {
  final response = await http.get("https://brp.com.np/covid/nepal.php");
  return Data.fromJson(json.decode(response.body));
}

Future<TotalData> fetchTotalData() async {
  final response = await http.get("https://brp.com.np/covid/alldata.php");
  return TotalData.fromJson(json.decode(response.body));
}

Future<List<Data>> fetchData() async {
  final response = await http.get("https://brp.com.np/covid/country.php");
  var getData = json.decode(response.body)['countries_stat'] as List;
  List<Data> dataList = getData.map((data) => Data.fromJson2(data)).toList();
  return dataList;
}

Future<List<Data>> getData() async {
    var result = await fetchData();
    result.removeWhere((item) => item.countryName == "");
    return result;
  }