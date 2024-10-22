import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/data/authentication/mdoels/login_user_model.dart';
import 'package:meshwar/data/authentication/remote_data_source/remote_data_source.dart';

part 'states.dart';

class AuthenticationAppCubit extends Cubit<AuthenticationAppStates> {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthenticationAppCubit(this.authRemoteDataSource)
      : super(InitializeAppState());

  // public
  final String emailAppRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final String passwordRegex = r'^(?=.*[a-zA-Z]).{7,}$';

  // login
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  bool loginObscureText = true;

  LoginUserModel? loginUserModel;

  attemptLogin(BuildContext context) async {
    emit(LoadingLoginAppState());
    try {
      await authRemoteDataSource
          .login(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      )
          .then(
        (value) {
          loginUserModel = LoginUserModel.fromJson(value.data);
          // save user token
          SharedPreferencesService.saveData(
            key: SharedPreferencesKeys.userToken,
            value: loginUserModel!.token,
          );

          emit(SuccessLoginAppState());
        },
      ).catchError((error) {
        emit(ErrorLoginAppState(error: error.toString()));
      });
    } catch (error) {
      emit(ErrorLoginAppState(error: error.toString()));
    }
  }

  sendFcmToken(String? fcmToken) async {
    emit(LoadingSendingFCMTokenAppState());
    try {
      await authRemoteDataSource.sendFCMToken(fcmToken: fcmToken!);
      emit(SuccessSendingFCMTokenAppState());
    } catch (error) {
      emit(ErrorSendingFCMTokenAppState(error: error.toString()));
    }
  }

  void changeLoginPasswordVisibility() {
    loginObscureText = !loginObscureText;
    emit(ChangeLoginPasswordVisibilityAppState());
  }

  // register

  var registerFirstNameController = TextEditingController();
  var registerLastNameController = TextEditingController();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerPasswordConfirmationController = TextEditingController();
  var registerWhatsAppNumberController = TextEditingController();
  var registerAnotherNumberController = TextEditingController();

  XFile? nationalIdFrontImage;
  XFile? nationalIdBackImage;
  XFile? licenseFrontImage;
  XFile? licenseBackImage;

  var registerCountryController = TextEditingController();
  var registerCityController = TextEditingController();
  var registerRegionController = TextEditingController();
  var registerBuildingController = TextEditingController();
  var registerFloorController = TextEditingController();
  var registerFlatController = TextEditingController();

  XFile? birthCertificateImage;
  XFile? graduationCertificateImage;
  XFile? militaryCertificateImage;
  XFile? feshTshbeehImage;

  var registerWalletController = TextEditingController();
  var registerBankAccountNumberController = TextEditingController();
  XFile? profileImage;
  var registerExpirationLicenseDateController = TextEditingController();

  attemptRegistration(BuildContext context) async {
    emit(LoadingRegisterAppState());
    try {
      await authRemoteDataSource
          .register(
        registerWalletController.text,
        registerBankAccountNumberController.text,
        registerExpirationLicenseDateController.text,
        graduationCertificateImage,
        profileImage,
        firstName: registerFirstNameController.text,
        lastName: registerLastNameController.text,
        email: registerEmailController.text,
        password: registerPasswordController.text,
        passwordConfirmation: registerPasswordConfirmationController.text,
        whatsappNumber: registerWhatsAppNumberController.text,
        anotherNumber: registerAnotherNumberController.text,
        country: registerCountryController.text,
        city: registerCityController.text,
        region: registerRegionController.text,
        building: registerBuildingController.text,
        floor: registerFloorController.text,
        flat: registerFlatController.text,
        nationalIdFrontImage: nationalIdFrontImage!,
        nationalIdBackImage: nationalIdBackImage!,
        licenseFrontImage: licenseFrontImage!,
        licenseBackImage: licenseBackImage!,
        militaryCertificateImage: militaryCertificateImage!,
        birthCertificate: birthCertificateImage!,
        feshTshbeeh: feshTshbeehImage!,
      )
          .then(
        (value) {
          emit(SuccessRegisterAppState());
        },
      ).catchError((error) {
        emit(ErrorRegisterAppState(error: error.toString()));
      });
    } catch (error) {
      emit(ErrorRegisterAppState(error: error.toString()));
    }
  }
}
