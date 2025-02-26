import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/logger/logger.dart';

part 'user_repository.g.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUsername() async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc(uid).get();

    return userDoc.data()?['username'] as String?;
  }

  Future<void> updateUsername(String username) async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore.collection('users').doc(uid).update(<Object, Object?>{
        'username': username,
      });
      logger.info(message: 'Username updated successfully');
    } catch (e, stackTrace) {
      logger.error(message: 'Error updating username: $e', stack: stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepository();
}
