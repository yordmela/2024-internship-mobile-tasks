import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../injection_container.dart' as di;
import '../../domain/entities/product.dart';
import '../Bloc/product_bloc.dart';
import '../Bloc/product_event.dart';
import '../Bloc/product_state.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildCards(Product product) {
   

   
      return GestureDetector(
        onTap: () =>
            {Navigator.pushNamed(context, '/details', arguments: product)},
        child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 190,
                      child: Image.network(product.imageUrl, fit: BoxFit.fitWidth)),
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
                        Text(product.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color:
                                    const Color.fromARGB(255, 168, 163, 163))),
                        Row(
                          children: [
                            Image.asset('assets/star.png',
                                width: 20, height: 20),
                            const SizedBox(width: 5),
                            Text('5.0',
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
              ),
            )),
      );
   
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProductBloc>()..add(LoadAllProductEvent()),
      child: Scaffold(
          body: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
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
                  Expanded(child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedAllProductState) {
                      
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.25,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return _buildCards(product);
                          });
                    } else if (state is ErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('Unknown State'));
                    }
                    
                  }))
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
          )),
    );
  }
}
