import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/models/city.dart';
import 'package:tourism/models/trip.dart';
import 'package:tourism/router_names.dart';
import 'package:tourism/screens/cities2.dart';
import 'package:tourism/screens/city_detail.dart';
import 'package:tourism/screens/cities.dart';
import 'package:go_router/go_router.dart';
import 'package:tourism/screens/main_screen.dart';
import 'package:tourism/screens/trip_detail.dart';
import 'package:tourism/screens/trips.dart';
import 'package:tourism/widgets/main_tabbar/welcome_screen.dart';

final GoRouter _router = GoRouter(
  redirect: (context, state) {},
  routes: <RouteBase>[
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: RouteNames.main,
      name: RouteNames.main,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: RouteNames.trips,
      name: RouteNames.trips,
      builder: (BuildContext context, GoRouterState state) {
        return const Trips();
      },
    ),
    GoRoute(
      path: RouteNames.tripDetial,
      name: RouteNames.tripDetial,
      builder: (BuildContext context, GoRouterState state) {
        final tripId = int.parse(state.pathParameters['tripId']!);
        final trip = state.extra as Trip;
        return TripDetail(tripId: tripId, trip: trip,);
      },
    ),
    GoRoute(
      path: RouteNames.cities,
      name: RouteNames.cities,
      builder: (BuildContext context, GoRouterState state) {
        return const Cities();
      },
    ),
    GoRoute(
      path: RouteNames.cityDetail,
      name: RouteNames.cityDetail,
      builder: (BuildContext context, GoRouterState state) {
        final City city = state.extra as City;
        return CityDetail(city: city);
      },
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: primaryColor, foregroundColor: Colors.white)),
      // home: const MainScreen(),
    );
  }
}
