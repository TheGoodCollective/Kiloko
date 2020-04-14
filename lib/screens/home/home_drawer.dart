import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';


class HomeDrawer extends StatelessWidget {
  final Size screenSize;
  final Function navigateTo;
  
  HomeDrawer({ @required this.screenSize, this.navigateTo });


  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Drawer(

        elevation: 4.0,

        child: Container(
          color: AppColors.secondary,
          child: ListView(
            children: <Widget>[
              
              // 
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 48,
                        color: AppColors.black,
                      ),
                      title: Text(
                        'Hello',
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Text(
                        'Your kiloko ID is ',
                        style: Theme.of(context).textTheme.body1.copyWith()
                      ),
                    ),
                    Center(
                      child: Text(
                        'x4D4v0gKtYH',
                        style: Theme.of(context).textTheme.body1.copyWith(
                          color: AppColors.sucsess
                        )
                      ),
                    ),

                  ],
                ),
              ),

              // divider
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Divider(
                  color: AppColors.blackAlt2,
                  thickness: 1,
                ),
              ),

              SizedBox(height: screenSize.height/10),

              // navigation options

              // keep safe
              ListTile(
                leading: Icon(
                  Icons.playlist_add_check,
                  size: 40,
                  color: AppColors.black,
                ),
                title: Text(
                  'How to keep safe',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  ),
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.PREVENTION),
              ),
              divider(),
              
              vSizedBox(),

              // check symptoms
              ListTile(
                leading: Icon(
                  Icons.local_hospital,
                  size: 36,
                  color: AppColors.black,
                ),
                title: Text(
                  'Check Symptoms',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.SYMPTOM_CHECK),
              ),
              divider(),
              
              vSizedBox(),

              // hospitals near me
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  size: 36,
                  color: AppColors.black,
                ),
                title: Text(
                  'Hospitals near me',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.HOSPITALS_NEAR),
              ),
              divider(),
              
              vSizedBox(),

              // world stats
              ListTile(
                leading: Icon(
                  Icons.language,
                  size: 36,
                  color: AppColors.black,
                ),
                title: Text(
                  'World Stats',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                // onTap: ()=> this.navigateTo(route: AppRoutes.),
              ),
              divider(),
              
              vSizedBox(),

              // policy
              ListTile(
                leading: Icon(
                  Icons.security,
                  size: 36,
                  color: AppColors.black,
                ),
                title: Text(
                  'Policy',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.POLICIES),
              ),
              divider(),

              vSizedBox(height: 72),
              
              // account
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 40,
                  color: AppColors.black,
                ),
                title: Text(
                  'My Account',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.ACCOUNT),
              ),

            ],
          ),
        ),
        
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.only(left: 72, right: 28, top: 10),
      child: Divider(
        color: AppColors.blackAlt2.withOpacity(0.2),
        thickness: 1,
      ),
    );
  }// Widget divider() { .. }

  Widget vSizedBox({ double height = 8 }) {
    return SizedBox(height: height);
  }// Widget sizedBox() { .. }

}