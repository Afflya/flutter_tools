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

  ByteData get asByteDataWithOffset => buffer.asByteData(offsetInBytes, lengthInBytes);

  int toUInt8() => asByteDataWithOffset.getUint8(0);

  int toUInt16() => asByteDataWithOffset.getUint16(0, Endian.little);

  int toUInt32() => asByteDataWithOffset.getUint32(0, Endian.little);

  BigInt toUInt64() => BigInt.from(asByteDataWithOffset.getUint64(0, Endian.little).toUnsigned(64));

  int toInt8() => asByteDataWithOffset.getUint8(0);

  int toInt16() => asByteDataWithOffset.getInt16(0, Endian.little);

  int toInt32() => asByteDataWithOffset.getInt32(0, Endian.little);

  int toInt64() => asByteDataWithOffset.getInt64(0, Endian.little);

  int? toUInt8Safely() {
    if (length < Uint8List.bytesPerElement) return null;
    return toUInt8();
  }

  int? toUInt16Safely() {
    if (length < Uint16List.bytesPerElement) return null;
    return toUInt16();
  }

  int? toIUInt32Safely() {
    if (length < Uint32List.bytesPerElement) return null;
    return toUInt32();
  }

  BigInt? toUInt64Safely() {
    if (length < Uint64List.bytesPerElement) return null;
    return toUInt64();
  }

  int? toInt8Safely() {
    if (length < Uint8List.bytesPerElement) return null;
    return toInt8();
  }

  int? toInt16Safely() {
    if (length < Uint16List.bytesPerElement) return null;
    return toInt16();
  }

  int? toInt32Safely() {
    if (length < Uint32List.bytesPerElement) return null;
    return toInt32();
  }

  int? toInt64Safely() {
    if (length < Uint64List.bytesPerElement) return null;
    return toInt64();
  }

  double toFloat32() => asByteDataWithOffset.getFloat32(0, Endian.little);

  double toFloat64() => asByteDataWithOffset.getFloat64(0, Endian.little);

  double? toFloat32Safely() {
    if (length < Float32List.bytesPerElement) return null;
    return toFloat32();
  }

  double? toFloat64Safely() {
    if (length < Float64List.bytesPerElement) return null;
    return toFloat64();
  }

  // without floating point
  double? toUnsignedDouble() {
    switch (length) {
      case 1:
        return toUInt8Safely()?.toDouble();
      case 2:
        return toUInt16Safely()?.toDouble();
      case 4:
        return toIUInt32Safely()?.toDouble();
      case 8:
        return toUInt64Safely()?.toDouble();
      default:
        return null;
    }
  }
}

extension ByteUtilsStringX on String {
  Uint8List get asBytes => Uint8List.fromList(cv.hex.decode(this));
}

extension ByteUtilsByteX on int {
  int getBit(int bit) => this & (1 << bit) == 0 ? 0 : 1;

  int setBit(int bit, int value) {
    return this | (value << bit);
  }

  Uint8List convertToUInt8List(int size) {
    switch (size) {
      case 1:
        return int8ToUInt8List;
      case 2:
        return int16ToUInt8List;
      case 4:
        return int32ToUInt8List;
      case 8:
        return int64ToUInt8List;
    }
    throw UnsupportedError('unsupported size');
  }

  Uint8List get int8ToUInt8List {
    return Uint8List.fromList([this]);
  }

  Uint8List get int16ToUInt8List {
    return Uint8List.fromList([
      this & 0xff,
      (this >> 8) & 0xff,
    ]);
  }

  Uint8List get int32ToUInt8List {
    return Uint8List.fromList([
      this & 0xff,
      (this >> 8) & 0xff,
      (this >> 16) & 0xff,
    ]);
  }

  Uint8List get int64ToUInt8List {
    return Uint8List.fromList([
      this & 0xff,
      (this >> 8) & 0xff,
      (this >> 16) & 0xff,
      (this >> 32) & 0xff,
    ]);
  }
}
