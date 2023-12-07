// double _myLatitude = 0.0;
// double _myLongitude = 0.0;
// bool _isLoading = true;
// String _errorMessage = '';
//
// @override
// void initState() {
//   super.initState();
//   _getCurrentLocation();
// }
//
// Future<void> _getCurrentLocation() async {
//   try {
//     final hasPermission = await LocationUtils.handlePermission();
//     if (!hasPermission) throw 'Location permission not granted.';
//
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _myLatitude = position.latitude;
//       _myLongitude = position.longitude;
//       _isLoading = false;
//     });
//   } catch (e) {
//     setState(() {
//       _errorMessage = e.toString();
//       _isLoading = false;
//     });
//   }
// }
//
// double distanceInMeters =
// Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
//
//
//
//
