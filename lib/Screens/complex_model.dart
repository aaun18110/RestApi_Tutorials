// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/ComplexApiModel.dart';

class ComplexModel extends StatefulWidget {
  const ComplexModel({super.key});

  @override
  State<ComplexModel> createState() => _ComplexModelState();
}

class _ComplexModelState extends State<ComplexModel> {
  Future<ComplexApiModel> fetchData() async {
    print("object");
    final response = await http.get(
        Uri.parse("https://webhook.site/d015501a-0cdc-4cda-ac24-fb1529e2b4e8"));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      return ComplexApiModel.fromJson(data);
    } else {
      return ComplexApiModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex REST API Model"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder<ComplexApiModel>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.data![index].shop!.image!
                                          .toString()),
                                    ),
                                    title: Text(snapshot
                                        .data!.data![index].shop!.name
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.data![index].shop!.shopemail
                                        .toString()),
                                    trailing: Text(snapshot
                                        .data!.data![index].shop!.shopaddress
                                        .toString()),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    decoration: const BoxDecoration(),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot
                                            .data!.data![index].images!.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        snapshot
                                                            .data!
                                                            .data![index]
                                                            .images![position]
                                                            .url
                                                            .toString(),
                                                      ))),
                                            ),
                                          );
                                        }),
                                  ),
                                  Icon(snapshot.data!.data![index].inWishlist
                                              .toString() ==
                                          false
                                      ? Icons.favorite_outline
                                      : Icons.favorite_outline),
                                ],
                              );
                            });
                      }
                    }),
              )
            ]),
      ),
    );
  }
}
