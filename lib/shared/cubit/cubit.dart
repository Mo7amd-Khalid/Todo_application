import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared/cubit/states.dart';
import 'package:todo_application/shared/network/local/cache_helper.dart';



class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode({bool? fromShared}){

    if(fromShared != null) {
      isDark = CacheHelper.getData(key: 'DarkMode');
      emit(ChangeModeAppState());
    } else
      {
        isDark = !isDark;
        CacheHelper.saveData(key: 'DarkMode', value: isDark).then((value)
        {
          emit(ChangeModeAppState());
        });
      }


  }

}