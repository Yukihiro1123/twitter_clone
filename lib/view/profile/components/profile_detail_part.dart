import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

import 'profile_bio.dart';
import 'profile_image.dart';
import 'profile_records.dart';

class ProfileDetailPart extends StatelessWidget {
  const ProfileDetailPart({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => context.push('/edit_profile'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('プロフィールを編集'),
              )
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
