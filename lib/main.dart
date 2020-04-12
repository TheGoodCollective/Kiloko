import 'package:flutter/material.dart';

void main() => runApp(Kiloko());

class Kiloko extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiloko',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        primaryColor: Color(0x3F92B7),
        buttonColor: Color(0x3F92B7),
        errorColor: Color(0xE57373),

        textTheme: TextTheme(
          
          title: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0x000000),
          ),
          subtitle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0x000000).withOpacity(0.8),
          ),
          subhead: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0x000000).withOpacity(0.8),
            fontStyle: FontStyle.italic,
          ),

          body1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Color(0x000000),
          ),
          body2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0x000000),
          ),

          display1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Color(0x000000),
          ),
          display2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0x000000),
          ),
          display3: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0x000000),
          ),

        ),

        iconTheme: IconThemeData(
          color: Color(0x000000),
        ),

        inputDecorationTheme: InputDecorationTheme(
          focusColor: Color(0x6CC4DC),
        ),

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      
    );
  }
}
