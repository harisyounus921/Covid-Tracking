import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Models/WorldStatesModel.dart';
import '../Utilities/states_Services.dart';
import 'package:covid_19_tracker_app/Utilities/Routes.dart';
import 'CountriesList.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({Key? key}) : super(key: key);

  @override
  _WorldStatusState createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> with TickerProviderStateMixin {

  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList=[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  StateServices stateServices=StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .01,),
          FutureBuilder(
            future: stateServices.fetchWorkedStateRecoreds(),
            builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                       return Expanded(flex: 1,
                           child: SpinKitFadingCircle(
                               color: Colors.white, size: 50,controller:_controller),);
                }else{
                 return Column(
                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   //crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0),
                       child: PieChart(dataMap: {
                         "Total":double.parse(snapshot.data!.cases.toString()),
                         "Recover":double.parse(snapshot.data!.recovered.toString()),
                         "Death":double.parse(snapshot.data!.deaths.toString()),
                       },
                         chartValuesOptions: ChartValuesOptions(
                             showChartValuesInPercentage: true),
                         chartRadius: MediaQuery.of(context).size.width/4.2,
                         legendOptions: LegendOptions(legendPosition: LegendPosition.left),
                         animationDuration: Duration(microseconds: 1200),
                         chartType: ChartType.ring,
                         colorList: colorList,
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                       child: Card(
                         child: Column(
                           children: [
                             ReuseableRow(name: "TOTAL CASES", value: snapshot.data!.cases.toString()),
                             ReuseableRow(name: "DEATH", value: snapshot.data!.deaths.toString()),
                             ReuseableRow(name: "RECOVERED", value: snapshot.data!.recovered.toString()),
                             ReuseableRow(name: "ACTIVE", value: snapshot.data!.active.toString()),
                             ReuseableRow(name: "CRITICAL", value: snapshot.data!.critical.toString()),
                             ReuseableRow(name: "TODAY TOTAL", value: snapshot.data!.todayCases.toString()),
                             ReuseableRow(name: "TODAY DEATH", value: snapshot.data!.todayDeaths.toString()),
                            ReuseableRow(name: "TODAY RECOVERED", value: snapshot.data!.todayRecovered.toString()),
                           ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, RouteName.countryScreen);
                       },
                       child: Padding(
                         padding: const EdgeInsets.only(left: 18.0,right: 18),
                         child: Container(
                           height: 50,
                           decoration: BoxDecoration(
                             color: Color(0xff1aa260),
                             borderRadius: BorderRadius.circular(10),
                           ),
                           child: Center(child: Text("Track Countries")),
                         ),
                       ),
                     ),
                 ],);
                }
            },
          ),

        ],
      ),),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String name,value;
  ReuseableRow({Key? key,required this.value,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text(value),
            ],
          ),
          SizedBox(height: 5,), Divider(),
        ],
      ),
    );
  }
}
