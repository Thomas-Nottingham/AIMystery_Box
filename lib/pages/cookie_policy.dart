import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
import 'package:SandBox_Gifts_Backup/footer.dart';

// Adjust these imports based on your actual project structure
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
// If you have a separate Footer widget and use it:
// import 'package:SandBox_Gifts_Backup/footer.dart';

class CookiePolicyPage extends StatelessWidget {
  const CookiePolicyPage({super.key});

  // Helper function to launch URLs
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    // Base style for paragraphs, to be used in RichText
    final TextStyle paragraphStyle = TextStyle(
      color: Colors.grey[300],
      fontSize: 15,
      height: 1.5,
    );

    // Style for links
    final TextStyle linkStyle = TextStyle(
      color: Colors.blue[400], // A typical link color
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue[400],
      fontSize: 15, // Keep consistent with paragraph font size
      height: 1.5,
    );

    return BaseLayout(
      appBarColor: const Color(0xFF1F1F1F),
      text_title: Text(
        'Cookie Policy',
        style: TextStyle(color: Pallete.whiteColor),
      ),
      child: Container(
        color: const Color.fromARGB(255, 36, 36, 36),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last updated May 21, 2025',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),

                Paragraph(
                  "This Cookie Policy explains how Vitreon Limited uses cookies and similar technologies to recognize you when you visit our website at https://thegiftvaults.com (\"Website\"). It explains what these technologies are and why we use them, as well as your rights to control our use of them.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "In some cases we may use cookies to collect personal information, or that becomes personal information if we combine it with other information.",
                ),
                const SizedBox(height: 30),

                SectionTitle('What are cookies?'),
                const SizedBox(height: 10),
                Paragraph(
                  "Cookies are small data files that are placed on your computer or mobile device when you visit a website. Cookies are widely used by website owners in order to make their websites work, or to work more efficiently, as well as to provide reporting information.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "Cookies set by the website owner (in this case, Vitreon Limited) are called \"first-party cookies.\" Cookies set by parties other than the website owner are called \"third-party cookies.\" Third-party cookies enable third-party features or functionality to be provided on or through the website (e.g., advertising, interactive content, and analytics). The parties that set these third-party cookies can recognize your computer both when it visits the website in question and also when it visits certain other websites.",
                ),
                const SizedBox(height: 30),

                SectionTitle('Why do we use cookies?'),
                const SizedBox(height: 10),
                Paragraph(
                  "We use first- and third-party cookies for several reasons. Some cookies are required for technical reasons in order for our Website to operate, and we refer to these as \"essential\" or \"strictly necessary\" cookies. Other cookies also enable us to track and target the interests of our users to enhance the experience on our Online Properties. Third parties serve cookies through our Website for advertising, analytics, and other purposes. This is described in more detail below.",
                ),
                const SizedBox(height: 30),

                SectionTitle('How can I control cookies?'),
                const SizedBox(height: 10),
                Paragraph(
                  "You have the right to decide whether to accept or reject cookies. You can exercise your cookie rights by setting your preferences in the Cookie Consent Manager. The Cookie Consent Manager allows you to select which categories of cookies you accept or reject. Essential cookies cannot be rejected as they are strictly necessary to provide you with services.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "The Cookie Consent Manager can be found in the notification banner and on our Website. If you choose to reject cookies, you may still use our Website though your access to some functionality and areas of our Website may be restricted. You may also set or amend your web browser controls to accept or refuse cookies.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "The specific types of first- and third-party cookies served through our Website and the purposes they perform are described in the table below (please note that the specific cookies served may vary depending on the specific Online Properties you visit):",
                ),
                const SizedBox(height: 15),
                Text(
                  "Essential website cookies:",
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Paragraph(
                  "These cookies are strictly necessary to provide you with services available through our Website and to use some of its features, such as access to secure areas.",
                ),
                const SizedBox(height: 15),

                // --- MODIFIED COOKIE DETAILS ---
                Align(
                  // To ensure RichText adheres to CrossAxisAlignment.start from Column
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify, // Keep justification
                    text: TextSpan(
                      style: paragraphStyle, // Default style for this RichText
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "Name: __stripe_sid\nPurpose: Fraud prevention and detection\nProvider: .thegiftvaults.com\nService: Stripe ",
                        ),
                        TextSpan(
                          text: "View Service Privacy Policy",
                          style: linkStyle,
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                    'https://stripe.com/en-nl/privacy',
                                  );
                                },
                        ),
                        const TextSpan(
                          text: "\nType: http_cookie\nExpires in: 30 minutes",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: paragraphStyle,
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "Name: __stripe_mid\nPurpose: Fraud prevention and detection\nProvider: .thegiftvaults.com\nService: Stripe ",
                        ),
                        TextSpan(
                          text: "View Service Privacy Policy",
                          style: linkStyle,
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                    'https://stripe.com/en-nl/privacy',
                                  );
                                },
                        ),
                        const TextSpan(
                          text:
                              "\nType: http_cookie\nExpires in: 11 months 30 days",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: paragraphStyle,
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "Name: m\nPurpose: Tracks the user's session for Stripe\nProvider: m.stripe.com\nService: Stripe ",
                        ),
                        TextSpan(
                          text: "View Service Privacy Policy",
                          style: linkStyle,
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                    'https://stripe.com/en-nl/privacy',
                                  );
                                },
                        ),
                        const TextSpan(
                          text:
                              "\nType: server_cookie\nExpires in: 1 year 11 months 29 days",
                        ),
                      ],
                    ),
                  ),
                ),
                // --- END OF MODIFIED COOKIE DETAILS ---
                const SizedBox(height: 30),

                SectionTitle('How can I control cookies on my browser?'),
                const SizedBox(height: 10),
                Paragraph(
                  "As the means by which you can refuse cookies through your web browser controls vary from browser to browser, you should visit your browser's help menu for more information. The following is information about how to manage cookies on the most popular browsers:\nChrome\nInternet Explorer\nFirefox\nSafari\nEdge\nOpera",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "In addition, most advertising networks offer you a way to opt out of targeted advertising. If you would like to find out more information, please visit:\nDigital Advertising Alliance\nDigital Advertising Alliance of Canada\nEuropean Interactive Digital Advertising Alliance",
                ),
                const SizedBox(height: 30),

                SectionTitle(
                  'What about other tracking technologies, like web beacons?',
                ),
                const SizedBox(height: 10),
                Paragraph(
                  "Cookies are not the only way to recognize or track visitors to a website. We may use other, similar technologies from time to time, like web beacons (sometimes called \"tracking pixels\" or \"clear gifs\"). These are tiny graphics files that contain a unique identifier that enables us to recognize when someone has visited our Website or opened an email including them. This allows us, for example, to monitor the traffic patterns of users from one page within a website to another, to deliver or communicate with cookies, to understand whether you have come to the website from an online advertisement displayed on a third-party website, to improve site performance, and to measure the success of email marketing campaigns. In many instances, these technologies are reliant on cookies to function properly, and so declining cookies will impair their functioning.",
                ),
                const SizedBox(height: 30),

                SectionTitle(
                  'Do you use Flash cookies or Local Shared Objects?',
                ),
                const SizedBox(height: 10),
                Paragraph(
                  "Websites may also use so-called \"Flash Cookies\" (also known as Local Shared Objects or \"LSOs\") to, among other things, collect and store information about your use of our services, fraud prevention, and for other site operations.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "If you do not want Flash Cookies stored on your computer, you can adjust the settings of your Flash player to block Flash Cookies storage using the tools contained in the Website Storage Settings Panel. You can also control Flash Cookies by going to the Global Storage Settings Panel and following the instructions (which may include instructions that explain, for example, how to delete existing Flash Cookies (referred to \"information\" on the Macromedia site), how to prevent Flash LSOs from being placed on your computer without your being asked, and (for Flash Player 8 and later) how to block Flash Cookies that are not being delivered by the operator of the page you are on at the time).",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "Please note that setting the Flash Player to restrict or limit acceptance of Flash Cookies may reduce or impede the functionality of some Flash applications, including, potentially, Flash applications used in connection with our services or online content.",
                ),
                const SizedBox(height: 30),

                SectionTitle('Do you serve targeted advertising?'),
                const SizedBox(height: 10),
                Paragraph(
                  "Third parties may serve cookies on your computer or mobile device to serve advertising through our Website. These companies may use information about your visits to this and other websites in order to provide relevant advertisements about goods and services that you may be interested in. They may also employ technology that is used to measure the effectiveness of advertisements. They can accomplish this by using cookies or web beacons to collect information about your visits to this and other sites in order to provide relevant advertisements about goods and services of potential interest to you. The information collected through this process does not enable us or them to identify your name, contact details, or other details that directly identify you unless you choose to provide these.",
                ),
                const SizedBox(height: 30),

                SectionTitle('How often will you update this Cookie Policy?'),
                const SizedBox(height: 10),
                Paragraph(
                  "We may update this Cookie Policy from time to time in order to reflect, for example, changes to the cookies we use or for other operational, legal, or regulatory reasons. Please therefore revisit this Cookie Policy regularly to stay informed about our use of cookies and related technologies.",
                ),
                const SizedBox(height: 20),
                Paragraph(
                  "The date at the top of this Cookie Policy indicates when it was last updated.",
                ),
                const SizedBox(height: 30),

                SectionTitle('Where can I get further information?'),
                const SizedBox(height: 10),
                Paragraph(
                  "If you have any questions about our use of cookies or other technologies, please contact us at:",
                ),
                const SizedBox(height: 15),
                Paragraph(
                  "Vitreon Limited\nOffice 8081\n321-323 High Road\nChadwell Heath\nEssex RM6 6AX\nUnited Kingdom\nPhone: +44 7307 178980",
                ),
                const SizedBox(height: 60),
                Center(child: MyFooter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Keep your SectionTitle and Paragraph helper widgets as they are.
// SectionTitle definition...
// Paragraph definition...

// Define these helper widgets if they are not in a shared location
// Make sure Pallete.whiteColor is defined.
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Pallete.whiteColor, // Or your desired title color
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;
  const Paragraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[300], // Or your desired paragraph text color
        fontSize: 15,
        height: 1.5, // Line height for better readability
      ),
      textAlign: TextAlign.justify,
    );
  }
}
