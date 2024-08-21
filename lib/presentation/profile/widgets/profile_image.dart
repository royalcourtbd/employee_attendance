import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.profileImage});
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        color: Colors.white,
        colorBlendMode: BlendMode.color,
        imageUrl: profileImage ?? '',
        placeholder: (context, url) =>
            const Icon(Icons.image, color: Colors.grey),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 170,
        height: 170,
        fit: BoxFit.cover,
      ),
    );
  }
}
