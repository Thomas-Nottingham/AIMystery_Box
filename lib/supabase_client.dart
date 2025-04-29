import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url:
        'https://orbyufgotjazcyvuqslq.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9yYnl1ZmdvdGphemN5dnVxc2xxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU1MTU4ODUsImV4cCI6MjA2MTA5MTg4NX0.D5cCLX5b4aTRAcpAFzIBajNg9xX65cPKRsscd2V7P5k', // Replace with your Supabase anon key
  );
}
