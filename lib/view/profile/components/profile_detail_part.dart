import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data_models/user.dart';
import '../../../view_models/profile_view_model.dart';
import 'profile_bio.dart';
import 'profile_image.dart';
import 'profile_records.dart';

class ProfileDetailPart extends StatelessWidget {
  final User? selectedUser;
  const ProfileDetailPart({super.key, this.selectedUser});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final currentUser = profileViewModel.currentUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const ProfileImage(),
              ElevatedButton(
                  onPressed: () {
                    (selectedUser != null &&
                            selectedUser!.userId != currentUser.userId)
                        //TODO: 他者のページの場合はフォロー/フォロー解除
                        ? context.push('/edit_profile')
                        //自分のページの場合はプロフィール編集画面へ
                        : context.push('/edit_profile');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: (selectedUser != null &&
                          selectedUser!.userId != currentUser.userId)
                      //TODO: 他者のページの場合はフォロー/フォロー解除
                      ? const Text('フォロー')
                      //自分のページの場合はプロフィール編集画面へ
                      : const Text('プロフィールを編集'))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  ProfileBio(),
                  SizedBox(height: 10),
                  ProfileRecords(),
                ]),
          ),
        ),
      ],
    );
  }
}
