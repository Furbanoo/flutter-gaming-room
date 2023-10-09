String formattedDate(String dateEnglish) {
  final Map<String, String> monthName = {
    'January': 'janeiro',
    'February': 'fevereiro',
    'March': 'março',
    'April': 'abril',
    'May': 'maio',
    'June': 'junho',
    'July': 'julho',
    'August': 'agosto',
    'September': 'setembro',
    'October': 'outubro',
    'November': 'novembro',
    'December': 'dezembro',
  };

  final parts = dateEnglish.split(' ');
  final day = parts[0];
  final monthEnglish = parts[1];
  final year = parts[2];

  final monthBrazilian = monthName[monthEnglish] ?? monthEnglish;

  final dateFormatted = '$day de $monthBrazilian de $year';

  return dateFormatted;
}
