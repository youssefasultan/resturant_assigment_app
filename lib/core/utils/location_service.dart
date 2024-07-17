import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Request location permissions if not already granted
    final status = await Permission.location.request();
    if (status.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } else {
      throw Exception('Location permission denied.');
    } 
  }
}
