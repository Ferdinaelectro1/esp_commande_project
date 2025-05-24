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
                    if(_switchValue)
                    {
                      sendMessage("onled");
                    }
                    else
                    {
                      sendMessage("offled");
                    }
                  });},
                ),
              ),
              Icon(_switchValue ? Icons.lightbulb : Icons.light_outlined)
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
  final url = "http://192.168.177.221/$msg";

  try
  {
    Response response = await dio.get(url);
    print("Reponse : ${response.data}");

  }
  catch(e)
  {
    print("Erreur de  communication: $e");
  }
}