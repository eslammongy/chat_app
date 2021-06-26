import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_chat/bloc/baseBlock/base_status.dart';

class BaseUserCubit extends Cubit<BaseUserSatatus> {
  BaseUserCubit() : super(BaseUserInitialStatus());

  static BaseUserCubit get(context) => BlocProvider.of(context);
}
