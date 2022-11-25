import 'dart:typed_data';

import 'package:convert/convert.dart' as cv show hex;

BigInt bytesToBigInt(Uint8List bytes) {
  BigInt read(int start, int end) {
    if (end - start <= 4) {
      int result = 0;
      for (int i = end - 1; i >= start; i--) {
        result = result * 256 + bytes[i];
      }
      return BigInt.from(result);
    }
    final int mid = start + ((end - start) >> 1);
    final result = read(start, mid) + read(mid, end) * (BigInt.one << ((mid - start) * 8));
    return result;
  }

  return read(0, bytes.length);
}

Uint8List bigIntToBytes(final BigInt number) {
// Not handling negative numbers. Decide how you want to do that.
  BigInt temp = number;
  final int bytes = (number.bitLength + 7) >> 3;
  final b256 = BigInt.from(256);
  final result = Uint8List(bytes);
  for (int i = 0; i < bytes; i++) {
    result[i] = number.remainder(b256).toInt();
    temp = temp >> 8;
  }
  return result;
}

extension ByteArrayX on Uint8List {
  String get asHex => cv.hex.encode(this);
}

extension ByteUtilsStringX on String {
  Uint8List get asBytes => Uint8List.fromList(cv.hex.decode(this));
}
