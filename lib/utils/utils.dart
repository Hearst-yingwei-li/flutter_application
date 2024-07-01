class Utils {
  static decodeUrl(String storename) {
    return Uri.encodeComponent(storename).replaceAll(' ', '+');
  }

  static formatPagerange(String? str, {int padding = 3}) {
    if (str == null || str.isEmpty) return '';
    return str.padLeft(padding, '0');
  }

  static String getImageUrl(String storeName, int minorversion,
      {String? sorPagerange}) {
    if (sorPagerange != null) {
      return 'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=page$sorPagerange-2&s=$storeName&mv=$minorversion';
    } else {
      return 'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=$storeName&mv=$minorversion';
    }
  }

  //'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=native&s=61/4/610447&mv=2&type=.jpg&name=fg2403_art_01_01'
  static String getImageDownloadUrl(
      String storeName, int minorversion, String imageName) {
    String downloadStoreName = storeName.replaceAll('%2F', '/');

    return 'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=native&s=$downloadStoreName&mv=$minorversion&type=.jpg&name=$imageName';
  }
}
