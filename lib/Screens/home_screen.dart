// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/ApiModels.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostApiModel> postList = [];
  Future<List<PostApiModel>> getData() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      // postList.clear();
      for (Map<String, dynamic> i in data) {
        postList.add(PostApiModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    // final postProvider = Provider.of<PostApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    print("Future Builder");
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          print("ListView Builder");
                          return Card(
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      postList[index].thumbnailUrl.toString()),
                                ),
                                trailing:
                                    Text(postList[index].albumId.toString()),
                                title: Text(
                                    "id : ${postList[index].id.toString()}"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Title :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      postList[index].title.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                )),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
