import 'package:flutter/material.dart';
import 'screen_time_overlay.dart'; // Import the overlay file

class ScreenTime extends StatefulWidget {
  const ScreenTime({super.key});

  @override
  State<ScreenTime> createState() => _ScreenTimeState();
}

class _ScreenTimeState extends State<ScreenTime> {
  int timeOfPlaying = 360; // Dynamic
  int totalTime = 360;
  bool _showOverlay = false;
  Map<String, dynamic>? _screenTimeSettings;
  String childName = "Simou"; // You can make this dynamic if needed

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "General Screen Time  ⌛",
                style: TextStyle(
                  color: Color(0xFF2086CB),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            width: 315,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 192, 194, 212),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clock icon aligned to the right - Now clickable
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _showScreenTimeOverlay(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.access_time,
                        size: 30,
                        color: Color(0xFF2086CB),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Time text
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$timeOfPlaying",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " / $totalTime min",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Progress bar
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      // Background
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // Progress indicator
                      FractionallySizedBox(
                        widthFactor: timeOfPlaying / totalTime,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF2086CB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Display settings if available
                if (_screenTimeSettings != null) ...[
                  SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.5)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedule:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_formatTimeOfDay(_screenTimeSettings!['fromTime'])} - ${_formatTimeOfDay(_screenTimeSettings!['toTime'])}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Limits:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_screenTimeSettings!['minimumMinutes']} - ${_screenTimeSettings!['maximumMinutes']} min/day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Add this new method to show the overlay using Navigator
  void _showScreenTimeOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ScreenTimeOverlay(
          childName: childName,
          // Pass current settings as initial values if available
          initialFromTime: _screenTimeSettings?['fromTime'],
          initialToTime: _screenTimeSettings?['toTime'],
          initialDifferentWeekends: _screenTimeSettings?['differentWeekends'],
          initialMinimumMinutes: _screenTimeSettings?['minimumMinutes'],
          initialMaximumMinutes: _screenTimeSettings?['maximumMinutes'],
          onConfirm: (settings) {
            setState(() {
              _screenTimeSettings = settings;

              // Update the total time based on the maximum minutes
              totalTime = settings['maximumMinutes'];

              // Adjust current time if needed
              if (timeOfPlaying > totalTime) {
                timeOfPlaying = totalTime;
              }
            });

            // Show confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Screen time settings updated for $childName'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.of(context).pop(); // Close the dialog
          },
          onBack: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
