import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/custom/customappbarwithoutback.dart';
import 'package:ticketbooking/custom/customappnavi.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<dynamic> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookingHistory = prefs.getStringList('booking_history') ?? [];

    // Check if each string is JSON or plain text
    setState(() {
      _bookings = bookingHistory.map((booking) {
        try {
          return json.decode(booking); // Try to decode JSON
        } catch (e) {
          return booking; // If it's not JSON, return the raw string
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: customappbarnavi(customappbarnavitittle: "Booking History")
        
        
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            var booking = _bookings[index];

            // Check if the booking is a map (JSON) or a string (plain text)
            if (booking is Map<String, dynamic>) {
              // JSON format: Access fields individually
              return Container(
                margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/Image/ticketui.png"), // Use AssetImage here
                    fit: BoxFit.fill, // Optional: Adjust the image's fit
                  ),
                ),
                // color: ScreenSizeConfig.customwhite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        Icon(
                          CupertinoIcons.bus,
                          size: 25,
                          color: ScreenSizeConfig.customblack.withOpacity(0.6),
                        ),
                        Text(' ${booking['busName']}'),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Seat: ${booking['seatNumbers']}' , style: subtittletextwhite,),
                            SizedBox(width: 80,),
                            Text('Price: ₹${booking['totalPrice']}'),
                          ],
                        ),
                        
                        //Text('name ₹${booking['name']}'),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Plain string format: Show as is
              return Card(
                color: ScreenSizeConfig.customwhite,
                child: ListTile(
                  title: Text(booking),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
