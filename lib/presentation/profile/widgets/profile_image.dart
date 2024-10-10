import 'package:cached_network_image/cached_network_image.dart';

import 'package:employee_attendance/core/static/svg_path.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profileImage,
    this.onTap,
    this.isPhotoEditable = false,
  });
  final String profileImage;
  final VoidCallback? onTap;
  final bool? isPhotoEditable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        if (isPhotoEditable!) ...[
          Positioned(
            right: 10,
            top: 0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: padding8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}
