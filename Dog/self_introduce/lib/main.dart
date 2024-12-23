import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Profile Section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.grey[200],
                                        child: Image(
                                          image: AssetImage('assets/me.jpg'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Contact Info
                                _buildSection('CONTACT', [
                                  _buildContactItem(
                                      Icons.home, '134 Rightward Way'),
                                  _buildContactItem(
                                      Icons.phone, '(555)954-987-2478'),
                                  _buildContactItem(
                                      Icons.email, 'theresawebb@gmail.com'),
                                  _buildContactItem(
                                      Icons.web, 'www.webb.com/mycy'),
                                ]),

                                // Skills
                                _buildSection('SKILLS', [
                                  _buildSkillsGrid([
                                    'HTML/JS/WS/C#',
                                    'Project Scheduling',
                                    'Dream Weaver',
                                    'WordPress',
                                    'Microsoft Project',
                                    'MS Windows',
                                  ]),
                                ]),

                                // Awards
                                _buildSection('AWARDS', [
                                  _buildAwardItem(
                                    'Outstanding Achievement Award',
                                    '2017, Clarendon Smith',
                                  ),
                                  _buildAwardItem(
                                    'Employee of the Month',
                                    'December 2009, Outer Sachs',
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 24),

                        // Right Column
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Education
                                _buildSection('EDUCATION', [
                                  _buildEducationItem(
                                    'Master of Computer Science',
                                    [
                                      'Graduated Summa Cum Laude',
                                      'Member of Student Association of Project Management',
                                      'Managed a student project to develop a weekly IT News podcast',
                                    ],
                                  ),
                                  _buildEducationItem(
                                    'Bachelor of Computer Science',
                                    [
                                      'Graduated Summa Cum Laude',
                                      'Member of Student Association of Computer Science',
                                    ],
                                  ),
                                ]),

                                // Experience
                                _buildSection('EXPERIENCE', [
                                  _buildExperienceItem(
                                    'Web Developer',
                                    'Creation Smith, Los Angeles, CA, 2015-present',
                                    [
                                      'Manage accounts worth \$4.7 million in annual sales',
                                      'Selected to train 3 new account managers',
                                      'Increased business volume by 130%',
                                    ],
                                  ),
                                  _buildExperienceItem(
                                    'Junior Developer',
                                    'Outer Sachs, Los Santos, CA, 2008-2011',
                                    [
                                      'Networked effectively with clients, increasing revenue by 47%',
                                      'Recognized as Employee of the Month',
                                    ],
                                  ),
                                ]),

                                // Certifications
                                _buildSection('CERTIFICATION', [
                                  _buildCertificationItem(
                                      'PMP - Project Management Institute',
                                      '2015/05'),
                                  _buildCertificationItem(
                                      'CAPM - Project Management Institute',
                                      '2007/11'),
                                  _buildCertificationItem(
                                      'PRINCE2 Foundation', '2014/04'),
                                ]),
                              ],
                            ),
                          ),
                        ),
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
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(List<String> skills) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: skills
          .map((skill) => Chip(
                label: Text(
                  skill,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.grey[200],
              ))
          .toList(),
    );
  }

  Widget _buildAwardItem(String title, String subtitle) {
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

  Widget _buildCertificationItem(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Text(date, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
