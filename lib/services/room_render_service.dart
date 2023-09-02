

import 'dart:convert';

import 'package:devameet_flutter/models/room_model.dart';
import 'package:flutter/services.dart';

abstract class RoomRenderService {
  Future<Map<String, DevameetAssetModel>> getDevameetAssets();
}

class ScaleHelper {
  static const SCALES = {
    "floor": 1.55,
    "wall": 1.55,
    "chair": 1.2,
    "table": 1.1,
    "decor": 1.3
  };

  static double getScaleAsset(String assetName) {
    final assetType = assetName.split("_")[0];
    return ScaleHelper.SCALES[assetType] ?? 1.0;
  }
}

class RoomRenderServiceImpl implements RoomRenderService {

  Future<Map<String, DevameetAssetModel>> getDevameetAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys.where((String key) => key.contains("devameet/")).toList();

    Map<String, DevameetAssetModel> devameetAssets = {};

    for (var imagePath in imagePaths) {
      final assetName = imagePath.split("/")[3].split(".")[0];
      final scale = ScaleHelper.getScaleAsset(assetName);

      final devameetAsset = DevameetAssetModel(
        name: assetName,
        source: imagePath,
        scale: scale
      );

      devameetAssets[assetName] = devameetAsset;

    }

    return devameetAssets;
  }

}