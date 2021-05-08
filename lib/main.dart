import 'package:basic_http/controller.dart';
import 'package:basic_http/result_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Lepas Provider ini jika pake PostPage()
      home: BlocProvider(create: (BuildContext context) => ProductListBloc(),
          child: Scaffold(body: BlocPage())
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ProductList productList;
  String manipulasiPref;
  TextEditingController emailController = TextEditingController();

  _PostPageState(){
    panggilGetPref();
  }

  void postProcess() {
    ProductController.postData(emailController.text).then((value) {
      productList = value;
      setState(() {});

      //Nebeng Bloc (Gak ada hubungan)
    });
  }

  void getProcess() {
    ProductController.getData().then((value) {
      productList = value;
      setState(() {});
    });

    // Nebeng SharedPref (Gak ada hubungan sama http
    setDataPref();
    panggilGetPref();
  }

  // ----------------------- Shared Preferences (Tidak ada hubungan dengan http), manggilnya di contructor utk coba2

  void setDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("name", "Joni Sharing");
  }

  Future<String> getNamePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name") ?? "No Name";
  }

  void panggilGetPref(){
    getNamePref().then((value) {
      manipulasiPref = value;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.teal),
              border: InputBorder.none,
              labelText: "Email",
            ),
          ),
        ),

        ElevatedButton(
          onPressed: postProcess,
          child: Text("Post"),
        ),

        ElevatedButton(
          onPressed: getProcess,
          child: Text("Get"),
        ),

        Text((productList != null) ? productList.name : "No Data"),
        Text("Pref Data: " + manipulasiPref),

        Container(
          margin: EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 350,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: productList?.product?.length ?? 0,
              padding: EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Text(productList.product[index].title),
                      Text(productList.product[index].desc)
                    ],
                  ),
                );
              },
            ),
          ),
        ),

      ],
    );
  }
}

class BlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void postBloc(){
      context.read<ProductListBloc>().add("Poco");
    }

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: postBloc,
            child: Text("Bloc"),
          ),

          BlocBuilder<ProductListBloc, ProductList>(
              builder: (context, productList) => Text((productList is ProductListKosong) ? "No Bloc Data" : productList.name)
          ),
        ],
      ),
    );

  }
}


// Petunjuk
// 1. Model buat di quicktype
// 2. Buat Controller
// 3. Main.dart akses controller di method postProcess() dan getProcess()

// Shared Pref : Buat setDataPref(), manggilnya harus pake future method getNamePref(), tampilkan di manipulasiPref


// Bloc :
// Ada di bloc_controller, mengakses controller, mengubah nilai Text di main (Bungkus provider dan builder).
// Satu bloc satu model