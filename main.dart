import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showup_mobile_app/home_navscreen.dart';
import 'providers/auth_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/location_provider.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/phone_login_screen.dart';
import 'screens/auth/otp_verify_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
          title: 'ShowUp Mobile App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // home: const AppNavigator(),
          home: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade200,
        body: const Center(
            child: Text('Content area',
                style: TextStyle(color: Colors.white, fontSize: 24))),
        bottomNavigationBar: SafeArea(child: FancyBottomNav()));
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        switch (authProvider.appState) {
          case AppState.splash:
            return SplashScreen(
              onComplete: () => authProvider.setAppState(AppState.onboarding),
            );
          case AppState.onboarding:
            return OnboardingScreen(
              onComplete: () => authProvider.setAppState(AppState.phoneLogin),
            );
          case AppState.phoneLogin:
            return PhoneLoginScreen(
              onSendOTP: (phone) {
                authProvider.setPhoneNumber(phone);
                authProvider.setAppState(AppState.otpVerify);
              },
            );
          case AppState.otpVerify:
            return OTPVerifyScreen(
              phone: authProvider.phoneNumber,
              onVerify: (otp) => authProvider.verifyOTP(otp),
              onBack: () => authProvider.setAppState(AppState.phoneLogin),
              onResend: () => authProvider.resendOTP(),
            );
          case AppState.signup:
            return SignupScreen(
              phone: authProvider.phoneNumber,
              onSignup: (user) => authProvider.signup(user),
              onBack: () => authProvider.setAppState(AppState.otpVerify),
            );
          case AppState.dashboard:
            return DashboardScreen(
              user: authProvider.currentUser!,
              onLogout: () => authProvider.logout(),
            );
        }
      },
    );
  }
}
