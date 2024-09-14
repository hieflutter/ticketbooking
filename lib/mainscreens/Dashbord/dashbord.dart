import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/Model/model.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/Dashbord/Buselectionscreen.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  final List<String> imgList = [
    'assets/Image/carosel.png',
    'assets/Image/splash.png',
    'assets/Image/caroseltwo.png',
  ];
  String _selectedTripType = 'One Way';

  void _updateTripType(String newTripType) {
    setState(() {
      _selectedTripType = newTripType;
    });
  }

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  DateTime? selectedDate;
  DataModel? dataModel;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/Image/data.json');
    setState(() {
      dataModel = DataModel.fromJson(jsonString);
    });
  }

  List<String> getSuggestions(String query, String type) {
    if (dataModel == null) return [];

    Set<String> suggestions = {};

    for (var route in dataModel!.routes) {
      if (type == 'from') {
        suggestions.add(route.from);
      } else if (type == 'to') {
        suggestions.add(route.to);
      }
    }

    return suggestions
        .where((route) => route.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void searchRoutes() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date.'),
        ),
      );
      return;
    }

    if (dataModel == null) return;

    var selectedDateStr =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    // Use a default value or handle null case explicitly
    Routes? selectedRoute = dataModel!.routes.firstWhere(
      (route) =>
          route.from == fromController.text && route.to == toController.text,
      orElse: () => null!,
    );

    if (selectedRoute != null) {
      var filteredBuses = selectedRoute.buses.where((bus) {
        return bus.date == selectedDateStr;
      }).toList();

      if (filteredBuses.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BusSelectionScreen(route: selectedRoute, buses: filteredBuses),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ScreenSizeConfig.primarycolor,
            content: Text(
              'No buses available for the selected date.',
              style: subtittletextwhite,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ScreenSizeConfig.primarycolor,
          content: Text('No buses available for the selected route.',
              style: subtittletextwhite),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: AppBar(
                    //toolbarHeight: 10,
                    centerTitle: true,
                    // title: Text("Book", style: buttonText,),
                    backgroundColor: ScreenSizeConfig.primarycolor,
                    leading: Icon(null),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeConfig.ScreenHeight * 0.12,
                      left: ScreenSizeConfig.ScreenWidth * 0.034,
                      right: ScreenSizeConfig.ScreenWidth * 0.034),
                  child: Column(
                    children: [
                      Container(
                        //height: ScreenSizeConfig.ScreenHeight * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customRatiobutton(
                                      () => _updateTripType('Select Location'),
                                      "Select Location"),
                                  // customRatiobutton(
                                  //     () => _updateTripType('Round Trip'),
                                  //     "Round Trip"),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                // customfiled("From "),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                // customfiled("To"),
                                customfiled(
                                  "from",
                                  fromController,
                                  'From',
                                  (text) => getSuggestions(text, 'from'),
                                  (selection) =>
                                      fromController.text = selection,
                                ),

                                SizedBox(height: 8),

                                customfiled(
                                  "to",
                                  toController,
                                  'To',
                                  (text) => getSuggestions(text, 'to'),
                                  (selection) => toController.text = selection,
                                ),

                                SizedBox(height: 35),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: commonBorder,
                                enabledBorder: commonBorder,
                                focusedBorder: commonBorder,
                                errorBorder: commonBorder,
                                disabledBorder: commonBorder,
                                focusedErrorBorder: commonBorder,
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: ScreenSizeConfig.primarycolor,
                                      size: 25,
                                    )),
                                filled: true,
                                fillColor: ScreenSizeConfig.customwhite,
                                hintStyle: selectedDate == null
                                    ? subtittletextindigo
                                    : subtittletext,
                                hintText: selectedDate == null
                                    ? 'Select Date'
                                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                              ),
                              onTap: () => _selectDate(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: ScreenSizeConfig.ScreenWidth * 0.5,
                        height: ScreenSizeConfig.ScreenHeight * 0.054,
                        child: ElevatedButton(
                          onPressed: () {
                            searchRoutes();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ScreenSizeConfig.primarycolor,
                            // Blue background color
                            //padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0), // Padding
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // White text color
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),

                              side: BorderSide(
                                color: ScreenSizeConfig
                                    .customwhite, // Border color
                                width: 1.0, // Border width
                              ),
                              // Rounded corners
                            ),
                          ),
                          child: Text(
                            "Search",
                            style: buttontext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: ScreenSizeConfig.ScreenHeight *
                  0.1, // Adjust the top position to cover part of the AppBar
              left: 0,
              right: 0,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: ScreenSizeConfig.ScreenHeight * 0.22,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imgList.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(item),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final OutlineInputBorder commonBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Colors.transparent, // Define your border color
      width: 1.0,
    ),
  );

  Widget customRatiobutton(VoidCallback OnTap, String buttontext) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: ScreenSizeConfig.primarycolor,
              width: 1,
            ),
            color: ScreenSizeConfig.primarycolor
            // _selectedTripType == buttontext
            //     ? ScreenSizeConfig.primarycolor
            //     : ScreenSizeConfig.primarycolor.withOpacity(0.2),
            ),
        child: Text(buttontext,
            style: TextStyle(
                fontFamily: ScreenSizeConfig.fontfamilyRegular,
                color: ScreenSizeConfig.customwhite,
                fontWeight: FontWeight.w600,
                fontSize: ScreenSizeConfig.ScreenWidth * .045)));
  }

  Widget customfiled(
  
   
    String fromto,
    TextEditingController controller,
    String labelText,
    Iterable<String> Function(String text) optionsBuilder,
    void Function(String selection) onSelected,
    // String hinttittle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.radio_button_checked_outlined,
                color: ScreenSizeConfig.primarycolor,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                fromto,
                style: subtittletextindigo,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Autocomplete<String>(
              
              optionsBuilder: (TextEditingValue textEditingValue) {
                
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return optionsBuilder(textEditingValue.text , );
              },
              
              onSelected: onSelected,
   

              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                 
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintStyle: subtittletext,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    //labelText: labelText,
                    //border: OutlineInputBorder(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
