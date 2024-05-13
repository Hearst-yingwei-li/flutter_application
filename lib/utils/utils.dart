class Utils {
  static decodeUrl(String storename) {
    return Uri.encodeComponent(storename).replaceAll(' ', '+');
  }
}
