import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_routes.dart';
import 'package:movie_app/core/constants/lang_keys.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({required this.posterImagePath, super.key});

  final String posterImagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network("${ApiRoutes.imageRoute}$posterImagePath",
          errorBuilder: (context, exception, stackTrace) {
        return SizedBox.square(
          dimension: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber, color: Colors.red, size: 30),
              Text(LangKeys.noImageFound)
            ],
          ),
        );
      }, loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      }, width: double.infinity, fit: BoxFit.cover),
    );
  }
}
