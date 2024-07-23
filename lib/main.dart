import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helpoo_insurance_dashboard/core/di/injection.dart' as di;
import 'package:helpoo_insurance_dashboard/core/network/local/cache_helper.dart';
import 'package:helpoo_insurance_dashboard/core/network/remote/api_endpoints.dart';
import 'package:helpoo_insurance_dashboard/core/util/bloc_observer.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/state.dart';
import 'package:helpoo_insurance_dashboard/core/util/enums.dart';
import 'package:helpoo_insurance_dashboard/core/util/routes.dart';
import 'package:helpoo_insurance_dashboard/firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:sizer/sizer.dart';

// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await di.init();

  bool isRtl = false;

  await di.sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('rtl ------------- $value');
    if (value != null) {
      isRtl = value;
    }

    isEnglish = !isRtl;
  });

  String translation = await rootBundle.loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  // const storage = FlutterSecureStorage(
  //   webOptions: WebOptions(
  //     dbName: 'helpoo',
  //     publicKey: 'helpoo',
  //   ),
  // );
  //
  // final key = encrypt.Key.fromUtf8('my 32 length key................');
  // final iv = encrypt.IV.fromLength(16);
  //
  // final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //
  // String? encryptedToken = html.window.localStorage['token'];

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  final String? securedKey = await secureStorage.read(key: 'key');
  var encryptionKey = base64Url.decode(securedKey!);
  await Hive.openBox('helpoo',encryptionCipher: HiveAesCipher(encryptionKey)).then(
    (value) {
      debugPrint('value ---------------- $value');
      debugPrint('value ---------------- ${value.get(Keys.token)}');
      // token = decryptData(base64: value.get(Keys.token)) ?? '';
      token = value.get(Keys.token) ?? '';
      // token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEzOTgsImlhdCI6MTcwMzUwODQ5MiwiZXhwIjoxNzA2MTAwNDkyfQ.ufq0afj0dz4kv9ZoQhmpYc8Z-G041rgxaIUMbnGJOkU';
      // token = '';

      debugPrint('value ---------------- $token');

      if (token.isNotEmpty) {
        debugPrint('---> token is not empty');
        debugPrint('---> currentCompanyId ${value.get(Keys.currentCompanyId)}');
        debugPrint('---> currentUserId ${value.get(Keys.currentUserId)}');

        if ((value.get(Keys.currentCompanyId) as String).isNotEmpty) {
          currentCompanyId =
              value.get(Keys.currentCompanyId) != null ? int.parse(value.get(Keys.currentCompanyId)!) : 0;
        // } else {
        //   currentCompanyId = 0;
        }

        if ((value.get(Keys.currentUserId) as String).isNotEmpty) {
          currentUserId =
              value.get(Keys.currentUserId) != null ? int.parse(value.get(Keys.currentUserId)!) : 0;
        } else {
          currentUserId = 0;
        }

        debugPrint('currentCompanyId ---------------- $currentCompanyId');
        debugPrint('currentUserId ---------------- $currentUserId');

        if ((value.get(Keys.userRoleName) as String).isNotEmpty) {
          userRoleName = value.get(Keys.userRoleName) ?? '';
        } else {
          userRoleName = '';
        }
        // userRoleName = decryptData(base64: value.get(Keys.userRoleName)) ?? '';
      } else {
        token = '';
      }
    },
  );

  // storage.read(key: Keys.token).then((value) {
  //   {
  //
  //   }
  // });

  // await di.sl<CacheHelper>().get('token').then(
  //   (value) {
  //     if (value != null) {
  //
  //
  //       token = value;
  //
  //       storage.read(key: Keys.currentCompanyId).then((value) {
  //         if (value != null) {
  //           currentCompanyId = int.parse(value);
  //         }
  //       });
  //
  //       // di.sl<CacheHelper>().get(Keys.currentCompanyId).then(
  //       //   (value) {
  //       //     if (value != null) {
  //       //       currentCompanyId = value;
  //       //     }
  //       //   },
  //       // );
  //
  //       storage.read(key: Keys.userRoleName).then((value) {
  //         if (value != null) {
  //           userRoleName = value;
  //         }
  //       });
  //
  //       // di.sl<CacheHelper>().get(Keys.userRoleName).then(
  //       //   (value) {
  //       //     if (value != null) {
  //       //       userRoleName = value;
  //       //     }
  //       //   },
  //       // );
  //     } else {
  //       token = '';
  //     }
  //   },
  // );

  // await di.sl<CacheHelper>().get(Keys.corporateId).then((value) {
  //   if (value != null) {
  //     currentCompanyId = value;
  //   } else {
  //     debugPrint('currentCompanyId = 0 ===>>> corporate');
  //     currentCompanyId = 0;
  //   }
  // });
  // User? user = FirebaseAuth.instance.currentUser;

  // if (user != null) {
  //   token = await user.getIdToken();
  // }

  debugPrintFullText('My Current Token => $token');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  idParam = Uri.base.queryParameters["id"] ?? '';

  debugPrint('idParam ---------------- $idParam');

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  await di.sl<CacheHelper>().get(Keys.userName).then((value) {
    if (value != null) {
      userName = value;
    } else {
      userName = '';
    }
    // if (mainBaseUrl == dev) {
    //   _setCompanyIdManuallyForDev(companyUserName: userName);
    // } else if (mainBaseUrl == production) {
    //   _setCompanyIdManuallyForProduction(companyUserName: userName);
    // }
  });

  await di.sl<CacheHelper>().get(Keys.currentCompanyName).then((value) {
    if (value != null) {
      currentCompanyName = value;
    } else {
      currentCompanyName = '';
    }
  });

  await Hive.openBox('helpoo',encryptionCipher: HiveAesCipher(encryptionKey)).then((value) {
    generalID = value.get(Keys.generalID) != null ? int.parse(value.get(Keys.generalID)!) : 0;
  });

  debugPrint('generalID ---------------->> $generalID');
  // if (userRoleName == Rules.Inspector.name ||
  //     userRoleName == Rules.Corporate.name) {
  //   // const storage = FlutterSecureStorage(
  //   //   webOptions: WebOptions(
  //   //     dbName: 'helpoo',
  //   //     publicKey: 'helpoo',
  //   //   ),
  //   // );
  //
  //   await Hive.openBox('helpoo').then((value) {
  //     generalID = decryptData(base64: value.get(Keys.generalID)) != null
  //         ? int.parse(decryptData(base64: value.get(Keys.generalID))!)
  //         : 0;
  //   });
  //
  //   // storage.read(key: Keys.inspectorId).then((value) {
  //   //   if (value != null) {
  //   //     inspectorId = int.parse(value);
  //   //   } else {
  //   //     inspectorId = 0;
  //   //   }
  //   // });
  //
  //   // await di.sl<CacheHelper>().get(Keys.inspectorId).then((value) {
  //   //   if (value != null) {
  //   //     inspectorId = value;
  //   //   } else {
  //   //     inspectorId = 0;
  //   //   }
  //   // });
  // }

  if (userRoleName == Rules.Corporate.name || userRoleName == Rules.CallCenter.name || userRoleName == Rules.Super.name) {
    await di.sl<CacheHelper>().get(Keys.availablePaymentMethods).then((value) {
      if (value != null) {
        debugPrint('availablePaymentMethods => $value');

        availablePayments = value.cast<String, bool>();
      } else {
        debugPrint('availablePaymentMethods => null');
        availablePayments = {};
      }
    });
  }
  // await di.sl<CacheHelper>().get(Keys.corporateId).then((value) {
  //   if (value != null) {
  //     currentCompanyId = value;
  //   } else {
  //     currentCompanyId = 0;
  //   }
  // });

  // debugPrint('User granted permission: ${settings.authorizationStatus}');

  // FirebaseMessaging.instance.getToken().then((value) {
  //   debugPrint('My Current FCM Token => $value');
  // });

  Bloc.observer = MyBlocObserver();

  runApp(
    // DefaultAssetBundle(
    //   bundle: SentryAssetBundle(enableStructuredDataTracing: true),
    //   child: MyApp(
    //     isRtl: isRtl,
    //     translation: translation,
    //   ),
    // ),
    MyApp(
      isRtl: isRtl,
      translation: translation,
    ),
  );

  // runZonedGuarded(
  //   () async {
  //     await SentryFlutter.init(
  //       (options) {
  //         options.dsn =
  //             'https://6d44d197b2444c039274f62f9a7db488@o4505081351176192.ingest.sentry.io/4505119715819520';
  //         options.tracesSampleRate = 1.0;
  //         // options.reportPackages = false;
  //         // options.addInAppInclude('khalil');
  //         // options.considerInAppFramesByDefault = false;
  //       },
  //     );
  //     runApp(
  //       DefaultAssetBundle(
  //         bundle: SentryAssetBundle(enableStructuredDataTracing: true),
  //         child: MyApp(
  //           isRtl: isRtl,
  //           translation: translation,
  //         ),
  //       ),
  //     );
  //   },
  //   (error, stackTrace) async {
  //     await Sentry.captureException(error, stackTrace: stackTrace);
  //   },
  // );
}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;

  const MyApp({
    super.key,
    required this.isRtl,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => di.sl<AppBloc>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )
            ..getConfig(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return RequestsInspector(
            enabled: ENVIRONMENT != production,
            showInspectorOn: ShowInspectorOn.Both,
            child: Sizer(
              builder: (_, __, ___) {
                return MaterialApp(
                  builder: BotToastInit(),
                  // navigatorObservers: [
                  //   SentryNavigatorObserver(),
                  // ],
                  title: 'Helpoo Dashboard',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  themeMode: ThemeMode.light,
                  theme: AppBloc.get(context).lightTheme,
                  darkTheme: AppBloc.get(context).darkTheme,
                  initialRoute: idParam.isNotEmpty
                      ? Routes.tracking
                      : token.isNotEmpty || token != ''
                          ? Routes.home
                          : Routes.login,
                  // initialRoute: Routes.test,
                  routes: Routes.routes,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
