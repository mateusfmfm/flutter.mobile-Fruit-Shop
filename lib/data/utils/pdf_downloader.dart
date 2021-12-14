import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:screenshot/screenshot.dart';

class PdfDownloader {
  takeScreenshot(
      ScreenshotController screenshotController, String filename) async {
    screenshotController.capture().then((Uint8List? image) async {
      savePdf(image!, filename);
    }).catchError((onError) {
      print(onError);
    });
  }

  Future savePdf(Uint8List screenShot, String filename) async {
    Directory? directory;
    directory = await getExternalStorageDirectory();
    print(directory!.path);
    String newPath = '';
    List<String> folders = directory.path.split('/');

    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/Download/";
    directory = Directory(newPath);
    print(directory.path);

    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
            child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
          );
        },
      ),
    );
    File pdfFile = File(directory.path + filename+".pdf");
    pdfFile.writeAsBytesSync(await pdf.save());
  }
}
