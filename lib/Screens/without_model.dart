// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutApiModel extends StatefulWidget {
  const WithoutApiModel({super.key});

  @override
  State<WithoutApiModel> createState() => _WithoutApiModelState();
}

class _WithoutApiModelState extends State<WithoutApiModel> {
  var data;
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print("object");
      print(data);
    } else {
      print("text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Without Api Model"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Sr-no: ${data[index]['id']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  ReuseableRow(
                                      icons: const Icon(
                                        Icons.person_3_outlined,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      title: "Username:",
                                      value:
                                          data[index]['username'].toString()),
                                  ReuseableRow(
                                      icons: const Icon(
                                        Icons.mail_outline,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      title: "Email:",
                                      value: data[index]['email'].toString()),
                                  ReuseableRow(
                                      icons: const Icon(
                                        Icons.email_outlined,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      title: "Address:",
                                      value: data[index]['address']['city']
                                          .toString()),
                                  ReuseableRow(
                                      icons: const Icon(
                                        Icons.location_on_outlined,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      title: "Phone no:",
                                      value: data[index]['phone'].toString()),
                                  ReuseableRow(
                                      icons: const Icon(
                                        Icons.phone_android_outlined,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      title: "Compnay Name:",
                                      value: data[index]['company']['name']
                                          .toString()),
                                ]),
                              );
                            }),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  Icon icons;
  String title, value;
  ReuseableRow(
      {super.key,
      required this.icons,
      required this.title,
      required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icons,
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
