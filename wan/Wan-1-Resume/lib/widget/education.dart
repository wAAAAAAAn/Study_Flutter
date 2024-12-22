import 'package:flutter/material.dart';

// class EducationTimeline extends StatelessWidget {
//   const EducationTimeline({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "EDUCATION",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView(
//                   children: const [
//                     EducationItem(
//                       yearRange: "2011 - 2014",
//                       title: "Lorem ipsum dolor sit amet, consec.",
//                       description: "adipiscing elit, sed diam nonummy nibh",
//                     ),
//                     EducationItem(
//                       yearRange: "2014 - 2016",
//                       title: "Lorem ipsum dolor sit amet, consec.",
//                       description: "adipiscing elit, sed diam nonummy nibh",
//                     ),
//                     EducationItem(
//                       yearRange: "2016 - 2018",
//                       title: "Lorem ipsum dolor sit amet, consec.",
//                       description: "adipiscing elit, sed diam nonummy nibh",
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

enum lineState { down, middle, up }

class EducationItem extends StatelessWidget {
  final String yearRange;
  final String title;
  final String description;
  final lineState flag;

  const EducationItem(
      {super.key,
      required this.yearRange,
      required this.title,
      required this.description,
      required this.flag});

  double lineOffset(lineState state) {
    switch (state) {
      case lineState.down:
        return 20;
      case lineState.middle:
        return 0;
      case lineState.up:
        return -20;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 왼쪽: 년도와 세로 라인 + 원
        Row(
          children: [
            // 년도 텍스트
            Text(
              yearRange,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            // 세로 라인 + 원
            Stack(
              alignment: Alignment.center,
              children: [
                // 세로 라인
                Transform.translate(
                  offset: Offset(0, lineOffset(flag)),
                  child: Container(
                    width: 2.5,
                    height: 45, // 라인의 길이
                    color: Colors.grey.shade400,
                  ),
                ),
                // 원
                Positioned(
                  child: Container(
                    width: 6,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 8),
        // 오른쪽: 텍스트
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class lineBox extends StatelessWidget {
  const lineBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.grey,
          height: 3,
          width: 80,
        ),
        Container(
          color: Colors.black,
          height: 3,
          width: 80,
        )
      ],
    );
  }
}

class SkillIcon extends StatelessWidget {
  final IconData iconData;
  final String name;

  const SkillIcon({super.key, required this.iconData, required this.name});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Column(
        children: [
          Icon(iconData),
          Text(
            name,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
