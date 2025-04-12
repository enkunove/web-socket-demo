import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:webSocketProject/view_model/home_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeModel model;

  @override
  void initState() {
    super.initState();
    model = GetIt.I<HomeModel>();
    model.connect();
  }
  @override
  void dispose() {
    model.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widget1(),
          ],
        ),
      ),
    );
  }

  Widget Widget1() {
    return StreamBuilder(
      stream: model.dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.all(10),
            color: Colors.amberAccent,
            child: Text("Loading..."),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            color: Colors.amberAccent,
            child: Text(snapshot.data.toString()),
          );
        }
      },
    );
  }

}
