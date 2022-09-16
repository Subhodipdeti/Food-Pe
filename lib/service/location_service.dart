import 'dart:convert' as convert;
import 'package:food_pe/constant/config.dart';
import 'package:food_pe/constant/errors.dart';
import 'package:food_pe/models/address.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const String base_url = "api.locationiq.com";

class LocationService {
  static Future<Address> getAddressByLoc(double lat, double lon) async {
    try {
      final url = Uri.https(base_url, '/v1/reverse', {
        'key': Config.API_KEY,
        'lat': '$lat',
        'lon': '$lon',
        'format': 'json'
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
        // ignore: prefer_typing_uninitialized_variables
        late Address filteredPlaces;
        final data = convert.jsonDecode(response.body);
        filteredPlaces = Address(
            address: data["display_name"].toString(),
            display_address: '${data['address']['road']}'.toString());

        return filteredPlaces;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<Address>> searchAddress(String search) async {
    try {
      final url = Uri.https(
          base_url, '/v1/autocomplete', {'key': Config.API_KEY, 'q': search});

      final response = await http.get(url);
      if (response.statusCode == 200) {
        late List<Address> filteredPlaces = [];
        for (final place in convert.jsonDecode(response.body)) {
          filteredPlaces.add(Address(
              address: place["display_place"],
              display_address:
                  '${place['address']['name']}, ${place['address']['country']}'));
        }
        return filteredPlaces;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }
}
