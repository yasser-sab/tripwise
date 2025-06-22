import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/models/city.dart';
import 'package:tourism/router_names.dart';
import 'package:tourism/screens/accommodations.dart';
import 'package:tourism/Service/api_service.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final SearchController _searchController = SearchController();

  String? _selectedCity;
  late Future<List<City>> lstCity;
  List<City> allCities = [];
  List<City> filteredCities = [];

  @override
  void initState() {
    super.initState();
    lstCity = fetchCities();
    lstCity.then((cities) {
      setState(() {
        allCities = cities;
        filteredCities = cities;
      });
    });
  }

  void filterCities(String cityName) {
    setState(() {
      filteredCities = allCities
          .where((city) => city.name!.toLowerCase() == cityName.toLowerCase())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Cities"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchAnchor(
                      isFullScreen: false,
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          hintText: "Search Cities",
                          controller: _searchController,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          onTap: () {
                            setState(() {
                              filteredCities = allCities;
                            });
                            controller.openView();
                            controller.text = _searchController.text;
                          },
                          onChanged: (query) {
                            setState(() {
                              filteredCities = allCities;
                            });
                            controller.openView();
                            controller.text = _searchController.text;
                          },
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (context, controller) {
                        final query = controller.text;
                        final suggestions = allCities
                            .where((city) => city.name!
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                        return suggestions.map<Widget>((city) {
                          return ListTile(
                            title: Text(city.name!),
                            onTap: () {
                              controller.text = city.name!;
                              filterCities(city.name!);
                              controller.closeView(controller.text);
                              _searchController.text = controller.text;
                              FocusScope.of(context).unfocus();
                            },
                          );
                        }).toList();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Text("FILTERS"),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.filter_alt,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder<List<City>>(
                  future: lstCity,
                  builder: (context, snapshot) {
                    log(snapshot.connectionState.toString());
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      log(snapshot.data!.length.toString());
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 17,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: filteredCities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final city = filteredCities[index];
                          final isSelected = _selectedCity == city.name;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // _selectedCity = city.name;
                                context.pushNamed(RouteNames.cityDetail,
                                    extra: city);
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: isSelected
                                      ? Color.fromARGB(255, 0, 116, 4)
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag: "cityImageHero-${city.name}",
                                      // child: Image.network(
                                      //   city.phototUri!,
                                      //   fit: BoxFit.cover,
                                      //   width: double.infinity,
                                      //   height: double.infinity,
                                      // ),
                                      child: Image.asset(
                                        "assets/${city.name}.jpg",
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.43),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            city.name![0].toUpperCase() +
                                                city.name!.substring(1),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isSelected,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/check.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
