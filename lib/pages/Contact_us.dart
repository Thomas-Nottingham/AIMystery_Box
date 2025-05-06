import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  Future<void> sendToSupabase(String name, String email, String message) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('contact_messages').insert({
      'name': name,
      'email': email,
      'message': message,
    });

    // Log the full response for debugging
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;

    // Controllers...
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return BaseLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Stack with background image and contact form
            SizedBox(
              height: screenHeight,
              child: Stack(
                children: [
                  // Background Image
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Image.asset(
                      isMobile
                          ? 'assets/images/contactUs.png'
                          : 'assets/images/contactUsLandscape.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),

                  // Contact Form
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: isMobile ? screenWidth * 0.9 : 1000,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.cyanAccent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "CONTACT US",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Please contact us with any questions or concerns you may have. We are here to help!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              "Your Name",
                              controller: nameController,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              "Your Mail",
                              controller: emailController,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              "Your Message - Max 4000 characters",
                              controller: messageController,
                              maxLines: 4,
                              maxLength: 4000,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () async {
                                final name = nameController.text.trim();
                                final email = emailController.text.trim();
                                final message = messageController.text.trim();

                                if (name.isEmpty ||
                                    email.isEmpty ||
                                    message.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please fill out all fields.",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // Capture the current context
                                final currentContext = context;

                                try {
                                  await sendToSupabase(name, email, message);

                                  // Use the captured context
                                  ScaffoldMessenger.of(
                                    currentContext,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Message sent successfully!",
                                      ),
                                    ),
                                  );

                                  // Clear the text fields after successful submission
                                  nameController.clear();
                                  emailController.clear();
                                  messageController.clear();
                                } catch (e) {
                                  // Use the captured context
                                  ScaffoldMessenger.of(
                                    currentContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Failed to send message: $e",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "SUBMIT →",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer section (visible *after* scrolling)
            MyFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText, {
    required TextEditingController controller,
    int maxLines = 1,
    int? maxLength,
    bool showCounter = true,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      buildCounter:
          showCounter
              ? null
              : (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) => null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        counterStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
