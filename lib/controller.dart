import 'package:http/http.dart' as http;
import 'package:basic_http/result_model.dart';
import 'dart:developer' as developer;

class ProductController
{
  static Future<ProductList> postData(String name) async {
    var url = Uri.parse("http://192.168.43.244/project/myproject/apitester/get.php");
    var response = await http.post(url, body:{"name": name});

    if(response.statusCode == 200){
      print(response.body);
      return productListFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<ProductList> getData() async {
    var url = Uri.parse("http://192.168.43.244/project/myproject/apitester/get.php");
    var response = await http.get(url);

    if(response.statusCode == 200){
      print(response.body);
      return productListFromJson(response.body);
    } else {
      return null;
    }
  }
}