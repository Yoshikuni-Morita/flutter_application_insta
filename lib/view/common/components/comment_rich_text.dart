import 'package:flutter/material.dart';

class CommentRichText extends StatefulWidget {
  final String name;
  final String text;

  const CommentRichText({super.key, required this.name, required this.text});

  @override
  State<CommentRichText> createState() => _CommentRichTextState();
}

class _CommentRichTextState extends State<CommentRichText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
