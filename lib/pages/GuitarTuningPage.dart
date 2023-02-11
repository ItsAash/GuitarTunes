import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class GuitarTuningPage extends StatefulWidget {
  @override
  State<GuitarTuningPage> createState() => _GuitarTuningPageState();
}

class _GuitarTuningPageState extends State<GuitarTuningPage> {
  int selected = 0; // zero as none of them selected
  final player = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    selected = 0;
  }
  //lists of the file paths of the sound files...
 List <String> stringSounds=["assets/sounds/E4_330.wav","assets/sounds/B_247.wav","assets/sounds/G_196.wav","assets/sounds/D_147.wav","assets/sounds/A_110.wav","assets/sounds/E2_82.wav"];
  onSelected(int stringNumber) {
    setState(() {
      selected = stringNumber;   
      player.open(Audio(stringSounds[stringNumber-1]),
         autoStart: true,
        showNotification: true,);
    }
    );
    print("Selected String: " + selected.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'GuitarTunes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Stack(
          children: [
            Positioned(
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/guitar-head.png"),
                )),
              ),
            ),
            Container(
              height: 250,
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StringButton(
                            stringName: "D",
                            isSelected: selected == 4,
                            onSelected: onSelected),
                        StringButton(
                            stringName: "A",
                            isSelected: selected == 5,
                            onSelected: onSelected),
                        StringButton(
                            stringName: "EHigh",
                            isSelected: selected == 6,
                            onSelected: onSelected),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StringButton(
                            stringName: "G",
                            isSelected: selected == 3,
                            onSelected: onSelected),
                        StringButton(
                            stringName: "B",
                            isSelected: selected == 2,
                            onSelected: onSelected),
                        StringButton(
                            stringName: "ELow",
                            isSelected: selected == 1,
                            onSelected: onSelected),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class StringButton extends StatefulWidget {
  final String stringName;
  final Function onSelected;
  bool isSelected;

  StringButton(
      {Key? key,
      required this.stringName,
      required this.isSelected,
      required this.onSelected})
      : super(key: key);

  @override
  State<StringButton> createState() => _StringButtonState();
}

class _StringButtonState extends State<StringButton> {  
  late bool isSelected;
  List<String> strings = ["ELow", "B", "G", "D", "A", "EHigh"];

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: Colors.blueGrey,
        //   width: 2.0,
        // ),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onSelected(strings.indexOf(widget.stringName) + 1);          
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                widget.isSelected ? Colors.blue.shade400 : Colors.grey.shade700,
            shape: CircleBorder(
                side: BorderSide(color: Colors.grey.shade800, width: 2))),
        child: Text(widget.stringName[0]),
      ),
    );
  }
}
