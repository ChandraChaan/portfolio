extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
}

double calculateAspectRatio(String imageUrl) {
  // Perform image loading and calculate aspect ratio
  // You can use your preferred method or library to load the image and retrieve its dimensions
  // For simplicity, this example uses the width and height directly

  // Replace the code below with your actual image loading and dimension retrieval logic
  double imageWidth = 800.0;
  double imageHeight = 600.0;

  return imageWidth / imageHeight;
}
