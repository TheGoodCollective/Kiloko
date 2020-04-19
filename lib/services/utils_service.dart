import 'dart:convert';
import 'dart:math';

class UtilsService {

    static String generateCode({int length = 32}) {
      Random random = Random.secure();
      var values = List<int>.generate(length, (i) => random.nextInt(256));
      return values.join('');
      // return base64Url.encode(values);
    }

}