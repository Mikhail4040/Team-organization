class User{
  var id;
  var password;
  var last_login ;
  var is_superuser;
  var username;
  var first_name;
  var last_name;
  var email;
  var is_staff;
  var is_active;
  var date_joined;
  var groups;
  var user_permissions;
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.date_joined,
    required this.last_login,
    required this.groups,
    required this.user_permissions,
    required this.is_active,
    required this.is_superuser,
    required this.is_staff,


});
}