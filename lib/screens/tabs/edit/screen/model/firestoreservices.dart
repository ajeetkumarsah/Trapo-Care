import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Post.dart';

final CollectionReference usersPostsCollection =
    Firestore.instance.collection('usersPosts');
final CollectionReference updatedPostsCollection =
    Firestore.instance.collection('Have any Leads'); //updatedPosts
final CollectionReference oxygenInfoCollection =
    Firestore.instance.collection('oxygen');
final CollectionReference plasmaBloodInfoCollection =
    Firestore.instance.collection('plasmaBlood');
final CollectionReference ambulanceInfoCollection =
    Firestore.instance.collection('ambulance');
final CollectionReference homeCareInfoCollection =
    Firestore.instance.collection('homeCare');
final CollectionReference pvtHospitalInfoCollection =
    Firestore.instance.collection('pvtHospitals');
final CollectionReference mentalHeathInfoCollection =
    Firestore.instance.collection('mentalHealthResource');
final CollectionReference medicineDeliveryInfoCollection =
    Firestore.instance.collection('teleMedicineDelivery');
final CollectionReference mealsDeliveryInfoCollection =
    Firestore.instance.collection('mealsDelivery');
final CollectionReference ventilatorInfoCollection =
    Firestore.instance.collection('ventilators');

class FirestoreService {
  Future<Post> createUserPost(
      String username,
      String hName,
      String hContact,
      String otherInfo,
      String resourcestype,
      String hospitalAddress,
      String verifiedBy) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(usersPostsCollection.document());

      final Post post = new Post(username, hName, hContact, otherInfo,
          resourcestype, hospitalAddress, verifiedBy);
      final Map<String, dynamic> data = post.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Post.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = usersPostsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getUsersPostsList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = updatedPostsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getOxygenInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = oxygenInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getPlasmaBloodInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = plasmaBloodInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getAmbulanceInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = ambulanceInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getHomeCareInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = homeCareInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getPvtHospitalInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = pvtHospitalInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getMentalHealthResourcesList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = mentalHeathInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getTeleMedicineDeliveryList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        medicineDeliveryInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getMealsDeliveryList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = mealsDeliveryInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getVentilatorList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = ventilatorInfoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
