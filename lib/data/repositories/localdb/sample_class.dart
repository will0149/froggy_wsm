

/**
 * Made for froggysoft.
 * By User: josedominguez
 * type: sample class to use database helper class
 * Date: 03/23/25
 */

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final DatabaseHelper _dbHelper = DatabaseHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _insertSampleData();
//   }
//
//   Future<void> _insertSampleData() async {
//     await _dbHelper.insertUser({'name': 'John Doe', 'email': 'john@example.com'});
//     await _dbHelper.insertUser({'name': 'Jane Smith', 'email': 'jane@example.com'});
//   }
//
//   Future<void> _fetchUsers() async {
//     List<Map<String, dynamic>> users = await _dbHelper.getUsers();
//     print(users);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SQLite in Flutter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _fetchUsers,
//               child: Text('Fetch Users'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }