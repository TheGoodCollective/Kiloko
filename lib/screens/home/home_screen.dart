import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kiloko/config/app_routes.dart';
import 'package:kiloko/screens/home/home_drawer.dart';
import 'package:latlong/latlong.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _accessToken = 'pk.eyJ1IjoiYWdlbnRldGlra2EiLCJhIjoiY2s2bnRhY3h4MDhycjNlbTl6cWl2ZjF4bCJ9.qQnlBcstSfwU9OHabgj2ow';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: this._buildExposedWidget(context: context),
        centerTitle: true,
        actions: <Widget>[
           
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: this._goToAccount,
          )

        ],
      ),

      body: SafeArea(
        child: FlutterMap(
          options: new MapOptions(
            center: new LatLng(51.5, -0.09),
            zoom: 15.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': _accessToken,
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(51.5, -0.09),
                  builder: (ctx) =>
                  Container(
                    child: IconButton(
                            icon: Icon(Icons.location_on), 
                            iconSize: 48,
                            color: Colors.pink.shade500,
                            onPressed: () {
                              print('hey');
                            },
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      drawer: HomeDrawer(screenSize: screenSize, navigateTo: this._goTo),

    );
  }// Widget build(BuildContext context) { .. }


  
  Widget _buildUnexposedWidget({ BuildContext context }) {

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          
          Icon(Icons.check_circle_outline),
          Text('All Good'),

        ],
      ),
    );
  }// Widget _buildUnexposedWidget({ BuildContext context }) { .. }
  
  Widget _buildExposedWidget({ BuildContext context }) {
    double width = MediaQuery.of(context).size.width/3;

    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          
          Icon(Icons.info_outline),
          SizedBox(width: 16,),
          Text('Possible Exposure'),

        ],
      ),
    );
  }// Widget _buildExposedWidget({ BuildContext context }) { .. }
  

  /*
   ** logic only functions
   */

  void _goToAccount() {
    print('void _goToAccount() {');
    Navigator.of(context).pushNamed(AppRoutes.ACCOUNT);
  }// void _goToAccount() { .. }

  void _goTo({ String route }) {
    Navigator.of(context).pushNamed(route);
  }// void goTo({ String route }) { .. }

}