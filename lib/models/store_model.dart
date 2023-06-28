import 'package:aktuel_urunler_bim_a101_sok/constants/enums.dart';
import 'package:aktuel_urunler_bim_a101_sok/models/banner_model.dart';
import 'package:flutter/material.dart';

class StoreModel {
  final String logoPath;
  final String storeName;
  final StoreCode storeCode;
  final Future<List<BannerModel>> bannerDataFunc;
  final Color storeColor;

  StoreModel(
    this.logoPath,
    this.storeName,
    this.storeCode,
    this.bannerDataFunc,
    this.storeColor,
  );
}
