import 'dart:ui';

import 'package:flutter/material.dart';
import 'widget/TextWidget.dart';
import 'widget/education.dart';

void main() {
  runApp(const MaterialApp(home: ResumeTemplate()));
}

class ResumeTemplate extends StatelessWidget {
  const ResumeTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                        // 사진
                        height: 350,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image:
                              AssetImage('assets/image/resume.png'), // 이미지 경로
                          fit: BoxFit.cover, // 이미지를 박스에 맞게 조정)
                        )),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: const Text("Jaewan Park",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            fontFamily: 'HGGGothicssi',
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0), // 그림자의 위치
                                blurRadius: 30.0, // 흐림 정도
                                color: Colors.grey, // 그림자 색상
                              ),
                            ],
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ABOUT ME",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "I am a passionate and dedicated software developer with a strong foundation in building scalable, user-friendly applications. With expertise in Flutter and Dart.",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "CONTACT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "4-11, Wiryeseong-daero 16-gil, Songpa-gu, Seoul, Republic of Korea",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          IconText(
                            icon: Icons.phone_android_outlined,
                            infoText: "+82 10 4086 6102",
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          IconText(
                            icon: Icons.web_asset,
                            infoText: "@waaaaaaan",
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          IconText(
                            icon: Icons.email,
                            infoText: "smba66@naver.com",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white, // 박스를 검은색으로 설정
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      lineBox(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "EDUCATION",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.down),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.middle),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.up),
                      SizedBox(
                        height: 20,
                      ),
                      lineBox(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "EXPERIENCE",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.down),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.middle),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.middle),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.middle),
                      EducationItem(
                          yearRange: "2011 - 2014",
                          title: "Lorem ipsum dolor sit amet, consec.",
                          description: "adipiscing elit, sed diam nonummy nibh",
                          flag: lineState.up),
                      SizedBox(
                        height: 20,
                      ),
                      lineBox(),
                      SizedBox(
                        height: 20,
                      ),
                      Text("SKILL",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SkillIcon(iconData: Icons.code, name: "Code"),
                          SkillIcon(
                              iconData: Icons.music_note_outlined,
                              name: "Music"),
                          SkillIcon(iconData: Icons.work_outline, name: "Work"),
                          SkillIcon(
                              iconData: Icons.abc_rounded, name: "English")
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "note : ",
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "이거 테스트용으로 작업을 했는데 생각보다 오래 걸렸다. 플러터 재미가 있는거 같으면서도 유니티로 했으면 30분 컷인데 새로 배우는거라 그런지 진짜 오래 걸렸다.",
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
