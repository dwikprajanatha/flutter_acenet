import 'dart:convert';

import 'package:acenet_project/model/CustomerModel.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  //baseURL
  static String baseURL = "http://192.168.1.144/api/";

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
}
