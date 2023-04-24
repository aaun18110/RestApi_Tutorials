import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_1/Models/UserModels.dart';
import 'package:http/http.dart' as http;

class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  TextEditingController searchController = TextEditingController();
  String search = '';
  List<UserApiModel> userModel = [];
  Future<List<UserApiModel>> getUserData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userModel.add(UserApiModel.fromJson(i));
      }
      return userModel;
    } else {
      return userModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User Api Model"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (val) {
                search = val;
                setState(() {});
              },
              decoration: const InputDecoration(
                  hintText: "search here ...",
                  suffixIcon: Icon(
                    Icons.search,
                    size: 25,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final position =
                                snapshot.data![index].id.toString();
                            final position2 =
                                snapshot.data![index].name.toString();
                            if (searchController.text.isEmpty) {
                              return Card(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Roll no: ${snapshot.data![index].id}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    ReuseableRow(
                                        title: "Name:",
                                        value: snapshot.data![index].name
                                            .toString(),
                                        icons:
                                            const Icon(Icons.person_2_rounded)),
                                    ReuseableRow(
                                        title: "GMail:",
                                        value: snapshot.data![index].email
                                            .toString(),
                                        icons: const Icon(Icons.mail)),
                                    ReuseableRow(
                                        title: "Address:",
                                        value: snapshot
                                            .data![index].address!.city
                                            .toString(),
                                        icons: const Icon(
                                            Icons.location_on_outlined)),
                                    ReuseableRow(
                                        title: "Phone no:",
                                        value: snapshot.data![index].phone
                                            .toString(),
                                        icons: const Icon(
                                            Icons.phone_android_outlined)),
                                    ReuseableRow(
                                        title: "Company Name:",
                                        value: snapshot
                                            .data![index].company!.name
                                            .toString(),
                                        icons: const Icon(
                                            Icons.business_center_outlined))
                                  ],
                                ),
                              );
                            } else if (position.toLowerCase().contains(
                                    searchController.text.toString()) ||
                                position2.toLowerCase().contains(
                                    searchController.text.toString())) {
                              return Card(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      color: Colors.amber,
                                      child: Text(
                                        "Roll no: ${snapshot.data![index].id}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.amber,
                                      child: ReuseableRow(
                                          title: "Name:",
                                          value: snapshot.data![index].name
                                              .toString(),
                                          icons: const Icon(
                                              Icons.person_2_rounded)),
                                    ),
                                    ReuseableRow(
                                        title: "GMail:",
                                        value: snapshot.data![index].email
                                            .toString(),
                                        icons: const Icon(Icons.mail)),
                                    ReuseableRow(
                                        title: "Address:",
                                        value: snapshot
                                            .data![index].address!.city
                                            .toString(),
                                        icons: const Icon(
                                            Icons.location_on_outlined)),
                                    ReuseableRow(
                                        title: "Phone no:",
                                        value: snapshot.data![index].phone
                                            .toString(),
                                        icons: const Icon(
                                            Icons.phone_android_outlined)),
                                    ReuseableRow(
                                        title: "Company Name:",
                                        value: snapshot
                                            .data![index].company!.name
                                            .toString(),
                                        icons: const Icon(
                                            Icons.business_center_outlined))
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  Icon icons;
  ReuseableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.icons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icons,
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
