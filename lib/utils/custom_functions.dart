import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

String formatCurrency(num amount,{int decimalCount = 0}){
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);

}

String capitalize(String string) {
  return "${string[0].toUpperCase()}${string.substring(1)}";
}

Future<int> countItemsInFolder(String folderPath) async {
  int count = 0;

  // Get a reference to the folder in Firebase Storage
  Reference folderRef = FirebaseStorage.instance.ref().child(folderPath);

  // List all the items in the folder
  ListResult result = await folderRef.listAll();

  // Count the number of items
  count += result.items.length;

  // Recursively count items in subfolders
  for (Reference prefix in result.prefixes) {
    count += await countItemsInFolder(prefix.fullPath);
  }

  return count - 1;
}

Future<int> countFieldsInCollection(String collectionName) async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection(collectionName).get();

  return querySnapshot.size;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));