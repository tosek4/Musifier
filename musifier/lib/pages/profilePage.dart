import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musifier/auth/auth.dart';
import 'package:musifier/pages/loginPage.dart';
import 'package:musifier/pages/mapPage.dart';
import 'package:musifier/widgets/signOutButton.dart';
import '../widgets/button.dart';
import '../widgets/navBar.dart';
import '../widgets/textInput.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _imageUrl;
  final user = Auth().currentUser;
  final int _currentIndex = 3;
  String _locationName = '';

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _nameController.text = user?.displayName ?? '';
      _emailController.text = user?.email ?? '';

      _fetchUserAddress();
      _fetchUserProfile();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    try {
      await Auth().signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _fetchUserProfile() async {
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          _imageUrl = doc['profileImageBase64']; 
        });
      }
    }
  }

  Future<void> _fetchUserAddress() async {
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          setState(() {
            _addressController.text = doc['address'] ?? '';
          });
        }
      } catch (e) {
        print('Error fetching address: $e');
      }
    }
  }

  Future<void> _fetchLocationName(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        String address =
            "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}";
        setState(() {
          _locationName = address;
          _addressController.text = address; 
        });
      }
    } catch (e) {
      print('Error fetching location name: $e');
    }
  }

  Future<void> _updateFirebaseAddress() async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
          {
            'address': _addressController.text,
          },
          SetOptions(merge: true),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address updated successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update address: $e")),
        );
      }
    }
  }

  Future<void> _uploadBase64ToFirebase(String base64String) async {
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'profileImageBase64': base64String,
      });

      setState(() {
        _imageUrl = base64String;
      });

    } catch (e) {
      print("Error uploading Base64 image: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, 
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.single.bytes;

        if (fileBytes != null) {
          String base64String = base64Encode(fileBytes);
          await _uploadBase64ToFirebase(base64String);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _handleSave() async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'address': _addressController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B37),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SignOutButton(onPressed: _signOut)
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito-Regular',
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _imageUrl != null
                            ? MemoryImage(base64Decode(_imageUrl!))
                                as ImageProvider
                            : const AssetImage('assets/avatar.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF6156E2),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const Text(
                      'Change Picture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Nunito-Regular',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  controller: _nameController,
                  hintText: 'Enter your name',
                  labelText: 'Full name',
                  icon: Icons.person_outlined,
                  trailing: const Icon(
                    Icons.edit,
                    color: Colors.white54,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email address',
                  icon: Icons.email_outlined,
                  readOnly: true, 
                  trailing: const Icon(
                    Icons.edit,
                    color: Colors.white54,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _addressController,
                  hintText: 'Add or insert your address',
                  labelText: 'Address',
                  icon: Icons.location_pin,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final LatLng? location = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(),
                      ),
                    );

                    if (location != null) {
                      setState(() {});

                      await _fetchLocationName(location);
                      await _updateFirebaseAddress();
                    }
                  },
                  child: const Text('Select Location'),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Save',
                  onPressed: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
}
