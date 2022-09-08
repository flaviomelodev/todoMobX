import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = "";

  @action
  void setEmail(String value) {
    email = value;
  }

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @observable
  bool showPassord = false;

  @action
  void togglePassword() => showPassord = !showPassord;

  @observable
  bool loading = false;

  @action
  Future<void> isLoading() async {
    loading = true;
    await Future.delayed(const Duration(seconds: 2));

    loading = false;
  }

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 4;

  @computed
  Function? get loginPressed => (isEmailValid && isPasswordValid && !loading)
      ? isLoading as Function
      : null;
}
