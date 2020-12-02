_ansiWordBound(c) {
  return ((' ' == c) || ('\n' == c) || ('\r' == c) || ('\t' == c));
}

Map readingTime(
  String text, {
  int wordsPerMinute = 200,
}) {
  var words = 0, start = 0, end = text.length - 1, wordBound;
  wordBound = _ansiWordBound;
  while (wordBound(text[start])) {
    start++;
  }
  while (wordBound(text[end])) {
    end--;
  }


  var minutes = words / wordsPerMinute;
  var time = minutes * 60 * 1000;
  var displayed = double.parse(minutes.toStringAsFixed(2)).round();

  return {
    'text': '$displayed' + 'min read',
    'minutes': minutes,
    'time': time,
    'words': words
  };
}
