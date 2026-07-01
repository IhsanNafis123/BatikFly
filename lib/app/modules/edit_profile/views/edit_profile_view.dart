import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1021),

        appBar: AppBar(
          title: const Text(
            "EDIT PROFILE",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Obx(() {

          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                const SizedBox(height: 10),

                Hero(

                  tag: "profile",

                  child: Stack(

                    children: [

                      CircleAvatar(

                        radius: 60,

                        backgroundColor: const Color(0xFF15192F),

                        backgroundImage:

                            controller.selectedImage.value != null

                                ? FileImage(
                                    controller.selectedImage.value!,
                                  )

                                : controller.avatar.value.isNotEmpty

                                    ? NetworkImage(
                                        controller.avatar.value,
                                      ) as ImageProvider

                                    : null,

                        child:

                            controller.avatar.value.isEmpty &&
                                    controller.selectedImage.value == null

                                ? const Icon(
                                    Icons.person,
                                    size: 70,
                                    color: Colors.amber,
                                  )

                                : null,

                      ),

                      Positioned(

                        right: 0,

                        bottom: 0,

                        child: InkWell(

                          onTap: controller.pickImage,

                          borderRadius:
                              BorderRadius.circular(30),

                          child: Container(

                            padding: const EdgeInsets.all(8),

                            decoration: const BoxDecoration(

                              color: Colors.amber,

                              shape: BoxShape.circle,

                            ),

                            child: const Icon(

                              Icons.camera_alt,

                              color: Colors.white,

                              size: 20,

                            ),

                          ),

                        ),

                      ),

                    ],

                  ),

                ),

                const SizedBox(height: 15),

                TextButton.icon(
                  onPressed: controller.pickImage,
                  icon: const Icon(
                    Icons.photo,
                    color: Colors.amber,
                  ),
                  label: const Text(
                    "Ganti Foto",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                                _buildSectionTitle("Informasi Akun"),

                const SizedBox(height: 20),

                _buildTextField(

                  controller: controller.usernameController,

                  label: "Username",

                  hint: "Masukkan username",

                  icon: Icons.person,

                ),

                const SizedBox(height: 20),

                // ==========================
                // EMAIL
                // ==========================

                controller.provider.value == "google"

                    ? _buildReadOnlyField(

                        label: "Email",

                        value: controller.email.value,

                        icon: Icons.email,

                      )

                    : _buildTextField(

                        controller:
                            controller.emailController,

                        label: "Email",

                        hint: "Masukkan email",

                        icon: Icons.email,

                        keyboardType:
                            TextInputType.emailAddress,

                      ),

                // ==========================
                // PASSWORD
                // Hanya akun lokal
                // ==========================

                if (controller.provider.value != "google")
                  ...[

                    const SizedBox(height: 20),

                    _buildTextField(

                      controller:
                          controller.oldPasswordController,

                      label: "Password Lama",

                      hint: "Masukkan password lama",

                      icon: Icons.lock_outline,

                      obscureText: true,

                    ),

                    const SizedBox(height: 20),

                    _buildTextField(

                      controller:
                          controller.newPasswordController,

                      label: "Password Baru",

                      hint: "Masukkan password baru",

                      icon: Icons.lock,

                      obscureText: true,

                    ),

                    const SizedBox(height: 20),

                    _buildTextField(

                      controller: controller
                          .confirmPasswordController,

                      label: "Konfirmasi Password",

                      hint: "Masukkan ulang password",

                      icon: Icons.lock_reset,

                      obscureText: true,

                    ),

                  ],

                const SizedBox(height: 35),
                                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton.icon(

                    onPressed: controller.saveProfile,

                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,

                      shape: RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(16),

                      ),

                    ),

                    icon: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),

                    label: const Text(
                      "SIMPAN PERUBAHAN",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),

                  ),

                ),

                const SizedBox(height: 30),

              ],

            ),

          );

        }),

      ),

    );

  }
  Widget _buildSectionTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white,),
        obscureText: obscureText,
        keyboardType: keyboardType,

        decoration: InputDecoration(

          hintStyle: const TextStyle(
            color: Colors.white38,
          ),

          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),

          filled: true,

          fillColor: const Color(0xFF15192F),


          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.amber,
              width: 2,
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

        ),
      ),

    ],
  );
}

Widget _buildReadOnlyField({
  required String label,
  required String value,
  required IconData icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        style: const TextStyle(
          color: Colors.white70,
        ),
        controller: TextEditingController(
          text: value,
        ),

        readOnly: true,

        decoration: InputDecoration(

          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),

          filled: true,

          fillColor: const Color(0xFF15192F),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

        ),

      ),

    ],
  );
}
}