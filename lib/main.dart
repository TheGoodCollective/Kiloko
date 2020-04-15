import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiloko',

      theme: ThemeData(
        
        // primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
        buttonColor: AppColors.primary,
        errorColor: AppColors.error,
        

        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primary,
          splashColor: AppColors.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),

        primaryIconTheme: IconThemeData(
          size: 28,
          color: AppColors.white
        ),

        accentIconTheme: IconThemeData(
          size: 32,
          color: AppColors.white
        ),

        appBarTheme: AppBarTheme(
          color: AppColors.secondary,
          elevation: 10,
          textTheme: TextTheme(
            title: Theme.of(context).textTheme.title
          ),
          iconTheme: IconThemeData(
            size: 28,
            color: Colors.black
          ),
          actionsIconTheme: IconThemeData(
            size: 28,
            color: Colors.black
          ),
        ),

        textTheme: TextTheme(
          
          title: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            // color: Color(0xFFFF9000),
            color: Colors.black,
          ),
          subtitle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            // color: Color(0x0000).withOpacity(0.8),
            color: Colors.black,
          ),
          subhead: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            // color: Color(0x000000).withOpacity(0.8),
            color: Colors.black,
          ),

          body1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            // color: Color(0x000000),
            color: Colors.black,
          ),
          body2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            // color: Color(0x000000),
            color: Colors.black,
          ),

          display1: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          display2: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          display3: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          display4: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),

        ),

        iconTheme: IconThemeData(
          color: Color(0x000000),
        ),

        inputDecorationTheme: InputDecorationTheme(
          focusColor: Color(0x6CC4DC),
          labelStyle: TextStyle(
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(48.0),
            borderSide: BorderSide(),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 14
          ),
        ),
       
      ),
      
      
      initialRoute: AppRoutes.BASE,
      onGenerateRoute: AppRoutes.generate,

      // home: ThemesTest(),

      debugShowCheckedModeBanner: false,

    );
    
  }
}




// test themes
class ThemesTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Test Theme'),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // title
          Text(
            'title text',
            style: Theme.of(context).textTheme.title.copyWith(
              color: AppColors.primary
            ),
          ),

          SizedBox(height: 40,),

          // subtitle
          Text(
            'subtitle text',
            style: Theme.of(context).textTheme.subtitle.copyWith(
              color: AppColors.secondary
            ),
          ),

          SizedBox(height: 40,),


          // subhead
          Text(
            'subhead text',
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: AppColors.black
            ),
          ),

          SizedBox(height: 40,),

          // body 1
          Text(
            'body 1 text',
            style: Theme.of(context).textTheme.body1,
          ),

          SizedBox(height: 40,),          

          // body 2
          Text(
            'body 2 text',
            style: Theme.of(context).textTheme.body2,
          ),

          SizedBox(height: 40,),

          // display 1
          Text(
            'display 1 text',
            style: Theme.of(context).textTheme.display1,
          ),

          SizedBox(height: 40,),          

          // display 2
          Text(
            'display 2 text',
            style: Theme.of(context).textTheme.display2,
          ),

          SizedBox(height: 40,),          

          // display 3
          Text(
            'display 3 text',
            style: Theme.of(context).textTheme.display3,
          ),

          SizedBox(height: 40,),          

          // display 4
          Text(
            'display 4 text',
            style: Theme.of(context).textTheme.display4,
          ),

          
          Text(
            'display 4 text',
            style: TextStyle(
              color: Color(0x3F92B7),
            ),
          ),
           

        ],
      ),
      
    );
  }
}



