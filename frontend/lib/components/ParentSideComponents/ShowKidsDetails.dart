import 'package:flutter/material.dart';

class ShowKidsDetails extends StatefulWidget {
  const ShowKidsDetails({super.key});

  @override
  State<ShowKidsDetails> createState() => _ShowKidsDetailsState();
}

List dynamicArrayOfKids = [
  {"name": "YOUCEF", "achevGold": 40, "achevSilver": 40, "achevBronz": 50},
  {"name": "RAYANE", "achevGold": 40, "achevSilver": 40, "achevBronz": 50},
  {"name": "MOUHAMMED", "achevGold": 40, "achevSilver": 40, "achevBronz": 50},
  {"name": "WASSIM", "achevGold": 40, "achevSilver": 40, "achevBronz": 50},
];

class _ShowKidsDetailsState extends State<ShowKidsDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 371,
      decoration: BoxDecoration(color: Colors.red),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Row(
              children: [
                Text(
                  "Kids Ranking",
                  style: TextStyle(
                    color: Color(0xFF2086CB),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 192, 194, 212),
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            width: 315,

            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),

            child: ListView.builder(
              shrinkWrap: true, // Ensures the ListView doesn't overflow
              physics: NeverScrollableScrollPhysics(), //
              itemCount: dynamicArrayOfKids.length,
              itemBuilder: (context, index) {
                var kid = dynamicArrayOfKids[index];
                return ShowKidDetails(
                  number: index + 1,
                  name: kid["name"],
                  gold: kid["achevGold"],
                  silver: kid["achevSilver"],
                  bronz: kid["achevBronz"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget ShowKidDetails({
  required int number,
  required String name,
  required int gold,
  required int silver,
  required int bronz,
}) {
  return Container(
    height: 25,
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(111, 148, 188, 1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        // Blue border color for emphasis
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rank number
        Text(
          '#$number',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        // Kid's name
        Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        Row(
          children: [
            Text(
              "$gold 🥇",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "$silver 🥈",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "$bronz 🥉",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
