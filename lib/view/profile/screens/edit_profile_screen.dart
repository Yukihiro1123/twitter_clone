import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/style.dart';

import '../../../view_models/profile_view_model.dart';
import '../../common/circle_photo.dart';
import '../../common/confirm_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _photoUrl = "";
  bool _isImageFromFile = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;
    _isImageFromFile = false;
    _photoUrl = profileUser.photoUrl;
    _nameController.text = profileUser.appUserName;
    _bioController.text = profileUser.bio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => showConfirmDialog(
                context: context,
                title: "プロフィールの変更",
                content: "変更しても良いですか",
                onConfirmed: (isConfirmed) {
                  _updateProfile(context);
                }),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (_, model, child) {
          return model.isProcessing
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 16.0),
                        CirclePhoto(photoUrl: _photoUrl, radius: 50),
                        const SizedBox(height: 16.0),
                        Center(
                          child: InkWell(
                            onTap: () => _pickProfileImage(),
                            child: const Text(
                              "画像を変更",
                              style: changeProfilePhotoTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text("名前", style: editProfileTitleTextStyle),
                        TextField(controller: _nameController),
                        const SizedBox(height: 16.0),
                        const Text("プロフィール", style: editProfileTitleTextStyle),
                        TextField(controller: _bioController),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  _pickProfileImage() async {
    _isImageFromFile = false;
    final profileViewModel = context.read<ProfileViewModel>();
    _photoUrl = await profileViewModel.pickProfileImage();
    setState(() {
      _isImageFromFile = true;
    });
  }

  void _updateProfile(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.updateProfile(
      _nameController.text,
      _bioController.text,
      _photoUrl,
      _isImageFromFile,
    );
    if (!mounted) return;
    context.pop();
  }
}
