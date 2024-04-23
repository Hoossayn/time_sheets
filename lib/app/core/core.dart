import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:time_sheets/app/data/models/task.dart';
import 'package:time_sheets/app/prensentation/presentation.dart';


import '../../l10n/app_localizations.dart';
import '../prensentation/screens/create_task/create_new_task_screen.dart';
import '../prensentation/screens/taskDetails/task_details_screen.dart';
import 'constant/app_values.dart';
import 'di/di.dart';
import 'routes/routes.dart';

part 'base/cubit/base_cubit_wrapper.dart';
part 'base/cubit/cubit_status.dart';
part 'extension/context_ext.dart';
part 'routes/app_routes.dart';
part 'services/navigation_service.dart';
part 'theme/app_theme.dart';