import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/Model/model.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/custombutton.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final Bus bus;
  final List<Seat> seats;
  final Map<String, double> seatPrices;
  final VoidCallback onBookingConfirmed;

  BookingConfirmationScreen({
    required this.bus,
    required this.seats,
    required this.seatPrices,
    required this.onBookingConfirmed,
  });

  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  List<TextEditingController> nameControllers = []; // List to store controllers

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each seat
    for (int i = 0; i < widget.seats.length; i++) {
      nameControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    for (TextEditingController controller in nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    Future<void> _saveBooking() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve names from controllers
      List<String> names = nameControllers
          .map((controller) => controller.text.trim())
          .toList();

      String seatNumbers = widget.seats.map((seat) => seat.seatNumber).join(', ');

      Map<String, dynamic> bookingDetails = {
        'busName': widget.bus.busName,
        'seatNumbers': seatNumbers,
        'totalPrice':
            widget.seatPrices.values.reduce((a, b) => a + b), // Calculate total price
        'names': names, 
      };

      List<String> bookingHistory =
          prefs.getStringList('booking_history') ?? [];
      bookingHistory.add(json.encode(bookingDetails));
      await prefs.setStringList('booking_history', bookingHistory);
    }

    widget.seats.forEach((seat) {
      totalPrice += widget.seatPrices[seat.seatNumber]!;
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: customappbar(customappbartittle: "Booking Confirmation"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.bus,
                    size: 35,
                    color: ScreenSizeConfig.customblack.withOpacity(0.6),
                  ),
                  Text(
                    " ${widget.bus.busName}",
                    style: TextStyle(
                        fontFamily: ScreenSizeConfig.fontfamilytittle,
                        color: ScreenSizeConfig.customblack.withOpacity(0.9),
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenSizeConfig.ScreenWidth * .057),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.seats.length,
                itemBuilder: (context, index) {
                  var seat = widget.seats[index];
                  double seatPrice = widget.seatPrices[seat.seatNumber]!;

                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/Image/ticketui.png"), // Use AssetImage here
                        fit: BoxFit.fill, // Optional: Adjust the image's fit
                      ),
                    ),
                    //color: Colors.amberAccent,
                    child: ListTile(
                      // title: Column(
                      //   children: [
                      //     SizedBox(height: 10,),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           "Seat:",
                      //           style: subtittletextblack,
                      //         ),
                      //         Text(
                      //           " ${seat.seatNumber}",
                      //           style: subtittletextgrey,
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 9,
                              ),
                              Text(
                                "Seat: ${seat.seatNumber}",
                                style: subtittletextwhite,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: nameControllers[index],
                                  decoration: InputDecoration(
                                      border: commonBorder,
                                      enabledBorder: commonBorder,
                                      focusedBorder: commonBorder,
                                      errorBorder: commonBorder,
                                      disabledBorder: commonBorder,
                                      focusedErrorBorder: commonBorder,
                                      hintText: "Name",
                                      helperStyle: subtittletext),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                " ₹${seatPrice.toStringAsFixed(2)}",
                                style: subtittletextwhite,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: commonBorder,
                                      enabledBorder: commonBorder,
                                      focusedBorder: commonBorder,
                                      errorBorder: commonBorder,
                                      disabledBorder: commonBorder,
                                      focusedErrorBorder: commonBorder,
                                      hintText: 'Age',
                                      helperStyle: subtittletext),
                                ),
                              ),
                              DropdownButton<String>(
                                value: 'Male',
                                items: <String>['Male', 'Female', 'Other']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Total Price:",
                    style: subtittletextblack,
                  ),
                  Text(
                    " ₹${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontFamily: ScreenSizeConfig.fontfamilyRegular,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenSizeConfig.ScreenWidth * .045),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: customButton(
                  () async {
                    // Show a confirmation popup
                    bool? confirmBooking = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Booking'),
                          content: Text('Do you want to confirm the booking?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmBooking == true) {
                      // Trigger booking confirmed callback
                      widget.onBookingConfirmed();

                      // Save booking details
                      await _saveBooking();

                      // Show success notification
                      await flutterLocalNotificationsPlugin.show(
                        0,
                        'Booking Confirmed',
                        'Your booking has been confirmed.',
                        NotificationDetails(
                          android: AndroidNotificationDetails(
                            'your_channel_id',
                            'your_channel_name',
                            channelDescription: 'your_channel_description',
                            importance: Importance.max,
                            priority: Priority.high,
                            ticker: 'ticker',
                          ),
                        ),
                      );

                      // Go back to the first screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigationBarWidget(),
                        ),
                      );
                    }
                  },
                  'Payment',
                ),
              ),
            ],
          ),
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
}