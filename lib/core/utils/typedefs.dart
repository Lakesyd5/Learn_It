import 'package:dartz/dartz.dart';
import 'package:learn_it/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
