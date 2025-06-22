import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourism/Service/api_service.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/models/city.dart';
import 'package:tourism/router_names.dart';
import 'package:tourism/screens/cities.dart';
import 'package:tourism/utils/create_trip_bottom_sheet.dart';
import 'package:tourism/widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: Image.asset(
              "assets/welcome.png",
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            text: "New Trip",
            leadingIcon: Image.asset("assets/travel.png"),
            color: primaryColor,
            onTap: () {
              showTripBottomModalSheet(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            text: "Manage Trips",
            leadingIcon: Image.asset("assets/luggage.png"),
            color: primaryColor,
            onTap: () {
              context.pushNamed(RouteNames.trips);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            text: "Explore",
            leadingIcon: Image.asset("assets/destination.png"),
            color: primaryColor,
            onTap: () {
              context.pushNamed(RouteNames.cities);
            },
          ),
        ],
      ),
    );
  }
}
