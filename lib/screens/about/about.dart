import 'package:flutter/material.dart';



class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // 
                    Text(
                      'Kiloko Project',
                      style: Theme.of(context).textTheme.title,
                    ),

                    SizedBox(height: 40,),
 
                    Text(
                      'Kiloko Project',
                      style: Theme.of(context).textTheme.title,
                    ),

                    


                  ],
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}