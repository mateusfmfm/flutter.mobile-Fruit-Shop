// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class PdfDownloader extends GetxController {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   var firstOpen = false.obs;

//   Future selectNotification(String payload) async {
//     final payloadJson = json.decode(payload);
//     if (payloadJson['path'] != null) {
//       OpenFile.open(payloadJson['path']);
//     }
//     firstOpen.value = true;
//   }

//   // @override
//   // void onInit() {
//   //   super.onInit();

//   //   // Inicializar config Local Notification
//   //   const AndroidInitializationSettings initializationSettingsAndroid =
//   //       AndroidInitializationSettings('@mipmap/launcher_icon');

//   //   final IOSInitializationSettings initializationSettingsIOS =
//   //       new IOSInitializationSettings();

//   //   final InitializationSettings initializationSettings =
//   //       InitializationSettings(
//   //           android: initializationSettingsAndroid,
//   //           iOS: initializationSettingsIOS);

//   //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   //       onSelectNotification: selectNotification);
//   // }

//   Future<bool> saveFile(String url, String fileName, isUrl) async {
//     final Dio dio = Dio();

//     Directory? directory;

//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           print(directory!.path);
//           String newPath = '';
//           List<String> folders = directory.path.split('/');

//           for (int i = 1; i < folders.length; i++) {
//             String folder = folders[i];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/Download";
//           directory = Directory(newPath);
//           print(directory.path);
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         File saveFile = File(directory.path + "/$fileName");

//         if (isUrl) {
//           await dio.download(url, saveFile.path);
//         } else {
//           var document = PdfDocument();
//           //Add page and draw text to the page.
//           String url1 = url.replaceAll(new RegExp(r'[^\w\s]+'), '');

//           final PdfPage page = document.pages.add();
// // Create a new PDF text element class and draw the flow layout text.
//           final PdfLayoutResult? layoutResult = PdfTextElement(
//                   text: url1,
//                   font: PdfStandardFont(PdfFontFamily.helvetica, 12),
//                   brush: PdfSolidBrush(PdfColor(0, 0, 0)))
//               .draw(
//                   page: page,
//                   bounds: Rect.fromLTWH(0, 0, page.getClientSize().width,
//                       page.getClientSize().height),
//                   format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));
// // Draw the next paragraph/content.
//           page.graphics.drawLine(
//               PdfPen(PdfColor(255, 0, 0)),
//               Offset(0, layoutResult!.bounds.bottom + 10),
//               Offset(
//                   page.getClientSize().width, layoutResult.bounds.bottom + 10));

//           var bytes = document.save();

//           //Write PDF data
//           await saveFile.writeAsBytes(bytes, flush: true);
//           // Dispose the document
//           document.dispose();
//         }

//         await showNotification(fileName, saveFile.path);
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }

//   Future<void> showNotification(String filename, String filepath) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('id', 'channel ',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: false);

//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(presentSound: true);

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//         0, // notification id
//         'Download concluído',
//         "$filename",
//         platformChannelSpecifics,
//         payload: '{"path":"$filepath","first_time":"${firstOpen.value}"}');
//   }
// }
