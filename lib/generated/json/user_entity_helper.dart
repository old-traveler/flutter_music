import 'package:music/entity/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['user'] != null) {
		data.user = new UserUser().fromJson(json['user']);
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['name'] = entity.name;
	return data;
}

userUserFromJson(UserUser data, Map<String, dynamic> json) {
	if (json['vip'] != null) {
		data.vip = json['vip'];
	}
	if (json['king'] != null) {
		data.king = json['king'];
	}
	return data;
}

Map<String, dynamic> userUserToJson(UserUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['vip'] = entity.vip;
	data['king'] = entity.king;
	return data;
}