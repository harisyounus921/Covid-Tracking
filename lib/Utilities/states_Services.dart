import 'dart:convert';
import 'package:covid_19_tracker_app/Utilities/apiURL.dart';
import 'package:http/http.dart' as http;

import '../Models/WorldStatesModel.dart';

class StateServices{

  Future<WorldStatesModel> fetchWorkedStateRecoreds()async{
    final response=await http.get(Uri.parse(AppURL.worldStateApi));
    if(response.statusCode==200){
       return WorldStatesModel.fromJson(jsonDecode(response.body));
    }
    else{
        throw Exception("Error");
    }
  }

  Future<List<dynamic>> ContriesListApi()async{
    final response=await http.get(Uri.parse(AppURL.contriesList));
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Error");
    }
  }
}