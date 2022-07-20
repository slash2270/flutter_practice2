import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'line_theme.dart';

class LineUserInfoWidget extends StatelessWidget {
  const LineUserInfoWidget({Key? key,
        required this.userProfile,
        this.userEmail,
        required this.accessToken,
        required this.onSignOutPressed})
      : super(key: key);
  final UserProfile userProfile;
  final String? userEmail;
  final StoredAccessToken accessToken;
  final Function onSignOutPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (userProfile.pictureUrl ?? "").isNotEmpty
              ? Image.network(
            userProfile.pictureUrl!,
            width: 200,
            height: 200,
          )
              : const Icon(Icons.person),
          Text(
            userProfile.displayName,
            style: Theme.of(context).textTheme.headline5,
          ),
          if (userEmail != null) Text(userEmail!),
          Text(userProfile.statusMessage!),
          ElevatedButton(
              onPressed: () {
                onSignOutPressed.call();
              },
              style: ElevatedButton.styleFrom(
                  primary: accentColor, onPrimary: textColor),
              child: const Text('登出')),
        ],
      ),
    );
  }
}