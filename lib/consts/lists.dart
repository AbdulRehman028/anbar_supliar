// const slidersList = [imgSlider1, imgSlider2, imgSlider3, imgSlider4];


import 'images.dart';

String getSelectedIcon(int index) {
  switch (index) {
    case 0:
      return icHome;
    case 1:
      return icOrder;
    case 2:
      return icPromotion;
    case 3:
      return icNotification;
    default:
      return '';
  }
}

String getUnselectedIcon(int index) {
  switch (index) {
    case 0:
      return icHome1;
    case 1:
      return icOrder1;
    case 2:
      return icPromotion1;
    case 3:
      return icNotification1;
    default:
      return '';
  }
}

String getLabel(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Orders';
    case 2:
      return 'Promotions';
    case 3:
      return 'Notifications';
    default:
      return '';
  }
}

const slidersList = [imgSlider1, imgSlider2, imgSlider3];

