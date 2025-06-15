// focus_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class FocusCubit extends Cubit<String?> {
  FocusCubit() : super(null);

  void focusOn(String field) => emit(field);
  void clearFocus() => emit(null);
}
