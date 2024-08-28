import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../injection_container.dart' as di;
import '../../data/models/signup_model.dart';
import '../Bloc/auth_bloc.dart';
import '../Bloc/auth_event.dart';
import '../Bloc/auth_state.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 63, 81, 243)),
                onPressed: () => {Navigator.pop(context)},
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 63, 81, 243), // Border color
                    width: 1.0, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'ECOM',
                  style: GoogleFonts.caveatBrush(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 63, 81, 243),
                      height: 1.0),
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthSuccess) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You have successfully created an account.')));
            Navigator.pushReplacementNamed(context, '/signin');
          } else if (state is AuthFailure) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        }, builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Create your account',
                        style: GoogleFonts.poppins(
                            fontSize: 27, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Name',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 111, 111, 111)),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      maxLines: 1,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Name can't be empty";
                        } else if (text.length < 3) {
                          return 'Name must be longer than or equal to 3 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'ex: jon smith',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 136, 136,
                                136), // Customize hint text color
                            fontSize: 15.0,
                            // Customize hint text size
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Email',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 111, 111, 111)),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      maxLines: 1,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Email can't be empty";
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(text)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'ex: jonsmith@gmail.com',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 136, 136,
                                136), // Customize hint text color
                            fontSize: 15.0,
                            // Customize hint text size
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 111, 111, 111)),
                          textAlign: TextAlign.left,
                        )),
                    TextFormField(
                      controller: _passwordController,
                      maxLines: 1,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password can't be empty";
                        } else if (text.length < 6) {
                          return 'Password should be at least 6 character long';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        hintText: '*********',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 136, 136, 136), // Customize hint text color
                          fontSize: 15.0, // Customize hint text size
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Confirm Password',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 111, 111, 111)),
                          textAlign: TextAlign.left,
                        )),
                    TextFormField(
                      controller: _confirmpasswordController,
                      maxLines: 1,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password can't be empty";
                        } else if (text.length < 6) {
                          return 'Password should be at least 6 character long';
                        } else if (text != _passwordController.text) {
                          return "Password don't match";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        hintText: '*********',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 136, 136, 136), // Customize hint text color
                          fontSize: 15.0, // Customize hint text size
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Text(
                            'I understood the ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                'terms & policy.',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 63, 81, 243)),
                              ))
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 288,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                isChecked) {
                              final SignupModel signupEntity = SignupModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignupEvent(signupEntity: signupEntity));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please accept the terms & policy'),
                backgroundColor: Colors.red,
                ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(152, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 63, 81, 243),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('SIGNUP'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account? ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 111, 111, 111)),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: Text(
                                'SIGNIN',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 63, 81, 243)),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../injection_container.dart' as di;
// import '../Bloc/auth_bloc.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _emailController = TextEditingController();

//   final TextEditingController _passwordController = TextEditingController();

//   final TextEditingController _nameController = TextEditingController();

//   final TextEditingController _confirmpasswordController =
//       TextEditingController();

//   bool isChecked=false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => di.sl<AuthBloc>(),
//       child: Scaffold(
//         appBar: AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Positioned(
//               top: 16,
//               left: 16,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                     color: const Color.fromARGB(255, 63, 81, 243)),
//                 onPressed: () => {Navigator.pop(context)},
//               ),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Container(
//                 width: 60,
//                 height: 25,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 63, 81, 243), // Border color
//                     width: 1.0, // Border width
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 0,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'ECOM',
//                   style: GoogleFonts.caveatBrush(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w400,
//                       color: const Color.fromARGB(255, 63, 81, 243),
//                       height: 1.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Text(
//                     'Create your account',
//                     style: GoogleFonts.poppins(
//                         fontSize: 27, fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 40.0),
//                     child: Text(
//                       'Name',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: const Color.fromARGB(255, 111, 111, 111)),
//                       textAlign: TextAlign.left,
//                     )),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _nameController,
//                   maxLines: 1,
//                   decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'ex: jon smith',
//                       hintStyle: TextStyle(
//                         color: const Color.fromARGB(
//                             255, 136, 136, 136), // Customize hint text color
//                         fontSize: 15.0,
//                         // Customize hint text size
//                       ),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 40.0),
//                     child: Text(
//                       'Email',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: const Color.fromARGB(255, 111, 111, 111)),
//                       textAlign: TextAlign.left,
//                     )),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   maxLines: 1,
//                   decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'ex: jon smith',
//                       hintStyle: TextStyle(
//                         color: const Color.fromARGB(
//                             255, 136, 136, 136), // Customize hint text color
//                         fontSize: 15.0,
//                         // Customize hint text size
//                       ),
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 40.0),
//                     child: Text(
//                       'Password',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: const Color.fromARGB(255, 111, 111, 111)),
//                       textAlign: TextAlign.left,
//                     )),
//                 TextFormField(
//                   controller: _passwordController,
//                   maxLines: 1,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//                     hintText: '*********',
//                     hintStyle: TextStyle(
//                       color: const Color.fromARGB(
//                           255, 136, 136, 136), // Customize hint text color
//                       fontSize: 15.0, // Customize hint text size
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 40.0),
//                     child: Text(
//                       'Confirm Password',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: const Color.fromARGB(255, 111, 111, 111)),
//                       textAlign: TextAlign.left,
//                     )),
//                 TextFormField(
//                   controller: _confirmpasswordController,
//                   maxLines: 1,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//                     hintText: '*********',
//                     hintStyle: TextStyle(
//                       color: const Color.fromARGB(
//                           255, 136, 136, 136), // Customize hint text color
//                       fontSize: 15.0, // Customize hint text size
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
      
//         Padding(
//       padding: const EdgeInsets.only(left: 30.0),
//       child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Checkbox(
//                   value: isChecked,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isChecked = value!;
//                     });
//                   },),
//                         Text(
//                           'I understood the ',
//                           style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color:  Colors.black),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                             },
//                             child: Text(
//                               'terms & policy.',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color.fromARGB(255, 63, 81, 243)),
//                             ))
//                       ],
//                     ),
//         ),
      
//                 Center(
//                   child: SizedBox(
//                     width: 288,
//                     height: 42,
//                     child: ElevatedButton(
//                       onPressed: () async {},
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(152, 50),
//                           backgroundColor: const Color.fromARGB(255, 63, 81, 243),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                       child: Text('SIGN UP'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 120,
//                 ),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Have an account? ',
//                         style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: const Color.fromARGB(255, 111, 111, 111)),
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/signin');
//                           },
//                           child: Text(
//                             'SIGNUP',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color.fromARGB(255, 63, 81, 243)),
//                           ))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
