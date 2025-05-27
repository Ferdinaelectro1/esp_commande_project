import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget
{
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() {
   return InfoPageState(); 
  }
}

class InfoPageState extends State<InfoPage> 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("À propos"),
      ),
      body: Center(
        child: Text("Cette application a été developpé par Ferdinaelectro"),
      ),
    );
  }
}