import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/core/constant/app_icons.dart';
import 'app/core/core.dart';
import 'app/core/di/di.dart';
import 'base_app.dart';
import 'flavours/flavour_config.dart';
import 'flavours/product_config.dart';

void main() async {

  ProductConfig devConfig = ProductConfig(
    appName: 'Movie APP',
    logo: AppIcons.homeIcon,
    theme: AppLightScheme(),
  );

  FlavourConfig.instantiate(
    productConfig: devConfig,
  );



  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Inject all the dependencies
  var dependencyEnv = kIsWeb ? web : mobile;
  await configureDependencies(environment: dependencyEnv);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]).then(
        (value) =>
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then(
              (value) => runApp(
            MultiBlocProvider(
              providers: initialiseCubits(),
              child: BaseApp(),
            ),
          ),
        ),
  );
}


