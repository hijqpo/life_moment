

Map<int, String> monthMap = {

  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

String displayTime(DateTime t){

  DateTime currentTime = DateTime.now();

  Duration diff = currentTime.difference(t);

  // Cases of post time within today
  if (diff.inDays == 0){
    
    if (diff.inHours == 0){

      if (diff.inMinutes == 0){

        if (diff.inSeconds < 10){
          return 'Just Now';
        }

        return '${diff.inSeconds} Seconds';
      }

      return '${diff.inMinutes} Minutes';
    }

    return '${diff.inHours} Hours';

  }
  else if (diff.inDays == 1){

    return 'Yesterday ${t.hour}:${t.minute}';
  }
  else if (diff.inDays < 365){

    return '${monthMap[t.month]} ${t.day}';
  }
  else{
    return '${t.year} - ${t.month} - ${t.day}';
  }
}