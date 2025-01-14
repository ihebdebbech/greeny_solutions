// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:core/core.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny_solution/features/create_account/create_account_controller.dart';
import 'package:greeny_solution/features/create_account/widgets/create_account_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greeny_solution/features/home/homepageController.dart';
import 'package:greeny_solution/features/home/nav_menu.dart';
import 'package:greeny_solution/features/notification/consult_notification_screen.dart';
import 'package:greeny_solution/features/roomsmanagement/room_details.dart';
import 'package:greeny_solution/icons/deseasedetectionicon1.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:greeny_solution/main.dart';
import 'package:shared/shared.dart';
import 'package:get/get.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends GetView<HomeController> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
   
    int _page = 0;
    
    
     
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        shadowColor: const Color(0xFF17233D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,

            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(40, 0, 0, 0),
                offset: Offset(0, 10),
                spreadRadius: 0,
              )
            ],
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            //   topLeft: Radius.circular(0),
            //   topRight: Radius.circular(0),
            // ),
          ),
          child:  FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(top: 30),
            title: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 2.0), 
                child: Text(
                  'Welcome Back !'.tr,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.notifications,
                  size: 30,
                  color: AppColors.secondarydark,
                ),
                onPressed: () => Get.to(NotificationWidget()),
              ),
            ),
          ),
        ],
      ),
    
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.rooms.isEmpty) {
           return RefreshIndicator(
    onRefresh: controller.fetchRooms,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(), // Ensures the list is scrollable even when empty
      children: [
        const SizedBox(height: 15),
        Center(
          child: Container(),
        ),
      ],
    ),
  );
        } else {
          return RefreshIndicator(
              onRefresh: controller.fetchRooms,
              child: CustomScrollView(
            slivers: [
              
              SliverAppBar(
                floating: true,
                expandedHeight: 130.0,
                
                elevation: 8.0,
                flexibleSpace: FlexibleSpaceBar(
                   titlePadding : EdgeInsets.zero,
                  title: AnimatedOpacity(
                    opacity: 0.7,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 500,
                      height: 250,
                       child: Container(
                      color: AppColors.primary,
                      
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0), 
                        child: Center( child:Image.asset(
                          height: 100,
                          width: 170,
                          'assets/Images/greenywhite.png',
                          fit: BoxFit.contain,
                        ),
                        ),
                      ),
                    ),
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [       Hero(
                     tag: "dfbgf31" ,
                     child:               
                      Image.asset(
                        'assets/Images/imagehydroponic3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),           
                    ],
                  ),
                  centerTitle: true,
                ),
                snap: false,
                leading: Container(),
              ),
              
             SliverToBoxAdapter(
  child: SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.rooms.length,
          itemBuilder: (context, index) {
            var room = controller.rooms[index];
            return Hero(
              tag: "tagcard" + index.toString(),
              child: SizedBox(
                height: context.Heightmedia(0.3),
                child: GestureDetector(
                  onTap: () {
                    Get.to(RoomDetails(roomIndex: index,room: room,));
                  },
                  child: Card(
                    elevation: 20,
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      side:  BorderSide(
                          color:room.Status == 'active' ? AppColors.primary : Color.fromARGB(255, 218, 24, 10),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(
                        left: context.widthmedia(0.05),
                        right: context.widthmedia(0.05),
                        bottom: context.Heightmedia(0.03)),
                    child: SingleChildScrollView(child:  Column(
                      children: [
                        Text(
                          room.name,
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 150,
                                child: _getRadialGauge(
                                  value: room.latestEc,
                                  endvalue: 100,
                                  startAngle: 160,
                                  endAngle: 24,
                                  maximum: 100,
                                  annotations: <GaugeAnnotation>[
                                    _GaugeAnnotation(
                                        textdisplayed: "ec  " +
                                            room.latestEc.toStringAsFixed(2),
                                        color: AppColors.primary,
                                        angle: 90,
                                        positionFactor: 0.5),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 150,
                                child: _getPhGauge(
                                  value: room.latestPh,
                                  endvalue: 14,
                                  startAngle: 160,
                                  endAngle: 24,
                                  annotations: <GaugeAnnotation>[
                                    _GaugeAnnotation(
                                        textdisplayed: "Ph  " +
                                            room.latestPh.toStringAsFixed(2),
                                        color: AppColors.primary,
                                        angle: 90,
                                        positionFactor: 0.5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                         Text(
                          room.Status,
                          style: TextStyle(
                              color:room.Status == 'active' ? AppColors.primary : Color.fromARGB(255, 218, 24, 10),
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
       
      ],
    ),
  ),
),
              
            ],
          
          )
          );
        }
      }),

    
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Drawer(
        width: 350,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('notification'),
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Widget _getRadialGauge({
  required double value,
  required double endvalue,
  required double startAngle,
  required double endAngle,
  required double maximum,
  List<GaugeAnnotation>? annotations,
}) {
  return SfRadialGauge(
    enableLoadingAnimation: true,
    animationDuration: 4000,
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: maximum,
        startAngle: startAngle,
        endAngle: endAngle,
        ranges: <GaugeRange>[
          GaugeRange(
            color: const Color.fromARGB(255, 195, 195, 195),
            startValue: 0,
            endValue: endvalue,
            startWidth: 10,
            endWidth: 10,
          ),
        ],
        pointers: <GaugePointer>[
          RangePointer(
            value: value,
            gradient: const SweepGradient(
              colors: [Color.fromARGB(255, 0, 255, 55), AppColors.primary],
              stops: [0.0, 1.0],
            ),
            width: 0.1,
            sizeUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothCurve,
          ),
        ],
        annotations: annotations,
      ),
    ],
  );
}

Widget _getPhGauge({
  required double value,
  required double endvalue,
  required double startAngle,
  required double endAngle,
  List<GaugeAnnotation>? annotations,
}) {
  return SfRadialGauge(
    enableLoadingAnimation: true,
    animationDuration: 4000,
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 14,
        startAngle: startAngle,
        endAngle: endAngle,
        ranges: <GaugeRange>[
          GaugeRange(
            gradient: const SweepGradient(
              colors: [
                Color.fromARGB(255, 210, 1, 1),
                Color.fromARGB(255, 243, 227, 0),
                Color.fromARGB(255, 18, 175, 0),
                Color.fromARGB(255, 243, 227, 0),
                Color.fromARGB(255, 210, 1, 1)
              ],
              stops: [0.0, 0.3, 0.55, 0.65, 1.0],
            ),
            startValue: 0,
            endValue: endvalue,
            startWidth: 10,
            endWidth: 10,
          ),
        ],
        pointers: <GaugePointer>[
          MarkerPointer(
            value: value,
            color: Color.fromARGB(255, 0, 0, 0),
          )
        ],
        annotations: annotations,
      ),
    ],
  );
}

GaugeAnnotation _GaugeAnnotation({
  required String textdisplayed,
  required Color color,
  required double angle,
  required double positionFactor,
}) {
  return GaugeAnnotation(
    widget: Text(
      textdisplayed,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    ),
    angle: angle,
    positionFactor: positionFactor,
  );
}
