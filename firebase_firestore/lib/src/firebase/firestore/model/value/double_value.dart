// File created by
// Lung Razvan <long1eu>
// on 17/09/2018

import 'package:firebase_firestore/src/firebase/firestore/model/value/field_value.dart';
import 'package:firebase_firestore/src/firebase/firestore/model/value/number_value.dart';

/// A wrapper for float/double values in Firestore.
class DoubleValue extends NumberValue {
  static const DoubleValue nan = DoubleValue(double.nan);

  final double _value;

  const DoubleValue(this._value);

  factory DoubleValue.valueOf(double value) => DoubleValue(value);

  @override
  double get value => _value;

  /// -0.0 is not equal with 0.0
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is DoubleValue && runtimeType == other.runtimeType) {
      if ((identical(_value, -0.0) && identical(other._value, 0.0)) ||
          (identical(_value, 0.0) && identical(other._value, -0.0))) {
        return false;
      }

      return _value == other._value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _value.hashCode;

  /// Comparing NaN's should return 0, if [this] is NaN it should return -1 and
  /// if [other] is NaN it should return 1
  @override
  int compareTo(FieldValue other) {
    if (other is! NumberValue) {
      return defaultCompareTo(other);
    }

    final NumberValue otherValue = other;
    if (value.isNaN && otherValue.value.isNaN) {
      return 0;
    } else if (value.isNaN) {
      return -1;
    } else if (otherValue.value is double && otherValue.value.isNaN) {
      return 1;
    } else if (otherValue.value == value) {
      return 0;
    }

    return value.compareTo(other.value as num);
  }
}
