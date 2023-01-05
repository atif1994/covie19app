import 'package:covid19app/Servics/Utilities/state_services.dart';
import 'package:covid19app/Views/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final _SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
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
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _SearchController,
                decoration: InputDecoration(
                    hintText: "Search with Country name",
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.fetchCountry(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                      child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                    subtitle: Container(
                                      width: 89,
                                      height: 10,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      width: 89,
                                      height: 10,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ))
                              ],
                            );
                          }),
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100);
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (_SearchController.text.isEmpty) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                actice: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovery:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                            totalDeath: snapshot.data![index]['todayDeaths'],
                                            totlaCases: snapshot.data![index]['population'],

                                              )));
                                },
                                child: ListTile(
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(_SearchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                title: Text(snapshot.data![index]['country']),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
