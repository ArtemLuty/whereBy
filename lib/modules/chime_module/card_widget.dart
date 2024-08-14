import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final cardId = state.data!.rooms.first.cardId;
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
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 12),
                  child: Text(
                    state.cards?[0].content.text ?? '',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: FontFamily.poppinsBold),
                  ),
                ),
              Text(
                state.cards?[0].content.description ?? '',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: FontFamily.poppins),
              ),
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
              const SizedBox(
                height: 10,
              ),
              if (words != null && words.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: firstHalf
                          .map((word) => Text(
                                '• $word',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: FontFamily.poppins),
                              ))
                          .toList(),
                    ),
                    const SizedBox(width: 50), // Space between columns
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: secondHalf
                          .map((word) => Text(
                                '• $word',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: FontFamily.poppins),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
              // if (state.cards?[0].content.image1 != null &&
              //     state.cards![0].content.image1!.startsWith('http')) ...[
              Image.network(
                'https://test.wtalk.space${state.cards![0].content.image1!}',
                // scale: 1.0,
                height: 77,
                width: 77,
                // fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/png/default_avatar.png',
                    height: 77,
                    width: 77,
                    fit: BoxFit.fill,
                  );
                },
              ),
              // Image.network(
              //   state.cards![0].content.image1!,
              //   fit: BoxFit.cover,
              // ),
              // ],
              // Text(state.cards?[2].toString() ?? ''),
              // if (state.data != null) ...[
              //   Text('Additional Data: ${state.data!['someKey']}'),
              // ],
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
}
