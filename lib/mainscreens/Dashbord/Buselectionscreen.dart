import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketbooking/Model/model.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

import 'package:ticketbooking/mainscreens/Dashbord/seat_selection_screen.dart';

class BusSelectionScreen extends StatelessWidget {
  final Routes route;
  final List<Bus> buses;

  BusSelectionScreen({required this.route, required this.buses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: customappbar(
            customappbartittle: "Buses for ${route.from} to ${route.to}"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: buses.length,
          itemBuilder: (context, index) {
            var bus = buses[index];
            double discountedPrice = bus.price;

            // Calculate the discounted price if an offer is available
            if (bus.offer != null && bus.offer!.contains("% off")) {
              int discountPercentage =
                  int.parse(bus.offer!.replaceAll(RegExp(r'[^\d]'), ''));
              discountedPrice =
                  bus.price - (bus.price * discountPercentage / 100);
            } else if (bus.offer != null && bus.offer!.contains("Flat ₹")) {
              int discountAmount =
                  int.parse(bus.offer!.replaceAll(RegExp(r'[^\d]'), ''));
              discountedPrice = bus.price - discountAmount;
            }

            return Card(
              color: ScreenSizeConfig.customwhite,
              margin: EdgeInsets.only(left: 10 , right: 10 , top: 8),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.bus,
                          color: ScreenSizeConfig.customblack.withOpacity(0.6),
                        ),
                        Text(bus.busName , style: subtittletextblack,),
                      ],
                    ),

                    if (bus.offer != null && bus.offer!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          bus.offer!,
                          style:subtittletextwhite
                        ),
                      ),

                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${bus.departureTime} - ${bus.arrivalTime} on ${bus.date}" , style: subtittletextgrey,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Price: " , style: subtittletextblack,),
                        Text(" ₹${bus.price}" , style: subtittletextgrey,),
                      ],
                    ),
                    if (bus.offer != null && bus.offer!.isNotEmpty)
                    
                      Text(
                        "Discounted Price: ₹${discountedPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    //   ],
                    // ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatSelectionScreen(bus: bus),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
