
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const BalmitraApp());
}

class BalmitraApp extends StatelessWidget {
  const BalmitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'बालमित्र',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F6FF),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts tts = FlutterTts();
  int stars = 0;
  int tab = 0;

  final List<String> letters = [
    'अ','आ','इ','ई','उ','ऊ','ऋ','ए','ऐ','ओ','औ','अं','अः',
    'क','ख','ग','घ','ङ','च','छ','ज','झ','ञ',
    'ट','ठ','ड','ढ','ण','त','थ','द','ध','न',
    'प','फ','ब','भ','म','य','र','ल','व','श','ष','स','ह','ळ','क्ष','ज्ञ'
  ];

  final List<String> english = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  final List<Map<String, String>> objects = [
    {'emoji':'🐘','name':'हत्ती'},
    {'emoji':'🦁','name':'सिंह'},
    {'emoji':'🐦','name':'पक्षी'},
    {'emoji':'🐄','name':'गाय'},
    {'emoji':'🍎','name':'सफरचंद'},
    {'emoji':'🍌','name':'केळे'},
    {'emoji':'🥭','name':'आंबा'},
    {'emoji':'🌸','name':'फूल'},
    {'emoji':'🚗','name':'गाडी'},
    {'emoji':'✈️','name':'विमान'},
    {'emoji':'🌞','name':'सूर्य'},
    {'emoji':'🌙','name':'चंद्र'},
    {'emoji':'🔴','name':'लाल रंग'},
    {'emoji':'🟢','name':'हिरवा रंग'},
    {'emoji':'🔺','name':'त्रिकोण'},
    {'emoji':'⭐','name':'तारा'},
  ];

  final List<Map<String, String>> questions = [
    {'q':'मराठीतील पहिले अक्षर कोणते?', 'a':'अ', 'o':'आ, अ, इ'},
    {'q':'१ नंतर कोणता अंक येतो?', 'a':'२', 'o':'३, २, ४'},
    {'q':'सफरचंदाचा रंग कोणता असू शकतो?', 'a':'लाल', 'o':'लाल, निळा, काळा'},
    {'q':'आठ पाय कोणाला असतात?', 'a':'कोळी', 'o':'गाय, कोळी, पोपट'},
    {'q':'एका हाताला किती बोटे असतात?', 'a':'५', 'o':'४, ५, ६'},
    {'q':'इंग्रजीत पहिले अक्षर कोणते?', 'a':'A', 'o':'B, C, A'},
    {'q':'दिवसा आकाशात काय दिसतो?', 'a':'सूर्य', 'o':'सूर्य, तारा, दिवा'},
    {'q':'२ + ३ किती?', 'a':'५', 'o':'४, ५, ६'},
  ];

  final List<Map<String, String>> stories = [
    {
      'title':'तहानलेला कावळा',
      'body':'एका कावळ्याला खूप तहान लागली. त्याला एक माठ दिसला. माठात थोडे पाणी होते. कावळ्याने माठात खडे टाकले. पाणी वर आले आणि कावळ्याने पाणी प्यायले.\\n\\nतात्पर्य: युक्तीने समस्या सोडवता येते.'
    },
    {
      'title':'सिंह आणि उंदीर',
      'body':'एकदा सिंहाने एका उंदराला पकडले. उंदराने विनंती केली म्हणून सिंहाने त्याला सोडले. काही दिवसांनी सिंह जाळ्यात अडकला. उंदराने जाळे कुरतडून सिंहाला सोडवले.\\n\\nतात्पर्य: लहान व्यक्तीसुद्धा मोठी मदत करू शकते.'
    },
    {
      'title':'प्रामाणिक मुलगा',
      'body':'एका मुलाला रस्त्यात एक पाकीट सापडले. त्याने पाकिटातील पत्त्यावरून ते मालकाला परत दिले. मालकाने त्याचे कौतुक केले.\\n\\nतात्पर्य: नेहमी प्रामाणिक राहावे.'
    },
  ];

  final List<Map<String, String>> poems = [
    {'title':'चांदोबा', 'body':'चांदोबा चांदोबा भागलास का?\\nनिंबोणीच्या झाडामागे लपलास का?'},
    {'title':'पाऊस', 'body':'पाऊस आला रिमझिम रिमझिम\\nमाती झाली ओली ओली\\nझाडे झाली हिरवीगार\\nआनंद झाला फार फार!'},
    {'title':'फुलपाखरू', 'body':'रंगीबेरंगी फुलपाखरू\\nफुलाफुलांवर उडते भरू\\nफुलांचा घेते गोड रस\\nबघताना होतो आनंद खास!'},
  ];

  Future<void> speak(String text) async {
    try {
      await tts.setLanguage('mr-IN');
      await tts.setSpeechRate(0.42);
      await tts.speak(text);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('आवाजासाठी फोनमध्ये मराठी TTS सुविधा तपासा.'),
        ),
      );
    }
  }

  void openPage(String title, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget menuCard(
    String title,
    String emoji,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      color: color,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 38)),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'बालमित्र 🎈',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE7E4FF),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('⭐ $stars')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C6CFF), Color(0xFFFF9ACB)],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('नमस्कार छोट्या मित्रा! 👋',
                    style: TextStyle(color: Colors.white, fontSize: 23,
                      fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('चला, खेळूया आणि नवीन गोष्टी शिकूया!',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('काय शिकायचे आज?',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.15,
              children: [
                menuCard('मराठी अक्षरे','🔤',const Color(0xFFFFE0B2),()
                  => openPage('मराठी अक्षरे', AlphabetPage(
                    letters: letters, speak: speak))),
                menuCard('बाराखडी','📖',const Color(0xFFFFCDD2),()
                  => openPage('बाराखडी', BarakhadiPage(speak: speak))),
                menuCard('अंक आणि गणित','🔢',const Color(0xFFC8E6C9),()
                  => openPage('अंक', NumberPage(speak: speak))),
                menuCard('English ABC','🔠',const Color(0xFFBBDEFB),()
                  => openPage('English ABC', AlphabetPage(
                    letters: english, speak: speak))),
                menuCard('चित्रांमधून शिका','🦋',const Color(0xFFE1BEE7),()
                  => openPage('चित्रांमधून शिका', ObjectPage(
                    objects: objects, speak: speak))),
                menuCard('प्रश्नमंजुषा','🏆',const Color(0xFFFFF9C4),()
                  => openPage('प्रश्नमंजुषा', QuizPage(
                    questions: questions,
                    onCorrect: () => setState(() => stars++)))),
                menuCard('गोष्टी','📚',const Color(0xFFB2DFDB),()
                  => openPage('गोष्टी', ReadingPage(
                    items: stories, speak: speak))),
                menuCard('कविता','🎵',const Color(0xFFF8BBD0),()
                  => openPage('कविता', ReadingPage(
                    items: poems, speak: speak))),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Text('💡', style: TextStyle(fontSize: 30)),
                title: const Text('आजचा संदेश',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('रोज थोडे शिका, आनंदाने पुढे चला!'),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () => speak('रोज थोडे शिका, आनंदाने पुढे चला!'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(child: Text(
              'बालमित्र • शिकणे म्हणजे मजा! 🌈',
              style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}

class AlphabetPage extends StatelessWidget {
  final List<String> letters;
  final Future<void> Function(String) speak;

  const AlphabetPage({
    super.key, required this.letters, required this.speak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('अक्षरे शिका')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: letters.length,
        itemBuilder: (context, i) => Card(
          color: Colors.primaries[i % Colors.primaries.length].shade100,
          child: InkWell(
            onTap: () => speak(letters[i]),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(letters[i], style: const TextStyle(
                  fontSize: 34, fontWeight: FontWeight.bold)),
                const Icon(Icons.volume_up, size: 20),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class BarakhadiPage extends StatelessWidget {
  final Future<void> Function(String) speak;
  const BarakhadiPage({super.key, required this.speak});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['क','का','कि','की','कु','कू','के','कै','को','कौ','कं'],
      ['ख','खा','खि','खी','खु','खू','खे','खै','खो','खौ','खं'],
      ['ग','गा','गि','गी','गु','गू','गे','गै','गो','गौ','गं'],
      ['च','चा','चि','ची','चु','चू','चे','चै','चो','चौ','चं'],
      ['ज','जा','जि','जी','जु','जू','जे','जै','जो','जौ','जं'],
      ['त','ता','ति','ती','तु','तू','ते','तै','तो','तौ','तं'],
      ['द','दा','दि','दी','दु','दू','दे','दै','दो','दौ','दं'],
      ['न','ना','नि','नी','नु','नू','ने','नै','नो','नौ','नं'],
      ['प','पा','पि','पी','पु','पू','पे','पै','पो','पौ','पं'],
      ['म','मा','मि','मी','मु','मू','मे','मै','मो','मौ','मं'],
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('मराठी बाराखडी')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: rows.map((row) => Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: row.map((s) => TextButton(
                onPressed: () => speak(s),
                child: Text(s, style: const TextStyle(fontSize: 22)),
              )).toList(),
            ),
          ),
        )).toList(),
      ),
    );
  }
}

class NumberPage extends StatelessWidget {
  final Future<void> Function(String) speak;
  const NumberPage({super.key, required this.speak});

  @override
  Widget build(BuildContext context) {
    const marathi = [
      'शून्य','एक','दोन','तीन','चार','पाच','सहा','सात','आठ','नऊ',
      'दहा','अकरा','बारा','तेरा','चौदा','पंधरा','सोळा','सतरा',
      'अठरा','एकोणीस','वीस'
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('अंक शिका')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: marathi.length,
        itemBuilder: (context, i) => Card(
          color: Colors.primaries[i % Colors.primaries.length].shade100,
          child: InkWell(
            onTap: () => speak('${i == 0 ? "०" : i} ${marathi[i]}'),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${i == 0 ? "०" : i}',
                  style: const TextStyle(fontSize: 38,
                    fontWeight: FontWeight.bold)),
                Text(marathi[i], style: const TextStyle(fontSize: 20)),
                const Icon(Icons.volume_up),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class ObjectPage extends StatelessWidget {
  final List<Map<String, String>> objects;
  final Future<void> Function(String) speak;
  const ObjectPage({super.key, required this.objects, required this.speak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('चित्रांमधून शिका')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: objects.length,
        itemBuilder: (context, i) {
          final item = objects[i];
          return Card(
            child: InkWell(
              onTap: () => speak(item['name']!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['emoji']!,
                    style: const TextStyle(fontSize: 55)),
                  const SizedBox(height: 8),
                  Text(item['name']!,
                    style: const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  const Icon(Icons.volume_up),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final List<Map<String, String>> questions;
  final VoidCallback onCorrect;
  const QuizPage({super.key, required this.questions,
    required this.onCorrect});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int score = 0;
  String? selected;
  bool finished = false;

  @override
  Widget build(BuildContext context) {
    if (finished) {
      return Scaffold(
        appBar: AppBar(title: const Text('निकाल')),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 70)),
            const Text('छान खेळलात!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('तुमचे गुण: $score / ${widget.questions.length}',
              style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() {
                index = 0; score = 0; selected = null; finished = false;
              }),
              child: const Text('पुन्हा खेळा'),
            ),
          ],
        )),
      );
    }

    final q = widget.questions[index];
    final options = q['o']!.split(', ');
    return Scaffold(
      appBar: AppBar(title: const Text('प्रश्नमंजुषा')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('प्रश्न ${index + 1} / ${widget.questions.length}',
              style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(q['q']!, style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...options.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: selected != null ? null : () {
                  setState(() {
                    selected = option;
                    if (option == q['a']) {
                      score++;
                      widget.onCorrect();
                    }
                  });
                },
                child: Text(option, style: const TextStyle(fontSize: 20)),
              ),
            )),
            if (selected != null)
              Text(selected == q['a'] ? 'बरोबर! ⭐' : 'योग्य उत्तर: ${q['a']}',
                style: const TextStyle(fontSize: 20)),
            const Spacer(),
            ElevatedButton(
              onPressed: selected == null ? null : () {
                setState(() {
                  if (index + 1 == widget.questions.length) {
                    finished = true;
                  } else {
                    index++;
                    selected = null;
                  }
                });
              },
              child: Text(index + 1 == widget.questions.length
                ? 'निकाल पाहा' : 'पुढचा प्रश्न'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReadingPage extends StatelessWidget {
  final List<Map<String, String>> items;
  final Future<void> Function(String) speak;
  const ReadingPage({super.key, required this.items, required this.speak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('वाचा आणि ऐका')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items[i]['title']!,
                  style: const TextStyle(fontSize: 23,
                    fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(items[i]['body']!,
                  style: const TextStyle(fontSize: 19, height: 1.6)),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => speak(
                      '${items[i]['title']}. ${items[i]['body']}'),
                    icon: const Icon(Icons.volume_up, size: 30),
                    tooltip: 'ऐका',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

