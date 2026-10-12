import 'package:dartz/dartz.dart';

import 'failure.dart';

export 'package:dartz/dartz.dart' show Either, Left, Right, left, right;

typedef AsyncEither<T> = Future<Either<Failure, T>>;
