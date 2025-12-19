class StoreModel {
  final String nameKey;      // 🔥 localized key
  final String image;
  final String categoryKey;
  final String distance;
  final double rating;
  final String address;
  final String phone;
  final String time;

  StoreModel({
    required this.nameKey,
    required this.image,
    required this.categoryKey,
    required this.distance,
    required this.rating,
    required this.address,
    required this.phone,
    required this.time,
  });
}

List<StoreModel> nearbyStores = [
  StoreModel(
    nameKey: "sharmaGrocery",
    image: "assets/images/clothe.jpg",
    categoryKey: "groceryStore",
    distance: "1.2 km",
    rating: 4.5,
    address: "Main Road, Hazaribagh",
    phone: "9876543210",
    time: "9:00 AM - 9:00 PM",
  ),

  StoreModel(
    nameKey: "deliciousFood",
    image: "assets/images/kitchan.png",
    categoryKey: "foodDelivery",
    distance: "2.1 km",
    rating: 4.3,
    address: "Sadar Chowk, Hazaribagh",
    phone: "9123456780",
    time: "10:00 AM - 11:00 PM",
  ),

  StoreModel(
    nameKey: "fashionHub",
    image: "assets/images/electronics.jpg",
    categoryKey: "fashionStore",
    distance: "850 m",
    rating: 4.6,
    address: "Mandai Market, Hazaribagh",
    phone: "9988776655",
    time: "11:00 AM - 8:00 PM",
  ),
];

