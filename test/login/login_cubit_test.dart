import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/login/bloc/login_cubit.dart';
import 'package:flutter_poc/login/bloc/state/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppSharedPref>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppSharedPref appSharedPref;
  late FirebaseAuth firebaseAuth;
  late LoginCubit cubit;
  late UserCredential userCredential;
  late User mockUser;

  setUpAll(() {
    appSharedPref = MockAppSharedPref();

  });

  setUp(() async {
    firebaseAuth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    mockUser = MockUser();
    cubit = LoginCubit(appSharedPref, firebaseAuth);
  });

  blocTest<LoginCubit, LoginState>(
    'Test for singing with email and password handle  success state',
    build: () {
      return cubit;
    },
    act: (cubit) {
      when(firebaseAuth.signInWithEmailAndPassword(
              email: 'abc@gmail.com', password: '123456789'))
          .thenAnswer((_) => Future.value(userCredential));

      when(userCredential.user).thenAnswer((_) => mockUser);

      return cubit.signInUsingEmailPassword(
          email: 'abc@gmail.com', password: '123456789');
    },

    // expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],

    verify: (cubit) {
      expect((cubit.state), LoginSuccessState());
    },
  );
}
