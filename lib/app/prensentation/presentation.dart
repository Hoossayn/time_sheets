import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:time_sheets/app/prensentation/screens/create_task/create_new_task_screen.dart';
import 'package:time_sheets/app/prensentation/screens/timers/base_sheets.dart';
import 'package:time_sheets/app/prensentation/screens/timers/favourites/favourites_page.dart';

import '../../flavours/flavour_config.dart';
import '../blocs/timesheet/time_sheets_bloc.dart';
import '../core/base/state/base_state_wrapper.dart';
import '../core/constant/app_icons.dart';
import '../core/constant/app_values.dart';
import '../core/core.dart';
import '../utils/input_validation_builder.dart';
import '../utils/text_input_filters.dart';


part 'screens/timers/timers_content.dart';

part 'screens/timers/timers_screen.dart';

part 'screens/projects/project_screen.dart';

part 'screens/settings/settings_screen.dart';

part 'screens/timers/local/local_page.dart';

part 'widgets/gradient_scaffold.dart';

part 'widgets/ui_widgets.dart';

part 'widgets/input_text_field.dart';

part 'widgets/ui_checkbox.dart';

part 'widgets/filled_button.dart';

part 'screens/timers/widgets/timesheet_details_description.dart';

