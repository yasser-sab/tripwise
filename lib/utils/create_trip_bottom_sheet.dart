import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:tourism/Service/api_service.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/const/text_style.dart';
import 'package:tourism/router_names.dart';
import 'package:tourism/screens/cities.dart';
import 'package:tourism/widgets/top_snackbar.dart';

void showTripBottomModalSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return TripBottomSheet();
    },
  );
}

class TripBottomSheet extends StatefulWidget {
  @override
  _TripBottomSheetState createState() => _TripBottomSheetState();
}

class _TripBottomSheetState extends State<TripBottomSheet> {
  TextEditingController tripNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String durationText = "";

  void updateDuration(DateTimeRange? picked) {
    if (picked != null) {
      setState(() {
        startDateController.text =
            picked.start.toLocal().toString().split(' ')[0];
        endDateController.text = picked.end.toLocal().toString().split(' ')[0];
        int duration = picked.end.difference(picked.start).inDays;
        durationText = "Duration: $duration days";
      });
    }
  }

  String validateAndFormatTripName(String input) {
    // Remove spaces
    String formatted = input.replaceAll(' ', '');

    final valid = RegExp(r'^[a-zA-Z0-9]{4,}$');
    if (valid.hasMatch(formatted)) {
      return formatted;
    } else {
      return '';
    }
  }

  void onAddButtonPressed() {
    String tripName = validateAndFormatTripName(tripNameController.text);
    String startDate = startDateController.text;
    String endDate = endDateController.text;

    if (tripName.isEmpty) {
      mySnackBar(
          context: context,
          message: "Trip name invalid: 3+ characters, letters & numbers only",
          snackBarType: SnackBarType.failure);
    } else if (startDate.isEmpty || endDate.isEmpty) {
      mySnackBar(
          context: context,
          message: "Please Provide Start and End dates",
          snackBarType: SnackBarType.failure);
    } else {
      postTrip(tripName, startDate, endDate, 1).then(
        (value) {
          if (value) {
            mySnackBar(
                context: context,
                message: "Trip Created Successufully!",
                snackBarType: SnackBarType.success);
            context.pushNamed(RouteNames.trips);
          } else {
            mySnackBar(
                context: context,
                message: "Something went wrong",
                snackBarType: SnackBarType.failure);
          }
        },
      );
    }
    log(tripName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Adjusts for the keyboard
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Let's Create A Trip!",
                  style: kmStyleBolded(20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: tripNameController,
                  decoration: InputDecoration(
                    labelText: "Trip name",
                    labelStyle: kStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color:
                            primaryColor, // Change this to your desired color for focused state
                        width: 1.5,
                      ),
                    ),
                    floatingLabelStyle: kStyle.copyWith(color: primaryColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: startDateController,
                        onTap: () async {
                          DateTimeRange? picked = await showDateRangePicker(
                            initialDateRange: DateTimeRange(
                                start: DateTime.now(),
                                end: DateTime.now().add(Duration(days: 15))),

                            context: context,
                            firstDate: DateTime
                                .now(), // User can select dates from today onwards
                            lastDate: DateTime(
                                2101), // User can select dates up to the year 2101
                          );
                          updateDuration(picked);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Start Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 1.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.horizontal_rule_rounded,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: endDateController,
                        onTap: () async {
                          DateTimeRange? picked = await showDateRangePicker(
                            initialDateRange: DateTimeRange(
                                start: DateTime.now(),
                                end: DateTime.now().add(Duration(days: 15))),
                            context: context,
                            firstDate: DateTime
                                .now(), // User can select dates from today onwards
                            lastDate: DateTime(
                                2101), // User can select dates up to the year 2101
                          );
                          updateDuration(picked);
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "End Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (durationText.isNotEmpty)
                  Text(
                    durationText,
                    style: kmStyleBolded(16),
                  ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAddButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // set the border radius
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: kStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
