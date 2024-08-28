import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';
import 'features/authentication/presentation/pages/splash_screen.dart';
import 'features/ecommerce/presentation/Bloc/product_bloc.dart';
import 'features/ecommerce/presentation/pages/add_page.dart';
import 'features/ecommerce/presentation/pages/details_page.dart';
import 'features/ecommerce/presentation/pages/home_page.dart';
import 'features/ecommerce/presentation/pages/search_page.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer= SimpleBlocObserver();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> di.sl<ProductBloc>(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/signin',
          routes: {
            '/': (context) => const HomePage(),
            '/splash':(context)=> const SplashScreen(),
            '/add': (context) => const AddPage(),
            '/details': (context) => const DetailsPage(),
            '/search': (context) => const SearchPage(),
            '/signin': (context)=>  SignInPage(),
            '/signup': (context) => SignUpPage()
            
          }),
    );
  }
}
