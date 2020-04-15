import 'package:flutter/material.dart';


class PoliciesScreen extends StatefulWidget {
  @override
  _PoliciesScreenState createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Policies'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            children: <Widget>[
               

              // policy list
              Text('policies'),



            ],
          ),
        ),
      ),
      
    );
  }
}