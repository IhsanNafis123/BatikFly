import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/navbar/bindings/navbar_binding.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  // 1. Wajib ditambahkan agar proses async (seperti inisialisasi database) bisa berjalan sebelum UI muncul
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi Supabase menggunakan URL dan Anon Key proyek Stylo Anda
  await Supabase.initialize(
    url: 'https://cibyndvalwemevzqydxu.supabase.co',
    anonKey: 'sb_publishable_6xoHEnsyqaw5qrNMIwQ01g_ToKrSp5t',
  );

  await GetStorage.init();
  
  await initializeDateFormatting('id_ID',null,);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}