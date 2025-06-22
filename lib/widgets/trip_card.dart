import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/models/trip.dart';
import 'package:tourism/router_names.dart';

class TripCard extends StatelessWidget {
  const TripCard(
      {super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    TextStyle style = GoogleFonts.aBeeZee();

    return InkWell(
      onTap: () {
        context.pushNamed(
          RouteNames.tripDetial,
          pathParameters: {'tripId': trip.id.toString()},
          extra: trip
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          child: Column(
            children: [
              Center(
                child: Text(
                  trip.name,
                  style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Divider(),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(DateFormat("yyyy-MM-dd").format(trip.startDate),),
                      //  SizedBox(width: 2,),
                      const Text(" - "),
                      //  SizedBox(width: 2,),
                      Text(DateFormat("yyyy-MM-dd").format(trip.endDate)),
                    ],
                  ),
                  Spacer(),
                  const InkWell(
                    child: Row(
                      children: [
                        Text("Edit"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.edit,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
