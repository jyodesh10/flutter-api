import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intern/comments.dart';
import 'package:intern/users.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/Strings.dart';
import '../home.dart';

class Details extends StatefulWidget {
  final String name;
  final String email;
  final String body;

  Details({required this.name, required this.email, required this.body});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var _posts = [];

  void fetchPosts() async {
    final response = await http.get(Uri.parse(Strings.commenturl));
    final jsonresponse = jsonDecode(response.body) as List;

    setState(() {
      _posts = jsonresponse;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text('Menu',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
            ListTile(
              title: const Text('Posts',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Home(), type: PageTransitionType.fade));
              },
            ),
            ListTile(
              title: const Text('Comments',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Comments(), type: PageTransitionType.fade));
              },
            ),
            ListTile(
              title: const Text('Users',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Users(), type: PageTransitionType.fade));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          elevation: 10.0,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //         context,
          //         PageTransition(
          //             child: Home(), type: PageTransitionType.leftToRight));
          //   },
          // ),
          backgroundColor: Colors.blueGrey,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF2979FF),
                    const Color(0xffee0000),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: Text("DETAILS")),
      body: Container(
          margin: const EdgeInsets.fromLTRB(10, 200, 10, 200),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              // boxShadow: [
              //   new BoxShadow(
              //     color: Colors.black54,
              //     blurRadius: 10.0,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "" + widget.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text("" + widget.email),
                    Text("" + widget.body)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
