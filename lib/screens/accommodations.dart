import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_tab_bar/MotionTabItem.dart';

class Accommodations extends StatefulWidget {
  const Accommodations({super.key});

  @override
  State<Accommodations> createState() => _AccommodationsState();
}

class Accommodation {
  Accommodation(this.name, this.img, this.pric, this.rate);
  final String name;
  final String img;
  final int pric;
  final double rate;
}

List<Accommodation> lst = [
  Accommodation("La Mamonia", "assets/mamounia.jpeg", 150, 4.4),
  Accommodation("Royal Mirage Deluxe", "assets/mirage.jpg", 200, 3.6),
  Accommodation("mövenpick", "assets/movenpick.jpg", 100, 4.9),
  Accommodation("Sahrei", "assets/sahrei.jpeg", 100, 4.6),

  // Accommodation("Marrakech", "assets/marrakech.jpg"),
  // Accommodation("Fez", "assets/fez.jpg"),
  // Accommodation("Casablanca2", "assets/casablanca.jpg"),
];

class _AccommodationsState extends State<Accommodations> {
  final SearchController _searchController = SearchController();
  String? _selectedAccomodation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.keyboard_arrow_left_rounded),
        title: Text("Accommodations"),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right_rounded),
            onPressed: () {},
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Marakkesh",
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SearchAnchor(
                    isFullScreen: false,
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        hintText: "Search",
                        controller: _searchController,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      final filteredList = lst
                          .where((acco) => acco.name
                              .toLowerCase()
                              .contains(controller.value.text.toLowerCase()))
                          .toList();
                      return List<ListTile>.generate(filteredList.length,
                          (int index) {
                        final acco = filteredList[index];
                        return ListTile(
                          title: Text(acco.name),
                          onTap: () {
                            setState(() {
                              controller.closeView(acco.name);
                            });
                          },
                        );
                      });
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Filters",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 30,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text("Hotels"),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        height: 30,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text("Reorts"),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        height: 30,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Text("Cabin"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Room Type",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "value",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("Single")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "groupValue",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("Double")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "groupValue",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("Suite")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Cost",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "value",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("Low")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "groupValue",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("Medium")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Radio(
                                          value: "value",
                                          groupValue: "groupValue",
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      Text("High")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Rate",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 255, 193, 59),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 255, 193, 59),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 255, 193, 59),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 255, 193, 59),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color:
                                            Color.fromARGB(255, 255, 193, 59),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: lst.length,
                  itemBuilder: (BuildContext context, int index) {
                    final accom = lst[index];
                    final isSelected = _selectedAccomodation == accom.name;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAccomodation = accom.name;
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
                              Image.asset(
                                accom.img,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.43),
                                  ),
                                  // padding: const EdgeInsets.all(8.0),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        accom.name,
                                        style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('\$${accom.pric}/Night'),
                                          Spacer(),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            '${accom.rate}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.map_outlined),
                                          Spacer(),
                                          Icon(Icons.arrow_outward_outlined)
                                        ],
                                      ),
                                    ],
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
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
