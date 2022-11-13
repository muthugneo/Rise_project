

import 'shared_value_helper.dart';

class AuthHelper {
  setUserData(loginResponse) {
    if (loginResponse.result == true) {
      is_logged_in.$ = true;
      access_token.$ = loginResponse.access_token;
      user_id.$ = loginResponse.user.id;
      user_name.$ = loginResponse.user.name;
      user_email.$ = loginResponse.user.email;
      user_phone.$ = loginResponse.user.phone;
      avatar_original.$ = loginResponse.user.avatar_original;

    }
  }

  clearUserData() {
      is_logged_in.$ = false;
      access_token.$ = "";
      user_id.$ = 0;
      user_name.$ = "";
      user_email.$ = "";
      user_phone.$ = "";
      avatar_original.$ = "";
  }
}
