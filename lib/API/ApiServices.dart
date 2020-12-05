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

  Future<List<SpkDetail>> getSPK(int idTeknisi) async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");

    var url = "${baseURL}getSPK?id_teknisi=${id_teknisi}";
    Map<String, String>  header = {
      "Authorization" : "Bearer ${token}"
    };
    print(header);
    var response = await api.get(url,
        headers: header);

    var jsonObject = json.decode(response.body);
    print(response.body);

    var body = SpkResponse.fromJson(jsonObject);
    return body.data;
  }

  Future<List<SpkDetail>> getUpcomingSPK(int idTeknisi) async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");

    var url = "${baseURL}getUpcomingSPK?id_teknisi=${id_teknisi}";
    Map<String, String>  header = {
      "Authorization" : "Bearer ${token}"
    };
    print(header);
    var response = await api.get(url,
        headers: header);
    var jsonObject = json.decode(response.body);
    print(response.body);

    var body = SpkResponse.fromJson(jsonObject);
    return body.data;
  }

  Future<JobDoneCount> getJobCounting(int idTeknisi) async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");

    var url = "${baseURL}jobCount?id_teknisi=${id_teknisi}";
    Map<String, String>  header = {
      "Authorization" : "Bearer ${token}"
    };
    print(header);
    var response = await api.get(url,
        headers: header);
    var jsonObject = json.decode(response.body);
    print(response.body);

    var body = JobDoneResponse.fromJson(jsonObject);
    return body.data;
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
