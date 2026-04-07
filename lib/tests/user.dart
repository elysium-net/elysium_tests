import 'package:elysium_dart/elysium_dart.dart';
import 'package:elysium_tests/library.dart';
import 'package:elysium_tests/utils.dart';

final TestGroup userTests =
    TestGroup('user', 'User relatest tests', <(Test<dynamic>, dynamic)>[
      (CreateUserTest(), TestUser.admin),
      (CreateUserTest(), TestUser.supervisor),
      (CreateUserTest(), TestUser.newUser),
    ]);

class CreateUserTest extends Test<TestUser> {
  @override
  String get identifier => 'CreateUser';

  @override
  String get description => 'Create a new user';

  @override
  Future<void> init(TestGroup group, TestUser _) async {}

  @override
  Future<void> run(TestGroup group, TestUser user) async {
    final CreateUserResponse response = await group.user.createUser(
      CreateUserRequest(
        user: User(
          userId: 'foobar',
          username: 'Foo Bar',
          email: 'foo@bar.baz',
          password: '123456789',
          role: UserRole.USER_ROLE_USER_UNSPECIFIED,
          icon: defaultIcon,
        ),
      ),
      options: user.options(group),
    );

    final bool shouldFail = user != TestUser.admin;

    if (shouldFail) {
      assert(
        response.error.code == ErrorCode.ERROR_CODE_UNAUTHORIZED,
        'Test failed with wrong error: ${response.error}',
      );
    } else {
      assert(!response.hasError(), 'Test failed with error: ${response.error}');
    }
  }
}
