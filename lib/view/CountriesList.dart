import 'package:covid_19_tracker_app/Utilities/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Utilities/states_Services.dart';
import 'DetailScreen.dart';
import 'package:covid_19_tracker_app/Utilities/Routes.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}
TextEditingController searchController=TextEditingController();
class _CountriesListScreenState extends State<CountriesListScreen> {
  StateServices stateServices=StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                  });
                },
                controller:searchController ,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with Country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: FutureBuilder(
              future: stateServices.ContriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount:6,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade900,
                            highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(height: 10,width: 89,color: Colors.white,),
                                subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                leading: Container(height: 50,width: 50,color: Colors.white,),),
                            ],
                          ),
                        );
                      }
                  );
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                      String name=snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  searchController.clear();
                                });
                                Navigator.pushNamed(context,RouteName.detailScreen,
                                      arguments:{
                                        'name':snapshot.data![index]['country'] ,
                                        'image':snapshot.data![index]['countryInfo']['flag'] ,
                                        'totalcase':snapshot.data![index]['cases'] ,
                                        'totalrecovered':snapshot.data![index]['recovered'] ,
                                        'todaytrecovered':snapshot.data![index]['todayRecovered'] ,
                                        'active':snapshot.data![index]['active'] ,
                                        'test':snapshot.data![index]['tests'] ,
                                       'critical' :snapshot.data![index]['critical'] ,
                                        'totaldeath':snapshot.data![index]['deaths'] ,
                                      },
                                    );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text("Total Cases :  "+snapshot.data![index]['cases'].toString()),
                                leading: Image(height:50,width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),),
                            ),
                          ],
                        );
                      }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  searchController.clear();
                                });
                                Navigator.pushNamed(context,RouteName.detailScreen,
                                  arguments:{
                                    'name':snapshot.data![index]['country'] ,
                                    'image':snapshot.data![index]['countryInfo']['flag'] ,
                                    'totalcase':snapshot.data![index]['cases'] ,
                                    'totalrecovered':snapshot.data![index]['recovered'] ,
                                    'todaytrecovered':snapshot.data![index]['todayRecovered'] ,
                                    'active':snapshot.data![index]['active'] ,
                                    'test':snapshot.data![index]['tests'] ,
                                    ' critical' :snapshot.data![index]['critical'] ,
                                    'totaldeath':snapshot.data![index]['deaths'] ,
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(height:50,width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),),
                            ),
                          ],
                        );
                      }else{
                        return Container(

                        );
                      }
                      }
                    );
                }
                  } ),
            ),
          ],
        ),
      ),
    );
  }
}
