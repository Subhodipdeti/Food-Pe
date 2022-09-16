// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/provider/user_provider.dart';
import 'package:food_pe/service/location_service.dart';
import 'package:food_pe/widgets/custom_search_bar.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isLoading = false;
  List _searchList = [];

  _onHandleSearch(searchValue) async {
    if (searchValue.toString().isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await LocationService.searchAddress(searchValue);
        setState(() {
          _searchList = [...response];
        });
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      _onClearSearch();
    }
  }

  _onClearSearch() {
    setState(() {
      _searchList = [];
    });
  }

  void onClose() {
    Navigator.of(context).pop();
  }

  Widget _buildSearchList() {
    _onSelectAddres(address) {
      final addressStore = Provider.of<UserProvider>(context, listen: false);
      addressStore.setAddress(address);
      onClose();
    }

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: const Icon(Icons.pin_drop_outlined),
            title: InkWell(
              onTap: () {
                _onSelectAddres(_searchList[index].address);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: _searchList[index].display_address,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  CustomTextWidget(
                    text: _searchList[index].address,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          );
        }),
        separatorBuilder: ((context, _) {
          return const Divider();
        }),
        itemCount: _searchList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: Container(
          padding: const EdgeInsets.only(
              top: Dimens.button_height,
              right: Dimens.radius,
              left: Dimens.radius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: onClose,
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 40,
                    ),
                  ),
                  CustomTextWidget(
                    text: "Select a location",
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              const SizedBox(
                height: Dimens.big_horizontal_margin,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomSearchBar(
                    placeholder: "Search for area, street name...",
                    onChanged: _onHandleSearch),
              ),
              Expanded(child: _buildSearchList())
            ],
          ),
        ));
  }
}
