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

  Widget buildField(TextEditingController c, String label, IconData icon, {int lines = 1}) {
    return TextField(
      controller: c,
      maxLines: lines,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  void copyData() {
    final now = DateTime.now();
    final date = '${now.day}/${now.month}/${now.year}';
    final text = '📋 بيانات الأسرة\n─────────────────\n👨‍👩‍👧 اسم الأسرة : ${_family.text}\n📞 التليفون   : ${_phone.text}\n📍 العنوان    : ${_address.text}\n🤲 الاحتياج   : ${_need.text}\n─────────────────\n🗓️ التاريخ    : $date';
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
              buildField(_family, 'اسم الأسرة', Icons.people),
              const SizedBox(height: 16),
              buildField(_phone, 'رقم التليفون', Icons.phone),
              const SizedBox(height: 16),
              buildField(_address, 'العنوان', Icons.location_on),
              const SizedBox(height: 16),
              buildField(_need, 'الاحتياج', Icons.favorite, lines: 3),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: copyData,
                  icon: const Icon(Icons.copy),
                  label: const Text('توليد ونسخ البيانات', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
