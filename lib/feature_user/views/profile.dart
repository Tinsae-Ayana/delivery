import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/models/phone_number.dart';
import 'package:sura_online_shopping_admin/feature_authentication/view/login_screen.dart';
import 'package:sura_online_shopping_admin/feature_user/blocs/bloc/profile_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final TextEditingController _name;
  late final TextEditingController _phoneNumber;
  @override
  void initState() {
    _phoneNumber = TextEditingController(
        text:
            context.read<AppBloc>().state.user.phoneNumber.value.substring(4));
    _name =
        TextEditingController(text: context.read<AppBloc>().state.user.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context, listen: false)
        .add(NameChangeEvent(name: context.read<AppBloc>().state.user.name));
    debugPrint(context.read<AppBloc>().state.user.name);
    BlocProvider.of<ProfileBloc>(context, listen: false).add(
        PhoneNumberChangeEvent(
            phoneNumber: context.read<AppBloc>().state.user.phoneNumber));
    debugPrint(context.read<AppBloc>().state.user.phoneNumber.toString());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(SaveButtonEvent(
                      context: context,
                      userId: context.read<AppBloc>().state.user.id));
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        child: Ink.image(
                          image: context.read<AppBloc>().state.user.photo !=
                                  null
                              ? NetworkImage(
                                      context.read<AppBloc>().state.user.photo!)
                                  as ImageProvider
                              : const AssetImage('assets/image/man.png'),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: (() {
                              final imagePicker = ImagePicker();
                              imagePicker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) {
                                if (value != null) {
                                  context.read<ProfileBloc>().add(
                                      PhotoChangeEvent(
                                          photo: File(value.path)));
                                }
                              });
                            }),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) {
                    return previous != current;
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: 350,
                      child: TextField(
                          controller: _name,
                          onChanged: (value) {
                            context
                                .read<ProfileBloc>()
                                .add(NameChangeEvent(name: value));
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          )),
                    );
                  },
                ),
                const SizedBox(height: 50),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 350,
                      child: IntlPhoneField(
                        controller: _phoneNumber,
                        showCursor: false,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                        ),
                        initialCountryCode: 'ET',
                        onChanged: (phone) {
                          context.read<ProfileBloc>().add(
                              PhoneNumberChangeEvent(
                                  phoneNumber:
                                      PhoneNUmber.dirty(phone.completeNumber)));
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Logout()
              ],
            ),
          ),
        ));
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (() {
        context.read<AppBloc>().add(LogOutEvent());
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: ((context) {
          return const LoginScreen();
        })), (route) => false);
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: width * 0.9,
        height: height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            'Log Out',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
