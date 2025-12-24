// lib/main.dart
import 'package:flutter/material.dart';

List<HistoryItem> historyList = [];

void main() {
  runApp(const LangoraApp());
}

class LangoraApp extends StatelessWidget {
  const LangoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme .ltr
    return MaterialApp(
      title: 'Langora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0E1414),
        primaryColor: const Color(0xFF00C6B8),
        cardColor: const Color(0xFF062222),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C6B8),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      // Force.ltr for demo (Arabic)
      home: const Directionality(
        textDirection: TextDirection.ltr,
        child: SplashScreen(),
      ),
      routes: {
        '/home': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: HomePage(),
        ),
        '/levels': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: LevelsPage(),
        ),
        '/test': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: TestStartPage(),
        ),
        '/history': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: HistoryPage(),
        ),
        '/profile': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: ProfilePage(),
        ),
        '/stories': (c) => const Directionality(
          textDirection: TextDirection.ltr,
          child: StoriesPage(),
        ),
      },
    );
  }
}

/// Splash -> Onboarding -> Home
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scale = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// LOGO
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C6B8),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.menu_book,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),

                /// TITLE
                const Text(
                  'Langora',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                /// SUBTITLE
                const Text(
                  'تعلم بسهولة\nمحتوى منظم وممتع',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<_OnboardModel> pages = [
    _OnboardModel(
      icon: Icons.school,
      title: 'تعلم بسهولة',
      subtitle: 'محتوى منظم وبسيط يساعدك تفهم بسرعة',
    ),
    _OnboardModel(
      icon: Icons.quiz,
      title: 'اختبارات ذكية',
      subtitle: 'قيم مستواك وتابع تقدمك خطوة بخطوة',
    ),
    _OnboardModel(
      icon: Icons.menu_book,
      title: 'قصص تفاعلية',
      subtitle: 'حسن مهارة الاستماع والفهم',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A3D3D), Color(0xFF021F1F)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Pages
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) {
                    setState(() => currentIndex = i);
                  },
                  itemBuilder: (context, i) {
                    final item = pages[i];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C6B8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.icon, size: 60, color: Colors.black),
                        ),

                        const SizedBox(height: 40),

                        /// Title
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// Subtitle
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentIndex == i ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == i
                          ? const Color(0xFF00C6B8)
                          : Colors.white38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C6B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'ابدأ الآن',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardModel {
  final IconData icon;
  final String title;
  final String subtitle;

  _OnboardModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

/// Home Page with drawer and main buttons
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083A3A), // نفس الخلفية
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Langora',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const AppDrawer(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeButton(
              text: 'Levels',
              onTap: () => Navigator.pushNamed(context, '/levels'),
            ),
            const SizedBox(height: 18),
            homeButton(
              text: 'Test',
              onTap: () => Navigator.pushNamed(context, '/test'),
            ),
            const SizedBox(height: 18),
            homeButton(
              text: 'Stories',
              onTap: () => Navigator.pushNamed(context, '/stories'),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeButton({required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: 220,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF052525),
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context); // يقفل الـ drawer
                Navigator.pushNamed(context, '/profile'); // يفتح My Account
              },
              child: Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF00C6B8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Hello',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('User', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Levels'),
              onTap: () => Navigator.of(context).pushNamed('/levels'),
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Tests'),
              onTap: () => Navigator.of(context).pushNamed('/test'),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Stories'),
              onTap: () => Navigator.of(context).pushNamed('/stories'),
            ),

            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//** Levels page
