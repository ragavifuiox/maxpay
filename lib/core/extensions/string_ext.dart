extension BulletText on String {
  String get bulletText {
    // Split by either literal "\n" or actual newline control characters
    var bulletPoints = split(RegExp(r'\\n|\n'));

    // Remove empty strings and trim each item
    bulletPoints = bulletPoints
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    // Format as bullet list
    return bulletPoints.map((item) => '• $item').join('\n');
  }
}
