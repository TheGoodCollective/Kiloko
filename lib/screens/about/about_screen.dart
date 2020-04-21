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
                      'Kiloko application is a product of the EIP (Emergency Innovation Programme) at The Good Collective Inc. The application is developed under the code name TGC-EI-2120-C19P. The aim of developing it is to help the globe maintain a better control of Covid-19. Using the application, everyone joins the active effort of Flattening the curve.',
                      style: Theme.of(context).textTheme.display1,
                    ),

                    SizedBox(height: 120,),
                    Text(
                      'Kiloko is build with the world in mind. It\'s. not meant to generate any money in any way to The Good Collective. If any information or functions are lacking, email The Good Collective at thegoodcollecktive@gmail.com. All reactions are welcome.',
                      style: Theme.of(context).textTheme.display1,
                    ),

                    SizedBox(height: 80,),

                    Text(
                      'The Good Collective',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 12,),
                    Text(
                      'The Good Collective is a group of scientists who build do projects that put the world at a better strategic position when it comes to disasters, social equality and economic equality. At the TGC, we beleive that outsourcing the collective good gives the world a better edge in the future.',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 16,),
                    Text(
                      'The future is defines by our inactions and actions. Proactivity can only favor us',
                      style: Theme.of(context).textTheme.body1.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
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