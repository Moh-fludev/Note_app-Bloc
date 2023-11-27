import 'package:equatable/equatable.dart';

import '../bloc_extentions.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(switchvalue: false)) {
    on<SwitchOnEvent>(
      (event, emit) => emit(const SwitchState(switchValue: true)),
    );
    on<SwitchOffEvent>(
      (event, emit) => emit(const SwitchState(switchValue: false)),
    );
  }
//   void _onSwith(SwitchEvent event , Emitter<SwitchEvent> emit){
//  emit(const SwitchState(swichvalue: true));
//   }
//   void _offSwitch(
//     SwitchEvent event , Emitter<SwitchEvent> emit
//   ){
// emit(SwitchState(swichvalue: false));
//   }
}
