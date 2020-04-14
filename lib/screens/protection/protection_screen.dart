import 'package:flutter/material.dart';
import 'package:kiloko/config/app_protection_data.dart' as protectionInfo;
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/widgets/opacity_widget.dart';

class ProtectionScreen extends StatefulWidget {
  @override
  _ProtectionScreenState createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> with TickerProviderStateMixin {
  List<String> dos = protectionInfo.dos;
  List<String> donts = protectionInfo.donts;

  AnimationController _animationController;
  Animation<double> _mainTitleAnimation;
  Animation<double> _subTitlesAnimation;
  Animation<double> _instructioneAnimation;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1), vsync: this,
    );

    _mainTitleAnimation = Tween<double>( begin: 0.0, end: 1.0 ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6),
      )
    );
    
    _subTitlesAnimation = Tween<double>( begin: 0.0, end: 1.0 ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.8),
      )
    );
    
    _instructioneAnimation = Tween<double>( begin: 0.0, end: 1.0 ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0),
      )
    );

    _animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: Text('Protection'),
        centerTitle: true,
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 44),
            child: Column(
              children: <Widget>[
                
                // instruction text
                // AnimatedBuilder(
                //   animation: _animationController,
                //   child: Text(
                //     'Recommended ways to keep safe and avoid spreading corona',
                //     style: Theme.of(context).textTheme.subtitle,
                //     textAlign: TextAlign.center,
                //   ),
                //   builder: (ctx, child) {

                //     return Opacity(
                //       opacity: _mainTitleAnimation.value,
                //       child: child,
                //     );
                //   }
                // ),
                OpacityWidget(
                  child: Text(
                    'Recommended ways to keep safe and avoid spreading corona',
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  animation: _mainTitleAnimation,
                ),

                SizedBox(height: 40,),

                // dos
                AnimatedBuilder(
                  animation: _animationController,
                  child: Text(
                    'Dos',
                    style: Theme.of(context).textTheme.display2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary
                    ),
                  ),
                  builder: (ctx, child) {

                    return Opacity(
                      opacity: _subTitlesAnimation.value,
                      child: child,
                    );
                  }
                ),
                SizedBox(height: 40,),
                // list
                // ...dos.map((String du) {
                //   int index = dos.indexOf(du);
                //   return _buildInstruction(instruction: du, number: index+1);
                // }).toList(),
                AnimatedBuilder(
                  animation: _animationController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      ...dos.map((String du) {
                        int index = dos.indexOf(du);
                        return _buildInstruction(instruction: du, number: index+1);
                      }).toList(),

                    ],
                  ),
                  builder: (ctx, child) {

                    return Opacity(
                      opacity: _instructioneAnimation.value,
                      child: child,
                    );
                  },
                ),

                SizedBox(height: 80,),

                // donts
                AnimatedBuilder(
                  animation: _animationController,
                  child: Text(
                    'Dont\'s',
                    style: Theme.of(context).textTheme.display2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary
                    ),
                  ),
                  builder: (ctx, child) {

                    return Opacity(
                      opacity: _subTitlesAnimation.value,
                      child: child,
                    );
                  }
                ),
                SizedBox(height: 40,),
                // list
                // ...donts.map((String du) {
                //   int index = donts.indexOf(du);
                //   return _buildInstruction(instruction: du, number: index+1);
                // }).toList(),
                 AnimatedBuilder(
                  animation: _animationController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      ...donts.map((String du) {
                        int index = donts.indexOf(du);
                        return _buildInstruction(instruction: du, number: index+1);
                      }).toList(),

                    ],
                  ),
                  builder: (ctx, child) {

                    return Opacity(
                      opacity: _instructioneAnimation.value,
                      child: child,
                    );
                  },
                ),


              ],
            ),
          ),
        ),
      ),
      
    );
  }// Widget build(BuildContext context) { .. }
  

  Widget _buildInstruction({ @required String instruction, @required int number }) {

    return Container(
      margin: EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Center(
                child: Text(
                  number.toString(),
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: AppColors.primary,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              height: 48,
              width: 48,
            ),
          ),

          SizedBox(height: 16,),

          Text(
            instruction,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),

        ],
      ),
    );
  }// Widget _buildInstruction({ String instruction }) { .. }


}