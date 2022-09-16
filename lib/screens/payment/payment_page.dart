import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/custom_button_widget.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:lottie/lottie.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.all(Dimens.radius),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: ClipOval(
            child: Container(
              color: Colors.black,
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessContainer() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Center(
                child: ClipOval(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Lottie.network(
                    "https://assets5.lottiefiles.com/packages/lf20_4qldwfx4.json",
                    fit: BoxFit.cover,
                    controller: _controller),
              ),
            )),
            const SizedBox(
              height: Dimens.big_horizontal_margin,
            ),
            CustomTextWidget(
              text: "Payment successful",
              style: Theme.of(context).textTheme.headline5,
            ),
            const CustomTextWidget(
                text: "Hooray! you have completed your payment")
          ],
        ),
      ),
    );
  }

  Widget _buildActionArea() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(Dimens.radius),
          height: DeviceUtils.getScaledHeight(context) / 3,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CustomTextWidget(
                    text: 'Amount',
                  ),
                  CustomTextWidget(
                    text: "Rs. ${args["amount"]}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              CustomButtonWidget(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, Routes.orders_page);
                  },
                  child: const CustomTextWidget(
                    text: "Orders",
                  ))
            ],
          )),
    );
  }

  Widget _buildMainContenet() {
    return Column(
      children: [_buildSuccessContainer(), _buildActionArea()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: _buildMainContenet());
  }
}
