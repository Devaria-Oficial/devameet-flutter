

part of 'room_cubit.dart';

class RoomState extends Equatable {

  final FormHandler form;

  RoomState({required this.form});

  @override
  List<Object?> get props => [];

  factory RoomState.initial() {
    return RoomState(
      form: FormHandler({
        "link": FormInput<String>('', validator: Validator().required("Preencha o link da reunião"))
      })
    );
  }

}