import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  firebase_auth.FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  FirebaseMessaging get messaging => _messaging;

  Future<void> initializeFirebase() async {
    await _messaging.requestPermission();
  }

  Future<String?> getDeviceToken() async {
    return await _messaging.getToken();
  }
}
