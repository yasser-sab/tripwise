import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourism/Service/api_service.dart';
import 'package:tourism/const/text_style.dart';
import 'package:tourism/models/trip.dart';
import 'package:tourism/widgets/trip_card.dart';

class TripList extends StatefulWidget {
  const TripList({super.key});

  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  // late List<Trip> _trips;
  late Future<List<Trip>> trips;

  @override
  void initState() {
    super.initState();
    trips = fetchTrips();
    // fetchTrips().then(
    //   (value) {
    //     setState(() {
    //       _trips = value;
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder<List<Trip>>(
        future: trips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Trip> _trip = snapshot.data!;
            return _trip.isEmpty ? Center(child: Text("No Up Coming Trips.", style: kStyleBolded,),) : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _trip.length,
                    itemBuilder: (context, index) {
                      return TripCard(trip: _trip[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('No data available', style: kStyleBolded,),
          );
        },
      ),
    );
  }
}
