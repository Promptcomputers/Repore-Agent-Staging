import 'package:repore_agent/lib.dart';

abstract class IProfileServiceRepo {
  ///Get user details
  Future<UserDetailRes> getUserDetails(String userId);

  ///change password
  Future<bool> changePassword(
      String oldPassword, String newPassword, String userId);

  ///Add/change password for the first time
  Future<bool> changePasswordFirstTime(String password, String userId);

  ///update profile
  Future<bool> updateProfile(String userId, UpdateProfileReq updateProfileReq);

  ///Get user notifications
  Future<GetNotificationRes> getNotification();

  Future<bool> markNotificationAsRead(String id);
  Future<bool> markNotificationAllRead();
  Future<bool> setPin(String pin);
}
