class BannerModel {
  final String? bannerName;
  final String? date;
  final String? bannerImgUrl;
  final String? bannerUrl;

  BannerModel(
    this.bannerName,
    this.date,
    this.bannerImgUrl, {
    this.bannerUrl = "",
  });
}
