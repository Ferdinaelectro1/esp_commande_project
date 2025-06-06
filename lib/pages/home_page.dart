import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String,dynamic> data = {
    "ledYellow" : false,
    "ledGreen": false, 
    "ledBlue" :false,
    "ledRed" :false
  };
  bool _yellowState = false; 
  bool _greenState = false; 
  bool _blueState = false;
  bool _redState = false;
  //int? _responseStatusCode = 404;
  String _response = "";
  String _url = "";
  bool _await = false;

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
                activeColor: Colors.yellow,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.yellow,
                value: _yellowState, 
                onChanged: (value){
                  if(_url.isEmpty == false){
                  data["ledYellow"] = value ? true : false ;
                  _yellowState = value;
                  }
                  sendCommande(context);
                 }
               ),
              ),
              SizedBox(height: 30,),
              Align(
              child: Switch(
                activeColor: Colors.green,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.green,
                value: _greenState, 
                onChanged: (value){
                  if(_url.isEmpty == false){
                  data["ledGreen"] = value ? true : false;
                  _greenState = value;
                  }
                  sendCommande(context);
                 }
               ),
              ),
              SizedBox(height: 30,),
              Align(
              child: Switch(
                activeColor: Colors.red,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.red,
                value: _redState, 
                onChanged: (value){
                  if(_url.isEmpty == false){
                  data["ledRed"] = value ? true : false;
                  _redState = value;
                  }
                  sendCommande(context);
                 }
               ),
              ),
              SizedBox(height: 30,),
              Align(
              child: Switch(
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.blue,
                value: _blueState, 
                onChanged: (value){
                  if(_url.isEmpty == false){
                  data["ledBlue"] = value ? true : false;
                  _blueState = value;
                  }
                  sendCommande(context);
                 }
               ),
              ),
              SizedBox(height: 30,),
              Icon((_response == "ON") ? Icons.lightbulb : Icons.light_outlined),
              SizedBox(height: 30,),
              _await ? CircularProgressIndicator() : Text(""),
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

  //Fonctions d'envoie d'une commande
  void sendCommande(BuildContext context)
  { 
    if(_url.isEmpty == false)
    {
      setState(() {
        sendMessage(context);
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
  }

  //Fonctions d'envoie
  Future<void> sendMessage (BuildContext context) async
  {
    if(_url.isEmpty == false)
    {
      final url = "$_url/data";
      final dio = Dio();
      setState(() {
        _await = true;
      });
      try
      {
        //Response response = await dio.get(url);
        Response response = await dio.post(url,data: data);
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
      finally
      {
        setState(() {
          _await = false;
        });
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
