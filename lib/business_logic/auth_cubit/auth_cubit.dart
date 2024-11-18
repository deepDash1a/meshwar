import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/data/models/user_model/user_model.dart';
import 'package:meshwar/data/remote_data_source/auth_remote_data_source/auth_remote_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthCubit(this.authRemoteDataSource) : super(AuthInitial());

  refreshScreen() {
    emit(RefreshScreen());
  }

  // login screen
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z]).{6,}$');
  final egyptPhoneRegExp = RegExp(r'^(?:\+20|0)?1[0125]\d{8}$');

  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  bool isLoginPasswordVisible = true;
  UserModel? userModel;

  void changeVisibilityTrueOrFalse({
    required bool currentVisibility,
    required void Function(bool) updateVisibility,
  }) {
    final newVisibility = !currentVisibility;

    updateVisibility(newVisibility);

    emit(changeVisibilityTrueOrFalseAppState());
  }

  Future<void> login() async {
    emit(LoadingLoginAppState());

    try {
      final response = await authRemoteDataSource.login(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );

      userModel = UserModel.fromJson(response.data);

      await SharedPreferencesService.saveData(
        key: SharedPreferencesKeys.userToken,
        value: userModel!.token,
      );

      await SharedPreferencesService.saveData(
        key: SharedPreferencesKeys.userRole,
        value: userModel!.body!.role,
      );

      await SharedPreferencesService.saveData(
        key: SharedPreferencesKeys.userStatus,
        value: userModel!.body!.status,
      );

      emit(SuccessLoginAppState(userModel: userModel!));
    } catch (error) {
      final errorMessage = error.toString();

      emit(ErrorLoginAppState(error: errorMessage));
    }
  }

  // forget Password
  var forgetPasswordEmailController = TextEditingController();

  Future<void> forgetPassword() async {
    emit(LoadingForgetPasswordAppState());

    try {
      await authRemoteDataSource.forgetPassword(
          email: forgetPasswordEmailController.text);
      emit(SuccessForgetPasswordAppState());
    } catch (error) {
      emit(ErrorForgetPasswordAppState(error: error.toString()));
    }
  }

  // passenger registration
  int passengerRegisterCurrentStep = 0;
  int passengerRegisterTotalSteps = 3;

  double progressValue() {
    return (passengerRegisterCurrentStep + 1) / passengerRegisterTotalSteps;
  }

  void nextStep() {
    if (passengerRegisterCurrentStep < passengerRegisterTotalSteps - 1) {
      passengerRegisterCurrentStep++;
      emit(IncreaseStepsRegistrationAppState());
    }
  }

  void previousStep() {
    if (passengerRegisterCurrentStep > 0) {
      passengerRegisterCurrentStep--;
      emit(DecreaseStepsRegistrationAppState());
    }
  }

  // step one
  var passengerRegisterStepOneFormKey = GlobalKey<FormState>();
  XFile? profileImage;
  var passengerRegisterFirstNameController = TextEditingController();
  var passengerRegisterLastNameController = TextEditingController();
  var passengerRegisterEmailController = TextEditingController();
  var passengerRegisterPasswordController = TextEditingController();
  bool passengerRegisterPasswordObSecure = true;
  var passengerRegisterConfirmPasswordController = TextEditingController();
  bool passengerRegisterConfirmPasswordObSecure = true;
  var passengerRegisterPhoneNumberController = TextEditingController();
  var passengerRegisterWhatsAppNumberController = TextEditingController();

  // step two
  var passengerRegisterStepTwoFormKey = GlobalKey<FormState>();
  var passengerRegisterGovernorateController = TextEditingController();
  var passengerRegisterResidentialAreaController = TextEditingController();
  var passengerRegisterNeighborhoodController = TextEditingController();
  var passengerRegisterStreetController = TextEditingController();
  var passengerRegisterBuildingController = TextEditingController();
  var passengerRegisterDistinctiveMarkController = TextEditingController();

  // step three
  var passengerRegisterStepThreeFormKey = GlobalKey<FormState>();
  XFile? passengerRegisterIdCardFace;
  XFile? passengerRegisterIdCardBack;
  var passengerRegisterIdCardExpireController = TextEditingController();
  bool passengerRegisterIsCorrectData = false;
  bool passengerRegisterNoSmoking = false;
  bool passengerRegisterPunctual = false;

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

  checkPassengerRegistrationValid() {
    switch (passengerRegisterCurrentStep) {
      case 0:
        return passengerRegisterStepOneFormKey.currentState!.validate() &&
            profileImage != null &&
            passengerRegisterPasswordController.text ==
                passengerRegisterConfirmPasswordController.text;

      case 1:
        return passengerRegisterStepTwoFormKey.currentState!.validate();
      case 2:
        return passengerRegisterStepThreeFormKey.currentState!.validate() &&
            passengerRegisterIdCardFace != null &&
            passengerRegisterIdCardBack != null &&
            passengerRegisterIsCorrectData != false &&
            passengerRegisterNoSmoking != false &&
            passengerRegisterPunctual != false;
    }
  }

  Future<void> passengerRegister() async {
    emit(LoadingPassengerRegistrationAppState());

    try {
      await authRemoteDataSource.passengerRegistration(
        firstName: passengerRegisterFirstNameController.text,
        lastName: passengerRegisterLastNameController.text,
        email: passengerRegisterEmailController.text,
        password: passengerRegisterPasswordController.text,
        confirmPassword: passengerRegisterConfirmPasswordController.text,
        whatsAppNumber: passengerRegisterWhatsAppNumberController.text,
        anotherNumber: passengerRegisterPhoneNumberController.text,
        profileImage: profileImage!,
        role: '${SharedPreferencesService.getData(
          key: SharedPreferencesKeys.userRole,
        )}',
        governorate: passengerRegisterGovernorateController.text,
        residentialArea: passengerRegisterResidentialAreaController.text,
        neighborhood: passengerRegisterNeighborhoodController.text,
        street: passengerRegisterStreetController.text,
        building: passengerRegisterBuildingController.text,
        distinctiveMark: passengerRegisterDistinctiveMarkController.text,
        faceIdCard: passengerRegisterIdCardFace!,
        backIdCard: passengerRegisterIdCardBack!,
        expireOfIdCard: passengerRegisterIdCardExpireController.text,
        isDataCorrect: passengerRegisterIsCorrectData == true ? '1' : '0',
        isPassengerSmocking: passengerRegisterNoSmoking == true ? '1' : '0',
        isPassengerPunctual: passengerRegisterPunctual == true ? '1' : '0',
      );

      emit(SuccessPassengerRegistrationAppState());
    } catch (error) {
      print(error.toString());
      emit(ErrorPassengerRegistrationAppState(error: error.toString()));
    }
  }
}
