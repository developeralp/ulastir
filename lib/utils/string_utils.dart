import 'dart:math';

class StringUtils {
  static String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
}
