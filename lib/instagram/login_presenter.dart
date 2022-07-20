import 'package:flutter_practice2/instagram/token_bean.dart';

import '../instagram/instagram.dart' as instagram;
import '../util/constants.dart';

abstract class LoginViewContract {
  void onLoginSuccess(TokenBean token);
  void onLoginError(String message);
}

class LoginPresenter {
  LoginViewContract _view;
  LoginPresenter(this._view);

  void performLogin() {
    assert(_view != null);
    instagram.getToken(Constants.facebookID, Constants.facebookSecret).then((token)
    {
      if (token != null) {
        _view.onLoginSuccess(token);
      }
      else {
        _view.onLoginError('Error');
      }
    });
  }
}