class LevelsPage extends StatelessWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = List.generate(9, (i) => 'Level ${i + 1}');

    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              'Levels',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// Levels Card
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.separated(
                  itemCount: levels.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LevelCategoriesPage(levelName: levels[index]),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Color(0xFF00C6B8),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            levels[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelCategoriesPage extends StatelessWidget {
  final String levelName;
  const LevelCategoriesPage({super.key, required this.levelName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Level title
            Text(
              levelName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            /// Buttons
            categoryButton(
              text: 'Vocabulary',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillLevelsPage(title: 'Vocabulary'),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
            categoryButton(
              text: 'Listening',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillLevelsPage(title: 'Listening'),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            categoryButton(
              text: 'Grammar',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillLevelsPage(title: 'Grammar'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton({required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF00C6B8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Icons.play_arrow, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              '%',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillLevelsPage extends StatelessWidget {
  final String title;
  const SkillLevelsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pre'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// Title
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            /// ZigZag Levels
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  final isLeft = index % 2 == 0;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: isLeft
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [levelCircle('${index + 1}')],
                      ),
                      if (index != 7)
                        const SizedBox(
                          height: 30,
                          child: Center(
                            child: Icon(Icons.more_vert, color: Colors.white38),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget levelCircle(String text) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFF00C6B8),
        shape: BoxShape.circle,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TestStartPage extends StatelessWidget {
  const TestStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Test',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(Icons.quiz, color: Color(0xFF00C6B8), size: 30),
              ],
            ),

            const SizedBox(height: 50),

            /// Start Test
            mainButton(
              text: 'Start',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TestPage(levelName: 'Level 1'),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// History
            mainButton(
              text: 'History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryPage()),
                );
              },
            ),

            const Spacer(),

            /// Reminder
            Row(
              children: const [
                Icon(Icons.edit, size: 16, color: Colors.white70),
                SizedBox(width: 6),
                Text('Reminder', style: TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 6),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '○ You have just two attempt',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainButton({required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF00C6B8),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  final String levelName;
  const TestPage({super.key, required this.levelName});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int current = 0;
  int score = 0;
  int lives = 5;
  int? selectedIndex;

  final List<Question> questions = [
    Question(
      'What is the capital of France?',
      ['London', 'Berlin', 'Paris', 'Rome'],
      2,
      'assets/Capture.PNG',
    ),
    Question(
      'Which language is used in Flutter?',
      ['Java', 'Kotlin', 'Swift', 'Dart'],
      3,
      'assets/Capture.PNG',
    ),
    Question(
      'Flutter is developed by?',
      ['Apple', 'Google', 'Microsoft', 'Meta'],
      1,
      'assets/Capture.PNG',
    ),
    Question(
      'Which one is a programming language?',
      ['HTML', 'CSS', 'Python', 'Photoshop'],
      2,
      'assets/Capture.PNG',
    ),
    Question(
      'What does CPU stand for?',
      [
        'Central Process Unit',
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Unit',
      ],
      1,
      'assets/Capture.PNG',
    ),
    Question(
      'Which company owns Android?',
      ['Apple', 'Samsung', 'Google', 'Microsoft'],
      2,
      'assets/Capture.PNG',
    ),
    Question('What is 2 + 2?', ['3', '4', '5', '6'], 1, 'assets/Capture.PNG'),
    Question(
      'Which one is NOT an OS?',
      ['Windows', 'Linux', 'Android', 'Google'],
      3,
      'assets/Capture.PNG',
    ),
    Question(
      'Which language is used for web?',
      ['Dart', 'HTML', 'C++', 'Java'],
      1,
      'assets/Capture.PNG',
    ),
    Question(
      'What does UI stand for?',
      [
        'User Interface',
        'User Internet',
        'Universal Interface',
        'User Information',
      ],
      0,
      'assets/Capture.PNG',
    ),
  ];

  void nextQuestion() {
    if (selectedIndex == null) return;

    if (questions[current].correctIndex == selectedIndex) {
      score++;
    } else {
      lives--;
    }

    if (lives <= 0 || current == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(score: score, total: questions.length),
        ),
      );
    } else {
      setState(() {
        current++;
        selectedIndex = null;
      });
    }
  }

  void previousQuestion() {
    if (current > 0) {
      setState(() {
        current--;
        selectedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        title: Text('Question ${current + 1}/${questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('$lives'),
                const SizedBox(width: 4),
                const Icon(Icons.favorite_border),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Question
            /// Question Image
            Container(
              width: double.infinity,
              height: 180,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(q.image, fit: BoxFit.contain),
              ),
            ),

            /// Question Text
            Text(
              q.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),

            /// Options
            GridView.builder(
              shrinkWrap: true,
              itemCount: q.options.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3.2,
              ),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => setState(() => selectedIndex = i),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedIndex == i
                          ? const Color(0xFF00C6B8)
                          : const Color(0xFF022D2D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedIndex == i
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(q.options[i])),
                      ],
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: previousQuestion,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text(
                    current == questions.length - 1 ? 'Finish' : 'Next',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final int score;
  final int total;

  const ResultPage({super.key, required this.score, required this.total});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    TestHistoryManager.addResult(widget.score, widget.total);

    final percent = widget.score / widget.total;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animation = Tween<double>(
      begin: 0,
      end: percent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percent = widget.score / widget.total;

    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Langora'),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            final value = _animation.value;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Circle Score
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        strokeWidth: 14,
                        backgroundColor: Colors.white12,
                        color: const Color(0xFF00C6B8),
                      ),
                      Text(
                        '${(value * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Score Text
                Text(
                  'Score : ${widget.score}/${widget.total}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                /// Buttons
                resultButton(
                  text: 'New test',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/test');
                  },
                ),
                const SizedBox(height: 14),
                resultButton(
                  text: 'History',
                  onTap: () {
                    Navigator.pushNamed(context, '/history');
                  },
                ),
                const SizedBox(height: 14),
                resultButton(
                  text: 'Exit',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (_) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget resultButton({required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: 240,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C6B8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

/// =====================
/// Question Model
/// =====================
class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String image;

  Question(this.text, this.options, this.correctIndex, this.image);
}

class TestHistoryItem {
  final DateTime date;
  final int score;
  final int total;

  TestHistoryItem({
    required this.date,
    required this.score,
    required this.total,
  });
}

class TestHistoryManager {
  static final List<TestHistoryItem> history = [];

  static void addResult(int score, int total) {
    history.insert(
      0,
      TestHistoryItem(date: DateTime.now(), score: score, total: total),
    );
  }
}

/// History page (سجل)
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = TestHistoryManager.history;

    return Scaffold(
      backgroundColor: const Color(0xFF083A3A),
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No history yet',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final h = history[i];
                return Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C6B8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score: ${h.score}/${h.total}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        h.date.toString().substring(0, 16),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class HistoryItem {
  final String testName;
  final int score;
  final int total;

  HistoryItem({
    required this.testName,
    required this.score,
    required this.total,
  });
}

class Story {
  final String title;
  final String character;
  final String authors;
  final double rate;
  final String image;

  Story({
    required this.title,
    required this.character,
    required this.authors,
    required this.rate,
    required this.image,
  });
}

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      Story(
        title: 'The Red-Headed League',
        character: 'Sherlock Holmes',
        authors: 'Sir Arthur Conan Doyle',
        rate: 4.6,
        image: 'assets/1.jpg',
      ),
      Story(
        title: 'Treasure Island',
        character: 'Jim Hawkins',
        authors: 'Robert Louis Stevenson',
        rate: 4.7,
        image: 'assets/2.jpg',
      ),
      Story(
        title: 'The Adventures of Tom Sawyer',
        character: 'Tom Sawyer',
        authors: 'Mark Twain',
        rate: 4.5,
        image: 'assets/3.jpg',
      ),
      Story(
        title: 'Alice in Wonderland',
        character: 'Alice',
        authors: 'Lewis Carroll',
        rate: 4.8,
        image: 'assets/4.jpg',
      ),
      Story(
        title: 'Moby Dick',
        character: 'Captain Ahab',
        authors: 'Herman Melville',
        rate: 4.2,
        image: 'assets/5.jpg',
      ),
      Story(
        title: 'Around the World in 80 Days',
        character: 'Phileas Fogg',
        authors: 'Jules Verne',
        rate: 4.6,
        image: 'assets/6.jpg',
      ),
      Story(
        title: 'The Jungle Book',
        character: 'Mowgli',
        authors: 'Rudyard Kipling',
        rate: 4.9,
        image: 'assets/7.jpg',
      ),
      Story(
        title: 'The Secret Garden',
        character: 'Mary Lennox',
        authors: 'Frances Hodgson Burnett',
        rate: 4.4,
        image: 'assets/8.jpg',
      ),
      Story(
        title: 'Peter Pan',
        character: 'Peter Pan',
        authors: 'J. M. Barrie',
        rate: 4.7,
        image: 'assets/9.jpg',
      ),
      Story(
        title: 'Moby Dick',
        character: 'Captain Ahab',
        authors: 'Herman Melville',
        rate: 4.2,
        image: 'assets/5.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pre'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Row(
              children: const [
                Text(
                  'stories',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Icon(Icons.menu_book, color: Color(0xFF00C6B8)),
              ],
            ),

            const SizedBox(height: 14),

            //**  Search bar
            Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF00C6B8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'search...',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Icon(Icons.mic, color: Colors.black),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Stories list
            Expanded(
              child: ListView.separated(
                itemCount: stories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, i) {
                  final s = stories[i];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF062F2F),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        /// Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            s.image,
                            width: 90,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text('character: ${s.character}'),
                              Text('Authors: ${s.authors}'),
                              const SizedBox(height: 6),
                              Text('Rate: ⭐${s.rate}'),
                              const SizedBox(height: 10),

                              /// Buttons
                              Row(
                                children: [
                                  storyButton('Read'),
                                  const SizedBox(width: 10),
                                  storyButton('Download'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget storyButton(String text) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C6B8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Profile page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Profile Image
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00C6B8),
                      width: 5,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 52,
                  backgroundColor: Color(0xFF062F2F),
                  child: Icon(Icons.image, size: 40),
                ),
              ],
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () {},
              child: const Text(
                'Edit',
                style: TextStyle(color: Color(0xFF00C6B8), fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),

            /// Personal Info
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'personal info:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            buildInfoRow(label: 'Name', value: 'Mohamed Adel'),
            const SizedBox(height: 12),
            buildInfoRow(label: 'Email', value: 'Langora@langora.com'),
            const SizedBox(height: 12),
            buildInfoRow(label: 'Password', value: '********'),

            const Spacer(),

            /// Buttons
            buildActionButton(
              text: 'log out',
              color: Colors.white,
              textColor: Colors.black,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            buildActionButton(
              text: 'switch Acc',
              color: Colors.white,
              textColor: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow({required String label, required String value}) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 10, color: Color(0xFF00C6B8)),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(value, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
