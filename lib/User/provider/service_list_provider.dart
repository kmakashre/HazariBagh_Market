import 'package:flutter/material.dart';

import '../../Model/salon_model.dart';


class ServiceListProvider extends ChangeNotifier {
  final List<SalonModel> _salons = [
    SalonModel(
      image:
      "https://images.unsplash.com/photo-1595475884562-073c30d45670",
      name: "Payal Beauty Parlour",
      rating: "3.5",
      reviews: "2 Ratings",
      location: "Chouhan Nagar Pipliyahana, Indore",
      services: ["Home Service", "Facial", "Bridal Makeup"],
      phone: "07383733102",
    ),
    SalonModel(
      image:
      "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9",
      name: "S Tatsaya Family Salon",
      rating: "5.0",
      reviews: "2 Ratings",
      location: "Sagar Kunj Pipliyahana, Indore",
      services: ["Home Service", "Facial", "Bridal Makeup"],
      phone: "08460308528",
    ),
    SalonModel(
      image:
      "https://images.unsplash.com/photo-1503951458645-643d53bfd90f",
      name: "Glamified By Kavi",
      rating: "4.8",
      reviews: "31 Ratings",
      location: "MR 9 Road Vijay Nagar, Indore",
      services: ["Makeup", "Hair Colour", "Hair Cut"],
      phone: "07487875249",
    ),
  ];

  List<SalonModel> get salons => _salons;
}
