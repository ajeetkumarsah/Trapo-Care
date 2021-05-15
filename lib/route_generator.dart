import 'package:flutter/material.dart';
import 'package:trapo_care/screens/ambulance/ambulance.dart';
import 'package:trapo_care/screens/beds_Ventilators/beds_Icu.dart';
import 'package:trapo_care/screens/coWin/coWin_Screen.dart';
import 'package:trapo_care/screens/coWin/hospital.dart';
import 'package:trapo_care/screens/covid/covid.dart';
import 'package:trapo_care/screens/delivery/delivery.dart';
import 'package:trapo_care/screens/doctors/doctor.dart';
import 'package:trapo_care/screens/donate/donate_screen.dart';
import 'package:trapo_care/screens/feedback/feedback.dart';
import 'package:trapo_care/screens/helpline/helpline.dart';
import 'package:trapo_care/screens/homeCare/homeCare.dart';
import 'package:trapo_care/screens/homeScreen/homeScreen.dart';
import 'package:trapo_care/screens/meals/meals.dart';
import 'package:trapo_care/screens/oxygen/oxygen.dart';
import 'package:trapo_care/screens/plasma_blood/plasma_blood.dart';
import 'package:trapo_care/screens/posts/helper/create_post.dart';
import 'package:trapo_care/screens/posts/your_guide.dart';
import 'package:trapo_care/screens/hospital/pvthospital.dart';
import 'package:trapo_care/screens/survey/last_page.dart';
import 'package:trapo_care/screens/survey/survey_screen_new.dart';
import 'package:trapo_care/screens/tabs/edit/argument/haveAnyLeadsArgument.dart';
import 'package:trapo_care/screens/tabs/edit/beACarporateDonor/beACarporateDonor.dart';
import 'package:trapo_care/screens/tabs/edit/becomeDataPartner/becomeDataPartner.dart';
import 'package:trapo_care/screens/tabs/edit/haveAnyLeads/haveAnyLeads.dart';
import 'package:trapo_care/screens/tabs/edit/screen/emergency.dart';
import 'package:trapo_care/screens/tabs/edit/volunteerWithUs/volunteerWithUs.dart';
import 'package:trapo_care/screens/tabs/resources/argument.dart/resourcesArgument.dart';
import 'package:trapo_care/screens/tabs/updatedPosts/widget/postDetailsPage.dart';
import 'package:trapo_care/screens/widgets/emptyview.dart';
import 'package:trapo_care/screens/widgets/postViewDetails.dart';
import 'package:trapo_care/screens/yourGuide/yourGuide.dart';
import 'helper/screenArgumantHelper.dart';
import 'screens/splashScreen/onboardingScreen/screen/onboardingScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/fullScreenImage':
        return MaterialPageRoute(builder: (_) {
          FullScreenImageArgument argument = args;
          return FullScreenImage(url: argument.url);
        });
      case '/covid':
        return MaterialPageRoute(builder: (_) => Covid());
      case '/beACarporateDonor':
        return MaterialPageRoute(builder: (_) => BeACarporateDonor());
      case '/becomeDataPartner':
        return MaterialPageRoute(builder: (_) => BecomeDataPartner());
      case '/volunteerWithUs':
        return MaterialPageRoute(builder: (_) => VolunteerWithUs());
      case '/haveAnyLeads':
        return MaterialPageRoute(builder: (_) {
          HaveAnyLeadsArgument arguments = args;
          return HaveAnyLeads(
              lusername: arguments.username, lphone: arguments.phone);
        });
      case '/onboardingScreen':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/bedVentilator':
        return MaterialPageRoute(builder: (_) => BedsVentilators());

      case '/plasmablood':
        return MaterialPageRoute(builder: (_) => PlasmaBlood());
      case '/oxygen':
        return MaterialPageRoute(builder: (_) => Oxygen());
      case '/donate':
        return MaterialPageRoute(builder: (_) => PlasmaBlood());
      case '/ambulance':
        return MaterialPageRoute(builder: (_) => Ambulance());
      case '/surveyLastScreen':
        return MaterialPageRoute(builder: (_) => SurveyLastScreen());
      case '/surveyScreenNew':
        return MaterialPageRoute(builder: (_) => SurveyScreenNew());
      case '/userGuideScreen':
        return MaterialPageRoute(builder: (_) => YourGuide());
      case '/donateScreen':
        return MaterialPageRoute(builder: (_) => DonateScreen());
      case '/coWinScreen':
        return MaterialPageRoute(builder: (_) => CoWinScreen());
      case '/vaccineHospital':
        return MaterialPageRoute(builder: (_) => VaccineHospital());

      case '/homecare':
        return MaterialPageRoute(builder: (_) => HomeCare());

      case '/pvthospital':
        return MaterialPageRoute(builder: (_) => PvtHospital());
      case '/doctorsScreen':
        return MaterialPageRoute(builder: (_) => DoctorsScreen());
      case '/delivery':
        return MaterialPageRoute(builder: (_) => Delivery());
      case '/helpline':
        return MaterialPageRoute(builder: (_) => Helpline());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      case '/emergency':
        return MaterialPageRoute(builder: (_) => EmergencyScreen());
      case '/postViewDetails':
        return MaterialPageRoute(builder: (_) {
          PostViewScreenArguments argument = args;
          return PostViewDetails(
            username: argument.username,
            hospitalName: argument.hospitalName,
            hAddress: argument.hAddress,
            hContact: argument.hContact,
            otherInfo: argument.otherInfo,
            resourcestype: argument.resourcestype,
          );
        });
      case '/updatedPostViewDetails':
        return MaterialPageRoute(builder: (_) {
          ResourcesArguments argument = args;
          return UpdatedPostViewDetails(
            state: argument.state,
            city: argument.city,
            address: argument.address,
            resourceType: argument.resourceType,
            resourceSubtype: argument.resourceSubtype,
            otherDetails: argument.otherDetails,
            costperUnit: argument.costperUnit,
            contactPerson: argument.contactPerson,
            contactNumber: argument.contactNumber,
            informationSource: argument.informationSource,
            userFullName: argument.userFullName,
            date: argument.date,
          );
        });
      case '/pvtHospitalspostViewDetails':
        return MaterialPageRoute(builder: (_) {
          PlasmaBloodPostViewScreenArguments argument = args;
          return PostViewDetails(
            username: argument.username,
            hospitalName: argument.hospitalName,
            hAddress: argument.hAddress,
            hContact: argument.hContact,
            otherInfo: argument.otherInfo,
            resourcestype: argument.resourcestype,
            verifiedBy: argument.verifiedBy,
          );
        });
      case '/ambulancePostViewDetails':
        return MaterialPageRoute(builder: (_) {
          PlasmaBloodPostViewScreenArguments argument = args;
          return PostViewDetails(
            username: argument.username,
            hospitalName: argument.hospitalName,
            hAddress: argument.hAddress,
            hContact: argument.hContact,
            otherInfo: argument.otherInfo,
            resourcestype: argument.resourcestype,
            verifiedBy: argument.verifiedBy,
          );
        });
      case '/homeCarePostViewDetails':
        return MaterialPageRoute(builder: (_) {
          HomeCarePostViewScreenArguments argument = args;
          return PostViewDetails(
            username: argument.username,
            hospitalName: argument.hospitalName,
            hAddress: argument.hAddress,
            hContact: argument.hContact,
            otherInfo: argument.otherInfo,
            resourcestype: argument.resourcestype,
            verifiedBy: argument.verifiedBy,
            pricePerDay: argument.pricePerDay,
          );
        });

      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/mealScreen':
        return MaterialPageRoute(builder: (_) => MealScreen());

      default:
        return MaterialPageRoute(builder: (_) => EmptyView());
    }
  }
}

class PostViewScreenArguments {
  final String username,
      hospitalName,
      hContact,
      otherInfo,
      hAddress,
      resourcestype;

  PostViewScreenArguments(this.username, this.hospitalName, this.hContact,
      this.otherInfo, this.hAddress, this.resourcestype);
}
