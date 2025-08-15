import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../entities/user.dart';
import '../../../core/errors/failure.dart';

@injectable
class GetCurrentUserUseCase {
  Future<Either<Failure, User>> call() async {
    // Mock implementation - simulate no user found initially
    await Future.delayed(const Duration(milliseconds: 500));
    return Left(Failure('Usuário não encontrado'));
  }
}