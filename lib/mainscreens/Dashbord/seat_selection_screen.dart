import 'package:flutter/material.dart';
import 'package:ticketbooking/Model/model.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/custombutton.dart';
import 'package:ticketbooking/mainscreens/Dashbord/booking_confirmation_screen.dart';
import 'package:ticketbooking/mainscreens/Dashbord/dashbord.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Bus bus;

  SeatSelectionScreen({required this.bus});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<Seat> selectedSeats = [];
  Map<String, double> seatPrices = {}; // Map to store seat prices based on selection

  double _calculateSeatPrice() {
    double seatPrice = widget.bus.price;
    if (widget.bus.offer != null && widget.bus.offer!.contains("% off")) {
      int discountPercentage =
          int.parse(widget.bus.offer!.replaceAll(RegExp(r'[^\d]'), ''));
      seatPrice =
          widget.bus.price - (widget.bus.price * discountPercentage / 100);
    } else if (widget.bus.offer != null &&
        widget.bus.offer!.contains("Flat ₹")) {
      int discountAmount =
          int.parse(widget.bus.offer!.replaceAll(RegExp(r'[^\d]'), ''));
      seatPrice = widget.bus.price - discountAmount;
    }
    return seatPrice;
  }

  @override
  Widget build(BuildContext context) {
    var bus = widget.bus;
    var seats = bus.availableSeats;

    return Scaffold(
      appBar:   PreferredSize(preferredSize:Size.fromHeight(80.0), child: customappbar(customappbartittle: "Seats for ${bus.busName}"),
      
      
      ),
      
      
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: seats.length,
                itemBuilder: (context, index) {
                  var seat = seats[index];
                  bool isSelected = selectedSeats.contains(seat);
                  bool isBooked = seat.status == 'booked';

                  return GestureDetector(
                    onTap: () {
                      if (seat.status == 'available') {
                        setState(() {
                          if (isSelected) {
                            selectedSeats.remove(seat);
                            seatPrices.remove(
                                seat.seatNumber); // Remove seat price from map
                          } else {
                            selectedSeats.add(seat);
                            seatPrices[seat.seatNumber] =
                                _calculateSeatPrice(); // Add seat price to map
                          }
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isBooked
                            ? Colors.red
                            : isSelected
                                ? Colors.blue
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          seat.seatNumber,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            customButton(
              (){
                 if (selectedSeats.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmationScreen(
                        bus: bus,
                        seats: selectedSeats,
                        seatPrices: seatPrices, // Pass the seat prices map
                        onBookingConfirmed: () {
                          setState(() {
                            for (var seat in selectedSeats) {
                              seat.status = 'booked';
                            }
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                 }
              },"Continue"
            )
            // ElevatedButton(
            //   onPressed: () {
            //     if (selectedSeats.isNotEmpty) {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BookingConfirmationScreen(
            //             bus: bus,
            //             seats: selectedSeats,
            //             seatPrices: seatPrices, // Pass the seat prices map
            //             onBookingConfirmed: () {
            //               setState(() {
            //                 for (var seat in selectedSeats) {
            //                   seat.status = 'booked';
            //                 }
            //               });
            //               Navigator.pop(context);
            //             },
            //           ),
            //         ),
            //       );
            //     }
            //   },
            //   child: Text('Continue'),
            // ),
          ],
        ),
      ),
    );
  }
}
