import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared/domain/roomManagement/entity/sensor_data_entity.dart';
import 'package:shared/ui/theme/app_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SensorsHistoryDetails extends StatelessWidget {
  var phData = <SensorDataEntity>[];
   var ecData = <SensorDataEntity>[];
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  SensorsHistoryDetails({required this.phData,required this.ecData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        toolbarHeight: context.Heightmedia(0.08),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        shadowColor: const Color(0xFF17233D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(40, 0, 0, 0),
                offset: Offset(0, 3),
                spreadRadius: 0,
              )
            ],
          ),
          child:  FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(top: 30),
            title: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'Data History'.tr,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
              ),
            ),
          ),
        ),
        
       
      ),
      body: Column(
        
        children: [
          SizedBox(height: 20,),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              isVisible: false, // Hide the x-axis labels
            ),
            title: ChartTitle(text: 'This Months Ph History',textStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),),
            legend: Legend(isVisible: true),
            trackballBehavior: TrackballBehavior(
              enable: true,
              tooltipSettings: InteractiveTooltip(enable: true),
            ),
            // Enable tooltip behavior
            tooltipBehavior: TooltipBehavior(
                enable: true,
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  final dataa = DateFormat('yyyy-MM-dd').format(data.timestamp);
                 final value = data.value;

                  return Container(
                    alignment: Alignment.center,
                    width: context.widthmedia(0.4) ,
                    height: context.Heightmedia(0.06),
                    child: Column(children:[
                       Text("pH",style: TextStyle(
                      color: Colors.green[200],
                      fontWeight: FontWeight.w800,
                      fontSize: 14),),
                      Divider(height: 5,),
                      Text('$dataa :  '+value.toStringAsFixed(2),style: TextStyle(
                      color: const Color.fromARGB(255, 254, 254, 254),
                      fontWeight: FontWeight.w800,
                      fontSize: 12),),
                    ],),
                  );
                }), // Add the tooltip behavior here
            series: <CartesianSeries<SensorDataEntity, String>>[
              LineSeries<SensorDataEntity, String>(
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.verticalLine,
                  borderWidth: 1,
                ),
                dataSource: phData,
                xValueMapper: (SensorDataEntity data, _) =>
                    data.timestamp.toString(),
                yValueMapper: (SensorDataEntity data, _) => data.value,
                name: 'pH',
                dataLabelSettings: DataLabelSettings(isVisible: false),
                enableTooltip: true,
              )
            ],
          ),
            SfCartesianChart(
            primaryXAxis: CategoryAxis(
              isVisible: false, // Hide the x-axis labels
            ),
            title: ChartTitle(text: 'This Months Ec History',textStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),),
            legend: Legend(isVisible: true),
            trackballBehavior: TrackballBehavior(
              enable: true,
              tooltipSettings: InteractiveTooltip(enable: true),
            ),
            // Enable tooltip behavior
            tooltipBehavior: TooltipBehavior(
                enable: true,
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  final dataa = DateFormat('yyyy-MM-dd').format(data.timestamp);
                 final value = data.value;

                  return Container(
                    alignment: Alignment.center,
                    width: context.widthmedia(0.4) ,
                    height: context.Heightmedia(0.06),
                    child: Column(children:[
                       Text("Ec",style: TextStyle(
                      color: Colors.green[200],
                      fontWeight: FontWeight.w800,
                      fontSize: 14),),
                      Divider(height: 5,),
                      Text('$dataa :  '+value.toStringAsFixed(2),style: TextStyle(
                      color: const Color.fromARGB(255, 254, 254, 254),
                      fontWeight: FontWeight.w800,
                      fontSize: 12),),
                    ],),
                  );
                }),// Add the tooltip behavior here
            series: <CartesianSeries<SensorDataEntity, String>>[
              LineSeries<SensorDataEntity, String>(
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.verticalLine,
                  borderWidth: 1,
                ),
                dataSource: ecData,
                xValueMapper: (SensorDataEntity data, _) =>
                    data.timestamp.toString(),
                yValueMapper: (SensorDataEntity data, _) => data.value,
                name: 'Ec',
                dataLabelSettings: DataLabelSettings(isVisible: false),
                enableTooltip: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
