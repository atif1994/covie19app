import 'dart:core';
import 'dart:ffi';

import 'package:covid19app/Servics/Utilities/state_services.dart';
import 'package:covid19app/Views/coutryList_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/World_State_Model.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  final colorlist = <Color>[
    (Color(0xff4285f4)),
    (Color(0xff1aa260)),
    (Color(0xffde5246)),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: s.height * 0.1,
                ),
                FutureBuilder(
                    future: stateServices.fetchTheList(),
                    builder:
                        (context, AsyncSnapshot<WorldStateModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: animationController,
                        ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartType: ChartType.ring,
                              chartRadius: s.width / 3.2,
                              animationDuration: Duration(milliseconds: 1200),
                              colorList: colorlist,
                              dataMap: {
                                'Total': double.parse(
                                    snapshot.data!.cases.toString()),
                                'Recovery': double.parse(
                                    snapshot.data!.recovered.toString()),
                                'Death': double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                            ),
                            SizedBox(
                              height: s.height * 0.1,
                            ),
                            ReuseAble(
                                title: "Total ",
                                id: snapshot.data!.cases.toString()),
                            ReuseAble(
                                title: "Death",
                                id: snapshot.data!.deaths.toString()),
                            ReuseAble(
                                title: "Recovery",
                                id: snapshot.data!.recovered.toString()),
                            ReuseAble(
                                title: "Active",
                                id: snapshot.data!.active.toString()),
                            ReuseAble(
                                title: "Critical",
                                id: snapshot.data!.critical.toString()),
                            ReuseAble(
                                title: "Today death",
                                id: snapshot.data!.todayDeaths.toString()),
                            ReuseAble(
                                title: "Today Recovery",
                                id: snapshot.data!.todayRecovered.toString()),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                    }),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen()));
                  },
                  child: Container(
                    height: s.height * 0.07,
                    width: s.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green,
                    ),
                    child: Center(child: Text("TracK Country")),
                  ),
                ),
                Material(
                  color: Colors.white.withOpacity(0.0),
                  child: InkWell(
                    child: Container(width: 100, height: 100,
  child: Text("dfakdjfklajdlk"),                  ),
                    onTap: (){        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen()));},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReuseAble extends StatelessWidget {
  String title, id;

  ReuseAble({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ),
              Text(id),
            ],
          ),
        ),
      ),
    );
  }
}
