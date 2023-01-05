import 'dart:convert';

import 'package:covid19app/Servics/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../Model/World_State_Model.dart';

class StateServices {
  Future<WorldStateModel> fetchTheList()async {
    Response response = await http.get(Uri.parse(AppUrls.worldStateApi));
    if(response.statusCode==200){
      var data =  jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception('Error this time'
          );

    }
  }
  Future<List<dynamic>> fetchCountry()async {
    var data;
    Response response = await http.get(Uri.parse(AppUrls.countriesList));
    if(response.statusCode==200){
       data =  jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error this time'
      );

    }
  }
}
