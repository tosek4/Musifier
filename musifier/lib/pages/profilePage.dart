import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../widgets/button.dart';
import '../widgets/navBar.dart';
import '../widgets/textInput.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _imageFile;

  final int _currentIndex = 3;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        setState(() {
          _imageFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _handleSave() {
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Address: ${_addressController.text}');
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
                IconButton(
                  padding: const EdgeInsets.only(right: 24),
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
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
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
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
                  trailing: const Icon(Icons.edit, color: Colors.white54, size: 16,),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email address',
                  icon: Icons.email_outlined,
                  trailing: const Icon(Icons.edit, color: Colors.white54, size: 16,),
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _addressController,
                  hintText: 'Add or insert your address',
                  labelText: 'Address',
                  icon: Icons.location_pin,
                  trailing: const Icon(Icons.edit, color: Colors.white54, size: 16,),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _handleSave,
                  child: CustomButton(
                    text: 'Save',
                    onPressed: _handleSave,
                  ),
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
