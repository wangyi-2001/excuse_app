/// 用户数据交换通道

class UserRoute{
  static const String userRootPath='/user';
  static const String userCreatePath='$userRootPath/createUser';
  static const String userDeletePath='$userRootPath/deleteUser';
  static const String userUpdatePath='$userRootPath/updateUser';
  static const String userLoginPath='$userRootPath/findUserByPhoneAndPwd';
  static const String userLogoutPath='$userRootPath/logoutStatus';
  static const String userInfoByIdPath='$userRootPath/findUserById';
}