import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../injection_container.dart' as di;
import '../../domain/entities/product.dart';
import '../Bloc/product_bloc.dart';
import '../Bloc/product_event.dart';
import '../Bloc/product_state.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  bool _isvisible=false;
  RangeValues _currentRangeValue=const RangeValues(20, 80);
 @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> di.sl<ProductBloc>()..add(LoadAllProductEvent()),
      child: Scaffold(
          body: Container(
              padding:const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color:  Color.fromARGB(255, 63, 81, 243),
                          size: 20),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                   const SizedBox(
                      width: 90,
                    ),
                    Text('Search Product',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                        padding:  const EdgeInsets.all(0),
                        width: 310,
                        height: 43,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 216, 213, 213))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Leather',
                                  hintStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color:Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20)
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 63, 81, 243),
                                ))
                          ],
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 63, 81, 243)),
                      child: IconButton(
                        onPressed: () => {
                          setState(() {
                          _isvisible=!_isvisible;
                          })
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                  })),
                
               if(_isvisible) Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('Category',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                ),
               
                
                Container(
                  padding: const EdgeInsets.all(2),
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2, color: const Color.fromARGB(255, 185, 182, 182))),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                  child: Text('Price',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                ),
      
                
                SizedBox(
                  width:double.infinity,
                  child: RangeSlider(values:_currentRangeValue ,onChanged:(RangeValues values)=>{
                    setState(() {
                      _currentRangeValue= values;
                    })
                  },min:0, max:100,activeColor:const Color.fromARGB(255, 63, 81, 243) ,),
                ),
      
                const SizedBox(height: 40,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(152, 50),
                        backgroundColor: const Color.fromARGB(255, 63, 81, 243),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                             child: const Text('APPLY'),
                  ),
                ),
                  ],
                ),
                
              ])
              )
              ),
    );
  }
}
