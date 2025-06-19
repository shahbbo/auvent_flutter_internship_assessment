import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';
import '../models/home_item_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeItemModel>> getServices();
  Future<List<HomeItemModel>> getAds();
  Future<List<HomeItemModel>> getRestaurants();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  FirebaseFirestore firestore;
  FirebaseStorage storage;
  FirebaseAuth firebaseAuth;

  HomeRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
    required this.firebaseAuth,
  });

  bool get _isSignedIn => firebaseAuth.currentUser != null;

  void _checkAuth() {
    if (!_isSignedIn) {
      throw AuthException('You must be logged in to access this resource.');
    }
  }

  @override
  Future<List<HomeItemModel>> getServices() async {
    _checkAuth();
    try {
      final servicesCollection = await firestore.collection('services').get();
      return servicesCollection.docs.map((doc) {
        final data = doc.data();
        return HomeItemModel(
          id: doc.id,
          image: data['image'] ?? '',
          name: data['name'] ?? '',
          overlayText: data['offer'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      _handleFirebaseException(e, 'services');
    }
    throw ServerException(
      'An error occurred while fetching services: Unknown error',
    );
  }

  @override
  Future<List<HomeItemModel>> getRestaurants() async {
    _checkAuth();
    try {
      final restaurantsCollection =
          await firestore.collection('restaurants').get();
      return restaurantsCollection.docs.map((doc) {
        final data = doc.data();
        return HomeItemModel(
          id: doc.id,
          image: data['image'] ?? '',
          name: data['name'] ?? '',
          overlayText: data['delivery'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      _handleFirebaseException(e, 'restaurants');
    }
    throw ServerException(
      'An error occurred while fetching restaurants: Unknown error',
    );
  }

  @override
  Future<List<HomeItemModel>> getAds() async {
    _checkAuth();
    try {
      final result = await storage.ref('ads').listAll();
      final adsList = await Future.wait(
        result.items.map((ref) async {
          final downloadUrl = await ref.getDownloadURL();
          final adName = ref.name.replaceAll('.jpg', '').replaceAll('.png', '');
          return HomeItemModel(
            id: ref.name,
            image: downloadUrl,
            name: adName,
            overlayText: null,
          );
        }),
      );
      return adsList;
    } on FirebaseException catch (e) {
      _handleFirebaseException(e, 'ads');
    }
    throw ServerException(
      'An error occurred while fetching ads: Unknown error',
    );
  }

  void _handleFirebaseException(FirebaseException e, String from) {
    if (e.code == 'permission-denied') {
      throw AuthException('Permission denied to access $from.');
    } else if (e.code == 'unavailable') {
      throw NetworkException();
    } else {
      throw ServerException(
        'An error occurred while fetching $from: ${e.message ?? 'Unknown error'}',
      );
    }
  }
}
