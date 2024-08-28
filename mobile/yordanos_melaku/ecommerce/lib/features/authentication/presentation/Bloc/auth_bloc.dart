import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/log_in.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LogInUsecase logInUsecase;
  SignUpUsecase signUpUsecase;
  GetUserUsecase getUserUsecase;

  AuthBloc(
      {required this.logInUsecase,
      required this.signUpUsecase,
      required this.getUserUsecase})
      : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await logInUsecase
          .execute(LoginParam(loginEntity: event.loginEntity));
      result.fold((failure) {
        emit(AuthFailure(message: 'Failure in the login'));
      }, (userData) {
        emit(AuthSuccess());
      });
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpUsecase
          .execute(SignUpParam(signupEntity: event.signupEntity));
      result.fold((failure) {
        emit(AuthFailure(message: 'signup failure'));
      }, (userData) {
        emit(AuthSuccess());
      });
    });

    on<GetUserEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await getUserUsecase.execute(NoParams());

      result.fold((failure) {
        emit(UserLoadFailure(message: 'Can\'t get user'));
      }, (userData) {
        emit(UserLoaded(user: userData));
      });
    });
  }
}
