class Utils {
  static decodeUrl(String storename) {
    return Uri.encodeComponent(storename).replaceAll(' ', '+');
  }

  static formatPagerange(String? str, {int padding = 3}) {
    if (str == null || str.isEmpty) return '';
    return str.padLeft(padding, '0');
  }
}
