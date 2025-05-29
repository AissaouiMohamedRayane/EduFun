import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:EduFun/components/ParentSideComponents/SwitchAccount.dart';
import 'package:EduFun/components/ParentSideComponents/screens/Utilities/SwitchKidsAccountOverlay.dart';
import 'package:EduFun/components/ParentSideComponents/screens/auth/registration/Mychoice.dart';
import 'package:EduFun/Netflixfirstpage/SelectKidScreen.dart';

import 'screens/home.dart';
import 'screens/gamesPage.dart';

import 'package:flutter/services.dart';

import './services/sharedPreferences/prefsAuth.dart';

import './services/API/auth.dart';

import './services/models/users.dart';
import './services/models/store.dart';
import './services/models/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hides the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Load preferences
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParentProvider()),
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => ChildProvider()),
      ],
      child: MyApp(
        showIntro: isFirstTime,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showIntro;

  const MyApp({super.key, required this.showIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Apply globally
      ),
      routes: {
        '/childSideHome': (context) => ChildSideHome(),
        '/childSideHome/games': (context) => Gamespage(),
        '/login': (context) => const LoginPage(),
        '/parentHome': (context) => SelectKidScreen(),
      },
      home: showIntro ? const DetailsScreen() : SplashScreen(),
    );
  }
}

// Splash screen to check if the token is available
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check the token when the app starts
  }

  Future<void> checkLoginStatus() async {
    bool? ress = await validateToken();

    if (ress) {
      bool? isparent = await isParent();
      if (isparent == false) {
        Navigator.pushReplacementNamed(context, '/childSideHome');
      } else {
        Navigator.pushReplacementNamed(context, '/parentHome');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Basic splash screen (could be replaced with any loading indicator)
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _initPrefs(); // Call the async method
    _videoController =
        VideoPlayerController.asset("assets/videos/background.mp4")
          ..initialize().then((_) {
            setState(() {});
            _videoController.setLooping(true);
            _videoController.setVolume(0);
            _videoController.play();
          });

    _pageController = PageController();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
  }

  late VideoPlayerController _videoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: VideoPlayer(_videoController),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPage(
                    title: "Welcome To Edu Fun",
                    subtitle: "Thank you for downloading the EDUFUN app",
                    description: "With this application, you can...",
                  ),
                  _buildPage(
                    title: "Take Control!!",
                    subtitle:
                        "Manage your child's phone activity while ensuring a fun and safe digital experience!",
                  ),
                  _buildPage(
                    title: "Learn and Play!",
                    subtitle:
                        "Access educational content and fun activities designed for kids of all ages!",
                  ),
                  _buildPage(
                    title: "Monitor Usage",
                    subtitle:
                        "Track screen time, set daily limits, and keep an eye on app usage.",
                  ),
                  _buildPage(
                    title: "Parental Guidance",
                    subtitle:
                        "Get insights on your child's activity and guide them with educational content.",
                  ),
                  _buildLastPage(
                    context: context,
                    title: "Safe & Fun Learning",
                    subtitle:
                        "Ensure your child has a safe and enjoyable learning experience with EduFun!",
                    buttonText: "Get Started",
                  ),
                ],
              ),
            ),
            _buildIndicator(),
            const SizedBox(height: 20),
          ],
        ),
      ]),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: 18),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLastPage({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 320,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: _currentPage == index ? 14 : 10,
          height: _currentPage == index ? 14 : 10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_currentPage == index ? 1.0 : 0.5),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

void showSwitchAccountOverlay(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full-screen behavior
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const SwitchAccount(), // Display SwitchAccount widget
  );
}

void showSwitchAccountKidsOverlay(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows full-screen behavior
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) =>
        const SwitchKidsAccount(), // Display SwitchAccount widget
  );
}
