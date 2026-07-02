import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vnote_client/constants/navigation_factory.dart';
import 'package:vnote_client/features/forgot_password_screen/forgot_password.controller.dart';
import 'package:vnote_client/features/home_screen/home.controller.dart';
import 'package:vnote_client/features/landing_screen/landing.controller.dart';
import 'package:vnote_client/features/language_selector_screen/language.controller.dart';
import 'package:vnote_client/features/lock_screen/lockscreen.controller.dart';
import 'package:vnote_client/features/onboarding_screen/onboarding.controller.dart';
import 'package:vnote_client/features/questionare_screen/questionare.controller.dart';
import 'package:vnote_client/features/registration_screen/registration.controller.dart';
import 'package:vnote_client/features/registration_screen/views/registration_otp_view.dart';
import 'package:vnote_client/features/registration_screen/views/registration_welcome.controller.dart';
import 'package:vnote_client/features/splash_screen/splash.controller.dart';
import 'package:vnote_client/features/subscription_screen/subscription.controller.dart';
import 'package:vnote_client/features/welcome_screen/welcome.controller.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.bloc.dart';
import 'package:vnote_client/features/transaction_history_screen/transaction_history.controller.dart';
import 'package:vnote_client/features/transaction_statistics/transaction_statistics.controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenControllerBloc()),
        BlocProvider(create: (context) => GlobalColorModeControllerBloc()),
      ],
      child: MaterialApp(
        locale: const Locale("en"),
        supportedLocales: const [Locale('en'), Locale('hi'), Locale('pa'), Locale('ta'), Locale('te')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'VNote',
        debugShowCheckedModeBanner: false,
        initialRoute: NavigationFactory.homeScreen,
        routes: {
          NavigationFactory.splashScreen: (context) => const SplashScreenController(),
          NavigationFactory.landingScreen: (context) => const LandingControllerScreen(),
          NavigationFactory.onboardingScreen: (context) => const OnboardingControllerScreen(),
          NavigationFactory.questionareScreen: (context) => const QuestionareControllerScreen(),
          NavigationFactory.registrationScreen: (context) => const RegistrationControllerScreen(),
          NavigationFactory.forgotPasswordScreen: (context) => const ForgotPasswordControllerScreen(),
          NavigationFactory.registrationOtpScreen: (context) => const RegistrationOtpView(),
          NavigationFactory.welcomeScreen: (context) => const WelcomeScreenController(),
          NavigationFactory.registrationWelcomeScreen: (context) => const RegistrationWelcomeController(),
          NavigationFactory.languageSelectorScreen: (context) => const LanguageSelectorController(),
          NavigationFactory.subscriptionScreen: (context) => const SubscriptionController(),

          // MARK: Main Screens
          NavigationFactory.homeScreen: (context) => const HomeScreenController(),
          NavigationFactory.lockScreen: (context) => const LockScreenController(),
          NavigationFactory.transactionHistoryScreen: (context) => const TransactionHistoryScreen(),
          NavigationFactory.transactionStatisticsScreen: (context) => const TransactionStatisticsScreen(),
        },
      ),
    );
  }
}
