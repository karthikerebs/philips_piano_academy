import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/app/injector/injector.config.dart';

final getIt = GetIt.instance;
@InjectableInit()
void configureDependancies() => getIt.init();
