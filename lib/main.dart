import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home esp8266 commande',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Home esp8266 commande'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Text("Commander la led",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
              Align(
              child: Switch(
                activeColor: Colors.red,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.black,
                value: _switchValue, 
                onChanged: (value){
                  setState(() {
                    _switchValue = value;
                     sendMessage('/ledon');
                  });},
                ),
              ),
          ]
        ),
      )
    );
  }
}

//Fonctions d'envoie
Future<void> sendMessage (String msg) async
{
  final dio = Dio();
  final url = "//";
  final _msg = msg;

  try
  {
    Response response = await dio.post(url,data: _msg);
    print("Reponse : ${response.data}");
    print("Hello esp8266");
  }
  catch(e)
  {
    print("Erreur : $e");
  }
}