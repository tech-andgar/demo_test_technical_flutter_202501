extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word in the string.
  String titleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Capitalizes the first letter of each sentence in the string.
  String sentenceCase() {
    if (isEmpty) {
      return this;
    }

    // Split into sentences using common sentence terminators.
    final sentences = split(RegExp(r'(?<=[.?!])\s+'));

    return sentences.map((sentence) => sentence.trim().capitalize()).join(' ');
  }
}
