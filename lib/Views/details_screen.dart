import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String? name;
  String? image;
  int? totlaCases,
      totalDeath,
      totelRecovered,
      actice,
      critical,
      todayRecovery,
      test;

  DetailsScreen(
      {Key? key,
      this.name,
      this.image,
      this.totlaCases,
      this.critical,
      this.actice,
      this.test,
      this.todayRecovery,
      this.totalDeath,
      this.totelRecovered})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [Image(image: NetworkImage(widget.image.toString())),
              Text("Total Population :"+widget.totlaCases.toString()),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Today Death:"+widget.totalDeath.toString()),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Total Active :"+widget.actice.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Critical :"+widget.critical.toString()),
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
