import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBarColor: const Color(0xFF1F1F1F),
      text_title: Text(
        'Terms and Conditions',
        style: TextStyle(color: Pallete.whiteColor),
      ),

      child: Container(
        color: const Color.fromARGB(255, 36, 36, 36),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Last updated May 18, 2025',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Add these inside your Column in TermsAndConditionsPage
              SectionTitle('AGREEMENT TO OUR LEGAL TERMS'),
              SizedBox(height: 10),
              Paragraph(
                "We are Vitreon Limited (\"Company,\" \"we,\" \"us,\" \"our\").\n\n"
                "We operate thegiftvaults.com, as well as any other related products and services that refer or link to these legal terms (the \"Legal Terms\") (collectively, the \"Services\").\n\n"
                "You can contact us by email at vitreongen@gmail.com or by mail to [Your Full Address Here].\n\n"
                "These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity (\"you\"), and Vitreon Limited, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.",
              ),
              SizedBox(height: 20),
              Paragraph(
                "We reserve the right to make changes to these Legal Terms at any time. Updates will be noted by changing the \"Last updated\" date. Continued use of the Services constitutes acceptance of those changes.",
              ),
              SizedBox(height: 30),

              SectionTitle('1. OUR SERVICES'),
              SizedBox(height: 10),
              Paragraph(
                "The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement. Those who access the Services from other locations do so at their own initiative and are responsible for compliance with local laws.",
              ),
              SizedBox(height: 30),

              SectionTitle('2. INTELLECTUAL PROPERTY RIGHTS'),
              SizedBox(height: 10),
              Paragraph(
                "We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the \"Content\"), as well as the trademarks, service marks, and logos contained therein (the \"Marks\").",
              ),
              Paragraph(
                "Subject to your compliance with these Legal Terms, we grant you a non-exclusive, non-transferable, revocable license to access and use the Services for personal, non-commercial, or internal business purposes only.",
              ),
              Paragraph(
                "No part of the Services, Content, or Marks may be copied, reproduced, or used for any commercial purpose without our express prior written permission. Requests may be sent to: vitreongen@gmail.com.",
              ),
              Paragraph(
                "Any breach of our intellectual property rights will result in immediate termination of your right to use our Services.",
              ),
              SectionTitle('3. USER REPRESENTATIONS'),
              SizedBox(height: 10),
              Paragraph(
                "By using the Services, you represent and warrant that: "
                "(1) you have the legal capacity and you agree to comply with these Legal Terms; "
                "(2) you are not a minor in the jurisdiction in which you reside; "
                "(3) you will not access the Services through automated or non-human means, whether through a bot, script or otherwise; "
                "(4) you will not use the Services for any illegal or unauthorized purpose; and "
                "(5) your use of the Services will not violate any applicable law or regulation.",
              ),
              SizedBox(height: 10),
              Paragraph(
                "If you provide any information that is untrue, inaccurate, not current, or incomplete, "
                "we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof).",
              ),
              SizedBox(height: 30),

              SectionTitle('4. PROHIBITED ACTIVITIES'),
              SizedBox(height: 10),
              Paragraph(
                "You may not access or use the Services for any purpose other than that for which we make the Services available. "
                "The Services may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.",
              ),
              SizedBox(height: 10),
              Paragraph("As a user of the Services, you agree not to:"),
              BulletPoint(
                "Systematically retrieve data or other content to compile a database or directory without written permission.",
              ),
              BulletPoint(
                "Trick, defraud, or mislead us or other users, especially in attempts to obtain sensitive account information.",
              ),
              BulletPoint(
                "Bypass or interfere with security features of the Services.",
              ),
              BulletPoint(
                "Disparage or harm us or the Services in our opinion.",
              ),
              BulletPoint(
                "Use information from the Services to harass, abuse, or harm another person.",
              ),
              BulletPoint(
                "Misuse our support services or submit false abuse reports.",
              ),
              BulletPoint(
                "Use the Services in violation of applicable laws or regulations.",
              ),
              BulletPoint(
                "Engage in unauthorized framing of or linking to the Services.",
              ),
              BulletPoint(
                "Upload or transmit viruses, spam, or any content that disrupts the use of the Services.",
              ),
              BulletPoint(
                "Use scripts, bots, or other automated tools to interact with the Services.",
              ),
              BulletPoint(
                "Delete any copyright or proprietary notices from the Content.",
              ),
              BulletPoint("Impersonate another user or person."),
              BulletPoint(
                "Upload spyware or other passive collection mechanisms.",
              ),
              BulletPoint(
                "Interfere with or create an undue burden on our networks or systems.",
              ),
              BulletPoint("Harass or threaten our employees or agents."),
              BulletPoint(
                "Bypass measures designed to restrict access to parts of the Services.",
              ),
              BulletPoint(
                "Copy or adapt our software code, including Flash, PHP, HTML, JavaScript.",
              ),
              BulletPoint(
                "Reverse engineer any part of the Services except as allowed by law.",
              ),
              BulletPoint(
                "Use or launch automated systems (e.g., spiders, scrapers) without authorization.",
              ),
              BulletPoint(
                "Use a buying agent or purchasing agent to make purchases on the Services.",
              ),
              BulletPoint(
                "Collect emails/usernames for sending unsolicited email or creating fake accounts.",
              ),
              BulletPoint(
                "Use the Services to compete with us or for commercial purposes not approved by us.",
              ),
              SizedBox(height: 30),

              SectionTitle('5. USER GENERATED CONTRIBUTIONS'),
              SizedBox(height: 10),
              Paragraph(
                "The Services does not offer users to submit or post content. However, we may allow you to create, submit, post, display, transmit, perform, publish, "
                "or broadcast content and materials to us or on the Services, including but not limited to text, writings, video, audio, photographs, graphics, comments, "
                "suggestions, or personal information (collectively, \"Contributions\"). Contributions may be visible to other users and through third-party websites.",
              ),
              Paragraph(
                "When you create or make available any Contributions, you thereby represent and warrant that:",
              ),
              SizedBox(height: 30),

              SectionTitle('6. CONTRIBUTION LICENSE'),
              SizedBox(height: 10),
              Paragraph(
                "You and the Services agree that we may access, store, process, and use any information and personal data you provide and your choices (including settings).",
              ),
              Paragraph(
                "By submitting suggestions or other feedback regarding the Services, you agree that we may use and share such feedback for any purpose without compensation to you.",
              ),
              Paragraph(
                "We do not assert any ownership over your Contributions. You retain full ownership of your Contributions and any intellectual property rights associated with them. "
                "We are not responsible for any statements in your Contributions, and you agree to hold us harmless from any claims related to them.",
              ),
              SizedBox(height: 30),

              SectionTitle('7. SERVICES MANAGEMENT'),
              SizedBox(height: 10),
              Paragraph(
                "We reserve the right, but not the obligation, to: (1) monitor the Services for violations of these Legal Terms; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Legal Terms, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Services or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Services in a manner designed to protect our rights and property and to facilitate the proper functioning of the Services.",
              ),
              SizedBox(height: 30),

              SectionTitle('8. TERM AND TERMINATION'),
              SizedBox(height: 10),
              Paragraph(
                "These Legal Terms shall remain in full force and effect while you use the Services. WITHOUT LIMITING ANY OTHER PROVISION OF THESE LEGAL TERMS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SERVICES (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE LEGAL TERMS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SERVICES OR DELETE ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.",
              ),
              SizedBox(height: 20),
              Paragraph(
                "If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress.",
              ),
              SizedBox(height: 30),

              SectionTitle('9. MODIFICATIONS AND INTERRUPTIONS'),
              SizedBox(height: 10),
              Paragraph(
                "We reserve the right to change, modify, or remove the contents of the Services at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Services. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Services.",
              ),
              SizedBox(height: 20),
              Paragraph(
                "We cannot guarantee the Services will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Services, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Services at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Services during any downtime or discontinuance of the Services. Nothing in these Legal Terms will be construed to obligate us to maintain and support the Services or to supply any corrections, updates, or releases in connection therewith.",
              ),
              SizedBox(height: 30),

              SectionTitle('10. GOVERNING LAW'),
              SizedBox(height: 10),
              Paragraph(
                "These Legal Terms shall be governed by and defined following the laws of __________. __________ and yourself irrevocably consent that the courts of __________ shall have exclusive jurisdiction to resolve any dispute which may arise in connection with these Legal Terms.",
              ),
              SizedBox(height: 30), // Add some padding at the end

              SectionTitle('11. DISPUTE RESOLUTION'),
              SizedBox(height: 10),
              Paragraph(
                'Informal Negotiations\n\nTo expedite resolution and control the cost of any dispute, controversy, or claim related to these Legal Terms (each a "Dispute" and collectively, the "Disputes") brought by either you or us (individually, a "Party" and collectively, the "Parties"), the Parties agree to first attempt to negotiate any Dispute (except those Disputes expressly provided below) informally for at least __________ days before initiating arbitration. Such informal negotiations commence upon written notice from one Party to the other Party.',
              ),
              SizedBox(height: 20),
              Paragraph(
                'Binding Arbitration\n\nAny dispute arising out of or in connection with these Legal Terms, including any question regarding its existence, validity, or termination, shall be referred to and finally resolved by the International Commercial Arbitration Court under the European Arbitration Chamber (Belgium, Brussels, Avenue Louise, 146) according to the Rules of this ICAC, which, as a result of referring to it, is considered as the part of this clause. The number of arbitrators shall be __________. The seat, or legal place, or arbitration shall be __________. The language of the proceedings shall be __________. The governing law of these Legal Terms shall be substantive law of __________.',
              ),
              SizedBox(height: 20),
              Paragraph(
                'Restrictions\n\nThe Parties agree that any arbitration shall be limited to the Dispute between the Parties individually. To the full extent permitted by law, (a) no arbitration shall be joined with any other proceeding; (b) there is no right or authority for any Dispute to be arbitrated on a class-action basis or to utilize class action procedures; and (c) there is no right or authority for any Dispute to be brought in a purported representative capacity on behalf of the general public or any other persons.',
              ),
              SizedBox(height: 20),
              Paragraph(
                'Exceptions to Informal Negotiations and Arbitration\n\nThe Parties agree that the following Disputes are not subject to the above provisions concerning informal negotiations binding arbitration: (a) any Disputes seeking to enforce or protect, or concerning the validity of, any of the intellectual property rights of a Party; (b) any Dispute related to, or arising from, allegations of theft, piracy, invasion of privacy, or unauthorized use; and (c) any claim for injunctive relief. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate any Dispute falling within that portion of this provision found to be illegal or unenforceable and such Dispute shall be decided by a court of competent jurisdiction within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court.',
              ),
              SizedBox(height: 30),

              SectionTitle('12. CORRECTIONS'),
              SizedBox(height: 10),
              Paragraph(
                "There may be information on the Services that contains typographical errors, inaccuracies, or omissions, including descriptions, pricing, availability, and various other information. We reserve the right to correct any errors, inaccuracies, or omissions and to change or update the information on the Services at any time, without prior notice.",
              ),
              SizedBox(height: 30),

              SectionTitle('13. DISCLAIMER'),
              SizedBox(height: 10),
              Paragraph(
                "THE SERVICES ARE PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SERVICES AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SERVICES' CONTENT OR THE CONTENT OF ANY WEBSITES OR MOBILE APPLICATIONS LINKED TO THE SERVICES AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SERVICES, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SERVICES, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SERVICES BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SERVICES, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE.",
              ),
              SizedBox(height: 30),

              SectionTitle('14. LIMITATIONS OF LIABILITY'),
              SizedBox(height: 10),
              Paragraph(
                "IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SERVICES, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE LESSER OF THE AMOUNT PAID, IF ANY, BY YOU TO US OR __________. CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.",
              ),
              SizedBox(height: 30),

              SectionTitle('15. INDEMNIFICATION'),
              SizedBox(height: 10),
              Paragraph(
                "You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys’ fees and expenses, made by any third party due to or arising out of: (1) use of the Services; (2) breach of these Legal Terms; (3) any breach of your representations and warranties set forth in these Legal Terms; (4) your violation of the rights of a third party, including but not limited to intellectual property rights; or (5) any overt harmful act toward any other user of the Services with whom you connected via the Services. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it.",
              ),
              SizedBox(height: 30),

              SectionTitle('16. USER DATA'),
              SizedBox(height: 10),
              Paragraph(
                "We will maintain certain data that you transmit to the Services for the purpose of managing the performance of the Services, as well as data relating to your use of the Services. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Services. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data.",
              ),
              SizedBox(height: 30),

              SectionTitle(
                '17. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES',
              ),
              SizedBox(height: 10),
              Paragraph(
                "Visiting the Services, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Services, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SERVICES. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means.",
              ),
              SizedBox(height: 30),

              SectionTitle('18. MISCELLANEOUS'),
              SizedBox(height: 10),
              Paragraph(
                "These Legal Terms and any policies or operating rules posted by us on the Services or in respect to the Services constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Legal Terms shall not operate as a waiver of such right or provision. These Legal Terms operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Legal Terms is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Legal Terms and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Legal Terms or use of the Services. You agree that these Legal Terms will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Legal Terms and the lack of signing by the parties hereto to execute these Legal Terms.",
              ),
              SizedBox(height: 30),

              SectionTitle('19. CONTACT US'),
              SizedBox(height: 10),
              Paragraph(
                "In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, please contact us at:\n\n You can contact us here: vitreongen@gmail.com",
              ),
              SizedBox(height: 30),

              MyFooter(),
            ],
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

// === BulletPoint Widget ===
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.white, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
