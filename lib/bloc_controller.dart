
import 'package:basic_http/controller.dart';
import 'package:basic_http/result_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc<Data Dikirim, Data Diterima>
class ProductListBloc extends Bloc<String, ProductList>{
  ProductListBloc() : super(ProductListKosong()); // ini yang gakboleh null

  @override
  Stream<ProductList> mapEventToState(String event) async* {
    ProductList productList = await ProductController.postData(event);
    yield productList;
    throw UnimplementedError();
  }

  // Future<ProductList> postBloc(String event) async {
  //   ProductList productList = await ProductController.postData(event);
  //   emit(productList);
  // }
}