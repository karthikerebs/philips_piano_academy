// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:music_app/src/application/auth/bloc/auth_bloc.dart' as _i40;
import 'package:music_app/src/application/chat/chat_bloc.dart' as _i35;
import 'package:music_app/src/application/credit_class/credit_class_bloc.dart'
    as _i36;
import 'package:music_app/src/application/home/home_bloc.dart' as _i37;
import 'package:music_app/src/application/installment/installment_bloc.dart'
    as _i26;
import 'package:music_app/src/application/normal_class/normal_class_bloc.dart'
    as _i27;
import 'package:music_app/src/application/paid_class/paid_class_bloc.dart'
    as _i28;
import 'package:music_app/src/application/profile/profile_bloc.dart' as _i31;
import 'package:music_app/src/application/refund/refund_bloc.dart' as _i32;
import 'package:music_app/src/application/renewal/renewal_bloc.dart' as _i33;
import 'package:music_app/src/application/slot_booking/slot_booking_bloc.dart'
    as _i34;
import 'package:music_app/src/domain/auth/i_auth_repository.dart' as _i38;
import 'package:music_app/src/domain/chat/i_chat_repository.dart' as _i6;
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart'
    as _i4;
import 'package:music_app/src/domain/core/preference/preference.dart' as _i29;
import 'package:music_app/src/domain/credit_class/i_credit_class_repository.dart'
    as _i8;
import 'package:music_app/src/domain/home/i_home_repository.dart' as _i10;
import 'package:music_app/src/domain/installment/i_installment_repository.dart'
    as _i12;
import 'package:music_app/src/domain/normal_class/i_normal_repository.dart'
    as _i14;
import 'package:music_app/src/domain/paid_class/i_paid_class_repository.dart'
    as _i16;
import 'package:music_app/src/domain/profile/i_profile_repository.dart' as _i18;
import 'package:music_app/src/domain/refund_request/i_refund_repository.dart'
    as _i20;
import 'package:music_app/src/domain/renewal/i_renewal_repository.dart' as _i22;
import 'package:music_app/src/domain/slot_booking/i_slot_booking_repository.dart'
    as _i24;
import 'package:music_app/src/infrastructure/auth/auth_repository.dart' as _i39;
import 'package:music_app/src/infrastructure/chat/chat_repository.dart' as _i7;
import 'package:music_app/src/infrastructure/core/internet_helper.dart' as _i5;
import 'package:music_app/src/infrastructure/core/preference_helper.dart'
    as _i30;
import 'package:music_app/src/infrastructure/core/third_party_injectable_module.dart'
    as _i41;
import 'package:music_app/src/infrastructure/credit_class/credit_class_repository.dart'
    as _i9;
import 'package:music_app/src/infrastructure/home/home_repository.dart' as _i11;
import 'package:music_app/src/infrastructure/installment/installment_repository.dart'
    as _i13;
import 'package:music_app/src/infrastructure/normal_class/normal_class_repository.dart'
    as _i15;
import 'package:music_app/src/infrastructure/paid_class/paid_class_repository.dart'
    as _i17;
import 'package:music_app/src/infrastructure/profile/profile_repository.dart'
    as _i19;
import 'package:music_app/src/infrastructure/refund_request/refund_request_repository.dart'
    as _i21;
import 'package:music_app/src/infrastructure/renewal/renewal_request_repository.dart'
    as _i23;
import 'package:music_app/src/infrastructure/slot_booking/slot_booking_repository.dart'
    as _i25;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyInjectableModule = _$ThirdPartyInjectableModule();
    gh.lazySingleton<_i3.Client>(() => thirdPartyInjectableModule.client);
    gh.lazySingleton<_i4.IBaseClient>(
        () => _i5.InternetHelper(gh<_i3.Client>()));
    gh.lazySingleton<_i6.IChatRepossitory>(
        () => _i7.ChatRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i8.ICreditClassRepository>(
        () => _i9.CreditClassRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i10.IHomeRepository>(
        () => _i11.HomeRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i12.IInstallmentRepository>(
        () => _i13.InstallmentRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i14.INormalClassRepository>(
        () => _i15.NormalClassRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i16.IPaidClassRepository>(
        () => _i17.PaidClassRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i18.IProfileRepository>(
        () => _i19.ProfileRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i20.IRefundRequestRepository>(
        () => _i21.RefundRequestRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i22.IRenewalRepository>(
        () => _i23.RenewalRequestRepository(gh<_i4.IBaseClient>()));
    gh.lazySingleton<_i24.ISlotBookingRepository>(
        () => _i25.SlotBookingRepository(gh<_i4.IBaseClient>()));
    gh.factory<_i26.InstallmentBloc>(
        () => _i26.InstallmentBloc(gh<_i12.IInstallmentRepository>()));
    gh.factory<_i27.NormalClassBloc>(
        () => _i27.NormalClassBloc(gh<_i14.INormalClassRepository>()));
    gh.factory<_i28.PaidClassBloc>(
        () => _i28.PaidClassBloc(gh<_i16.IPaidClassRepository>()));
    gh.lazySingleton<_i29.PreferenceContracts>(() => _i30.PreferenceHelper());
    gh.lazySingleton<_i30.PreferenceHelper>(
        () => thirdPartyInjectableModule.preferenceHelper);
    gh.factory<_i31.ProfileBloc>(
        () => _i31.ProfileBloc(gh<_i18.IProfileRepository>()));
    gh.factory<_i32.RefundBloc>(
        () => _i32.RefundBloc(gh<_i20.IRefundRequestRepository>()));
    gh.factory<_i33.RenewalBloc>(
        () => _i33.RenewalBloc(gh<_i22.IRenewalRepository>()));
    gh.factory<_i34.SlotBookingBloc>(
        () => _i34.SlotBookingBloc(gh<_i24.ISlotBookingRepository>()));
    gh.factory<_i35.ChatBloc>(() => _i35.ChatBloc(gh<_i6.IChatRepossitory>()));
    gh.factory<_i36.CreditClassBloc>(
        () => _i36.CreditClassBloc(gh<_i8.ICreditClassRepository>()));
    gh.factory<_i37.HomeBloc>(() => _i37.HomeBloc(gh<_i10.IHomeRepository>()));
    gh.lazySingleton<_i38.IAuthRepository>(
        () => _i39.AuthRepository(gh<_i4.IBaseClient>()));
    gh.factory<_i40.AuthBloc>(() => _i40.AuthBloc(gh<_i38.IAuthRepository>()));
    return this;
  }
}

class _$ThirdPartyInjectableModule extends _i41.ThirdPartyInjectableModule {}
