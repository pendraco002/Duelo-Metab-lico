import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';

@injectable
class LogoutUseCase {
  Future<Either<Failure, void>> call() async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right(null);
  }
}