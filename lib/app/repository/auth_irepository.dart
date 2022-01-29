abstract class AuthIRepository {
  Future<void> googleSignIn()async{}
  Future<void> emailSignIn({required String email,required String password})async {}
  Future<void> ignInAnonymously()async{}
}