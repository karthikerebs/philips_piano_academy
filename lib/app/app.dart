import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/app/injector/injector.dart';
import 'package:music_app/app/router/router.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/application/chat/chat_bloc.dart';
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart';
import 'package:music_app/src/application/home/home_bloc.dart';
import 'package:music_app/src/application/installment/installment_bloc.dart';
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart';
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart';
import 'package:music_app/src/application/profile/profile_bloc.dart';
import 'package:music_app/src/application/refund/refund_bloc.dart';
import 'package:music_app/src/application/renewal/renewal_bloc.dart';
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart';
import 'package:music_app/src/presentation/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<SlotBookingBloc>()),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<NormalClassBloc>()),
        BlocProvider(create: (context) => getIt<CreditClassBloc>()),
        BlocProvider(create: (context) => getIt<PaidClassBloc>()),
        BlocProvider(create: (context) => getIt<InstallmentBloc>()),
        BlocProvider(create: (context) => getIt<RefundBloc>()),
        BlocProvider(create: (context) => getIt<ChatBloc>()),
        BlocProvider(create: (context) => getIt<RenewalBloc>()),
      ],
      child: MaterialApp(
        title: 'Philips Piano Academy',
        navigatorKey: navigatorKey,
        initialRoute: RouterConstants.splashRoute,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
