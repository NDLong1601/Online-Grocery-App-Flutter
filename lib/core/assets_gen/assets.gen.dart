// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/ReadexPro-Medium-w500.ttf
  String get readexProMediumW500 => 'assets/fonts/ReadexPro-Medium-w500.ttf';

  /// File path: assets/fonts/ReadexPro-Regular-w400.ttf
  String get readexProRegularW400 => 'assets/fonts/ReadexPro-Regular-w400.ttf';

  /// File path: assets/fonts/ReadexPro-SemiBold-w600.ttf
  String get readexProSemiBoldW600 =>
      'assets/fonts/ReadexPro-SemiBold-w600.ttf';

  /// List of all assets
  List<String> get values => [
    readexProMediumW500,
    readexProRegularW400,
    readexProSemiBoldW600,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_add.png
  AssetGenImage get icAdd => const AssetGenImage('assets/icons/ic_add.png');

  /// File path: assets/icons/ic_bonus.png
  AssetGenImage get icBonus => const AssetGenImage('assets/icons/ic_bonus.png');

  /// File path: assets/icons/ic_box.png
  AssetGenImage get icBox => const AssetGenImage('assets/icons/ic_box.png');

  /// File path: assets/icons/ic_chart.svg
  SvgGenImage get icChart => const SvgGenImage('assets/icons/ic_chart.svg');

  /// File path: assets/icons/ic_favorites.png
  AssetGenImage get icFavorites =>
      const AssetGenImage('assets/icons/ic_favorites.png');

  /// File path: assets/icons/ic_favourites.png
  AssetGenImage get icFavourites =>
      const AssetGenImage('assets/icons/ic_favourites.png');

  /// File path: assets/icons/ic_filter.png
  AssetGenImage get icFilter =>
      const AssetGenImage('assets/icons/ic_filter.png');

  /// File path: assets/icons/ic_history.png
  AssetGenImage get icHistory =>
      const AssetGenImage('assets/icons/ic_history.png');

  /// List of all assets
  List<dynamic> get values => [
    icAdd,
    icBonus,
    icBox,
    icChart,
    icFavorites,
    icFavourites,
    icFilter,
    icHistory,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_apecoin.png
  AssetGenImage get imgApecoin =>
      const AssetGenImage('assets/images/img_apecoin.png');

  /// File path: assets/images/img_apple.png
  AssetGenImage get imgApple =>
      const AssetGenImage('assets/images/img_apple.png');

  /// File path: assets/images/img_avalanche.png
  AssetGenImage get imgAvalanche =>
      const AssetGenImage('assets/images/img_avalanche.png');

  /// File path: assets/images/img_avatar.png
  AssetGenImage get imgAvatar =>
      const AssetGenImage('assets/images/img_avatar.png');

  /// File path: assets/images/img_bitcoin.png
  AssetGenImage get imgBitcoin =>
      const AssetGenImage('assets/images/img_bitcoin.png');

  /// File path: assets/images/img_bnb.png
  AssetGenImage get imgBnb => const AssetGenImage('assets/images/img_bnb.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    imgApecoin,
    imgApple,
    imgAvalanche,
    imgAvatar,
    imgBitcoin,
    imgBnb,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
