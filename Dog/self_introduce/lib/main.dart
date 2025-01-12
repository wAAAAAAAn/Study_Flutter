import 'package:self_introduce/widgets/linkButtonWidget.dart';

import './widgets/contactInfoWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    const brownBorder =
        BorderSide(color: Color.fromARGB(255, 161, 136, 127), width: 10);
    const greenishBorder =
        BorderSide(color: Color.fromARGB(255, 127, 161, 130), width: 10);
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(74, 88, 139, 0),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  top: brownBorder,
                                  start: brownBorder,
                                  end: brownBorder),
                              color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Column
                              Expanded(
                                flex: 2,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Profile Section
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '장현규',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'Backend & Flutter Developer',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              width: double.infinity,
                                              height: 150,
                                              color: Colors.grey[200],
                                              child: Image(
                                                image:
                                                    AssetImage('assets/me.jpg'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      // Contact Info
                                      _buildSection('CONTACT', [
                                        contactInfoWidget(Icons.home, '서울 마포구'),
                                        contactInfoWidget(
                                            Icons.phone, '010-2281-5399'),
                                        contactInfoWidget(
                                            Icons.email, 'wkdgusrb3@naver.com'),
                                      ]),

                                      // Skills
                                      _buildSection('SKILLS', [
                                        _buildSkillsGrid([
                                          'JAVA/JS/TS/PYHON/DART',
                                          'Spring Boot',
                                          'Flutter',
                                          'Oracle/MSSQL',
                                          'Mendix',
                                        ]),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // Right Column
                              Expanded(
                                flex: 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Education
                                      _buildSection('EDUCATION', [
                                        _buildEducationItem(
                                          'Bachelor of Computer Science',
                                          [
                                            'Sejong University',
                                            'Graduated Summa Cum Laude / GPA 4.19',
                                            '2017.02 ~ 2023.12'
                                          ],
                                        ),
                                        _buildEducationItem(
                                          '부스트코스 코칭스터디 13기',
                                          [
                                            '그룹 리더로 참여함',
                                            '2023.10 ~ 2023.11',
                                          ],
                                        ),
                                      ]),
                                      _buildSection('CERTIFICATIONS', [
                                        _buildCertificate(
                                          '정보처리기사',
                                          '2022.09.02',
                                        ),
                                        _buildCertificate(
                                          '컴퓨터 활용능력',
                                          '2019.12.27',
                                        ),
                                        _buildCertificate(
                                          'OPIC',
                                          'Intermediate Mid',
                                        ),
                                        _buildCertificate(
                                          'TOEIC',
                                          'LC: 495, RC: 465',
                                        ),
                                      ]),
                                      _buildSection('WEB SITE', [
                                        Linkbuttonwidget(
                                            link:
                                                'https://github.com/MartinDog',
                                            icon_: Icon(
                                              Icons.web_asset,
                                            ),
                                            name: 'GitHub')
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                                start: greenishBorder,
                                end: greenishBorder,
                                bottom: greenishBorder),
                            color: const Color.fromARGB(74, 88, 139, 0),
                          ),
                          child: // Experience
                              _buildSection('EXPERIENCE', [
                            _buildExperienceItem(
                              'Intern',
                              'Sejong Univ lab, Seoul, 2021 ~ 2021',
                              [
                                'Write paper & Translate',
                                'Support searching for High-average utility pattern mining',
                              ],
                            ),
                            _buildExperienceItem(
                              'Web Developer',
                              'Woongjin, Seoul, 2023 ~ 2024',
                              [
                                'Manage and develop the Shake & Go ERP System',
                                'Manage and develop SUBC system',
                              ],
                            ),
                            _buildExperienceItem(
                              '',
                              'PAGODA, Seoul, 2024 ~ Present',
                              [
                                'Manage and develop Talkool B2B,B2C & Admin',
                                'Manage and develop PAMIS System',
                                'Refactor the legacy code and diminish the errors 60%'
                              ],
                            ),
                            _buildExperienceItem(
                              'Flutter Developer',
                              'PAGODA, Seoul, 2024 ~ Present',
                              ['Refactor the Talkool app into Flutter'],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                    color: Colors.black, width: 3.0, style: BorderStyle.solid),
                bottom: BorderSide(
                    color: Colors.black, width: 3.0, style: BorderStyle.solid),
              )),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        ...children,
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSkillsGrid(List<String> skills) {
    return Column(
      children: skills
          .map(
            (skill) => FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                height: 20,
                child: Text(
                  skill,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCertificate(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(String degree, List<String> details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(detail)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
      String title, String company, List<String> responsibilities) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            company,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 4),
          ...responsibilities.map((responsibility) => Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(responsibility)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
