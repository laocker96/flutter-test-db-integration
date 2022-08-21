import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:test_db/models/user.dart';

class MyPaginatedDataTable extends StatelessWidget {
  const MyPaginatedDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder<UserQuerySnapshot>(
        ref: usersRef,
        builder: (context, AsyncSnapshot<UserQuerySnapshot> snapshot,
            Widget? child) {
          if (snapshot.hasError) return const Text('Something went wrong!');
          if (!snapshot.hasData) return const Text('Loading users...');

          // Access the QuerySnapshot
          UserQuerySnapshot querySnapshot = snapshot.requireData;

          List<User> users =
              querySnapshot.docs.map((snap) => snap.data).toList();

          var usersData = UsersDataTableSource(users);

          return PaginatedDataTable(
            header: const Text('Users Table'),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Email'))
            ],
            rowsPerPage: 5,
            source: usersData,
          );
        });
  }
}

class UsersDataTableSource extends DataTableSource {
  List<User> users;

  UsersDataTableSource(this.users);

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(cells: [
      DataCell(Text(users[index].name)),
      DataCell(Text(users[index].age.toString())),
      DataCell(Text(users[index].email))
    ], index: index);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
