import 'package:get/get.dart';

import 'package:inforamclub/app/modules/about_us/bindings/about_us_binding.dart';
import 'package:inforamclub/app/modules/about_us/views/about_us_view.dart';
import 'package:inforamclub/app/modules/about_us_form/bindings/about_us_form_binding.dart';
import 'package:inforamclub/app/modules/about_us_form/views/about_us_form_view.dart';
import 'package:inforamclub/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:inforamclub/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:inforamclub/app/modules/identity_cards/bindings/identity_cards_binding.dart';
import 'package:inforamclub/app/modules/identity_cards/views/identity_cards_view.dart';
import 'package:inforamclub/app/modules/location_on_map/bindings/location_on_map_binding.dart';
import 'package:inforamclub/app/modules/location_on_map/views/location_on_map_view.dart';
import 'package:inforamclub/app/modules/login/bindings/login_binding.dart';
import 'package:inforamclub/app/modules/login/views/login_view.dart';
import 'package:inforamclub/app/modules/my_registered_services/bindings/my_registered_services_binding.dart';
import 'package:inforamclub/app/modules/my_registered_services/views/my_registered_services_view.dart';
import 'package:inforamclub/app/modules/profile/bindings/profile_binding.dart';
import 'package:inforamclub/app/modules/profile/views/profile_view.dart';
import 'package:inforamclub/app/modules/register/bindings/register_binding.dart';
import 'package:inforamclub/app/modules/register/views/register_view.dart';
import 'package:inforamclub/app/modules/register/widgets/complete_register_view.dart';
import 'package:inforamclub/app/modules/reminder_setting/bindings/reminder_setting_binding.dart';
import 'package:inforamclub/app/modules/reminder_setting/views/reminder_setting_view.dart';
import 'package:inforamclub/app/modules/root/bindings/root_binding.dart';
import 'package:inforamclub/app/modules/root/views/root_view.dart';
import 'package:inforamclub/app/modules/send_notification/bindings/send_notification_binding.dart';
import 'package:inforamclub/app/modules/send_notification/views/send_notification_view.dart';
import 'package:inforamclub/app/modules/service_details/bindings/service_details_binding.dart';
import 'package:inforamclub/app/modules/service_details/views/reminder_view.dart';
import 'package:inforamclub/app/modules/service_details/views/service_details_view.dart';
import 'package:inforamclub/app/modules/service_form/bindings/service_form_binding.dart';
import 'package:inforamclub/app/modules/service_form/views/service_form_view.dart';
import 'package:inforamclub/app/modules/service_type_form/bindings/service_type_form_binding.dart';
import 'package:inforamclub/app/modules/service_type_form/views/service_type_form_view.dart';
import 'package:inforamclub/app/modules/services_view/bindings/services_view_binding.dart';
import 'package:inforamclub/app/modules/services_view/views/services_view_view.dart';
import 'package:inforamclub/app/modules/slider_images/bindings/slider_images_binding.dart';
import 'package:inforamclub/app/modules/slider_images/views/slider_images_view.dart';
import 'package:inforamclub/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:inforamclub/app/modules/user_profile/views/user_profile_view.dart';
import 'package:inforamclub/app/modules/users/bindings/users_binding.dart';
import 'package:inforamclub/app/modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  static const LOGIN_ROUTE = Routes.LOGIN;
  static const HOME_ROUTE = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Paths.COMPLETE_REGISTER,
      page: () => CompleteRegisterView(),
    ),
    GetPage(
      name: Paths.PROFILE,
      page: () => MyProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Paths.ABOUT,
      page: () => AboutUsFormView(),
      binding: AboutUsFormBinding(),
    ),
    GetPage(
      name: Paths.SERVICE_DETAILS,
      page: () => ServiceDetailsView(),
      binding: ServiceDetailsBinding(),
    ),
    GetPage(
      name: Paths.SERVICE_FORM,
      page: () => ServiceFormView(),
      binding: ServiceFormBinding(),
    ),
    GetPage(
      name: Paths.SERVICES_VIEW,
      page: () => ServicesViewView(),
      binding: ServicesViewBinding(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_TYPE_FORM,
      page: () => ServiceTypeFormView(),
      binding: ServiceTypeFormBinding(),
    ),
    GetPage(
      name: Routes.MY_REGISTERED_SERVICES,
      page: () => MyRegisteredServicesView(),
      binding: MyRegisteredServicesBinding(),
    ),
    GetPage(
      name: Routes.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: Routes.IDENTITY_CARDS,
      page: () => IdentityCardsView(),
      binding: IdentityCardsBinding(),
    ),
    GetPage(
      name: Routes.SLIDER_IMAGES,
      page: () => SliderImagesView(),
      binding: SliderImagesBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.USER_PROFILE,
      page: () => UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_ON_MAP,
      page: () => LocationOnMapView(),
      binding: LocationOnMapBinding(),
    ),
    GetPage(
      name: Routes.ABOUT_US,
      page: () => AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.SEND_NOTIFICATION,
      page: () => SendNotificationView(),
      binding: SendNotificationBinding(),
    ),
    GetPage(
      name: Routes.REMINDER_SETTING,
      page: () => ReminderSettingView(),
      binding: ReminderSettingBinding(),
    ),
  ];
}
