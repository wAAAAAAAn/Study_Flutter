import 'package:flutter/material.dart';
import 'package:wan_3_webtoon/button_data_model.dart';
import 'package:wan_3_webtoon/button_data_service.dart';
import 'package:wan_3_webtoon/widgets/ClothButton.dart';
import 'package:wan_3_webtoon/widgets/ImageDetail.dart';

class ButtonGrid extends StatefulWidget {
  final Function(String) onItemSelected;

  const ButtonGrid({super.key, required this.onItemSelected});

  @override
  State<ButtonGrid> createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  List<ButtonData> buttonList = [];
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadData(); // JSON 데이터를 로드
  }

  Future<void> _loadData() async {
    final List<ButtonData> data = await ButtonDataService.loadButtonData();
    setState(() {
      buttonList = data;
    });
  }

  void _onButtonSelected(int index, ButtonData title) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailPage(
          data: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (buttonList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(buttonList.length, (index) {
          final ButtonData data = buttonList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: HighlightedImageButton(
              imagePath: data.imagePath,
              title: data.title,
              isSelected: _selectedIndex == index,
              onPressed: () => _onButtonSelected(index, data),
            ),
          );
        }),
      ),
    );
  }
}
