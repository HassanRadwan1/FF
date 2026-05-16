import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'بيانات الأسرة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FamilyForm(),
    );
  }
}

class FamilyForm extends StatefulWidget {
  const FamilyForm({super.key});
  @override
  State<FamilyForm> createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FamilyForm> {
  final _family = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _need = TextEditingController();

  void _copyData() {
    final now = DateTime.now();
    final date = '${now.day}/${now.month}/${now.year}';
    final text = '''
📋 بيانات الأسرة
─────────────────
👨‍👩‍👧 اسم الأسرة : ${_family.text}
📞 التليفون   : ${_phone.text}
📍 العنوان    : ${_address.text}
🤲 الاحتياج   : ${_need.text}
─────────────────
🗓️ التاريخ    : $date''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم النسخ بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات الأسرة'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _field(_family, 'اسم الأسرة', Icons.people),
              const SizedBox(height: 16),
              _field(_phone, 'رقم التليفون', Icons.phone),
              const SizedBox(height: 16),
              _field(_address, 'العنوان', Icons.location_on),
              const SizedBox(height: 16),
              _field(_need, 'الاحتياج', Icons.favorite, lines: 3),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _copyData,
                  icon: const Icon(Icons.copy),
                  label: const Text('توليد ونسخ البيانات',
