import 'dart:convert';

import 'package:devameet_flutter/models/room_model.dart';
import 'package:flutter/services.dart';

abstract class RoomRenderService {
  Future<Map<String, DevameetAssetModel>> getDevameetAssets();
  Map<String, Map<String, RoomObjectModel>> classifierRoomObjects(
      List<RoomObjectModel> objects);
  List<RoomRenderItemModel> generateRoomItems(Map<String, DevameetAssetModel> assets,
      Map<String, Map<String, RoomObjectModel>> classifiedsRoomObjects, double width);
  getDevameetAssetByRoomObject(Map<String, DevameetAssetModel> assets, RoomObjectModel object);
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

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains("devameet/"))
        .toList();

    Map<String, DevameetAssetModel> devameetAssets = {};

    for (var imagePath in imagePaths) {
      final assetName = imagePath.split("/")[3].split(".")[0];
      final scale = ScaleHelper.getScaleAsset(assetName);

      final devameetAsset =
          DevameetAssetModel(name: assetName, source: imagePath, scale: scale);

      devameetAssets[assetName] = devameetAsset;
    }

    return devameetAssets;
  }

  @override
  Map<String, Map<String, RoomObjectModel>> classifierRoomObjects(
      List<RoomObjectModel> objects) {
    Map<String, Map<String, RoomObjectModel>> classifiedsRoomObjects = {};

    for (var object in objects) {
      final zIndex = object.zIndex.toString();
      final coordinate = "${object.x}-${object.y}";

      if (!classifiedsRoomObjects.containsKey(zIndex)) {
        classifiedsRoomObjects[zIndex] = {};
      }

      classifiedsRoomObjects[zIndex]![coordinate] = object;
    }

    return classifiedsRoomObjects;
  }

  @override
  List<RoomRenderItemModel> generateRoomItems(Map<String, DevameetAssetModel> assets,
      Map<String, Map<String, RoomObjectModel>> classifiedsRoomObjects, double width) {
    List<RoomRenderItemModel> renderPool = [];

    final blockSize = width / 8;

    for (int zIndex = 0; zIndex <= classifiedsRoomObjects.length; zIndex++) {
      for (int y = 0; y <= 7; y++) {
        for (int x = 0; x <= 7; x++) {
          final coordinate = "$x-$y";

          final object = classifiedsRoomObjects[zIndex.toString()]?[coordinate];

          if(object == null) continue;

          final asset = getDevameetAssetByRoomObject(assets, object);

          if(asset == null) continue;

          final renderItem = RoomRenderItemModel(top: y * blockSize, left: x * blockSize, asset: asset);

          renderPool.add(renderItem);
        }
      }
    }

    return renderPool;
  }

  @override
  getDevameetAssetByRoomObject(Map<String, DevameetAssetModel> assets, RoomObjectModel object) {
      String orientation = object.orientation.isNotEmpty ? "_${object.orientation}" : "_front";
      final name = "${object.name}$orientation";
      final objectAsset = assets[name] ?? assets[object.name];

      return objectAsset;
  }
}
