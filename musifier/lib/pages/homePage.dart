import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musifier/auth/auth.dart';
import 'package:musifier/models/category.dart';
import 'package:musifier/pages/playListPage.dart';
import 'package:musifier/service/category_service.dart';
import 'package:musifier/widgets/navBar.dart';
import '../widgets/boxSong.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  final int _currentIndex = 0;


  final CategoryService _categoryService = CategoryService();
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _categoryService.fetchCategories();

    _categoriesFuture.then((categories) {}).catchError((error) {
      print("Error fetching categories: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: const Text(
                  'MUSIFIER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommend for you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-Regular',
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Category>>(
                future: _categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No categories found."));
                  }
                  final categories = snapshot.data!;

                  return Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        children: categories.map((category) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylistPage(
                                    category: category,
                                    playlistId: category.playlists[0].id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 32) / 2,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ContentBox(
                                  image: NetworkImage(category.icon),
                                  text: category.name,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
}
