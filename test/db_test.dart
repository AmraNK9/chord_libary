import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/datasource/local_datasource.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  test('get artist test', () async {
    final LocalDataSource localDataSource = LocalDataSource();
    Database db = await localDataSource.database;
    print(db.isOpen);
    final data = localDataSource.getArtists();
    data.fold((left) {
      if (left is LocalFailure) {
        print(left.error);
      }
    }, (right) => prints(right.toString()));
  });
}
