import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/data/models/home_models/profile_model.dart';
import 'package:meshwar/data/remote_data_source/home_remote_data_source/home_remote_data_source.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRemoteDataSource) : super(HomeInitial());

  final HomeRemoteDataSource homeRemoteDataSource;
  final emailRegex =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z]).{6,}$');
  final egyptPhoneRegExp = RegExp(r'^(?:\+20|0)?1[0125]\d{8}$');

  // personal page
  XFile? profileImage;



  ProfileModel? profileModel;

  Future<void> getProfileData() async {
    emit(LoadingProfileAppState());

    try {
      final response = await homeRemoteDataSource.getProfileData();
      profileModel = ProfileModel.fromJson(response.data);
      emit(SuccessProfileDataAppState(profileModel: profileModel!));
    } catch (error) {
      print(error);
      emit(ErrorProfileDataAppState(error: error.toString()));
    }
  }

  void changeVisibilityTrueOrFalse({
    required bool currentVisibility,
    required void Function(bool) updateVisibility,
  }) {
    final newVisibility = !currentVisibility;

    updateVisibility(newVisibility);

    emit(changeVisibilityTrueOrFalseAppState());
  }

  XFile? pickImageFromDevice(XFile? imagePath, XFile newImage) {
    imagePath = newImage;
    emit(UploadImageState());
    return imagePath;
  }

  Future<void> selectFutureDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? piked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (piked != null) {
      controller.text = piked.toString().split(" ")[0];
      emit(SelectDateAppState());
    }
  }

}
