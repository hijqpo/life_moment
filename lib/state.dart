import 'package:life_moment/forms/login_form.dart';
import 'package:life_moment/views/main_view.dart';


enum Mood {
  VeryHappy,
  Happy,
  Normal,
  VerySad,
  Sad,
}


class GlobalState {

  // System state
  

  static LoginForm loginForm;




  static Mood _currentMood = Mood.Normal;

  static MainViewState mainViewState;

  static void updateCurrentMood(Mood mood){
    _currentMood = mood;
    if (mainViewState != null){
      mainViewState.updateMood(_currentMood);
    }
  }
}





