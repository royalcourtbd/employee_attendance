import 'package:cached_network_image/cached_network_image.dart';

import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileImage});
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: profileImage.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: profileImage,
                placeholder: (context, url) =>
                    const Icon(Icons.image, color: Colors.grey),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.grey),
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              )
            : Image.asset(
                SvgPath.icDemoUser,
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
