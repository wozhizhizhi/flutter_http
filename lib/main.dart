import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'datas/user.dart';
void main() => runApp(new MaterialApp(home: new MyHomePage()));

//class MyApp
//{
//  // This widget is the root of your application.
//
//
//
//}


class MyHomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  User user;
  TextEditingController controller = new TextEditingController();

  void getUserInfo(String userName)
  {
    http.get("https://api.github.com/users/$userName").then((respsone)
    {
      setState(()
      {
        final responseJson = json.decode(respsone.body);
        user = new User.fromJson(responseJson);
        print(user.avatar_url);
      });
    }).catchError((error) {
      print(error.toString());
    }).whenComplete(() {
      print("请求完成");
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(appBar: new AppBar(title: new Text("网络请求")),
        body: new SingleChildScrollView(padding: const EdgeInsets.only(top: 10.0),
            child: new Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[new Container(child: new Image.network(
                    user != null
                        ? user.avatar_url
                        : "https://avatars1.githubusercontent.com/u/6630762?v=4") , width: 50.0 , height: 50.0),
                new ListTile(leading: new Icon(Icons.person),
                    title: new Text("name:" + (user != null && user.name != null
                        ? user.name
                        : "暂无"))),
                new ListTile(leading: new Icon(Icons.person),
                    title: new Text("location:" +
                        (user != null && user.location != null
                            ? user.location
                            : "暂无"))),
                new ListTile(leading: new Icon(Icons.person),
                    title: new Text("blog:" + (user != null && user.blog != null
                        ? user.blog
                        : "暂无"))),
                new ListTile(leading: new Icon(Icons.person),
                    title: new Text("avatar_url:" +
                        (user != null && user.avatar_url != null ? user
                            .avatar_url : "暂无"))),
                new ListTile(leading: new Icon(Icons.person),
                    title: new Text("html_url:" +
                        (user != null && user.html_url != null
                            ? user.html_url
                            : "暂无"))),
                new TextField(
                    decoration: InputDecoration(labelText: "请输入你的github名字"),
                    controller: controller),
                RaisedButton(
                  onPressed: () {
                    getUserInfo(controller.text.toString());
                  },
                  child: Text("Get请求"),
                  // ignore: expected_token
                )
                ])));
  }}