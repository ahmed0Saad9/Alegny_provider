import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Repo/profile_repo.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Repo/change_password_repo.dart';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/repo/add_service_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/DeleteAccount/Bloc/Repo/delete_account_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Repo/account_details_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Repo/efit_profile_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/check_email_and_send_otp_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/ForgetPassword/Bloc/repo/validate-otp-and-change-password_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogIn/Bloc/Repo/login_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/LogOut/Bloc/Repo/log_out_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Repo/get_company_categories_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Repo/register_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Controller/send_otp_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Repo/send_otp_repository.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Verification/Bloc/Repo/verify_otp_repository.dart';
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Repo/complaints_repo.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/Repo/get_services_repo.dart';
import 'package:Alegny_provider/src/core/ThemeData/theme_manager.dart';
import 'package:Alegny_provider/src/core/services/Network/network_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///
    /// use cases
    ///
    // Home
    // sl.registerLazySingleton(() => GetAllFingerPrintUseCase(sl()));

    ///
    /// REPOSITORY
    ///
    // sl.registerLazySingleton(() => GetSettingRepository());
    // Auth
    sl.registerLazySingleton(() => LogInRepository());
    sl.registerLazySingleton(() => SendOTPController());
    sl.registerLazySingleton(() => AccountDetailsRepository());
    sl.registerLazySingleton(() => LogOutRepository());
    sl.registerLazySingleton(() => DeleteAccountRepository());
    sl.registerLazySingleton(() => ChangePasswordRepository());
    sl.registerLazySingleton(() => RegisterRepository());
    sl.registerLazySingleton(() => SendOTPRepository());
    sl.registerLazySingleton(() => VerifyOTPRepository());
    sl.registerLazySingleton(() => GetCompanyCategoriesRepository());
    sl.registerLazySingleton(() => ValidateOtpAndChangePasswordRepo());
    sl.registerLazySingleton(() => CheckEmailAndSendOtpRepo());
    sl.registerLazySingleton(() => EditGeneralProfileRepository());
    // sl.registerLazySingleton(() => ChangePasswordRepository());
    // sl.registerLazySingleton(() => GetUserDataRepository());
//app
    sl.registerLazySingleton(() => ProfileRepo());
    sl.registerLazySingleton(() => CreateServiceRepository());
    sl.registerLazySingleton(() => ServicesRepository());
    sl.registerLazySingleton(() => ComplaintRepository());

    //app
    // sl.registerLazySingleton(() => OpportunitiesRepository());

    ///
    /// DATA SOURCE
    ///
    // Home
    // sl.registerLazySingleton<BaseHomeDataSource>(() => HomeDataSource());

    // sl.registerLazySingleton(() => AccountDetailsRepository());

    /// Other
    sl.registerFactory(() => ThemeManagerController());
    sl.registerLazySingleton(() => NetworkService());
    sl.registerLazySingleton(() => GetStorage());
    sl.registerLazySingleton(() => LogInterceptor(
          request: true,
          error: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
        ));
  }
}
