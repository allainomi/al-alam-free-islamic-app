import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:hijri_date_time/hijri_date_time.dart';
import 'package:geolocator/geolocator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import 'package:quran/quran.dart' as quran;

void main() => runApp(const AlAlamApp());

class AlAlamApp extends StatelessWidget {
  const AlAlamApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Alam Free Islamic App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final player = AudioPlayer();
  PrayerTimes? prayerTimes;
  HijriDateTime? hijriDate;
  Position? position;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    position = await Geolocator.getCurrentPosition();
    final coords = Coordinates(position!.latitude, position!.longitude);
    prayerTimes = PrayerTimes.today(coords, CalculationMethod.ummAlQura());
    hijriDate = HijriDateTime.now();
    setState(() {});
  }

  Future<void> _playQuranAudio(int surah) async {
    await player.play(AssetSource('audio/surah_$surah.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الْعَلَمْ - Free Islamic App')),
      body: ListView(
        children: [
          // Hijri & Gregorian Date
          Card(
            child: ListTile(
              title: const Text('ہجری تاریخ'),
              subtitle: Text(hijriDate?.toString() ?? ''),
              trailing: Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
            ),
          ),
          // Prayer Times
          if (prayerTimes != null) ...[
            const Text('نماز کے اوقات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            _prayerTile('فجر', prayerTimes!.fajr),
            _prayerTile('ظہر', prayerTimes!.dhuhr),
            _prayerTile('عصر', prayerTimes!.asr),
            _prayerTile('مغرب', prayerTimes!.maghrib),
            _prayerTile('عشاء', prayerTimes!.isha),
          ],
          // Quran
          ListTile(
            title: const Text('قرآن پاک'),
            onTap: () => _playQuranAudio(1), // Example: Surah Fatiha
            subtitle: Text(quran.getVerse(1, 1, verseEnd: 7, verseTextType: VerseTextType.ARABIC)),
          ),
          // Azkar
          const ListTile(title: Text('اذکار صبح و شام'), subtitle: Text('اللہ أكبر...')),
          // Hadith
          const ListTile(title: Text('حدیث مبارکہ'), subtitle: Text('نماز مومن کی معراج ہے')),
        ],
      ),
    );
  }

  Widget _prayerTile(String name, DateTime time) => ListTile(
        title: Text(name),
        trailing: Text(DateFormat('HH:mm').format(time)),
      );
}
