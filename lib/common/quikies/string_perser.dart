class StringParser {
  static List<String> parseSymptomsList(dynamic symptoms) {
    if (symptoms == null || symptoms.toString().trim() == '{}') {
      // Empty or null case
      return [];
    }

    // Convert to string and remove any outer spaces
    String symptomsStr = symptoms.toString().trim();

    // Check if it has a opening and closing brace format
    if (symptomsStr.startsWith('{') && symptomsStr.endsWith('}')) {
      // Extract content between braces (excluding the braces)
      symptomsStr = symptomsStr.substring(1, symptomsStr.length - 1);

      // Replace newlines with spaces to handle multiline input
      symptomsStr = symptomsStr.replaceAll('\n', ' ');

      // Split by commas and clean up each item
      List<String> symptomsList = symptomsStr
          .split(',')
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .toList();

      return symptomsList;
    }

    // If the format is not as expected, return empty list
    return [];
  }
}