import 'package:flutter/material.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class ToppingWidget extends StatefulWidget {
  final AsyncSnapshot snapshot;
  const ToppingWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<ToppingWidget> createState() => _ToppingWidgetState();
}

class _ToppingWidgetState extends State<ToppingWidget> {
  // ignore: non_constant_identifier_names
  late List topping_list = [];

  void onAddTopping(item) {
    if (topping_list.contains(item)) {
      var filtredValue = topping_list;
      filtredValue.remove(item);
      setState(() {
        topping_list = filtredValue;
      });
      onHandleToggleTopping();
      return;
    }

    setState(() {
      topping_list = [...topping_list, item];
    });
    onHandleToggleTopping();
  }

  void onHandleToggleTopping() {
    num totalPrice = 0;
    for (var element in topping_list) {
      totalPrice += element.price;
    }
    Provider.of<ProductProvider>(context, listen: false)
        .setToppingWithPrice(totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.snapshot.data.toppings.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final price = widget.snapshot.data.toppings[index].price.toString();
        return ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextWidget(text: "Rs. $price"),
              Checkbox(
                value:
                    topping_list.contains(widget.snapshot.data.toppings[index]),
                activeColor: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: MaterialStateBorderSide.resolveWith((states) =>
                    const BorderSide(width: 2.0, color: Colors.amber)),
                onChanged: (bool? value) {
                  onAddTopping(widget.snapshot.data.toppings[index]);
                },
              ),
            ],
          ),
          title:
              CustomTextWidget(text: widget.snapshot.data.toppings[index].name),
        );
      },
    );
  }
}
