import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/feature_authentication/blocs/otp_bloc/otp_bloc.dart';
import 'package:sura_online_shopping_admin/feature_authentication/model/otp.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpBloc>(
      create: (context) => OtpBloc(
          phoneNUmber: context.read<AppBloc>().state.user.phoneNumber,
          username: context.read<AppBloc>().state.user.name,
          services: context.read<AppBloc>().services),
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            reverse: true,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/image/mobile.png',
                      width: 150, height: 150),
                  const SizedBox(height: 20),
                  Text(
                    'Verification Code',
                    style: GoogleFonts.bebasNeue(
                        fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We have sent the verification code to ',
                    style: GoogleFonts.bebasNeue(
                        fontWeight: FontWeight.normal, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  Text('mobile number!',
                      style: GoogleFonts.bebasNeue(
                          fontWeight: FontWeight.normal, fontSize: 22)),
                  const SizedBox(height: 10),
                  Builder(builder: (context) {
                    return Text(context.read<OtpBloc>().phoneNUmber.value,
                        style: GoogleFonts.bebasNeue(
                            fontWeight: FontWeight.normal, fontSize: 22));
                  }),
                  const SizedBox(height: 10),
                  Builder(builder: (context) {
                    return _smsInputField(context);
                  }),
                  const SizedBox(height: 10),
                  Builder(builder: (context) {
                    return _resendButton(context);
                  }),
                  const SizedBox(height: 50),
                  Builder(builder: (context) {
                    return _submitButton(context);
                  })
                ],
              ),
            ),
          )),
    );
  }

  Widget _resendButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('haven\'t received yet?',
            style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.normal, fontSize: 18)),
        const SizedBox(width: 10),
        TextButton(
            onPressed: () {
              BlocProvider.of<OtpBloc>(context, listen: false)
                  .add(ResendButtonEvent());
            },
            child: Text('Resend',
                style: GoogleFonts.bebasNeue(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                    fontSize: 18)))
      ],
    );
  }

  Widget _submitButton(context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                height: 55.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text('Submit'),
                  onPressed: () {
                    BlocProvider.of<OtpBloc>(context, listen: false)
                        .add(OtpScreenSubmitEvent(context: context));
                  },
                ),
              );
      },
    );
  }

  Widget _smsInputField(context) {
    return Pinput(
        onChanged: (text) {
          BlocProvider.of<OtpBloc>(context, listen: false)
              .add(OtpCodeChangeEvent(otpCode: OtpCode.dirty(text)));
        },
        keyboardType: TextInputType.number,
        length: 6,
        defaultPinTheme: PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            border: Border.all(color: Colors.blue[100]!),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        disabledPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(
                fontSize: 20,
                color: Colors.blue[100],
                fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
              borderRadius: BorderRadius.circular(20),
            )));
  }
}
