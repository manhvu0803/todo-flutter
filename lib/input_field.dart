import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final Function()? onTap;
  final bool isMultiline;

  const InputField({
    super.key,
    required this.title,
    this.hint = "",
    this.controller,
    this.widget,
    this.onTap,
    this.isMultiline = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            height: isMultiline ? 152 : 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: isMultiline ? TextInputType.multiline : null,
                    maxLines: 8,
                    onTap: onTap,
                    controller: controller,
                    autofocus: false,
                    readOnly: widget != null ? true : false,
                    decoration: InputDecoration(
                      hintText: hint,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.background)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: 0
                        )
                      ),
                    )
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: widget ?? Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
