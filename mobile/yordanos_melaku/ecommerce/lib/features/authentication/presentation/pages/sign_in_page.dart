import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../injection_container.dart' as di;
import '../../../ecommerce/presentation/Bloc/product_state.dart';
import '../../data/models/login_model.dart';
import '../Bloc/auth_bloc.dart';
import '../Bloc/auth_event.dart';
import '../Bloc/auth_state.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final _formKey= GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthBloc>(),
      child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Successfully logged in')));
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is AuthFailure) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
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
                      height: 90,
                    ),
                    Center(
                      child: Container(
                        width: 144,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(
                                255, 63, 81, 243), // Border color
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
                              fontSize: 48,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 63, 81, 243),
                              height: 1.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    
                    Center(
                      child: Text(
                        'Sign into your account',
                        style: GoogleFonts.poppins(
                            fontSize: 27, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 25.0),
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
                        if(text ==null || text.isEmpty){
                          return "Email can't be empty";
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(text)) {
                          return 'Enter a valid email';
                        }return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'ex: jon.smith@email.com',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(
                                255, 136, 136, 136), // Customize hint text color
                            fontSize: 15.0,
                            // Customize hint text size
                          ),

                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 25.0),
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
                        if(text==null || text.isEmpty){
                            return "password can't be empty";
                        } return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        hintText: '*********',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 136, 136, 136), // Customize hint text color
                          fontSize: 15.0, // Customize hint text size
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: SizedBox(
                        width: 288,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                            final LoginModel loginEntity= LoginModel(email: _emailController.text, password: _passwordController.text);
                            BlocProvider.of<AuthBloc>(context).add(LoginEvent(loginEntity: loginEntity));}
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(152, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 63, 81, 243),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text('SIGN IN'),
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
                            'Don’t have an account? ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 111, 111, 111)),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                'SIGNUP',
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
        },
      )),
    );
  }
}
