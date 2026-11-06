import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sikovis/presentation/booking_screen.dart';

import 'package:sikovis/presentation/main_screen.dart';
import 'package:sikovis/presentation/register_screen.dart';
import 'package:sikovis/presentation/signin_screen.dart';

import 'package:sikovis/cubit/profile_cubit.dart/profile_cubit.dart';
import 'package:sikovis/cubit/booking_cubit/booking_cubit.dart';
import 'package:sikovis/presentation/splash_screen.dart';
import 'package:sikovis/presentation/update_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('user');
  await Hive.openBox('users'); // Store registered users
  await Hive.openBox('bookings'); // Store bookings

  await initializeDateFormatting('id_ID', null); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()..loadProfile()),
        BlocProvider(create: (_) => BookingCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sikovis',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/sign-in': (context) => const SigninScreen(),
          '/main': (context) => const MainScreen(),
          '/booking': (context) => const ServiceBookingForm(),
          '/register': (context) => const RegistScreen(),
          '/update-profile': (context) => const UpdateProfileScreen(),
        }
      ),
    );
  }
}
