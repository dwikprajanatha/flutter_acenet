import 'dart:convert';

import 'package:acenet_project/model/CustomerModel.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  //baseURL
  static String baseURL = "http://phpstack-346672-1621496.cloudwaysapps.com/api/";

  SharedPreferences sp;

  var api = new http.Client();

  Future<CustomerModel> getCustomer(int idCustomer) async {
    //create URL
    var url = "${baseURL}/getCustomer/${idCustomer}";

    var response = await api.get(url);

    return CustomerModel.fromJson(json.decode(response.body));
  }

  Future<List<SPKModel>> getSPK(int idTeknisi) async {
    var url = "${baseURL}getSPK?id_teknisi=${idTeknisi}";

    print(url);

    var response = await api.get(url);

    var jsonObject = json.decode(response.body);

    List<dynamic> listSPK = jsonObject;

    List<SPKModel> spk = [];
    listSPK.forEach((element) {
      spk.add(SPKModel.fromJSON(element));
    });

    return spk;
  }

  Future<SPKModel> getDetailSPK(int idSPK) async {
    var url = "${baseURL}getDetailSPK?id_spk=${idSPK}";

    print(url);

    var response = await api.get(url);

    return SPKModel.fromJSON(jsonDecode(response.body));
  }

  Future<LoginResponse> login(User user) async {

    var url = "${baseURL}login";

    var response = await api.post(url,
        body: {
          "username": user.username,
          "password": user.password,
        }
    );

    if(response.statusCode == 200) {
      var data = LoginResponse.fromJson(jsonDecode(response.body));

      return data;
    }

    return null;

  }


}
