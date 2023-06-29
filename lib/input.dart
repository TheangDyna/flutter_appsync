import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final ValueChanged<String> onTap;

  const Input({Key? key, required this.onTap}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          height: 46.0,
          child: TextField(
            style: const TextStyle(fontSize: 18),
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'name...',
              hintStyle: const TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 20.0,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 4.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100.0),
              onTap: () {
                widget.onTap(textEditingController.text);
                textEditingController.clear();
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.send_rounded,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
