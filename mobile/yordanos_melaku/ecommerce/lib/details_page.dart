import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './home_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Product info = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(info.image), fit: BoxFit.cover)),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color.fromARGB(255, 63, 81, 243)),
              onPressed: () => {Navigator.pop(context)},
            ),
          )
        ]),
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(info.catagory,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 168, 163, 163))),
                    Row(
                      children: [
                        Image.asset('../assets/star.png',
                            width: 20, height: 20),
                        const SizedBox(width: 5),
                        Text('${info.rating}.0',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color:
                                    const Color.fromARGB(255, 168, 163, 163))),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(info.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 20)),
                    Text('\$ ${info.price}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 14))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Size:',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: info.size.length,
                      itemBuilder: (context, index) {
                        final size = info.size[index];
                        return Row(children: [
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(60, 60),
                                backgroundColor: index == 2
                                    ? const Color.fromARGB(255, 63, 81, 243)
                                    : Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(size.toString()),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ]);
                      })),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: Text(info.description,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 67, 65, 65)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(152, 50),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: Colors.red, width: 1)),
                    child: const Text('DELETE'),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/add',
                          arguments: {'product': info, 'isUpdateMode': true})
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(152, 50),
                        backgroundColor: const Color.fromARGB(255, 63, 81, 243),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('UPDATE'),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    )));
  }
}
