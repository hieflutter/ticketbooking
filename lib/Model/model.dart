import 'dart:convert';

class Routes {
  final String from;
  final String to;
  final List<Bus> buses;

  Routes({required this.from, required this.to, required this.buses});

  factory Routes.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<Bus> busesList = list.map((i) => Bus.fromJson(i)).toList();
    return Routes(
      from: json['from'],
      to: json['to'],
      buses: busesList,
    );
  }
}

// Define the Bus model
class Bus {
  final String busName;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final List<Seat> availableSeats;
  final String offer;
  final double price;

  Bus({
    required this.busName,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.offer,
    required this.availableSeats,
    required this.price,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    var list = json['available_seats'] as List;
    List<Seat> seatsList = list.map((i) => Seat.fromJson(i)).toList();
    return Bus(
      busName: json['bus_name'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      date: json['date'],
      availableSeats: seatsList,
      offer: json['offer'] ?? '',
      price: json['price'].toDouble(),
    );
  }
}

// Define the Seat model
class Seat {
  final String seatNumber;
  String status; // Status can change from available to booked

  Seat({required this.seatNumber, required this.status});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatNumber: json['seat_number'],
      status: json['status'],
    );
  }
}

// Define the DataModel class which holds a list of routes
class DataModel {
  final List<Routes> routes;

  DataModel({required this.routes});

  factory DataModel.fromJson(String str) {
    final jsonData = json.decode(str);
    var list = jsonData['routes'] as List;
    List<Routes> routesList = list.map((i) => Routes.fromJson(i)).toList();
    return DataModel(routes: routesList);
  }
}
