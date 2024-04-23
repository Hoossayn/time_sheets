import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../prensentation/screens/create_task/cubit/time_form_cubit.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

const web = Environment('web');
const mobile = Environment('mobile');

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies({Environment environment = mobile}) async {
  init(getIt, environment: environment.name);
}

List<BlocProvider> initialiseCubits() {
  return [
    BlocProvider<TimeFormCubit>(
      create: (context) => TimeFormCubit(),
    ),
    BlocProvider<TimeFormCubit>(
      create: (context) =>
          TimeFormCubit(),
    ),
  ];
}
