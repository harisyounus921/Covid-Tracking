import 'package:covid_19_tracker_app/view/WorldStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  dynamic data;
  DetailScreen({
  required this.data
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
                 child: Stack(
                   alignment: Alignment.topCenter,
                   children: [
                     Padding(
                       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                       child: Card(
                         child: Column(
                           children: [
                             SizedBox(height: MediaQuery.of(context).size.height * .06,),
                             ReuseableRow(name: 'Total Cases',value: widget.data['totalcase'].toString(),),
                             ReuseableRow(name: 'Total Death',value: widget.data['totaldeath'].toString(),),
                             ReuseableRow(name: 'Total Recovered',value: widget.data['totalrecovered'].toString(),),
                             ReuseableRow(name: 'Active',value: widget.data['active'].toString(),),
                             ReuseableRow(name: 'Critical',value: widget.data['critical'].toString(),),
                             ReuseableRow(name: 'TodayRecovered',value: widget.data['totaldeath'].toString(),),
                             ReuseableRow(name: 'Test',value: widget.data['test'].toString(),),
                           ],
                         ),
                       ),
                     ),
                     CircleAvatar(
                       radius: 50,
                       backgroundImage: NetworkImage(widget.data['image']),
                     ),
                   ],
                 ),
               ),
        ],
      ),
    );
  }
}
