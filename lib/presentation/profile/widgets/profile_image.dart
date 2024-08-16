import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.userImage});
  final String? userImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CachedNetworkImage(
        imageUrl: userImage ?? '',
        placeholder: (context, url) =>
            const Icon(Icons.image, color: Colors.grey),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 170,
        height: 170,
      ),
    );
  }
}
