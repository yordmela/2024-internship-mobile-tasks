import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../Bloc/product_bloc.dart';
import '../Bloc/product_event.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _filePath;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _filePath = pickedFile.path;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Product? product = args['product'];
    final bool isUpdateMode = product != null;

    if (isUpdateMode) {
      _nameController.text = product.name;
      _descriptionController.text = product.description;
      _priceController.text = product.price.toString();
      if (_filePath == null && product.imageUrl.isNotEmpty) {
        _filePath = product.imageUrl;
      }
    }

    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Color.fromARGB(255, 63, 81, 243),
                              size: 20),
                          onPressed: () => {Navigator.pop(context)},
                        ),
                        const SizedBox(
                          width: 95,
                        ),
                        Text((isUpdateMode) ? 'Edit Product' : 'Add Product',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: isUpdateMode
                            ? SizedBox(
                                width: double.infinity,
                                height: 190,
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ))
                            : GestureDetector(
                                onTap: () async {
                                  pickImage();
                                },
                                child:_filePath==null?
                                ( Container(
                                    padding: const EdgeInsets.all(50),
                                    width: double.infinity,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 240, 240, 240),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.image, size: 48),
                                        const SizedBox(height: 10),
                                        Text('upload image',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ))):
                                   SizedBox(
                                width: double.infinity,
                                height: 190,
                                child: Image.file(File(_filePath!)
                                 , fit: BoxFit.cover,
                                )) 
                              )),
                    const SizedBox(height: 20),
                    Text('name',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _nameController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('category',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _nameController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('price',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _priceController,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.attach_money),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20)),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Text('description',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final ProductModel newProduct=ProductModel(id: product?.id ?? '', name: _nameController.text, price: double.parse(_priceController.text), description: _descriptionController.text, imageUrl: _filePath ?? '');
                          if(isUpdateMode){
                            productBloc.add(UpdateProductEvent(newProduct));
                            
                          }else{
                            productBloc.add(InsertProductEvent(newProduct));
                          }
                          Navigator.pushNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(152, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 63, 81, 243),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                                
                        child: Text((isUpdateMode)? 'EDIT': 'ADD'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => {
                        if (isUpdateMode)  {productBloc.add(DeleteProductEvent(product.id))},
                        Navigator.pushNamed(context, '/')
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side:
                                const BorderSide(color: Colors.red, width: 1)),
                        child: const Text('DELETE'),
                      ),
                    )
                  ],
                ))));
  }
}

