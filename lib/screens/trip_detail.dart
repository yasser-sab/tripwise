import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourism/Service/api_service.dart';
import 'package:tourism/const/text_style.dart';
import 'package:tourism/models/city.dart';
import 'package:tourism/models/trip.dart';
import 'package:tourism/models/trip_city.dart';
import 'package:tourism/widgets/city_container.dart';

class TripDetail extends StatefulWidget {
  const TripDetail({super.key, required this.tripId, required this.trip});
  final int tripId;
  final Trip trip;
  @override
  State<TripDetail> createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  late Future<List<TripCity>> _tripCities;

  @override
  void initState() {
    super.initState();

    _tripCities = fetchTripCities(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.trip.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, size: 27),
            color: Color.fromARGB(255, 187, 30, 19),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _tripCities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Goes Wrrong :("),
            );
          } else if (snapshot.hasData) {
            List<TripCity> _tripCity = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "From : ${DateFormat("yyyy-MM-dd").format(widget.trip.startDate)}", style: kStyleBolded.copyWith(fontSize: 15),),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "    To : ${DateFormat("yyyy-MM-dd").format(widget.trip.endDate)}", style: kStyleBolded.copyWith(fontSize: 15),),

                  const SizedBox(
                    height: 25,
                  ),

                  Divider(),
                  const SizedBox(
                    height: 10,
                  ),

                  _tripCity.isEmpty
                      ? Center(
                          child: Text("No Cities in this Trip"),
                        )
                      : ActivitiesSection(
                          tripCity: _tripCity,
                        ),
                  // CityContainer(tripCity:  _tripCity[index])
                ],
              ),
            );
          }
          return Text("data");
        },
      ),
    );
  }
}

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key, required this.tripCity});
  final List<TripCity> tripCity;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tripCity.length,
        itemBuilder: (context, index) {
          return CityContainer(tripCity: tripCity[index]);
        },
      ),
    );
  }
}
