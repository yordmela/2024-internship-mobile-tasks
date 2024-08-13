import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String image;
  final String name;
  final String catagory;
  final int price;
  final double rating;
  final String description;
  final List size;

  const Product({required this.image, required this.name, required this.catagory, required this.price, required this.rating, required this.description, required this.size});

  @override
  List <Object> get props=>([image, name, catagory, price, rating, description, size]);
}
