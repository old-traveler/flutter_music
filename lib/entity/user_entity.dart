import 'package:music/generated/json/base/json_convert_content.dart';

class UserEntity with JsonConvert<UserEntity> {
	int status;
	UserUser user;
	String name;
}

class UserUser with JsonConvert<UserUser> {
	bool vip;
	bool king;
}
