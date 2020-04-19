import 'dart:math';

class UtilsService {

    static String generateCode() {
      Random random = Random.secure();
      var values = List<int>.generate(4, (i) => random.nextInt(256));
      return values.join('').substring(0, 7);
      // return base64Url.encode(values);
    }

}