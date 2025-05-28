import 'package:flutter/material.dart';
import 'package:frontend/Netflixfirstpage/SelectKidScreen.dart';
import 'package:frontend/components/ParentSideComponents/BottomNavBar.dart';

class SelectAvatar extends StatefulWidget {
  const SelectAvatar({super.key});

  @override
  State<SelectAvatar> createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {
  String? selectedAvatarAsset;
  bool showAvatarSelector = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You're signed in successfully!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.deepPurple, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        selectedAvatarAsset != null
                            ? AssetImage(selectedAvatarAsset!)
                            : const AssetImage('assets/images/bgImage.png'),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAvatarSelector = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Select Avatar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Allow Access To Gallery To Choose an Image
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                    child: const Text(
                      "Choose From Gallery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(158, 219, 244, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Builder(
                    // Use a Builder to get a context that is a child of Scaffold
                    builder: (context) {
                      return TextButton(
                        onPressed: () {
                          // Now this context is a child of Scaffold
                          print("Select Kid Screen button pressed");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SelectKidScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Confirm Selection",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Avatar Selection Overlay
          if (showAvatarSelector)
            AvatarSelectorOverlay(
              onClose: () {
                setState(() {
                  showAvatarSelector = false;
                });
              },
              onAvatarSelected: (String avatarAsset) {
                setState(() {
                  selectedAvatarAsset = avatarAsset;
                  showAvatarSelector = false;
                });
              },
            ),
        ],
      ),
    );
  }
}

// // Placeholder for your BottomAppBar widget
// class MyBottomAppBar extends StatelessWidget {
//   const MyBottomAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: const Center(child: Text('Home Screen')),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(icon: const Icon(Icons.home), onPressed: () {}),
//             IconButton(icon: const Icon(Icons.search), onPressed: () {}),
//             IconButton(icon: const Icon(Icons.person), onPressed: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AvatarSelectorOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String) onAvatarSelected;

  const AvatarSelectorOverlay({
    Key? key,
    required this.onClose,
    required this.onAvatarSelected,
  }) : super(key: key);

  @override
  State<AvatarSelectorOverlay> createState() => _AvatarSelectorOverlayState();
}

class _AvatarSelectorOverlayState extends State<AvatarSelectorOverlay> {
  String? tempSelectedAvatar;

  // Define avatar options - in a real app, these would be actual asset paths
  final List<Map<String, dynamic>> avatarOptions = [
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401560712.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': ' assets/images/adventurerNeutral-1741401566239.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {'asset': 'assets/images/37.png', 'color': Colors.purple.shade200},
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.purple.shade200,
    },
    {
      'asset': 'assets/images/adventurerNeutral-1741401563851.png',
      'color': Colors.blue.shade200,
    },
    // ... rest of your avatar options
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFF33B5E5), // Bright blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Avatar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: widget.onClose,
                      ),
                    ],
                  ),
                ),

                // Subheader
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Select one of these avatars to be displayed On your profile picture',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),

                // Avatar Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: avatarOptions.length,
                      itemBuilder: (context, index) {
                        final avatar = avatarOptions[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              tempSelectedAvatar = avatar['asset'];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: avatar['color'],
                              shape: BoxShape.circle,
                              border:
                                  tempSelectedAvatar == avatar['asset']
                                      ? Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      )
                                      : null,
                            ),
                            child: Center(
                              child: Icon(
                                index % 4 == 0
                                    ? Icons.person
                                    : index % 4 == 1
                                    ? Icons.face
                                    : index % 4 == 2
                                    ? Icons.face_retouching_natural
                                    : Icons.face_unlock_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: widget.onClose,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              tempSelectedAvatar == null
                                  ? null
                                  : () {
                                    widget.onAvatarSelected(
                                      tempSelectedAvatar!,
                                    );
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
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
