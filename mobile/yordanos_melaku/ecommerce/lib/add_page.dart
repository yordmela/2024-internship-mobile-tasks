import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './home_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final bool isUpdateMode = args['isUpdateMode'] ?? false;
    final Product? product = args['product'];

    final nameController =
        TextEditingController(text: isUpdateMode ? product?.name : '');
    final categoryController =
        TextEditingController(text: isUpdateMode ? product?.catagory : '');
    final priceController = TextEditingController(
        text: isUpdateMode ? (product?.price).toString() : '');
    final descriptionController =
        TextEditingController(text: isUpdateMode ? product?.description : '');

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
                          width: 150,
                        ),
                        Text('Add Product',
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
                                child: Image.asset(
                                  product!.image,
                                  fit: BoxFit.cover,
                                ))
                            : Container(
                                padding: const EdgeInsets.all(50),
                                width: double.infinity,
                                height: 190,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 240, 240),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    const Icon(Icons.image, size: 48),
                                    const SizedBox(height: 10),
                                    Text('upload image',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ))),
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
                        controller: nameController,
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
                        controller: categoryController,
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
                                controller: priceController,
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
                        controller: descriptionController,
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
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(152, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 63, 81, 243),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text('ADD'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => {},
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
