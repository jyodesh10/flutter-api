import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intern/entities/details.dart';
import 'package:intern/constants/Strings.dart';
import 'package:intern/entities/posts.dart';
import 'package:intern/entities/post_comment.dart';
import 'package:intern/home.dart';
import 'package:intern/users.dart';
import 'package:page_transition/page_transition.dart';

// var _posts = [];

// Future<Posts> fetchPosts() async {
//   try {
//     final response = await http.get(Uri.parse(Strings.posturl));
//     final jsonresponse = json.decode(response.body) as List;

//     setState(() {
//       _posts = jsonresponse;
//     });
//   } catch (e) {}

// if (response.statusCode == 200) {
//   return Posts.fromJson(jsonresponse[5]);
// } else {
//   throw Exception('Failed to load album');
// }
// }

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var _comments = [];

  void fetchPosts() async {
    final response = await http.get(Uri.parse(Strings.commenturl));
    final jsonresponse = jsonDecode(response.body) as List;

    setState(() {
      _comments = jsonresponse;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
              onTap: () {},
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
          //   alignment: Alignment.center,
          //   icon: Icon(Icons.post_add, color: Colors.white),
          //   onPressed: null,
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
          title: Text("COMMENTS")),
      body:
          //  Card(
          //   child: FutureBuilder<Posts>(
          //       future: futurePosts,
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           return Padding(
          //             padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   snapshot.data!.title,
          //                   style: TextStyle(
          //                       fontSize: 30, fontWeight: FontWeight.bold),
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 Text(snapshot.data!.body,
          //                     style:
          //                         TextStyle(fontSize: 15, color: Colors.blueGrey))
          //               ],
          //             ),
          //           );
          //         } else if (snapshot.hasError) {
          //           return Text('${snapshot.error}');
          //         }
          //         return const CircularProgressIndicator();
          //       }),
          // )
          ListView.builder(
        itemBuilder: (context, index) {
          final post = _comments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                            name: " ${post["name"]}",
                            email: "${post["email"]}",
                            body: "${post["body"]}"))),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${post["id"]}. ${post["name"]}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${post["email"]}",
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${post["body"]}",
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: _comments.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: postComment(), type: PageTransitionType.bottomToTop));
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }
}
