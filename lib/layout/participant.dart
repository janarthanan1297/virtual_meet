import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> createExcel(String code) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName = '$path/Output.xlsx';
  int length;
  FirebaseFirestore.instance.collection('$code').get().then((snapshot) async {
    length = snapshot.docs.length;
    sheet.getRangeByName('A1').setText('Name');
    sheet.getRangeByName('B1').setText('Email');
    sheet.getRangeByName('c1').setText('Time');
    for (int i = 2; i <= length + 1; i++) {
      int j = i - 2;
      sheet.getRangeByName('A$i').setText(snapshot.docs[j]['user name'].toString());
      sheet.getRangeByName('B$i').setText(snapshot.docs[j]['email'].toString());
      sheet.getRangeByName('c$i').setText(snapshot.docs[j]['time'].toString());
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  });
}
