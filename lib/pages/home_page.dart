import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switchValue = false;
  //int? _responseStatusCode = 404;
  String _response = "";
  String _url = "";

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
                inactiveThumbColor: Colors.green,
                value: _switchValue, 
                onChanged: (value){
                  
                    if(_url.isEmpty == false)
                    {
                      setState(() {
                        _switchValue = value;
                        if(_switchValue)
                        {
                          sendMessage(context,"onled");
                        }
                        else
                        {
                          sendMessage(context,"offled");
                        }
                      });
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Vous devez renseigner l'url du serveur d'abord !"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                 },
                ),
              ),
              Icon((_response == "ON") ? Icons.lightbulb : Icons.light_outlined)
          ]
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
              child: const Text("Menu",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            ListTile(
              title:  Text("Paramétrage"),
              leading: Icon(Icons.settings),
              onTap: (){
                getUrl(context);
              },
            ),
            ListTile(
              title:  Text("À propos"),
              leading: Icon(Icons.info),
              onTap: (){
                Navigator.pushNamed(
                  context, 
                  '/info_page'
                );
              },
            )
          ],
        ),
      ),
    );
  }

  //Fonctions d'envoie
  Future<void> sendMessage (BuildContext context, String msg) async
  {
    if(_url.isEmpty == false)
    {
      final url = "$_url/$msg";
      final dio = Dio();
      try
      {
        Response response = await dio.get(url);
        _response = response.toString();
       // _responseStatusCode = response.statusCode;

      }
      catch(e)
      {
        if(mounted)//vérifie si on est toujours dans le homepage avant d'afficher le message
        {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de la communication avec le serveur"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          )
        );
        }
      }
    }
  }

  Future<void> getUrl(BuildContext context) async
  {
    final result = await Navigator.pushNamed(
      context,
      '/settings_page'
    );
    if(result != null && result is Map<String,dynamic>)
    {
      setState(() {
        _url = result['url'];
       // print("$_url");
      });
    }
  }
}
