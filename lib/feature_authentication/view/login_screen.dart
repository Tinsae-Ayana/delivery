import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_authentication/blocs/login_bloc/login_bloc.dart';
import 'package:sura_online_shopping_admin/feature_authentication/view/otp_screen.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(services: context.read<Services>()),
      child: Builder(builder: (context) {
        return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.phoneNumStatus == Phoneverfied.verfiedPhone) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (centext) {
                  return const OtpScreen();
                }));
              }
            },
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/user.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text('Wellcome!',
                          style: GoogleFonts.bebasNeue(
                              fontWeight: FontWeight.normal, fontSize: 34)),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Sura Online Shopping and Delivery',
                        style: GoogleFonts.bebasNeue(
                            fontWeight: FontWeight.normal, fontSize: 24),
                      ),
                      const SizedBox(height: 25),
                      Builder(builder: (context) {
                        return _nameTextField(context);
                      }),
                      const SizedBox(height: 50),
                      Builder(builder: (context) {
                        return _phoneInputField(context);
                      }),
                      const SizedBox(height: 50),
                      Builder(builder: (context) {
                        return _loginButton(context);
                      })
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }

  Widget _phoneInputField(context) {
    return IntlPhoneField(
      showCursor: false,
      style: GoogleFonts.bebasNeue(),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.black, width: 3, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(30)),
        hintText: 'Phone Number',
        hintStyle: GoogleFonts.bebasNeue(),
      ),
      initialCountryCode: 'ET',
      onChanged: (phone) {
        BlocProvider.of<LoginBloc>(context, listen: false).add(PhoneChangeEvent(
            phoneNUmber: PhoneNUmber.dirty(phone.completeNumber)));
      },
    );
  }

  Widget _nameTextField(context) {
    return TextField(
      showCursor: false,
      keyboardType: TextInputType.name,
      style: GoogleFonts.bebasNeue(),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.blue,
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.black, width: 3, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(30)),
        hintText: 'Name',
        hintStyle: GoogleFonts.bebasNeue(),
      ),
      onChanged: (name) {
        BlocProvider.of<LoginBloc>(context, listen: false)
            .add(NameChangeEvent(name: name));
      },
    );
  }

  Widget _loginButton(context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status == FormzStatus.submissionInProgress
          ? const CircularProgressIndicator()
          : Container(
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    final name =
                        BlocProvider.of<LoginBloc>(context, listen: false)
                            .state
                            .name;
                    final phone =
                        BlocProvider.of<LoginBloc>(context, listen: false)
                            .state
                            .phoneNUmber;
                    BlocProvider.of<AppBloc>(context, listen: false).add(
                        UserChangeEvent(
                            user: User(
                                id: '',
                                name: name,
                                phoneNumber: phone,
                                type: UserType.normal)));
                    BlocProvider.of<LoginBloc>(context, listen: false)
                        .add(LoginButtonPressedEvent(context: context));
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.bebasNeue(
                        fontWeight: FontWeight.normal, fontSize: 24),
                  )),
            );
    });
  }
}
