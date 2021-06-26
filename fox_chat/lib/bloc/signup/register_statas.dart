abstract class UserRegisterStates {}

class UserRegisterIntialState extends UserRegisterStates {}

class UserRegisterLoadingState extends UserRegisterStates {}

class UserRegisterSuccessState extends UserRegisterStates {}

class CreateUserSuccessState extends UserRegisterStates {}

class CreateUserErrorState extends UserRegisterStates {
  final String errorMessage;
  CreateUserErrorState({this.errorMessage});
}

class UserChangePasswordVisibiltyState extends UserRegisterStates {}

class UserRegisterErrorState extends UserRegisterStates {
  final String errorMessage;
  UserRegisterErrorState({this.errorMessage});
}
