import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/common/components/circle_photo.dart';
import 'package:insta_clone/view/common/dialog/confirm_dialog.dart';
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

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

    _nameController.text = profileUser.inAppUserName;
    _bioController.text = profileUser.bio;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).editProfile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            // TODO
            onPressed: showConfirmDialog(
              context: context,
              title: S.of(context).editProfile,
              content: S.of(context).editProfileConfirm,
              onConfirmed: (isConfirmed) {
                if (isConfirmed) {
                  _updateProfile(context);
                }
              },
            ),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (_, model, child) {
          return model.isProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        Center(
                          child: (_photoUrl == "")
                              ? Container()
                              : CirclePhoto(
                                  radius: 60.0,
                                  photoUrl: _photoUrl,
                                  isImageFromFile: _isImageFromFile,
                                ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          // todo
                          onTap: () => _picNewProfileImage(),
                          child: Text(
                            S.of(context).changeProfilePhoto,
                            style: changeProfilePhotoTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Name",
                          style: editProfileTitleTextStyle,
                        ),
                        TextField(
                          controller: _nameController,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Bio",
                          style: editProfileTitleTextStyle,
                        ),
                        TextField(
                          controller: _bioController,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future<void> _picNewProfileImage() async {
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

    Navigator.pop(context);
  }
}
