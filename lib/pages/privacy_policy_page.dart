import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBarColor: const Color(0xFF1F1F1F),
      text_title: Text(
        'Privacy Policy',
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
              children: const [
                Text(
                  'Last updated May 18, 2025',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 20),
                SectionTitle('Privacy Policy'),
                SizedBox(height: 10),
                Paragraph(
                  "This Privacy Notice for Vitreon Limited ('we', 'us', or 'our'), describes how and why we might access, collect, store, use, and/or share ('process') your personal information when you use our services ('Services'), including when you:\n\n"
                  "• Visit our website at thegiftvaults.com, or any website of ours that links to this Privacy Notice\n"
                  "• Engage with us in other related ways, including any sales, marketing, or events\n\n"
                  "Questions or concerns? Reading this Privacy Notice will help you understand your privacy rights and choices. We are responsible for making decisions about how your personal information is processed. If you do not agree with our policies and practices, please do not use our Services. If you still have any questions or concerns, please contact us at vitreongen@gmail.com.",
                ),
                SizedBox(height: 30),
                SectionTitle('SUMMARY OF KEY POINTS'),
                SizedBox(height: 10),
                ItalicText(
                  'This summary provides key points from our Privacy Notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for.',
                ),
                SizedBox(height: 20),
                BoldQuestion('What personal information do we process?'),
                Paragraph(
                  "When you visit, use, or navigate our Services, we may process personal information depending on how you interact with us and the Services, the choices you make, and the products and features you use.",
                ),
                BoldQuestion(
                  'Do we process any sensitive personal information?',
                ),
                Paragraph("We do not process sensitive personal information."),
                BoldQuestion(
                  'Do we collect any information from third parties?',
                ),
                Paragraph(
                  "We do not collect any information from third parties.",
                ),
                BoldQuestion('How do we process your information?'),
                Paragraph(
                  "We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.",
                ),
                BoldQuestion(
                  'In what situations and with which parties do we share personal information?',
                ),
                Paragraph(
                  "We may share information in specific situations and with specific third parties.",
                ),
                BoldQuestion('How do we keep your information safe?'),
                Paragraph(
                  "We have organizational and technical processes and procedures in place to protect your personal information. However, no electronic transmission over the internet or information storage technology can be guaranteed to be 100% secure.",
                ),
                BoldQuestion('What are your rights?'),
                Paragraph(
                  "Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information.",
                ),
                BoldQuestion('How do you exercise your rights?'),
                Paragraph(
                  "The easiest way to exercise your rights is by contacting us at vitreongen@gmail.com. We will consider and act upon any request in accordance with applicable data protection laws.",
                ),
                SizedBox(height: 30),
                SectionTitle('1. WHAT INFORMATION DO WE COLLECT?'),
                SizedBox(height: 10),
                BoldQuestion('Personal information you disclose to us'),
                ItalicText(
                  'In Short: We collect personal information that you provide to us.',
                ),
                Paragraph(
                  "We collect personal information that you voluntarily provide to us when you express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.",
                ),
                Paragraph(
                  "Personal Information Provided by You. The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:\n\n"
                  "• names\n"
                  "• email addresses\n"
                  "• debit/credit card numbers\n"
                  "• billing addresses\n"
                  "• contact or authentication data",
                ),
                BoldQuestion('Sensitive Information'),
                Paragraph("We do not process sensitive information."),
                BoldQuestion('Payment Data'),
                Paragraph(
                  "We may collect data necessary to process your payment if you choose to make purchases, such as your payment instrument number, and the security code associated with your payment instrument. All payment data is handled and stored by Stripe. You may find their privacy notice link(s) here:\n"
                  "https://stripe.com/gb/privacy.",
                ),
                Paragraph(
                  "All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.",
                ),
                BoldQuestion('Information automatically collected'),
                ItalicText(
                  "In Short: Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our Services.",
                ),
                Paragraph(
                  "We automatically collect certain information when you visit, use, or navigate the Services. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our Services, and other technical information. "
                  "This information is primarily needed to maintain the security and operation of our Services, and for our internal analytics and reporting purposes.",
                ),
                Paragraph(
                  "Like many businesses, we also collect information through cookies and similar technologies.",
                ),
                Paragraph(
                  "The information we collect includes:\n\n"
                  "• Log and Usage Data. Log and usage data is service-related, diagnostic, usage, and performance information our servers automatically collect when you access or use our Services and which we record in log files. "
                  "Depending on how you interact with us, this log data may include your IP address, device information, browser type, and settings and information about your activity in the Services "
                  "(such as the date/time stamps associated with your usage, pages and files viewed, searches, and other actions you take such as which features you use), device event information "
                  "(such as system activity, error reports [sometimes called 'crash dumps']), and hardware settings.\n\n"
                  "• Device Data. We collect device data such as information about your computer, phone, tablet, or other device you use to access the Services. "
                  "Depending on the device used, this device data may include information such as your IP address (or proxy server), device and application identification numbers, location, browser type, "
                  "hardware model, Internet service provider and/or mobile carrier, operating system, and system configuration information.",
                ),
                SizedBox(height: 30),
                SectionTitle('2. HOW DO WE PROCESS YOUR INFORMATION?'),
                ItalicText(
                  "In Short: We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.",
                ),
                Paragraph(
                  "We process your personal information for a variety of reasons, depending on how you interact with our Services, including:",
                ),
                Paragraph(
                  "• To deliver and facilitate delivery of services to the user. We may process your information to provide you with the requested service.\n"
                  "• To fulfil and manage your orders. We may process your information to fulfil and manage your orders, payments, returns, and exchanges made through the Services.\n"
                  "• To identify usage trends. We may process information about how you use our Services to better understand how they are being used so we can improve them.\n"
                  "• To save or protect an individual’s vital interest. We may process your information when necessary to save or protect an individual’s vital interest, such as to prevent harm.\n"
                  "• Product Finding. We utilise the information provided during the chat conversation to match the interests and requirements with product options.",
                ),
                SizedBox(height: 30),
                SectionTitle(
                  '3. WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR INFORMATION?',
                ),
                ItalicText(
                  "In Short: We only process your personal information when we believe it is necessary and we have a valid legal reason (i.e. legal basis) to do so under applicable law, "
                  "like with your consent, to comply with laws, to provide you with services to enter into or fulfill our contractual obligations, to protect your rights, or to fulfill our legitimate business interests.",
                ),
                Paragraph(
                  "The General Data Protection Regulation (GDPR) and UK GDPR require us to explain the valid legal bases we rely on in order to process your personal information. As such, we may rely on the following legal bases to process your personal information:\n\n"
                  "• Consent. We may process your information if you have given us permission (i.e. consent) to use your personal information for a specific purpose. "
                  "You can withdraw your consent at any time. Learn more about withdrawing your consent.",
                ),
                Paragraph(
                  "• Performance of a Contract. We may process your personal information when we believe it is necessary to fulfil our contractual obligations to you, including providing our Services or at your request prior to entering into a contract with you.\n"
                  "• Legitimate Interests. We may process your information when we believe it is reasonably necessary to achieve our legitimate business interests and those interests do not outweigh your interests and fundamental rights and freedoms. "
                  "For example, we may process your personal information for some of the purposes described in order to:\n"
                  "    ○ Analyse how our Services are used so we can improve them to engage and retain users\n"
                  "• Legal Obligations. We may process your information where we believe it is necessary for compliance with our legal obligations, such as to cooperate with a law enforcement body or regulatory agency, exercise or defend our legal rights, or disclose your information as evidence in litigation in which we are involved.\n"
                  "• Vital Interests. We may process your information where we believe it is necessary to protect your vital interests or the vital interests of a third party, such as situations involving potential threats to the safety of any person.",
                ),
                SizedBox(height: 30),
                SectionTitle(
                  '4. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?',
                ),
                ItalicText(
                  "In Short: We may share information in specific situations described in this section and/or with the following third parties.",
                ),
                Paragraph(
                  "Vendors, Consultants, and Other Third-Party Service Providers. We may share your data with third-party vendors, service providers, contractors, or agents ('third parties') who perform services for us or on our behalf and require access to such information to do that work. "
                  "We have contracts in place with our third parties, which are designed to help safeguard your personal information. This means that they cannot do anything with your personal information unless we have instructed them to do it. "
                  "They will also not share your personal information with any organisation apart from us. They also commit to protect the data they hold on our behalf and to retain it for the period we instruct.",
                ),
                Paragraph(
                  "The third parties we may share personal information with are as follows:",
                ),
                Paragraph(
                  "• AI Service Providers\n"
                  "   ○ Groq\n"
                  "• Cloud Computing Services\n"
                  "   ○ Supabase\n"
                  "• Invoice and Billing\n"
                  "   ○ Stripe\n"
                  "• Web and Mobile Analytics\n"
                  "   ○ Google Analytics\n"
                  "• Website Hosting\n"
                  "   ○ Hostinger",
                ),
                Paragraph(
                  "We also may need to share your personal information in the following situations:\n\n"
                  "• Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.",
                ),
                SizedBox(height: 30),
                SectionTitle(
                  '5. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?',
                ),
                ItalicText(
                  'In Short: We may use cookies and other tracking technologies to collect and store your information.',
                ),
                Paragraph(
                  "We may use cookies and similar tracking technologies (like web beacons and pixels) to gather information when you interact with our Services. "
                  "Some online tracking technologies help us maintain the security of our Services, prevent crashes, fix bugs, save your preferences, and assist with basic site functions.",
                ),
                Paragraph(
                  "We also permit third parties and service providers to use online tracking technologies on our Services for analytics and advertising, including to help manage and display advertisements, "
                  "to tailor advertisements to your interests, or to send abandoned shopping cart reminders (depending on your communication preferences). "
                  "The third parties and service providers use their technology to provide advertising about products and services tailored to your interests which may appear either on our Services or on other websites.",
                ),
                Paragraph(
                  "Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.",
                ),
                BoldQuestion('Google Analytics'),
                Paragraph(
                  "We may share your information with Google Analytics to track and analyse the use of the Services. To opt out of being tracked by Google Analytics across the Services, "
                  "visit https://tools.google.com/dlpage/gaoptout. For more information on the privacy practices of Google, please visit the Google Privacy & Terms page.",
                ),
                SizedBox(height: 30),
                SectionTitle(
                  '6. DO WE OFFER ARTIFICIAL INTELLIGENCE–BASED PRODUCTS?',
                ),
                ItalicText(
                  'In Short: We offer products, features, or tools powered by artificial intelligence, machine learning, or similar technologies.',
                ),
                Paragraph(
                  "As part of our Services, we offer products, features, or tools powered by artificial intelligence, machine learning, or similar technologies (collectively, 'AI Products'). "
                  "These tools are designed to enhance your experience and provide you with innovative solutions. The terms in this Privacy Notice govern your use of the AI Products within our Services.",
                ),
                BoldQuestion('Use of AI Technologies'),
                Paragraph(
                  "We provide the AI Products through third-party service providers ('AI Service Providers'), including Groq. As outlined in this Privacy Notice, your input, output, and personal information will be shared with and processed by these AI Service Providers "
                  "to enable your use of our AI Products for purposes outlined in 'What Legal Bases Do We Rely On To Process Your Personal Information?'. You must not use the AI Products in any way that violates the terms or policies of any AI Service Provider.",
                ),
                BoldQuestion('Our AI Products'),
                Paragraph(
                  "Our AI Products are designed for the following functions:\n\n• AI bots",
                ),
                BoldQuestion('How We Process Your Data Using AI'),
                Paragraph(
                  "All personal information processed using our AI Products is handled in line with our Privacy Notice and our agreement with third parties. "
                  "This ensures high security and safeguards your personal information throughout the process, giving you peace of mind about your data’s safety.",
                ),
                SizedBox(height: 30),
                SectionTitle('7. HOW LONG DO WE KEEP YOUR INFORMATION?'),
                ItalicText(
                  'In Short: We keep your information for as long as necessary to fulfill the purposes outlined in this privacy notice unless otherwise required by law.',
                ),
                Paragraph(
                  "We will only keep your personal information for as long as it is necessary for the purposes set out in this privacy notice, unless a longer retention period is required or permitted by law (such as tax, accounting, or other legal requirements).",
                ),
                Paragraph(
                  "When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymize such information, "
                  "or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information "
                  "and isolate it from any further processing until deletion is possible.",
                ),
                SizedBox(height: 30),
                SectionTitle('8. HOW DO WE KEEP YOUR INFORMATION SAFE?'),
                ItalicText(
                  'In Short: We aim to protect your personal information through a system of organisational and technical security measures.',
                ),
                Paragraph(
                  "We have implemented appropriate and reasonable technical and organisational security measures designed to protect the security of any personal information we process. "
                  "However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, "
                  "so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorised third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information.",
                ),
                Paragraph(
                  "Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk. "
                  "You should only access the Services within a secure environment.",
                ),
                SizedBox(height: 30),
                SectionTitle('9. DO WE COLLECT INFORMATION FROM MINORS?'),
                ItalicText(
                  'In Short: We do not knowingly collect data from or market to children under 18 years of age.',
                ),
                Paragraph(
                  "We do not knowingly collect, solicit data from, or market to children under 18 years of age, nor do we knowingly sell such personal information. "
                  "By using the Services, you represent that you are at least 18 or that you are the parent or guardian of such a minor and consent to such minor dependent’s use of the Services. "
                  "If we learn that personal information from users less than 18 years of age has been collected, we will deactivate the account and take reasonable measures to promptly delete such data from our records. "
                  "If you become aware of any data we may have collected from children under age 18, please contact us at vitreongen@gmail.com.",
                ),
                SizedBox(height: 30),
                SectionTitle('10. WHAT ARE YOUR PRIVACY RIGHTS?'),
                ItalicText(
                  'In Short: In some regions, such as the European Economic Area (EEA), United Kingdom (UK), and Switzerland, '
                  'you have rights that allow you greater access to and control over your personal information. '
                  'You may review, change, or terminate your account at any time, depending on your country, province, or state of residence.',
                ),
                Paragraph(
                  "In some regions (like the EEA, UK, and Switzerland), you have certain rights under applicable data protection laws. "
                  "These may include the right (i) to request access and obtain a copy of your personal information, "
                  "(ii) to request rectification or erasure; (iii) to restrict the processing of your personal information; "
                  "(iv) if applicable, to data portability; and (v) not to be subject to automated decision-making. "
                  "In certain circumstances, you may also have the right to object to the processing of your personal information. "
                  "You can make such a request by contacting us using the contact details provided in the section 'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?'.",
                ),
                Paragraph(
                  "We will consider and act upon any request in accordance with applicable data protection laws.",
                ),
                Paragraph(
                  "If you are located in the EEA or UK and you believe we are unlawfully processing your personal information, "
                  "you also have the right to complain to your Member State data protection authority, or UK data protection authority.",
                ),
                SizedBox(height: 30),
                SectionTitle('11. CONTROLS FOR DO-NOT-TRACK FEATURES'),
                Paragraph(
                  "Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ('DNT') feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. "
                  "At this stage, no uniform technology standard for recognising and implementing DNT signals has been finalised. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. "
                  "If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Notice.",
                ),
                SizedBox(height: 30),
                SectionTitle('12. DO WE MAKE UPDATES TO THIS NOTICE?'),
                ItalicText(
                  'In Short: Yes, we will update this notice as necessary to stay compliant with relevant laws.',
                ),
                Paragraph(
                  "We may update this Privacy Notice from time to time. The updated version will be indicated by an updated 'Revised' date at the top of this Privacy Notice. "
                  "If we make material changes to this Privacy Notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. "
                  "We encourage you to review this Privacy Notice frequently to be informed of how we are protecting your information.",
                ),
                SizedBox(height: 30),
                SectionTitle('13. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?'),
                Paragraph(
                  "If you have questions or comments about this notice, you may email us at vitreongen@gmail.com or contact us by post at:\n\n"
                  "Vitreon Limited\n"
                  "Office 8081\n"
                  "321-323 High Road\n"
                  "Chadwell Heath, Essex RM6 6AX\n"
                  "United Kingdom",
                ),
                SizedBox(height: 30),
                SectionTitle(
                  '14. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
                ),
                Paragraph(
                  "You have the right to request access to the personal information we collect from you, details about how we have processed it, correct inaccuracies, or delete your personal information. "
                  "You may also have the right to withdraw your consent to our processing of your personal information. These rights may be limited in some circumstances by applicable law. "
                  "To request to review, update, or delete your personal information, please visit: thegiftvaults.com.",
                ),
                SizedBox(height: 60),
                Center(child: MyFooter()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// === Reusable Widgets ===

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
      style: const TextStyle(color: Colors.white70, height: 1.5),
    );
  }
}

class BoldQuestion extends StatelessWidget {
  final String text;
  const BoldQuestion(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ItalicText extends StatelessWidget {
  final String text;
  const ItalicText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
