import 'package:flutter/material.dart';

class GardenGame extends StatefulWidget {
  const GardenGame({super.key});

  @override
  State<GardenGame> createState() => _GardenGameState();
}

class _GardenGameState extends State<GardenGame> {
  int stage = 0;
  int water = 0;
  int stars = 0;
  bool seedPlanted = false;
  bool watered = false;
  bool finished = false;

  final List<String> stages = [
    'माती तयार कर',
    'बी पेर',
    'पाणी घाल',
    'सूर्यप्रकाश दे',
    'फूल उमलले!',
  ];

  void prepareSoil() {
    if (stage != 0) return;
    setState(() => stage = 1);
  }

  void plantSeed() {
    if (stage != 1 || seedPlanted) return;
    setState(() {
      seedPlanted = true;
      stage = 2;
      stars++;
    });
  }

  void waterPlant() {
    if (stage != 2) return;
    setState(() {
      water++;
      watered = true;
      if (water >= 2) {
        stage = 3;
        stars++;
      }
    });
  }

  void giveSunlight() {
    if (stage != 3) return;
    setState(() {
      stage = 4;
      finished = true;
      stars += 2;
    });
  }

  void restart() {
    setState(() {
      stage = 0;
      water = 0;
      stars = 0;
      seedPlanted = false;
      watered = false;
      finished = false;
    });
  }

  String get plantEmoji {
    if (!seedPlanted) return '🟤';
    if (stage == 2) return water == 0 ? '🌰' : '🌱';
    if (stage == 3) return '🌿';
    return '🌻';
  }

  String get instruction {
    switch (stage) {
      case 0:
        return 'चला, माती तयार करूया!';
      case 1:
        return 'मातीत बी पेरा.';
      case 2:
        return 'रोपाला दोन वेळा पाणी घाला.';
      case 3:
        return 'रोपाला सूर्यप्रकाश द्या.';
      default:
        return 'शाब्बास! तुझ्या बागेत फूल उमलले!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌱 जादूची बाग'),
        backgroundColor: const Color(0xFFB7F0A1),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFBDEEFF),
              Color(0xFFE8FBD5),
              Color(0xFFFFF0B5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'माझी बाग',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF236D39),
                      ),
                    ),
                    Chip(
                      avatar: const Text('⭐'),
                      label: Text(
                        '$stars तारे',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      Text(
                        instruction,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF51318B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'प्रत्येक पायरी पूर्ण करून रोप वाढव!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 280,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF72D5FF),
                        Color(0xFFCBF4FF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        top: 15,
                        right: 20,
                        child: Text(
                          '☀️',
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      const Positioned(
                        top: 25,
                        left: 22,
                        child: Text(
                          '☁️',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 95,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF8A5837),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '🌼   🌱   🌼   🌱   🌼',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 75,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            plantEmoji,
                            key: ValueKey(plantEmoji),
                            style: const TextStyle(fontSize: 100),
                          ),
                        ),
                      ),
                      if (stage == 2 && water == 0)
                        const Positioned(
                          bottom: 145,
                          right: 40,
                          child: Text(
                            '💧',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      if (finished)
                        const Positioned(
                          top: 85,
                          child: Text(
                            '✨ 🌻 ✨',
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (!finished) ...[
                  if (stage == 0)
                    actionButton(
                      '🪴 माती तयार करा',
                      prepareSoil,
                    ),
                  if (stage == 1)
                    actionButton(
                      '🌰 बी पेरा',
                      plantSeed,
                    ),
                  if (stage == 2)
                    actionButton(
                      water == 0
                          ? '💧 पाणी घाला (१/२)'
                          : '💧 पुन्हा पाणी घाला (२/२)',
                      waterPlant,
                    ),
                  if (stage == 3)
                    actionButton(
                      '☀️ सूर्यप्रकाश द्या',
                      giveSunlight,
                    ),
                ],
                if (finished)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '🎉 शाब्बास बाळा!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'झाडांना पाणी, माती आणि सूर्यप्रकाश लागतो.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: restart,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'पुन्हा बाग लावा',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '🌍 झाडे लावा, पृथ्वी वाचवा!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF236D39),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButton(String label, VoidCallback action) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5AB85B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

