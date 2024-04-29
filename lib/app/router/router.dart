import 'package:flutter/material.dart';
import 'package:music_app/app/router/router_constatnts.dart';
import 'package:music_app/src/domain/models/response_models/blog_model/blog.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';
import 'package:music_app/src/presentation/view/activities/activities_view.dart';
import 'package:music_app/src/presentation/view/blog_details/blog_details_view.dart';
import 'package:music_app/src/presentation/view/blogs/blogs_view.dart';
import 'package:music_app/src/presentation/view/bottom_nav/bottom_nav_view.dart';
import 'package:music_app/src/presentation/view/cancel_multiple_class/cancel_mutiple_class_view.dart';
import 'package:music_app/src/presentation/view/change_password/change_password_view.dart';
import 'package:music_app/src/presentation/view/chat/chat_view.dart';
import 'package:music_app/src/presentation/view/choose_payment/choose_payment_view.dart';
import 'package:music_app/src/presentation/view/credit_class/credit_class_note.dart';
import 'package:music_app/src/presentation/view/paid_class/paid_class_note_view.dart';
import 'package:music_app/src/presentation/view/paid_class_change/paid_fee_details.dart';
import 'package:music_app/src/presentation/view/privacy_policy/privacy_policy_view.dart';
import 'package:music_app/src/presentation/view/renewal/renewal_view.dart';
import 'package:music_app/src/presentation/view/renewal_fee/renewal_fee_details_view.dart';
import 'package:music_app/src/presentation/view/terms_and_conditions/terms_and_conditions_view.dart';
import 'package:music_app/src/presentation/view/unused/class_cancellation/class_cancellation_view.dart';
import 'package:music_app/src/presentation/view/credit_class/credit_class_view.dart';
import 'package:music_app/src/presentation/view/credit_class_change_date/credit_class_change_date_view.dart';
import 'package:music_app/src/presentation/view/edit_profile/edit_profile_view.dart';
import 'package:music_app/src/presentation/view/fee_details/fee_details_view.dart';
import 'package:music_app/src/presentation/view/installments/installments_view.dart';
import 'package:music_app/src/presentation/view/login/login_view.dart';
import 'package:music_app/src/presentation/view/normal_class/normal_class_view.dart';
import 'package:music_app/src/presentation/view/note_detail/note_detail_view.dart';
import 'package:music_app/src/presentation/view/paid_class/paid_class_view.dart';
import 'package:music_app/src/presentation/view/paid_class_change/paid_class_change_view.dart';
import 'package:music_app/src/presentation/view/refund/refund_view.dart';
import 'package:music_app/src/presentation/view/register/register_view.dart';
import 'package:music_app/src/presentation/view/settings/settings_view.dart';
import 'package:music_app/src/presentation/view/unused/reschedule/reschedule_view.dart';
import 'package:music_app/src/presentation/view/select_slot/select_slot_view.dart';
import 'package:music_app/src/presentation/view/splash/splash_view.dart';
import 'package:music_app/src/presentation/view/support/support_view.dart';
import 'package:music_app/src/presentation/view/tutorial_videos/tutorial_videos_view.dart';
import 'package:music_app/src/presentation/view/unused/transaction/transaction_view.dart';
import 'package:music_app/src/presentation/view/videos_detail/videos_detail_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterConstants.splashRoute:
        return MaterialPageRoute<SplashView>(
          builder: (_) => const SplashView(),
        );
      case RouterConstants.loginRoute:
        return MaterialPageRoute<LoginView>(
          builder: (_) => const LoginView(),
        );
      case RouterConstants.registerRoute:
        return MaterialPageRoute<RegisterView>(
          builder: (_) => const RegisterView(),
        );
      case RouterConstants.slotSelectionRoute:
        return MaterialPageRoute<SelectSlotView>(
          builder: (_) => const SelectSlotView(),
        );
      case RouterConstants.choosePaymentRoute:
        final args = settings.arguments as Map;
        return MaterialPageRoute<ChoosePaymentView>(
          builder: (_) => ChoosePaymentView(
              slote: args["slote"], day: args["day"], slotId: args["slotId"]),
        );
      case RouterConstants.feeDetailsRoute:
        final args = settings.arguments as SlotBookingModel;
        return MaterialPageRoute<FeeDetailsView>(
          builder: (_) => FeeDetailsView(slotBookingModel: args),
        );
      case RouterConstants.bottomNavRoute:
        final args = settings.arguments as int;
        return MaterialPageRoute<BottomNavView>(
          builder: (_) => BottomNavView(selectedIndex: args),
        );

      case RouterConstants.latestBlogRoute:
        return MaterialPageRoute<BlogsView>(
          builder: (_) => const BlogsView(),
        );
      case RouterConstants.blogDetailsRoute:
        final args = settings.arguments as Blog;
        return MaterialPageRoute<BlogDetailView>(
          builder: (_) => BlogDetailView(blogData: args),
        );
      case RouterConstants.tutorialVideoRoute:
        return MaterialPageRoute<TutorialVideosView>(
          builder: (_) => const TutorialVideosView(),
        );
      case RouterConstants.tutorialVideoDetailRoute:
        final args = settings.arguments as Video;
        return MaterialPageRoute<TutorialVideosDetailView>(
          builder: (_) => TutorialVideosDetailView(tutorialVideoData: args),
        );
      case RouterConstants.editProfileRoute:
        return MaterialPageRoute<EditProfileView>(
          builder: (_) => const EditProfileView(),
        );
      case RouterConstants.normalClassRoute:
        return MaterialPageRoute<NormalClassView>(
          builder: (_) => const NormalClassView(),
        );
      case RouterConstants.cancelMutipleClassRoute:
        return MaterialPageRoute<CancelMultipleClassView>(
          builder: (_) => const CancelMultipleClassView(),
        );
      case RouterConstants.noteDetailsRoute:
        final args = settings.arguments as List;
        return MaterialPageRoute<NoteDetailView>(
          builder: (_) => NoteDetailView(title: args[0], id: args[1]),
        );
      case RouterConstants.classRescheduleRoute:
        return MaterialPageRoute<ClassRescheduleView>(
          builder: (_) => const ClassRescheduleView(),
        );
      case RouterConstants.refundRoute:
        return MaterialPageRoute<RefundView>(
          builder: (_) => const RefundView(),
        );
      case RouterConstants.creditClassRoute:
        return MaterialPageRoute<CreditClassView>(
          builder: (_) => const CreditClassView(),
        );
      case RouterConstants.creditClassChangeRoute:
        final args = settings.arguments as int;
        return MaterialPageRoute<ChangeCreditClassView>(
          builder: (_) => ChangeCreditClassView(classId: args),
        );
      case RouterConstants.installemntsView:
        return MaterialPageRoute<InstallmentsView>(
          builder: (_) => const InstallmentsView(),
        );
      case RouterConstants.classCancellationRoute:
        return MaterialPageRoute<ClassCancellatonView>(
          builder: (_) => const ClassCancellatonView(),
        );
      case RouterConstants.supportRoute:
        return MaterialPageRoute<SupportView>(
          builder: (_) => const SupportView(),
        );
      case RouterConstants.chatRoute:
        return MaterialPageRoute<ChatView>(
          builder: (_) => const ChatView(),
        );
      case RouterConstants.paidClassRoute:
        return MaterialPageRoute<PaidClassView>(
          builder: (_) => const PaidClassView(),
        );
      case RouterConstants.paidClasschangeRoute:
        return MaterialPageRoute<ChangePaidClassView>(
          builder: (_) => const ChangePaidClassView(),
        );
      case RouterConstants.settingsRoute:
        return MaterialPageRoute<SettingsView>(
          builder: (_) => const SettingsView(),
        );
      case RouterConstants.changePasswordRoute:
        return MaterialPageRoute<ChangePasswordView>(
          builder: (_) => const ChangePasswordView(),
        );
      case RouterConstants.renewalRoute:
        return MaterialPageRoute<RenewalView>(
          builder: (_) => const RenewalView(),
        );
      case RouterConstants.renewalFeeDetailsRoute:
        final arg = settings.arguments as String;
        return MaterialPageRoute<RenewalFeeDetailsView>(
          builder: (_) => RenewalFeeDetailsView(
            extraClassFee: arg, /* sendRequestModel: arg */
          ),
        );
      case RouterConstants.privacyPolicyRoute:
        return MaterialPageRoute<PrivacyPolicyView>(
          builder: (_) => PrivacyPolicyView(),
        );
      case RouterConstants.termsAndConditionsRoute:
        return MaterialPageRoute<TermsAndConditionsView>(
          builder: (_) => TermsAndConditionsView(),
        );
      case RouterConstants.activitiesRoute:
        return MaterialPageRoute<ActivitiesView>(
          builder: (_) => ActivitiesView(),
        );
      case RouterConstants.paidFeeDeatilsRoute:
        final arg = settings.arguments as Map;
        return MaterialPageRoute<PaidClassFeeDetails>(
          builder: (_) => PaidClassFeeDetails(
            paidClassFee: arg['fee'],
            date: arg['date'],
            slotId: arg['slote'],
          ),
        );
      case RouterConstants.transactionsRoute:
        return MaterialPageRoute<TransactionView>(
          builder: (_) => TransactionView(),
        );
      case RouterConstants.creditClassNoteRoute:
        final args = settings.arguments as List;
        return MaterialPageRoute<CreditClassNoteView>(
          builder: (_) => CreditClassNoteView(title: args[0], id: args[1]),
        );
      case RouterConstants.paidClassNoteRoute:
        final args = settings.arguments as List;
        return MaterialPageRoute<PaidClassNoteView>(
          builder: (_) => PaidClassNoteView(title: args[0], id: args[1]),
        );
      default:
        return MaterialPageRoute<Scaffold>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
