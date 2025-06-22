import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourism/const/text_style.dart';
import 'package:tourism/models/trip_city.dart';
import 'package:timelines/timelines.dart';

class CityContainer extends StatelessWidget {
  const CityContainer({super.key, required this.tripCity});

  final TripCity tripCity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.center, child: Text(tripCity.city.name.toString(), style: kStyleBolded.copyWith(fontSize: 15),)),
              SizedBox(height: 8),
            // Add the timeline here
            FixedTimeline(
              children: [
                TimelineTile(
                  nodeAlign: TimelineNodeAlign.start,
                  contents: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hotel'),
                    ),
                  ),
                  node: TimelineNode(
                    indicator: DotIndicator(),
                    endConnector: SolidLineConnector(),
                  ),
                ),
                TimelineTile(
                  nodeAlign: TimelineNodeAlign.start,
                  contents: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Restuarant'),
                    ),
                  ),
                  node: TimelineNode(
                    indicator: DotIndicator(),
                    startConnector: SolidLineConnector(),
                    endConnector: SolidLineConnector(),
                  ),
                ),
                TimelineTile(
                  nodeAlign: TimelineNodeAlign.start,
                  contents: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cruise'),
                    ),
                  ),
                  node: TimelineNode(
                    indicator: DotIndicator(),
                    startConnector: SolidLineConnector(),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
    );
  }
}