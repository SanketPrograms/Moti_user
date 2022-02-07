import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  var currentPosition;
  var currentLocationAddress;
  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentLocationAddress != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                currentLocationAddress,
                style: TextStyle(fontSize: 23),
              ),
            ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text("Get Current Location",
                style: TextStyle(fontSize: 22, color: Colors.white)),
            onPressed: () {
              getCurrentLocation();
            },
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    ));
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    getCurrentLocationAddress();
    debugPrint(currentPosition.toString() + "current location is ");
  }

  getCurrentLocationAddress() async {
    try {
      currentPosition;
      List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = listPlaceMarks[0];

      setState(() {
        currentLocationAddress =
            "${place.street},${place.name},${place.locality} ${place.postalCode},${place.administrativeArea}";

        debugPrint(currentLocationAddress.toString());
      });
    } catch (e) {
      debugPrint(e.toString() + "Issue 2 ");
    }
  }


  ///////////////////////////////CHeck For A Permissons my user//////////////////////////////////////
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return getCurrentLocation();
  }
}
