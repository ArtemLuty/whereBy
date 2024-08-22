import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/utils/fonts.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
      builder: (context, state) {
        final roomId = state.data;
        final task = state.data!.rooms.first;
        final currentSpeaker = state.data!.rooms.first.currentSpeakerId;
        final speakerName = state.data!.rooms.first.users[currentSpeaker]?.name;
        final words = state.cards?[0].content.words;
        List<String> firstHalf = [];
        List<String> secondHalf = [];
        if (words != null) {
          final midIndex = (words.length / 2).ceil();
          firstHalf = words.sublist(0, midIndex);
          secondHalf = words.sublist(midIndex);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (state.cards?[0].type == 'start_cards')
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 12),
                  child: Center(
                    child: Text(
                      state.cards?[0].content.text ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: FontFamily.poppinsBold),
                    ),
                  ),
                ),
              if (state.cards?[0].type == 'start_cards')
                SvgPicture.network(
                  'https://test.wetalk.co/wp-content/uploads/2024/07/handshake.svg',
                  height: 77,
                  width: 77,
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              Text.rich(
                TextSpan(
                  children: parseTextWithHighlights(
                      state.cards?[0].content.description ?? ''),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: FontFamily.poppins),
              ),
              if (state.cards?[0].type != 'start_cards' &&
                  state.cards?[0].content.question != null)
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: speakerName,
                          style: const TextStyle(
                              fontSize: 28,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.poppinsBold),
                        ),
                        TextSpan(
                          text:
                              ', ${state.cards?[0].content.question.toString()}' ??
                                  '',
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.poppins,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (state.cards?[0].type != 'start_cards' &&
                  state.cards?[0].content.task != null)
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: speakerName,
                          style: TextStyle(
                              fontSize:
                                  state.cards?[0].content.sentences?[0] != null
                                      ? 18
                                      : 28,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.poppinsBold),
                        ),
                        TextSpan(
                          text:
                              ', ${state.cards?[0].content.task.toString()}' ??
                                  '',
                          style: TextStyle(
                            fontSize:
                                state.cards?[0].content.sentences?[0] != null
                                    ? 18
                                    : 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.poppins,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (state.cards?[0].type != 'start_cards' &&
                  state.cards?[0].content.sentences?[0] != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${state.cards?[0].content.sentences?[0].toString()}' ??
                                    '',
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (state.cards?[0].type == 'helping_words')
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 12),
                  child: Text(
                    'Helping words:',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: FontFamily.poppinsBold),
                  ),
                ),
              if (state.cards?[0].content.image != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      'https://test.wetalk.co${state.cards?[0].content.image}',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text('Failed to load image');
                      },
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (words != null && words.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: firstHalf.asMap().entries.map((entry) {
                        int index = entry.key;
                        String word = entry.value;
                        return RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: FontFamily.poppins,
                            ),
                            children: [
                              const TextSpan(
                                text: '• ',
                                style: TextStyle(fontSize: 23),
                              ),
                              TextSpan(
                                text: index == 0 ? ' $word  ' : '$word',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: FontFamily.poppins,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: secondHalf
                          .map((word) => RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: FontFamily.poppins,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: '• ',
                                        style: TextStyle(fontSize: 23)),
                                    TextSpan(
                                      text: word,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: FontFamily.poppins),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
              if (state.errorMessage!.isNotEmpty) ...[
                Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  List<TextSpan> parseTextWithHighlights(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'###(.*?)###');
    final matches = regex.allMatches(text);

    int start = 0;
    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: FontFamily.poppins,
          ),
        ));
      }

      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorConstants.primaryBlue,
          fontFamily: FontFamily.poppins,
        ),
      ));

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: FontFamily.poppins,
        ),
      ));
    }

    return spans;
  }
}
