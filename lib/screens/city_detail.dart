import 'package:flutter/material.dart';
import 'package:tourism/const/app_color.dart';
import 'package:tourism/const/text_style.dart';
import 'package:tourism/models/city.dart';

class CityDetail extends StatefulWidget {
  const CityDetail({super.key, required this.city});
  final City city;

  @override
  State<CityDetail> createState() => _CityDetailState();
}

class _CityDetailState extends State<CityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.city.name!),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'cityImageHero-${widget.city.name}',
                  // child: Image.network(widget.city.phototUri!),
                  child: Image.asset(
                    "assets/${widget.city.name}.jpg",
                    // width: double.infinity,
                    // height: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(20),
                      //   topRight: Radius.circular(20),
                      // )
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Center(
                        child: Text(
                      widget.city.name.toString(),
                      style: kStyleBolded.copyWith(fontSize: 25),
                    )),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc non enim at lectus luctus imperdiet sit amet et neque. Donec est libero, luctus vitae ullamcorper sed, fermentum sed orci. Vivamus bibendum velit lacinia dui pulvinar luctus. Suspendisse elementum ultricies libero at porttitor. Aenean id mauris id nisi consectetur bibendum. Aenean nec enim vitae ex rutrum tincidunt et a libero. Donec pretium quam ac odio dapibus, nec aliquam sapien porttitor.",
                style: kStyleBolded.copyWith(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
