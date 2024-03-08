String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // Return empty string if input is empty
  }

  return input[0].toUpperCase() + input.substring(1);
}

String getStringFirstLetter(String text) {
  if (text.isNotEmpty) {
    return text.substring(0, 1);
  }
  return '';
}
