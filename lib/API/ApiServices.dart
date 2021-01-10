import 'dart:convert';

import 'package:acenet_project/model/CustomerModel.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/models/user.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  //baseURL
  static String baseURL = "http://phpstack-521315-1659119.cloudwaysapps.com/api/";

  SharedPreferences sp;

  var api = new http.Client();

  Future<CustomerModel> getCustomer(int idCustomer) async {
    //create URL
    var url = "${baseURL}/getCustomer/${idCustomer}";

    var response = await api.get(url);

    return CustomerModel.fromJson(json.decode(response.body));
  }

  Future<List<SpkDetail>> getSPK() async {
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

  Future<List<SpkDetail>> getUpcomingSPK() async {
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

  Future<JobDoneCount> getJobCounting() async {
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

  Future<SpkDetailResponse> getDetailSPK(int idSPK) async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");
    print(token);
    var url = "${baseURL}getDetailSPK?id_spk=${idSPK}";
    Map<String, String>  header = {
      "Authorization" : "Bearer ${token}"
    };
    print(header);
    var response = await api.get(url,
        headers: header);

    return SpkDetailResponse.fromJson(json.decode(response.body));
  }

  Future<LoginResponse> login(User user) async {

    var url = "${baseURL}login";

    var response = await api.post(url,
        body: {
          "username": user.username,
          "password": user.password,
        }
    );

    print(url);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      var data = LoginResponse.fromJson(jsonDecode(response.body));

      return data;
    }

    return null;

  }

  Future<SpkResponse> submitSPK(Map<String,dynamic> body) async {
    // Get user profile for id
    sp = await SharedPreferences.getInstance();
    String token = sp.get("API_KEY");

    var request = new http.MultipartRequest("POST",Uri.parse(baseURL+'post/submitSPK'));
    request.headers.addAll({ "Authorization": "Bearer ${token}"});

    print(Uri.parse('$baseURL/post/submitSPK'));
    var signCustomer =  http.MultipartFile.fromBytes(
      'signCustomer',
      body['signCustomer'],
      filename: "Customer.png",
    );

    var signTeknisi =   http.MultipartFile.fromBytes(
      'signTeknisi',
      body['signTeknisi'],
      filename: "Teknisi.png",
    );

    request.fields['id_spk'] = body['id_spk'].toString();
    request.fields['keterangan'] = body['keterangan'];
    if (body['upload_data'] != null)
      request.fields['upload_data'] = body['upload_data'];

    if (body['download_data'] != null)
      request.fields['download_data'] = body['download_data'];

    request.files.add(await signCustomer);
    request.files.add(await signTeknisi);

    var response = await request.send();
    String msg = await response.stream.bytesToString();
    print(msg);
    Clipboard.setData(new ClipboardData(text: msg));
    return SpkResponse.fromJson(json.decode(msg));

  }

  Future<List<SpkDetail>> getJobDone() async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");

    var url = "${baseURL}listJobDone?id_teknisi=${id_teknisi}";
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

  Future<User> getProfile() async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");

    var url = "${baseURL}getProfile";
    Map<String, String>  header = {
      "Authorization" : "Bearer ${token}"
    };
    print(header);
    var response = await api.get(url,
        headers: header);

    var jsonObject = json.decode(response.body);
    print(response.body);

    var body = LoginResponse.fromJson(jsonObject);
    return body.data;
  }


}
