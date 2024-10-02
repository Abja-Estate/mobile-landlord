import 'dart:ui';

import '../../../constants/app_images.dart';

String getIconAssetName(String iconKey) {
  switch (iconKey) {
    case 'Fumigator':
      return AppImages.fumigator;

    case 'Plumber':
      return AppImages.plumber;
    case 'Gardener':
      return AppImages.gardener;
    case 'Cleaner':
      return AppImages.cleaner;
    case 'Painter':
      return AppImages.painter;
    case 'Mover':
      return AppImages.movers;
    case 'House Agent':
      return AppImages.agent;
    case 'Carpenter':
      return AppImages.carpenter;
    case 'Electrician':
      return AppImages.electrician;

    default:
      return AppImages.electrician;
  }
}

Color getIconAssetColor(String iconKey) {
  switch (iconKey) {
    case 'Fumigator':
      return Color(0xFFFFE4E9);

    case 'Plumber':
      return Color(0xFFEADAFF);
    case 'Gardener':
      return Color(0xFFFFDFCC);
    case 'Cleaner':
      return Color(0xFFFBD9D7);
    case 'Painter':
      return Color(0xFFD3F8F1);
    case 'Mover':
      return Color(0xFFDAE7D9);
    case 'House Agent':
      return Color(0xFFDAE7D9);
    case 'Carpenter':
      return Color(0xFFDAE7D9);
    case 'Electrician':
      return Color(0xFFFCEADA);

    default:
      return Color(0xFFFCEADA);
  }
}

Color getIconAssetColorDeep(String iconKey) {
  switch (iconKey) {
    case 'Fumigator':
      return Color(0xFFFF7892);

    case 'Plumber':
      return Color(0xFF9747FF);
    case 'Gardener':
      return Color(0xFFFF5F00);
    case 'Cleaner':
      return Color(0xFFEA4335);
    case 'Painter':
      return const Color(0xFF22DBBA);
    case 'Mover':
      return Color(0xFF750790);
    case 'House Agent':
      return Color(0xFFDAE7D9);
    case 'Carpenter':
      return Color(0xFF5DADEC);
    case 'Electrician':
      return Color(0xFFEF9645);

    default:
      return Color(0xFFFCEADA);
  }
}
