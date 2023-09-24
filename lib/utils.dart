String getMonthNumberFromName({String? month}) {
  switch (month) {
    case 'Jan':
      return '01';
    case 'Feb':
      return '02';
    case 'Mar':
      return '03';

    case 'Apr':
      return '04';

    case 'May':
      return '05';

    case 'Jun':
      return '06';

    case 'Jul':
      return '07';

    case 'Aug':
      return '08';

    case 'Sep':
      return '09';

    case 'Oct':
      return '10';

    case 'Nov':
      return '11';

    case 'Dec':
      return '12';

    default:
      return '';
  }
}

getMonthNumberInWords({int? month}) {
  switch (month) {
    case 1:
      return 'Jan';

    case 2:
      return 'Feb';

    case 3:
      return 'Mar';

    case 4:
      return 'Apr';

    case 5:
      return 'May';

    case 6:
      return 'Jun';

    case 7:
      return 'Jul';

    case 8:
      return 'Aug';

    case 9:
      return 'Sep';

    case 10:
      return 'Oct';

    case 11:
      return 'Nov';

    case 12:
      return 'Dec';
  }
}
