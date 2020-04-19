import 'package:flutter/material.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/config/app_utils.dart';
import 'package:kiloko/models/account.dart';


class HomeDrawer extends StatelessWidget {
  final Size screenSize;
  final Function navigateTo;
  final Account account;
  
  HomeDrawer({ @required this.screenSize, this.navigateTo, this.account });


  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
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
                        account.kilokoID,
                        style: Theme.of(context).textTheme.body1.copyWith(
                          color: AppColors.sucsess
                        ),
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

              SizedBox(height: screenSize.height/30),

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

              vSizedBox(),
              
              // about
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: 40,
                  color: AppColors.black,
                ),
                title: Text(
                  'About Us',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600
                  )
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.ABOUT),
              ),
              divider(),

              vSizedBox(),
                            
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
              divider(),

              vSizedBox(height: 48),
              
              // i have corona
              ListTile(
                leading: Icon(
                  Icons.warning,
                  size: 40,
                  color: AppColors.warning,
                ),
                title: Text(
                  'I have corona',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                  
                ),
                onTap: ()=> this.navigateTo(route: AppRoutes.I_HAVE_CORONA),
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