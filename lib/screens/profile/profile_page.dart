import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/service/authentication_service.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/custom_button_widget.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: const Text("Profile"),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  void onLogout() async {
    try {
      await AuthenticationService(FirebaseAuth.instance).signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.watch<User?>();
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context) / 2.5,
                width: double.infinity,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: userDetails != null
                            ? Container(
                                height: 200,
                                width: 200,
                                color: Colors.amber.shade300,
                                child: Image.network(
                                  userDetails.photoURL.toString(),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center()),
                    const Divider(
                      height: Dimens.big_horizontal_margin,
                    ),
                    CustomTextWidget(
                      text: userDetails!.displayName.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    CustomTextWidget(
                      text: userDetails.email.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )),
              ),
              const Divider(
                height: Dimens.big_horizontal_margin,
              ),
              Material(
                color: Theme.of(context).colorScheme.onBackground,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orders_page);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.radius),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        const SizedBox(
                          width: Dimens.big_horizontal_margin,
                        ),
                        CustomTextWidget(
                          text: "Orders",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimens.radius),
                      child: CustomButtonWidget(
                          onPressed: onLogout,
                          child: const CustomTextWidget(
                            text: "Log Out",
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
