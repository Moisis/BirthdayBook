import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'navhelper.dart';
import 'demo.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int _currentIndex = 1;
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // Fetch users and refresh screen
  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    users = await ApiService.fetchUsers();
    allUsers = users; // Update allUsers
    setState(() {
      isLoading = false;
    });
  }

  // Toggle favorite by user ID
  void toggleFavorite(dynamic user) {
    setState(() {
      int userId = user['id']; // Assuming each user has a unique 'id'
      if (favoriteUserIds.contains(userId)) {
        favoriteUserIds.remove(userId); // Remove from favorites
      } else {
        favoriteUserIds.add(userId); // Add to favorites
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birthday Book'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isFavorite =
                    favoriteUserIds.contains(user['id']); // Check by ID

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${user['firstName']} ${user['lastName']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.purple : Colors.grey,
                              ),
                              onPressed: () => toggleFavorite(user),
                            ),
                          ],
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
            navigateToPage(context, index);
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
