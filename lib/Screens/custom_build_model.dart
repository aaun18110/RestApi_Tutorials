// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomBuildModel extends StatefulWidget {
  const CustomBuildModel({super.key});

  @override
  State<CustomBuildModel> createState() => _CustomBuildModelState();
}

class _CustomBuildModelState extends State<CustomBuildModel> {
  List<ApiModel> listModel = [];
  Future<List<ApiModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var data = jsonDecode(response.body.toString());
    print("data");
    if (response.statusCode == 200) {
      for (Map i in data) {
        // print(data);
        ApiModel custom =
            ApiModel(id: i["id"], title: i["title"], completed: i["completed"]);
        listModel.add(custom);
      }
      return listModel;
    } else {
      return listModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Custom Build Model With REST API"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: fetchData(),
                builder: (context, AsyncSnapshot<List<ApiModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: listModel.length,
                        itemBuilder: (context, index) {
                          print("ListView");
                          return ListTile(
                              leading: Icon(
                                snapshot.data![index].completed == true
                                    ? Icons.check_box
                                    : Icons.error_outline,
                                size: 25,
                                color: Colors.teal,
                              ),
                              title: Text(
                                "id : ${snapshot.data![index].id}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              subtitle: Text(
                                "Title : ${snapshot.data![index].title}",
                                style: const TextStyle(color: Colors.orange),
                              ),
                              trailing: Text(
                                snapshot.data![index].completed.toString(),
                                style: const TextStyle(color: Colors.green),
                              ));
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ApiModel {
  int id;
  String title;
  bool completed;
  ApiModel({required this.id, required this.title, required this.completed});
}
