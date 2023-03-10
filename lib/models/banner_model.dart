class BannerModel {
  final String? categoryName;
  final String? date;
  final String? catalogImgUrl;
  final String? catagoryUrl;

  BannerModel(this.categoryName, this.date, this.catalogImgUrl,
      {this.catagoryUrl = ""});
}
