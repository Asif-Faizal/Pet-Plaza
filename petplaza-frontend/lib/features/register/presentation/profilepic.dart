import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petplaza/features/register/presentation/passcode.dart';

import '../bloc/register_user/register_user_bloc.dart';

class Profilepic extends StatefulWidget {
  const Profilepic({super.key});

  @override
  State<Profilepic> createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  File? _profileImage;
  final ImagePicker _profile = ImagePicker();

  // Method to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _profile.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Method to capture an image using the camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await _profile.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Method to remove the profile picture
  void _removeProfilePicture() {
    setState(() {
      _profileImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox.shrink(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 4,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.width / 5,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: _showImageSourceOptions,
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Please Upload profile picture to continue! ",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: Text("Upload"),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  onPressed: _pickImageFromCamera,
                  child: Text("Take Photo"),
                ),
              ),
              SizedBox(height: 100),
              // Conditionally show the "Continue" button only after the profile image is uploaded
              if (_profileImage != null)
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: BlocProvider.of<RegisterUserBloc>(
                              context), // Pass correct bloc
                          child: PasscodePage(profilePic: _profileImage!),
                        ),
                      ),
                    );
                  },
                  child: Text("Continue", style: theme.textTheme.bodyLarge),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Show a bottom sheet to choose between gallery, camera, or remove the picture
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Pick from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              // Add Remove option if there is a profile picture
              if (_profileImage != null)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove profile picture'),
                  onTap: () {
                    Navigator.pop(context);
                    _removeProfilePicture();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
