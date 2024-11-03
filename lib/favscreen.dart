import 'package:flutter/material.dart';
import 'navhelper.dart';
import 'package:lab2/demo.dart'; // This includes favoriteUserIds and allUsers

class Favscreen extends StatefulWidget {
  @override
  State<Favscreen> createState() => _FavscreenState();
}

class _FavscreenState extends State<Favscreen> {
  int _currentIndex = 2;
  bool isLoading = true;
  List<dynamic> favoriteUsers = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() {
    // Filter all users to get only those in favoriteUserIds
    favoriteUsers = allUsers.where((user) => favoriteUserIds.contains(user['id'])).toList();

    // Sort the favorite users by birthdate
    favoriteUsers.sort((a, b) {
      // Function to format date
      String formatDate(String date) {
        List<String> parts = date.split('-');
        // Ensure year, month, and day are two digits
        String year = parts[0];
        String month = parts[1].padLeft(2, '0');
        String day = parts[2].padLeft(2, '0');
        return '$year-$month-$day';
      }
      // Parse the dates
      DateTime dateA = DateTime.parse(formatDate(a['birthDate']));
      DateTime dateB = DateTime.parse(formatDate(b['birthDate']));

      return dateA.compareTo(dateB);
    });

      setState(() {
        isLoading = false;
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Birthday Book"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteUsers.isEmpty
          ? Center(child: Text("No favorites added."))
          : ListView.builder(
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          final user = favoriteUsers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user['firstName']} ${user['lastName']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Age: ${user['age']}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${user['email']}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: ${user['phone']}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Birthday: ${user['birthDate']}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            navigateToPage(context, index); // Assuming this function is in navhelper
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Contracts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey.shade200,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
