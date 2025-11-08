import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class FirestoreService {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem(Item item) async {
    await _itemsCollection.add(item.toMap());
  }

  Stream<List<Item>> getItemsStream() {
    return _itemsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> updateItem(Item item) async {
    await _itemsCollection.doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String itemId) async {
    await _itemsCollection.doc(itemId).delete();
  }
}
