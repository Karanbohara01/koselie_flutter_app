import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/features/auth/domain/usecase/logout_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late LogoutUseCase logoutUseCase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    logoutUseCase = LogoutUseCase(mockTokenSharedPrefs);
  });

  group('LogoutUseCase', () {
    test('✅ should return Right(void) when token removal is successful',
        () async {
      // Arrange
      when(() => mockTokenSharedPrefs.removeToken())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await logoutUseCase.call();

      // Assert
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.removeToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    });
  });
}
