import 'package:flutter/material.dart';

String _userUrl = "";

class SettingsPage extends StatefulWidget
{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() {
   return SettingsPageState(); 
  }
}

class SettingsPageState extends State<SettingsPage> 
{
  //vérifie si l'utilisateur n'avait pas encore saisi d'url , alors l'url par défaut est dans le formulaire sinon l'url de 
  //l'utilisateur est mis dans le formulaire
  final _urlController =  _userUrl.isEmpty ? TextEditingController(text: "http://192.168.") : TextEditingController(text: _userUrl);
  final _formField =  GlobalKey<FormState>();
  final _response = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramétrage"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formField,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Réglage de la connexion",style: TextStyle(fontSize: 23),)
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: "Url du serveur",
                  border: OutlineInputBorder()
                ),
                validator: (value)
                {
                  if(value!.isEmpty)
                  {
                    return "L'url ne peut pas être vide";
                  }
                  else if(!value.startsWith("http://192.168."))//vérifie que l'url commmence bien par http://192.168. .
                  {
                    _urlController.text = "http://192.168.";
                    return "L'url doit forcément commencé par : http://192.168.";
                  }
                  else if(value == "http://192.168.")
                  {
                    return "Url Invalid";
                  }
                  else if(value.length >= 23)
                  {
                    return "Url incorrect. Trop long !";
                  }
                  else 
                  {
                    String Url_end = value.substring(15,value.length);// extrait la chaine qui se trouve après : http://192.168. et la stocke dans Url_end
                    List<String> parts = Url_end.split('.'); // déparatage la chaine en parties séparé par '.' ex : 343.23 retourne 343 et 23
                    if(parts.length <= 1)
                    {
                      return "Url incorrect. Manque de '.'";
                    }
                    else if(!RegExp(r'^[0-9]+$').hasMatch(parts[0]) || !RegExp(r'^[0-9]+$').hasMatch(parts[1])) // verifie si ex : 453.343 , 453 est un nombre et 343 est un nombre.
                    {
                      return "Utilisez des nombres uniquement";
                    }
                    else
                    {
                      return null;
                    }
                  }
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  if(_formField.currentState!.validate())
                  {
                    //on mémoire l'url de l'utilisateur pour un prochain usage
                    _userUrl = _urlController.text;
                    Navigator.pop(context,
                    {
                      'url':_urlController.text
                    });
                  }
                }, 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: Text("Valider",style: TextStyle(color: Colors.white),)
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Réponse du serveur : $_response",style: TextStyle(fontSize: 23),)
              ),
            ],
          )
        )
      ),
    );
  }
}