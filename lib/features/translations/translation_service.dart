import 'package:get/get.dart';
import 'package:greeny_solution/features/translations/en_AR.dart';
import 'package:greeny_solution/features/translations/en_Fr.dart';
import 'package:greeny_solution/features/translations/en_Us.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fr_FR': frFR,
        'ar_AR' : arAR,
      };
}