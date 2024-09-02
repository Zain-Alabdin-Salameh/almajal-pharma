import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': arabicTrans,
        'en': englishTrans,
      };

  Map<String, String> get englishTrans {
    return {
      'greeting': 'Hello',
      'login': 'login',
      'register': 'register',
      'login_hint': 'please enter required info to login',
      'ForgetPassword': 'Forget Password?',
      'username': 'username',
      'password': 'password',
      'email': 'email',
      'haveAccount': 'already registered?',
      'eduCources': 'Educational Courses',
      'timer': 'Timer',
      'calc': 'Calculator',
      'settings': 'Settings',
      'lang': 'Language',
      'about': 'About',
      'account': 'Account',
      'popularCourses': 'Popular Courses :',
      'ourTeachers': 'Our Teachers',
      'courseDuration': 'Course Duration :',
      'studentCount': 'Students Count :',
      'days': 'Days',
      'student': 'student',
      'courseDetails': 'Course Details :',
      'lessonsCount': 'Lessons Count :  ',
      'enrollNow': 'Enroll Now',
      'lessons': 'Lessons',
      'files': 'Files',
      'tests': 'Tests',
      'chapters': 'Chapters',
      'startQuiz': 'Start Quiz',
      'ready?': 'Are you ready?',
      'next': 'Next',
      'Choose Your Language': 'Choose Your Language'
    };
  }

  Map<String, String> get arabicTrans {
    return {
      'greeting': 'أهلا بك',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'login_hint': 'الرجاء ادخال المعلومات المطلوبة لتسجيل الدخول',
      'ForgetPassword': 'نسيت كلمة المرور؟',
      'username': 'أسم المستخدم',
      'password': 'كلمة المرور',
      'email': 'البريد الألكتروني',
      'haveAccount': 'لديك حساب بالفعل؟',
      'eduCources': 'الدورات التعليمية',
      'timer': 'المؤقت',
      'calc': 'الحاسبة',
      'settings': 'الإعدادات',
      'lang': 'اللغة',
      'about': 'نبذة عننا',
      'account': 'الحساب',
      'popularCourses': 'الدروس المميزة :',
      'ourTeachers': 'مدرسيننا :',
      'courseDuration': 'مدة الدورة :',
      'studentCount': 'عدد الطلاب : ',
      'days': 'يوم',
      'student': 'طالب',
      'courseDetails': 'تفاصيل الدورة : ',
      'lessonsCount': 'عدد الحصص :',
      'enrollNow': 'أشترك الان',
      'lessons': 'الحصص التعليمية',
      'files': "ملفات الطالب",
      'tests': 'اختبارات المادة',
      'chapters': 'الأقسام',
      'startQuiz': 'ابدأ الاختبار',
      'ready?': 'هل أنت مستعد ؟',
      'next': 'التالي',
      'Choose Your Language': 'أختر لغة التطبيق'
    };
  }
}
