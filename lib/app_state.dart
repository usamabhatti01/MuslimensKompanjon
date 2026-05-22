import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_namesList') != null) {
        try {
          _namesList =
              jsonDecode(await secureStorage.getString('ff_namesList') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_user') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_user') ?? '{}';
          _user =
              UserDataStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_AboutIslam') != null) {
        try {
          _AboutIslam =
              jsonDecode(await secureStorage.getString('ff_AboutIslam') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_tasbihList') != null) {
        try {
          _tasbihList =
              jsonDecode(await secureStorage.getString('ff_tasbihList') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
  }

  dynamic _namesList = jsonDecode(
      '{\"names\":[{\"id\":1,\"arabic\":\"ٱللَّٰهُ\",\"english\":\"Allah\",\"meaning_en\":\"The One True God\",\"meaning_ar\":\"الاسم الأعظم الذي تفرد به الله سبحانه وتعالى، المستحق للعبادة وحده.\"},{\"id\":2,\"arabic\":\"ٱلرَّحْمَـٰنُ\",\"english\":\"Ar-Rahman\",\"meaning_en\":\"The Most Merciful\",\"meaning_ar\":\"الواسع الرحمة الذي شملت رحمته جميع الخلق.\"},{\"id\":3,\"arabic\":\"ٱلرَّحِيمُ\",\"english\":\"Ar-Raheem\",\"meaning_en\":\"The Especially Merciful\",\"meaning_ar\":\"الذي يخصّ المؤمنين برحمته ومغفرته.\"},{\"id\":4,\"arabic\":\"ٱلْمَلِكُ\",\"english\":\"Al-Malik\",\"meaning_en\":\"The King\",\"meaning_ar\":\"المالك لكل شيء والمتصرف في خلقه بلا منازع.\"},{\"id\":5,\"arabic\":\"ٱلْقُدُّوسُ\",\"english\":\"Al-Quddus\",\"meaning_en\":\"The Most Holy\",\"meaning_ar\":\"المنزه عن كل نقص وعيب، الطاهر من كل سوء.\"},{\"id\":6,\"arabic\":\"ٱلسَّلَامُ\",\"english\":\"As-Salam\",\"meaning_en\":\"The Source of Peace\",\"meaning_ar\":\"السالم من العيوب، والذي سلم عباده من ظلمه.\"},{\"id\":7,\"arabic\":\"ٱلْمُؤْمِنُ\",\"english\":\"Al-Mu\'min\",\"meaning_en\":\"The Guarantor of Faith\",\"meaning_ar\":\"المصدق لرسله بالآيات، والذي يأمن أولياؤه من عذابه.\"},{\"id\":8,\"arabic\":\"ٱلْمُهَيْمِنُ\",\"english\":\"Al-Muhaymin\",\"meaning_en\":\"The Guardian\",\"meaning_ar\":\"الرقيب المطلع على خفايا الأمور والمسيطر عليها.\"},{\"id\":9,\"arabic\":\"ٱلْعَزِيزُ\",\"english\":\"Al-Aziz\",\"meaning_en\":\"The Almighty\",\"meaning_ar\":\"القوي الغالب الذي لا يُقهر ولا يُغلب.\"},{\"id\":10,\"arabic\":\"ٱلْجَبَّارُ\",\"english\":\"Al-Jabbar\",\"meaning_en\":\"The Compeller\",\"meaning_ar\":\"الذي يجبر قلوب المنكسرين، ويقهر الجبابرة.\"},{\"id\":11,\"arabic\":\"ٱلْمُتَكَبِّرُ\",\"english\":\"Al-Mutakabbir\",\"meaning_en\":\"The Supreme\",\"meaning_ar\":\"المتعالي عن صفات الخلق، والمنفرد بالعظمة والكبرياء.\"},{\"id\":12,\"arabic\":\"ٱلْخَالِقُ\",\"english\":\"Al-Khaliq\",\"meaning_en\":\"The Creator\",\"meaning_ar\":\"المبدع للأشياء والمقدر لها من العدم إلى الوجود.\"},{\"id\":13,\"arabic\":\"ٱلْبَارِئُ\",\"english\":\"Al-Bari\",\"meaning_en\":\"The Evolver\",\"meaning_ar\":\"الذي خلق الخلق بريئاً من التفاوت والنقص.\"},{\"id\":14,\"arabic\":\"ٱلْمُصَوِّرُ\",\"english\":\"Al-Musawwir\",\"meaning_en\":\"The Fashioner\",\"meaning_ar\":\"الذي أعطى لكل مخلوق صورته الخاصة وشكله المميز.\"},{\"id\":15,\"arabic\":\"ٱلْغَفَّارُ\",\"english\":\"Al-Ghaffar\",\"meaning_en\":\"The Repeatedly Forgiving\",\"meaning_ar\":\"الكثير المغفرة لذنوب عباده المستغفرين.\"},{\"id\":16,\"arabic\":\"ٱلْقَهَّارُ\",\"english\":\"Al-Qahhar\",\"meaning_en\":\"The Subduer\",\"meaning_ar\":\"الغالب على كل شيء، الذي قهر الجبابرة بعظمته.\"},{\"id\":17,\"arabic\":\"ٱلْوَهَّابُ\",\"english\":\"Al-Wahhab\",\"meaning_en\":\"The Bestower\",\"meaning_ar\":\"الكثير العطاء الذي يهب النعم بلا عوض أو سبب.\"},{\"id\":18,\"arabic\":\"ٱلرَّزَّاقُ\",\"english\":\"Ar-Razzaq\",\"meaning_en\":\"The Provider\",\"meaning_ar\":\"المتكفل بأرزاق العباد، والذي يوسع الرزق لمن يشاء.\"},{\"id\":19,\"arabic\":\"ٱلْفَتَّاحُ\",\"english\":\"Al-Fattah\",\"meaning_en\":\"The Opener\",\"meaning_ar\":\"الذي يفتح خزائن رحمته وأرزاقه لعباده، والحاكم بينهم.\"},{\"id\":20,\"arabic\":\"ٱلْعَلِيمُ\",\"english\":\"Al-Alim\",\"meaning_en\":\"The All-Knowing\",\"meaning_ar\":\"المحيط علمه بكل شيء، فلا يخفى عليه خافية.\"},{\"id\":21,\"arabic\":\"ٱلْقَابِضُ\",\"english\":\"Al-Qabid\",\"meaning_en\":\"The Withholder\",\"meaning_ar\":\"الذي يمسك الرزق عمن يشاء بحكمته وعدله.\"},{\"id\":22,\"arabic\":\"ٱلْبَاسِطُ\",\"english\":\"Al-Basit\",\"meaning_en\":\"The Extender\",\"meaning_ar\":\"الذي يوسع الرزق لمن يشاء بفضله ورحمته.\"},{\"id\":23,\"arabic\":\"ٱلْخَافِضُ\",\"english\":\"Al-Khafid\",\"meaning_en\":\"The Abaser\",\"meaning_ar\":\"الذي يخفض المتكبرين والظالمين.\"},{\"id\":24,\"arabic\":\"ٱلرَّافِعُ\",\"english\":\"Ar-Rafi\",\"meaning_en\":\"The Exalter\",\"meaning_ar\":\"الذي يرفع درجات المؤمنين والمتقين.\"},{\"id\":25,\"arabic\":\"ٱلْمُعِزُّ\",\"english\":\"Al-Mu\'izz\",\"meaning_en\":\"The Honorer\",\"meaning_ar\":\"الذي يهب العزة والرفعة لمن يشاء من عباده.\"},{\"id\":26,\"arabic\":\"ٱلْمُذِلُّ\",\"english\":\"Al-Mudhill\",\"meaning_en\":\"The Dishonorer\",\"meaning_ar\":\"الذي يذل الجبابرة والمتكبرين ومن يشاء بعدله.\"},{\"id\":27,\"arabic\":\"ٱلسَّمِيعُ\",\"english\":\"As-Sami\",\"meaning_en\":\"The All-Hearing\",\"meaning_ar\":\"الذي لا يخفى عليه مسموع، ويسمع السر والنجوى.\"},{\"id\":28,\"arabic\":\"ٱلْبَصِيرُ\",\"english\":\"Al-Basir\",\"meaning_en\":\"The All-Seeing\",\"meaning_ar\":\"الذي يرى كل شيء، ولا يخفى عليه شيء في الأرض ولا في السماء.\"},{\"id\":29,\"arabic\":\"ٱلْحَكَمُ\",\"english\":\"Al-Hakam\",\"meaning_en\":\"The Judge\",\"meaning_ar\":\"الحاكم العدل الذي يفصل بين الخلائق ولا يظلم أحداً.\"},{\"id\":30,\"arabic\":\"ٱلْعَدْلُ\",\"english\":\"Al-Adl\",\"meaning_en\":\"The Utterly Just\",\"meaning_ar\":\"المنزه عن الظلم والجور في أحكامه وأفعاله.\"},{\"id\":31,\"arabic\":\"ٱللَّطِيفُ\",\"english\":\"Al-Latif\",\"meaning_en\":\"The Subtle One\",\"meaning_ar\":\"البر بعباده، الذي يعلم دقائق الأمور وخفاياها.\"},{\"id\":32,\"arabic\":\"ٱلْخَبِيرُ\",\"english\":\"Al-Khabir\",\"meaning_en\":\"The All-Aware\",\"meaning_ar\":\"العالم بما كان وما يكون، ولا يخفى عليه شيء.\"},{\"id\":33,\"arabic\":\"ٱلْحَلِيمُ\",\"english\":\"Al-Halim\",\"meaning_en\":\"The Forbearing\",\"meaning_ar\":\"الذي لا يعاجل العصاة بالعقوبة، ويمهلهم ليتوبوا.\"},{\"id\":34,\"arabic\":\"ٱلْعَظِيمُ\",\"english\":\"Al-Azim\",\"meaning_en\":\"The Magnificent\",\"meaning_ar\":\"العظيم في ذاته وصفاته، والذي تتضاءل العقول عن إدراكه.\"},{\"id\":35,\"arabic\":\"ٱلْغَفُورُ\",\"english\":\"Al-Ghafur\",\"meaning_en\":\"The Forgiving\",\"meaning_ar\":\"الذي يغفر الذنوب ويستر العيوب مهما كثرت.\"},{\"id\":36,\"arabic\":\"ٱلشَّكُورُ\",\"english\":\"Ash-Shakur\",\"meaning_en\":\"The Appreciative\",\"meaning_ar\":\"الذي يثيب على العمل القليل بالثواب الكثير.\"},{\"id\":37,\"arabic\":\"ٱلْعَلِيُّ\",\"english\":\"Al-Ali\",\"meaning_en\":\"The Most High\",\"meaning_ar\":\"المرتفع عن صفات المخلوقين، والعالي على خلقه.\"},{\"id\":38,\"arabic\":\"ٱلْكَبِيرُ\",\"english\":\"Al-Kabir\",\"meaning_en\":\"The Most Great\",\"meaning_ar\":\"الموصوف بالجلال وكبرياء الشأن، أكبر من كل شيء.\"},{\"id\":39,\"arabic\":\"ٱلْحَفِيظُ\",\"english\":\"Al-Hafiz\",\"meaning_en\":\"The Preserver\",\"meaning_ar\":\"الذي يحفظ السماوات والأرض وما فيهما من الزوال.\"},{\"id\":40,\"arabic\":\"ٱلْمُقِيتُ\",\"english\":\"Al-Muqit\",\"meaning_en\":\"The Sustainer\",\"meaning_ar\":\"خالق الأقوات وموصلها للكائنات، والمقتدر على كل شيء.\"},{\"id\":41,\"arabic\":\"ٱلْحَسِيبُ\",\"english\":\"Al-Hasib\",\"meaning_en\":\"The Reckoner\",\"meaning_ar\":\"الكافي لعباده، والمحاسب لهم على أعمالهم يوم القيامة.\"},{\"id\":42,\"arabic\":\"ٱلْجَلِيلُ\",\"english\":\"Al-Jalil\",\"meaning_en\":\"The Majestic\",\"meaning_ar\":\"المتصف بصفات الجلال والعظمة والمجد.\"},{\"id\":43,\"arabic\":\"ٱلْكَرِيمُ\",\"english\":\"Al-Karim\",\"meaning_en\":\"The Bountiful\",\"meaning_ar\":\"الكثير الخير والعطاء، الذي لا ينفد عطاؤه.\"},{\"id\":44,\"arabic\":\"ٱلرَّقِيبُ\",\"english\":\"Ar-Raqib\",\"meaning_en\":\"The Watchful\",\"meaning_ar\":\"المراقب لأحوال العباد، الذي لا يغفل عنهم.\"},{\"id\":45,\"arabic\":\"ٱلْمُجِيبُ\",\"english\":\"Al-Mujib\",\"meaning_en\":\"The Responsive\",\"meaning_ar\":\"الذي يجيب دعاء الداعين وسؤال السائلين.\"},{\"id\":46,\"arabic\":\"ٱلْوَاسِعُ\",\"english\":\"Al-Wasi\",\"meaning_en\":\"The All-Encompassing\",\"meaning_ar\":\"الذي وسع رزقه ورحمته جميع خلقه، ووسعت معرفته كل شيء.\"},{\"id\":47,\"arabic\":\"ٱلْحَكِيمُ\",\"english\":\"Al-Hakim\",\"meaning_en\":\"The Wise\",\"meaning_ar\":\"الذي يضع الأشياء في مواضعها الصحيحة بحكمة بالغة.\"},{\"id\":48,\"arabic\":\"ٱلْوَدُودُ\",\"english\":\"Al-Wadud\",\"meaning_en\":\"The Loving\",\"meaning_ar\":\"المحب لأوليائه والمحبوب عندهم، المتودد لعباده بالنعم.\"},{\"id\":49,\"arabic\":\"ٱلْمَجِيدُ\",\"english\":\"Al-Majid\",\"meaning_en\":\"The Glorious\",\"meaning_ar\":\"البالغ النهاية في المجد والشرف والكمال.\"},{\"id\":50,\"arabic\":\"ٱلْبَاعِثُ\",\"english\":\"Al-Ba\'ith\",\"meaning_en\":\"The Resurrecter\",\"meaning_ar\":\"الذي يبعث الموتى من القبور للحساب والجزاء.\"},{\"id\":51,\"arabic\":\"ٱلشَّهِيدُ\",\"english\":\"Ash-Shahid\",\"meaning_en\":\"The Witness\",\"meaning_ar\":\"المطلع على كل شيء، الذي لا يغيب عنه شيء.\"},{\"id\":52,\"arabic\":\"ٱلْحَقُّ\",\"english\":\"Al-Haqq\",\"meaning_en\":\"The Truth\",\"meaning_ar\":\"الثابت وجوده يقيناً، والذي قوله حق ووعده حق.\"},{\"id\":53,\"arabic\":\"ٱلْوَكِيلُ\",\"english\":\"Al-Wakil\",\"meaning_en\":\"The Trustee\",\"meaning_ar\":\"الذي توكل بتدبير أمور خلقه وحفظهم.\"},{\"id\":54,\"arabic\":\"ٱلْقَوِيُّ\",\"english\":\"Al-Qawiyy\",\"meaning_en\":\"The Strong\",\"meaning_ar\":\"تام القوة الذي لا يعجزه شيء في الأرض ولا في السماء.\"},{\"id\":55,\"arabic\":\"ٱلْمَتِينُ\",\"english\":\"Al-Matin\",\"meaning_en\":\"The Firm\",\"meaning_ar\":\"الشديد القوة الذي لا تلحقه مشقة ولا تعب.\"},{\"id\":56,\"arabic\":\"ٱلْوَلِيُّ\",\"english\":\"Al-Waliyy\",\"meaning_en\":\"The Protecting Friend\",\"meaning_ar\":\"النصير والظهير لأوليائه، يتولاهم برعايته وتوفيقه.\"},{\"id\":57,\"arabic\":\"ٱلْحَمِيدُ\",\"english\":\"Al-Hamid\",\"meaning_en\":\"The Praiseworthy\",\"meaning_ar\":\"المستحق للحمد والثناء على كل حال.\"},{\"id\":58,\"arabic\":\"ٱلْمُحْصِي\",\"english\":\"Al-Muhsi\",\"meaning_en\":\"The Accounter\",\"meaning_ar\":\"الذي أحصى كل شيء عدداً، ولا يفوته دقيق ولا جليل.\"},{\"id\":59,\"arabic\":\"ٱلْمُبْدِئُ\",\"english\":\"Al-Mubdi\",\"meaning_en\":\"The Originator\",\"meaning_ar\":\"الذي أوجد الكائنات من العدم أول مرة.\"},{\"id\":60,\"arabic\":\"ٱلْمُعِيدُ\",\"english\":\"Al-Mu\'id\",\"meaning_en\":\"The Restorer\",\"meaning_ar\":\"الذي يعيد الخلق بعد الموت للحياة مرة أخرى.\"},{\"id\":61,\"arabic\":\"ٱلْمُحْيِي\",\"english\":\"Al-Muhyi\",\"meaning_en\":\"The Giver of Life\",\"meaning_ar\":\"واهب الحياة، الذي يحيي الأموات ويحيي القلوب الميتة بالإيمان.\"},{\"id\":62,\"arabic\":\"ٱلْمُمِيتُ\",\"english\":\"Al-Mumit\",\"meaning_en\":\"The Bringer of Death\",\"meaning_ar\":\"الذي قدر الموت على خلقه، ولا مميت سواه.\"},{\"id\":63,\"arabic\":\"ٱلْحَيُّ\",\"english\":\"Al-Hayy\",\"meaning_en\":\"The Ever-Living\",\"meaning_ar\":\"الباقي الذي لا يموت، المتصف بالحياة الدائمة الكاملة.\"},{\"id\":64,\"arabic\":\"ٱلْقَيُّومُ\",\"english\":\"Al-Qayyum\",\"meaning_en\":\"The Sustainer of Existence\",\"meaning_ar\":\"القائم بنفسه، والمقيم والمصلح لأمور خلقه.\"},{\"id\":65,\"arabic\":\"ٱلْوَاجِدُ\",\"english\":\"Al-Wajid\",\"meaning_en\":\"The Finder\",\"meaning_ar\":\"الغني الذي لا يفتقر، والذي يجد ما يطلبه متى شاء.\"},{\"id\":66,\"arabic\":\"ٱلْمَاجِدُ\",\"english\":\"Al-Majid\",\"meaning_en\":\"The Noble\",\"meaning_ar\":\"كثير الإحسان والأفضال، عظيم الشأن.\"},{\"id\":67,\"arabic\":\"ٱلْوَاحِدُ\",\"english\":\"Al-Wahid\",\"meaning_en\":\"The One\",\"meaning_ar\":\"المتفرد في ذاته وصفاته وأفعاله، لا شريك له.\"},{\"id\":68,\"arabic\":\"ٱلصَّمَدُ\",\"english\":\"As-Samad\",\"meaning_en\":\"The Eternal Refuge\",\"meaning_ar\":\"السيد المقصود في الحوائج كلها، الذي لا يحتاج إلى أحد.\"},{\"id\":69,\"arabic\":\"ٱلْقَادِرُ\",\"english\":\"Al-Qadir\",\"meaning_en\":\"The Capable\",\"meaning_ar\":\"صاحب القدرة التامة الذي لا يعجزه شيء.\"},{\"id\":70,\"arabic\":\"ٱلْمُقْتَدِرُ\",\"english\":\"Al-Muqtadir\",\"meaning_en\":\"The Powerful\",\"meaning_ar\":\"البالغ في القدرة نهايتها، والمسيطر على كل شيء.\"},{\"id\":71,\"arabic\":\"ٱلْمُقَدِّمُ\",\"english\":\"Al-Muqaddim\",\"meaning_en\":\"The Expediter\",\"meaning_ar\":\"الذي يقدم الأشياء ويضعها في مواضعها، ويقدم من يشاء من عباده.\"},{\"id\":72,\"arabic\":\"ٱلْمُؤَخِّرُ\",\"english\":\"Al-Mu\'akhkhir\",\"meaning_en\":\"The Delayer\",\"meaning_ar\":\"الذي يؤخر الأشياء بحكمته، ويؤخر العقاب عن العصاة.\"},{\"id\":73,\"arabic\":\"ٱلْأَوَّلُ\",\"english\":\"Al-Awwal\",\"meaning_en\":\"The First\",\"meaning_ar\":\"الذي ليس قبله شيء، القديم بلا بداية.\"},{\"id\":74,\"arabic\":\"ٱلْآخِرُ\",\"english\":\"Al-Akhir\",\"meaning_en\":\"The Last\",\"meaning_ar\":\"الذي ليس بعده شيء، الباقي بعد فناء الخلق.\"},{\"id\":75,\"arabic\":\"ٱلظَّاهِرُ\",\"english\":\"Az-Zahir\",\"meaning_en\":\"The Manifest\",\"meaning_ar\":\"الذي ليس فوقه شيء، الظاهر بآياته وقدرته.\"},{\"id\":76,\"arabic\":\"ٱلْبَاطِنُ\",\"english\":\"Al-Batin\",\"meaning_en\":\"The Hidden\",\"meaning_ar\":\"الذي ليس دونه شيء، المطلع على السرائر والخفايا.\"},{\"id\":77,\"arabic\":\"ٱلْوَالِي\",\"english\":\"Al-Wali\",\"meaning_en\":\"The Patron\",\"meaning_ar\":\"المالك للأشياء المتصرف فيها بمشيئته وحكمته.\"},{\"id\":78,\"arabic\":\"ٱلْمُتَعَالِي\",\"english\":\"Al-Muta\'ali\",\"meaning_en\":\"The Supremely Exalted\",\"meaning_ar\":\"المنزه عن كل نقص وعن صفات المخلوقين.\"},{\"id\":79,\"arabic\":\"ٱلْبَرُّ\",\"english\":\"Al-Barr\",\"meaning_en\":\"The Good\",\"meaning_ar\":\"العطوف على عباده، واسع الإحسان والفضل.\"},{\"id\":80,\"arabic\":\"ٱلتَّوَّابُ\",\"english\":\"At-Tawwab\",\"meaning_en\":\"The Accepting of Repentance\",\"meaning_ar\":\"الذي ييسر أسباب التوبة لعباده ويقبلها منهم.\"},{\"id\":81,\"arabic\":\"ٱلْمُنْتَقِمُ\",\"english\":\"Al-Muntaqim\",\"meaning_en\":\"The Avenger\",\"meaning_ar\":\"المعاقب للظالمين والعصاة بعد الإعذار والإنذار.\"},{\"id\":82,\"arabic\":\"ٱلْعَفُوُّ\",\"english\":\"Al-Afuww\",\"meaning_en\":\"The Pardoner\",\"meaning_ar\":\"الذي يمحو السيئات ويتجاوز عن المعاصي.\"},{\"id\":83,\"arabic\":\"ٱلرَّءُوفُ\",\"english\":\"Ar-Ra\'uf\",\"meaning_en\":\"The Compassionate\",\"meaning_ar\":\"البالغ في الرحمة والرأفة بعباده.\"},{\"id\":84,\"arabic\":\"مَالِكُ ٱلْمُلْكِ\",\"english\":\"Malik-ul-Mulk\",\"meaning_en\":\"The Owner of All Sovereignty\",\"meaning_ar\":\"المتصرف في ملكه كيف يشاء، ولا راد لحكمه.\"},{\"id\":85,\"arabic\":\"ذُو ٱلْجَلَالِ وَٱلْإِكْرَامِ\",\"english\":\"Dhul-Jalali-wal-Ikram\",\"meaning_en\":\"Lord of Majesty and Bounty\",\"meaning_ar\":\"المتصف بالعظمة والكبرياء، وصاحب الفضل والإنعام.\"},{\"id\":86,\"arabic\":\"ٱلْمُقْسِطُ\",\"english\":\"Al-Muqsit\",\"meaning_en\":\"The Equitable\",\"meaning_ar\":\"العادل في حكمه وأفعاله الذي ينصف المظلوم من الظالم.\"},{\"id\":87,\"arabic\":\"ٱلْجَامِعُ\",\"english\":\"Al-Jami\",\"meaning_en\":\"The Gatherer\",\"meaning_ar\":\"الذي يجمع الخلائق يوم القيامة للحساب والجزاء.\"},{\"id\":88,\"arabic\":\"ٱلْغَنِيُّ\",\"english\":\"Al-Ghani\",\"meaning_en\":\"The Self-Sufficient\",\"meaning_ar\":\"المستغني عن كل ما سواه، والكل مفتقر إليه.\"},{\"id\":89,\"arabic\":\"ٱلْمُغْنِي\",\"english\":\"Al-Mughni\",\"meaning_en\":\"The Enricher\",\"meaning_ar\":\"الذي يغني من يشاء من عباده ويفيض عليهم من رزقه.\"},{\"id\":90,\"arabic\":\"ٱلْمَانِعُ\",\"english\":\"Al-Mani\",\"meaning_en\":\"The Withholder\",\"meaning_ar\":\"الذي يمنع البلاء عن أوليائه، ويمنع العطاء عمن يشاء بحكمته.\"},{\"id\":91,\"arabic\":\"ٱلضَّارُّ\",\"english\":\"Ad-Darr\",\"meaning_en\":\"The Harm Creator\",\"meaning_ar\":\"المقدر للضرر لمن يشاء بحكمته وعدله.\"},{\"id\":92,\"arabic\":\"ٱلنَّافِعُ\",\"english\":\"An-Nafi\",\"meaning_en\":\"The Benefit Creator\",\"meaning_ar\":\"مقدر النفع والخير لمن يشاء من عباده.\"},{\"id\":93,\"arabic\":\"ٱلنُّورُ\",\"english\":\"An-Nur\",\"meaning_en\":\"The Light\",\"meaning_ar\":\"الذي بنوره تستنير السماوات والأرض، والهادي لقلوب المؤمنين.\"},{\"id\":94,\"arabic\":\"ٱلْهَادِي\",\"english\":\"Al-Hadi\",\"meaning_en\":\"The Guide\",\"meaning_ar\":\"الذي يهدي القلوب إلى الحق، ويهدي الكائنات لمصالحها.\"},{\"id\":95,\"arabic\":\"ٱلْبَدِيعُ\",\"english\":\"Al-Badi\",\"meaning_en\":\"The Incomparable\",\"meaning_ar\":\"الذي أبدع الأشياء وخلقها على غير مثال سابق.\"},{\"id\":96,\"arabic\":\"ٱلْبَاقِي\",\"english\":\"Al-Baqi\",\"meaning_en\":\"The Everlasting\",\"meaning_ar\":\"الدائم الوجود الذي لا يفنى ولا يزول.\"},{\"id\":97,\"arabic\":\"ٱلْوَارِثُ\",\"english\":\"Al-Warith\",\"meaning_en\":\"The Inheritor\",\"meaning_ar\":\"الذي يبقى بعد فناء الخلق، وترجع إليه الأملاك كلها.\"},{\"id\":98,\"arabic\":\"ٱلرَّشِيدُ\",\"english\":\"Ar-Rashid\",\"meaning_en\":\"The Guide to the Right Path\",\"meaning_ar\":\"الذي يرشد خلقه إلى مصالحهم ويهديهم للصواب.\"},{\"id\":99,\"arabic\":\"ٱلصَّبُورُ\",\"english\":\"As-Sabur\",\"meaning_en\":\"The Patient\",\"meaning_ar\":\"الذي لا يعاجل العصاة بالعقوبة، ويمهلهم ليتوبوا إليه.\"}]}');
  dynamic get namesList => _namesList;
  set namesList(dynamic value) {
    _namesList = value;
    secureStorage.setString('ff_namesList', jsonEncode(value));
  }

  void deleteNamesList() {
    secureStorage.delete(key: 'ff_namesList');
  }

  List<YoutubeStruct> _youtubeData = [
    YoutubeStruct.fromSerializableMap(jsonDecode(
        '{\"video\":\"https://www.youtube.com/watch?v=YF9OgRYxXsQ\",\"title\":\"Har du följt våra Ramadan-påminnelser?\",\"topic\":\"Hjälp oss förbättra kanalen genom att svara på en kort enkät (1 minut):\"}'))
  ];
  List<YoutubeStruct> get youtubeData => _youtubeData;
  set youtubeData(List<YoutubeStruct> value) {
    _youtubeData = value;
  }

  void addToYoutubeData(YoutubeStruct value) {
    youtubeData.add(value);
  }

  void removeFromYoutubeData(YoutubeStruct value) {
    youtubeData.remove(value);
  }

  void removeAtIndexFromYoutubeData(int index) {
    youtubeData.removeAt(index);
  }

  void updateYoutubeDataAtIndex(
    int index,
    YoutubeStruct Function(YoutubeStruct) updateFn,
  ) {
    youtubeData[index] = updateFn(_youtubeData[index]);
  }

  void insertAtIndexInYoutubeData(int index, YoutubeStruct value) {
    youtubeData.insert(index, value);
  }

  UserDataStruct _user = UserDataStruct();
  UserDataStruct get user => _user;
  set user(UserDataStruct value) {
    _user = value;
    secureStorage.setString('ff_user', value.serialize());
  }

  void deleteUser() {
    secureStorage.delete(key: 'ff_user');
  }

  void updateUserStruct(Function(UserDataStruct) updateFn) {
    updateFn(_user);
    secureStorage.setString('ff_user', _user.serialize());
  }

  HijriCalenderStruct _hijriData = HijriCalenderStruct();
  HijriCalenderStruct get hijriData => _hijriData;
  set hijriData(HijriCalenderStruct value) {
    _hijriData = value;
  }

  void updateHijriDataStruct(Function(HijriCalenderStruct) updateFn) {
    updateFn(_hijriData);
  }

  dynamic _AboutIslam = jsonDecode(
      '{\"tabs\":[{\"id\":1,\"title\":\"Introduction\",\"subtitle\":\"Welcome to Guiding Reminders\",\"pageHeading\":\"Growing in Faith\",\"imagePath\":\"https://picsum.photos/seed/intro/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3\",\"contentBody\":\"Islam is a beautiful journey of continuous growth.\",\"contentBody2\":\"These daily reminders are designed to help us connect with Allah.\",\"contentBody3\":\"Bismillah.\"},{\"id\":2,\"title\":\"Day 1\",\"subtitle\":\"Prayer is your foundation\",\"pageHeading\":\"The Pillar of Salah\",\"imagePath\":\"https://picsum.photos/seed/day1/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3\",\"contentBody\":\"Salah is the first thing we will be asked about.\",\"contentBody2\":\"It is our direct connection to the Creator.\",\"contentBody3\":\"Make it your priority today.\"},{\"id\":3,\"title\":\"Day 2\",\"subtitle\":\"The beauty of good character\",\"pageHeading\":\"Perfecting Akhlaq\",\"imagePath\":\"\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3\",\"contentBody\":\"The Prophet (PBUH) was sent to perfect good character.\",\"contentBody2\":\"Kindness, honesty, and respect are at the core of our faith.\",\"contentBody3\":\"\"},{\"id\":4,\"title\":\"Day 3\",\"subtitle\":\"Trusting Allah\'s plan\",\"pageHeading\":\"The Power of Sabr\",\"imagePath\":\"https://picsum.photos/seed/day3/600/400\",\"audioPath\":\"\",\"contentBody\":\"Patience is not just waiting; it is how we behave while waiting.\",\"contentBody2\":\"Trust that Allah\'s timing is always perfect.\",\"contentBody3\":\"\"},{\"id\":5,\"title\":\"Day 4\",\"subtitle\":\"Recognizing our blessings\",\"pageHeading\":\"Gratitude (Shukr)\",\"imagePath\":\"https://picsum.photos/seed/day4/600/400\",\"audioPath\":\"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3\",\"contentBody\":\"If you are grateful, Allah will give you more.\",\"contentBody2\":\"Take a moment today to thank Him.\",\"contentBody3\":\"\"}]}');
  dynamic get AboutIslam => _AboutIslam;
  set AboutIslam(dynamic value) {
    _AboutIslam = value;
    secureStorage.setString('ff_AboutIslam', jsonEncode(value));
  }

  void deleteAboutIslam() {
    secureStorage.delete(key: 'ff_AboutIslam');
  }

  dynamic _tasbihList = jsonDecode(
      '[{\"id\":1,\"tasbihName\":\"سُبْحَانَ اللهِ\",\"tasbih\":\"سُبْحَانَ اللهِ فِي اللُّغَةِ تُعْنِي تَنْزِيهَ اللهِ عَزَّ وَجَلَّ عَنِ السُّوءِ، وَأَنْ يَكُونَ لَهُ مِثْلٌ أَوْ شَرِيكٌ.\",\"englishDescription\":\"Glory be to Allah — to declare He is free from all imperfection.\",\"limit\":33},{\"id\":2,\"tasbihName\":\"اللهُ أَكْبَرُ\",\"tasbih\":\"اللهُ أَكْبَرُ تَعْنِي أَنَّ اللهَ أَعْظَمُ مِنْ كُلِّ شَيْءٍ، لَا شَيْءَ يُسَاوِيهِ أَوْ يَفُوقُهُ.\",\"englishDescription\":\"Allah is the Greatest — nothing equals or surpasses Him.\",\"limit\":33},{\"id\":3,\"tasbihName\":\"أَسْتَغْفِرُ اللهَ وَأَتُوبُ إِلَيْهِ\",\"tasbih\":\"أَسْتَغْفِرُ اللهَ أَيْ أَطْلُبُ مَغْفِرَتَهُ، وَأَتُوبُ إِلَيْهِ أَيْ أَرْجِعُ عَنِ الذُّنُوبِ وَأَعُودُ إِلَى طَرِيقِ الصَّوَابِ.\",\"englishDescription\":\"I seek Allah\'s forgiveness and repent to Him, turning away from sins.\",\"limit\":100},{\"id\":4,\"tasbihName\":\"لَا إِلَهَ إِلَّا اللهُ\",\"tasbih\":\"لَا إِلَهَ إِلَّا اللهُ هِيَ كَلِمَةُ التَّوْحِيدِ، تَعْنِي أَنَّهُ لَا مَعْبُودَ بِحَقٍّ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ.\",\"englishDescription\":\"There is no deity worthy of worship except Allah alone, with no partner.\",\"limit\":100},{\"id\":5,\"tasbihName\":\"الْحَمْدُ لِلَّهِ\",\"tasbih\":\"الْحَمْدُ لِلَّهِ تَعْنِي الشُّكْرَ وَالثَّنَاءَ لِلَّهِ عَلَى نِعَمِهِ الظَّاهِرَةِ وَالْبَاطِنَةِ.\",\"englishDescription\":\"All praise and thanks belong to Allah for His visible and hidden blessings.\",\"limit\":33}]');
  dynamic get tasbihList => _tasbihList;
  set tasbihList(dynamic value) {
    _tasbihList = value;
    secureStorage.setString('ff_tasbihList', jsonEncode(value));
  }

  void deleteTasbihList() {
    secureStorage.delete(key: 'ff_tasbihList');
  }

  int _currentTasbihId = 1;
  int get currentTasbihId => _currentTasbihId;
  set currentTasbihId(int value) {
    _currentTasbihId = value;
  }

  int _sessionCount = 1;
  int get sessionCount => _sessionCount;
  set sessionCount(int value) {
    _sessionCount = value;
  }

  List<CityRecordStruct> _cityList = [];
  List<CityRecordStruct> get cityList => _cityList;
  set cityList(List<CityRecordStruct> value) {
    _cityList = value;
  }

  void addToCityList(CityRecordStruct value) {
    cityList.add(value);
  }

  void removeFromCityList(CityRecordStruct value) {
    cityList.remove(value);
  }

  void removeAtIndexFromCityList(int index) {
    cityList.removeAt(index);
  }

  void updateCityListAtIndex(
    int index,
    CityRecordStruct Function(CityRecordStruct) updateFn,
  ) {
    cityList[index] = updateFn(_cityList[index]);
  }

  void insertAtIndexInCityList(int index, CityRecordStruct value) {
    cityList.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
