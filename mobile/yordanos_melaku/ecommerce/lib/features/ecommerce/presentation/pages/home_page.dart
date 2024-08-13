import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Product {
  String image;
  String name;
  String catagory;
  int price;
  double rating;
  String description;
  List size;

  Product(this.image, this.name, this.catagory, this.price, this.rating,
      this.description, this.size);
}

List<Product> products = [
  Product(
      '../assets/shoes.webp',
      'Derby Leather Shoes',
      'Men\'s Shoes',
      120,
      4.0,
      'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
      [39, 40, 41, 42, 43, 44, 45, 46, 47]),
  Product(
      '../assets/shoes.webp',
      'Sneaker Shoes',
      'Men\'s Shoes',
      130,
      4.0,
      'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
      [30, 31, 32, 33, 34, 35, 36, 37])
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _buildCards(BuildContext context) {
    if (products.isEmpty) {
      return <Card>[];
    }

    return products.map((product) {
      return GestureDetector(
        onTap: () =>
            {Navigator.pushNamed(context, '/details', arguments: product)},
        child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 190,
                    child: Image.asset(product.image, fit: BoxFit.fitWidth)),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                      Text('\$ ${(product.price).toString()}',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 14))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.catagory,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color.fromARGB(255, 168, 163, 163))),
                      Row(
                        children: [
                          Image.asset('../assets/star.png',
                              width: 20, height: 20),
                          const SizedBox(width: 5),
                          Text((product.rating).toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color.fromARGB(
                                      255, 168, 163, 163))),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 209, 205, 205),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('july 14, 2023',
                                  style: GoogleFonts.syne(
                                      fontWeight: FontWeight.w100,
                                      color: const Color.fromARGB(
                                          255, 172, 169, 169))),
                              Row(
                                children: [
                                  Text(
                                    'Hello, ',
                                    style: GoogleFonts.sora(fontSize: 15),
                                  ),
                                  Text(
                                    'Yohannes',
                                    style: GoogleFonts.sora(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border:Border.all(color: Color.fromARGB(255, 57, 20, 20))),),
                      Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(
                                      255, 216, 213, 213))),
                          child: const Icon(Icons.notifications_active))
                    ]),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Products',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 24)),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        255, 216, 213, 213))),
                            child: IconButton(
                              onPressed: () =>
                                  {Navigator.pushNamed(context, '/search')},
                              icon: const Icon(
                                Icons.search_rounded,
                                size: 25,
                                color: Color.fromARGB(255, 216, 213, 213),
                              ),
                            ))
                      ],
                    )),
                Expanded(
                    child: GridView.count(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        crossAxisCount: 1,
                        childAspectRatio: 1.525,
                        children: _buildCards(context)))
              ],
            )),
        floatingActionButton: SizedBox(
          width: 72,
          height: 72,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.pushNamed(context, '/add',
                  arguments: {'isUpdateMode': false})
            },
            backgroundColor: const Color.fromARGB(255, 63, 81, 243),
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 36),
          ),
        ));
  }
}
