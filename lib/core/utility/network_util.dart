import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class NetworkUtil {
  final NetworkInfo _networkInfo = NetworkInfo();
  final String _officeWifiSSID = 'Sayed';

  Future<bool> isConnectedToOfficeWifi() async {
    if (await _requestLocationPermission()) {
      try {
        String? wifiName = await _networkInfo.getWifiName();
        debugPrint('Connected to: $wifiName');

        if (wifiName == null) {
          debugPrint('Unable to get Wi-Fi name. Check app permissions.');
          return false;
        }

        // Remove quotes if present
        wifiName = wifiName.replaceAll('"', '');

        return wifiName == _officeWifiSSID;
      } catch (e) {
        debugPrint('Error checking Wi-Fi connection: $e');
        return false;
      }
    } else {
      debugPrint('Location permission denied');
      return false;
    }
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }
}
