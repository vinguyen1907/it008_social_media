import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

final User? user = authInstance.currentUser;
final uid = user!.uid;

// collection ref
final CollectionReference usersRef = firestore.collection('users');
final CollectionReference storiesRef = firestore.collection('stories');
final CollectionReference followRef = firestore.collection('follow');
final CollectionReference postsRef = firestore.collection('posts');

// storage ref
final storageRef = FirebaseStorage.instance.ref();
