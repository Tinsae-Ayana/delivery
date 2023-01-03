import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/commons/adim_home/screen/home.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/commons/user_home/screen/user_home.dart';
import 'package:sura_online_shopping_admin/feature_authentication/view/login_screen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: AnimatedSplashScreen(
        splashIconSize: 200,
        splash: Lottie.asset('assets/splash/online.json',
            height: 3000, width: 500, frameRate: FrameRate.max),
        nextScreen: const NextSplashScreen(),
        duration: 3200,
      ),
    );
  }
}

class NextSplashScreen extends StatelessWidget {
  const NextSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            if (state.intConStatus == true) {
              _pageChange(context);
            } else {
              showSimpleNotification(
                  const Text(
                    'No Internet Connection!',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                  background: Colors.red,
                  position: NotificationPosition.top,
                  elevation: 0,
                  duration: const Duration(seconds: 3));
            }
          },
          builder: ((context, state) {
            if (state.intConStatus == true) {
              if (context.read<AppBloc>().services.isUserLoggedIn() == true) {
                final id = context.read<AppBloc>().services.loggedInUser();
                context
                    .read<AppBloc>()
                    .services
                    .readUserFromFirebase(id: id)
                    .then((value) {
                  context.read<AppBloc>().add(UserChangeEvent(user: value));
                });
                return context.read<AppBloc>().state.user.type == UserType.admin
                    ? const Home()
                    : const UserHome();
              } else {
                return const LoginScreen();
              }
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/noConnection.png',
                          height: 100, width: 100),
                      const SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Connecting',
                            style: GoogleFonts.bebasNeue(
                                fontWeight: FontWeight.normal, fontSize: 25),
                          ),
                          const SizedBox(width: 10),
                          JumpingDotsProgressIndicator(
                            fontSize: 30,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }),
        ));
  }

  void _pageChange(context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      if (context.read<AppBloc>().services.isUserLoggedIn() == true) {
        final id = context.read<AppBloc>().services.loggedInUser();
        context
            .read<AppBloc>()
            .services
            .readUserFromFirebase(id: id)
            .then((value) {
          context.read<AppBloc>().add(UserChangeEvent(user: value));
        });
        return context.read<AppBloc>().state.user.type == UserType.admin
            ? const Home()
            : const UserHome();
      } else {
        return const LoginScreen();
      }
    }));
  }
}
