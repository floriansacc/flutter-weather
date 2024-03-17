import 'package:logger/logger.dart';

final Logger logger = Logger(printer: PrettyPrinter());

///  Log error
void errorLog(dynamic e, [StackTrace? s]) {
  logger.e(e, stackTrace: s);
}
