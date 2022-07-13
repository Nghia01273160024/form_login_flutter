import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 String? action;
Future<void> getData () async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    action = prefs.getString('user');
  });
  if(action == null){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp())
    );
  }
}
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('action');
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            deleteData();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Xin chào $action',
          style: TextStyle(
            fontSize: 24,
          ),
          ),
        ),
      ),
    );
  }
}

