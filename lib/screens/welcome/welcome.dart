// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:food_pe/constant/assets.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/provider/user_provider.dart';
import 'package:food_pe/service/authentication_service.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  var size, height, width;
  final List<String> welcomText = [
    "All the best restaurants with their top",
    "menu waiting for you, they can't wait",
    "for your order!"
  ];

  Widget _buildWelcomeImage() {
    return SizedBox(
      height: height / 3,
      child: Image.asset(
        Assets.welcomeBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildGetStartButton(BuildContext context) {
    void onSignin() async {
      try {
        final response = await AuthenticationService(FirebaseAuth.instance)
            .signInWithGoogle();
        if (response.user != null) {
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.user);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      } catch (e) {
        print(e);
      }
    }

    return SignInButton(Buttons.Google,
        padding: const EdgeInsets.all(Dimens.radius), onPressed: onSignin);
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        AutoSizeText("Felling Hungry?",
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(
          height: Dimens.vertical_padding,
        ),
        ...List.generate(welcomText.length, (position) {
          return AutoSizeText(
            welcomText[position],
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          );
        }),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: height / 3,
        width: width,
        color: Theme.of(context).colorScheme.onBackground,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.horizontal_padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWelcomeText(context),
              _buildGetStartButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [_buildWelcomeImage(), _buildMainContent(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = DeviceUtils.getScaledHeight(context);
    width = DeviceUtils.getScaledWidth(context);
    return Material(child: _buildBody(context));
  }
}
