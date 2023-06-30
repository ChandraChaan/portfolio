extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}