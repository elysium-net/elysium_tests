import 'package:elysium_dart/resource/v1/resource.pb.dart';
import 'package:elysium_tests/library.dart';
import 'package:grpc/grpc.dart';

const String adminUsername = 'admin';
const String adminPassword = 'admin';
const String supervisorUsername = 'supervisor';
const String supervisorPassword = 'supervisor';
const String newUserUsername = 'user';
const String newUserPassword = 'user';

final ResourceId defaultIcon = ResourceId(
  key: 'default_icon',
  namespace: 'elysium',
);

CallOptions authOptions(String token) =>
    CallOptions(metadata: <String, String>{'Authorization': token});

class UserAuth {
  final String username;
  final String password;

  const UserAuth(this.username, this.password);
}

enum TestUser {
  admin,
  supervisor,
  newUser;

  String get username {
    switch (this) {
      case TestUser.admin:
        return adminUsername;
      case TestUser.supervisor:
        return supervisorUsername;
      case TestUser.newUser:
        return newUserUsername;
    }
  }

  CallOptions options(TestGroup group) {
    switch (this) {
      case TestUser.admin:
        return group.adminOptions;
      case TestUser.supervisor:
        return group.supervisorOptions;
      case TestUser.newUser:
        return group.newUserOptions;
    }
  }
}
