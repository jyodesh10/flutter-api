import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intern/comments.dart';
import 'package:intern/constants/Strings.dart';
import 'package:intern/home.dart';
import 'package:intern/users.dart';
import 'package:page_transition/page_transition.dart';

class postComment extends StatefulWidget {
  const postComment({Key? key}) : super(key: key);

  @override
  _postCommentState createState() => _postCommentState();
}

class _postCommentState extends State<postComment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  TextEditingController bodyController = new TextEditingController();

  String name = "";
  String email = "";
  String body = "";
  String postid = "";
  String id = "";

  void _setText() {
    setState(() {
      name = nameController.text;
      email = emailController.text;
      body = bodyController.text;
    });
  }

  void postData() async {
    try {
      final response = await post(
          Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"),
          body: {
            "name": nameController.text,
            "email": emailController.text,
            "body": bodyController.text,
            "postId": "1",
            "id": id
          });
      print(response.body);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          title: Text("Add new comment")),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: bodyController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(labelText: 'Body'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Body';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            postData();
                            _setText();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully Submitted')),
                            );
                          } else {
                            print("error submission");
                          }
                        },
                        child: Text("Submit")),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(120, 50, 120, 50),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Name : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Email : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Body : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: body,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'ID : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: id,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Post nameID : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: postid,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
