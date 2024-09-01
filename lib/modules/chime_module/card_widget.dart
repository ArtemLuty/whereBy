import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/utils/fonts.dart';
import 'package:whereby_app/widgets/app_button.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  PageController _pageController = PageController();

  bool _buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaitingRoomCubit, WaitingRoomState>(
      listener: (context, state) {
        if (state.cards != null && state.cards!.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients && _pageController.page != null) {
              int nextPage = state.cards!.length - 2;
              _pageController.animateToPage(
                nextPage,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      },
      child: BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
        builder: (context, state) {
          // if (state.isLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.cards == null || state.cards!.isEmpty) {
            return const Center(child: Text("No cards available."));
          }

          // final currentCard = state.cards![0];
          final currentRoom = state.data!.users[state.logInUserId]?.roomId;
          final currentSpeakerId =
              state.data!.rooms[currentRoom]?.currentSpeakerId;
          final speakerName = currentSpeakerId != null &&
                  state.data!.rooms[currentRoom]?.users != null
              ? state.data!.rooms[currentRoom]?.users[currentSpeakerId]?.name
              : null;

          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: state.cards?.length ?? 0,
              itemBuilder: (context, index) {
                final card = state.cards![index];
                bool isStartCard = card.type == 'start_cards';
                bool isCurrentSpeaker =
                    state.userRoom!.currentSpeakerId == state.logInUserId;
                final currentCard = state.cards![index];
                final words = currentCard.content.words;
                List<String> firstHalf = [];
                List<String> secondHalf = [];
                if (words != null) {
                  final midIndex = (words.length / 2).ceil();
                  firstHalf = words.sublist(0, midIndex);
                  secondHalf = words.sublist(midIndex);
                }
                return SingleChildScrollView(
                  child: Container(
                    height: 530,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (card.type == 'start_cards')
                          const SizedBox(height: 150),
                        if (card.type == 'start_cards')
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 12),
                            child: Center(
                              child: Text(
                                card.content.text ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: FontFamily.poppinsBold),
                              ),
                            ),
                          ),
                        if (card.type != 'start_cards')
                          Text.rich(
                            TextSpan(
                              children: parseTextWithHighlights(
                                  card.content.description ?? ''),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: FontFamily.poppins),
                          ),
                        if (card.type != 'start_cards' &&
                            card.content.question != null)
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
                                        ', ${card.content.question.toString()}' ??
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
                        if (card.type != 'start_cards' &&
                            card.content.task != null)
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: speakerName,
                                    style: TextStyle(
                                        fontSize:
                                            card.content.sentences?[0] != null
                                                ? 18
                                                : 28,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: FontFamily.poppinsBold),
                                  ),
                                  TextSpan(
                                    text: ', ${card.content.task.toString()}' ??
                                        '',
                                    style: TextStyle(
                                      fontSize:
                                          card.content.sentences?[0] != null
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

                        if (card.type != 'start_cards' &&
                            card.content.sentences?[0] != null)
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 26.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${card.content.sentences?[0].toString()}',
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
                        if (card.content.image != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                'https://test.wetalk.co${card.content.image}',
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 500,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 500,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        if (words != null && words.isNotEmpty)
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

                        // Image content
                        // if (card.content.image != null)
                        //   Padding(
                        //     padding: const EdgeInsets.all(16.0),
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(16.0),
                        //       child: Image.network(
                        //         'https://test.wetalk.co${card.content.image}',
                        //         loadingBuilder: (BuildContext context,
                        //             Widget child,
                        //             ImageChunkEvent? loadingProgress) {
                        //           if (loadingProgress == null) {
                        //             return child;
                        //           } else {
                        //             return Center(
                        //               child: CircularProgressIndicator(
                        //                 value:
                        //                     loadingProgress.expectedTotalBytes !=
                        //                             null
                        //                         ? loadingProgress
                        //                                 .cumulativeBytesLoaded /
                        //                             loadingProgress
                        //                                 .expectedTotalBytes!
                        //                         : null,
                        //               ),
                        //             );
                        //           }
                        //         },
                        //         errorBuilder: (BuildContext context,
                        //             Object exception, StackTrace? stackTrace) {
                        //           return const Text('Failed to load image');
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(height: 10),
                        // Helping words list
                        if (words != null && words.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    firstHalf.asMap().entries.map((entry) {
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
                                          text:
                                              index == 0 ? ' $word  ' : '$word',
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
                                children:
                                    secondHalf.asMap().entries.map((entry) {
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
                                          text:
                                              index == 0 ? '$word  ' : '$word',
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
                            ],
                          ),
                        ],
                        // if (isStartCard) const SizedBox(height: 150),

                        // // Title for start card
                        // if (isStartCard)
                        //   Padding(
                        //     padding: const EdgeInsets.fromLTRB(0, 30, 0, 12),
                        //     child: Center(
                        //       child: Text(
                        //         card.content.text ?? '',
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w600,
                        //           color: Colors.black,
                        //           fontFamily: FontFamily.poppinsBold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),

                        // // Card content
                        // if (card.type != 'start_cards')
                        //   Column(
                        //     children: [
                        //       Text.rich(
                        //         TextSpan(
                        //           children: parseTextWithHighlights(
                        //               card.content.description ?? ''),
                        //         ),
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //           fontSize: 20,
                        //           color: Colors.black,
                        //           fontFamily: FontFamily.poppins,
                        //         ),
                        //       ),
                        //       if (card.content.question != null)
                        //         RichText(
                        //           textAlign: TextAlign.center,
                        //           text: TextSpan(
                        //             children: [
                        //               TextSpan(
                        //                 text: speakerName,
                        //                 style: const TextStyle(
                        //                   fontSize: 28,
                        //                   color: Colors.green,
                        //                   fontWeight: FontWeight.w600,
                        //                   fontFamily: FontFamily.poppinsBold,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text: ', ${card.content.question}',
                        //                 style: const TextStyle(
                        //                   fontSize: 28,
                        //                   color: Colors.black,
                        //                   fontWeight: FontWeight.w600,
                        //                   fontFamily: FontFamily.poppins,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //     ],
                        //   ),

                        // // Image content
                        // // if (card.content.image != null)
                        // //   Padding(
                        // //     padding: const EdgeInsets.all(16.0),
                        // //     child: ClipRRect(
                        // //       borderRadius: BorderRadius.circular(16.0),
                        // //       child: Image.network(
                        // //         'https://test.wetalk.co${card.content.image}',
                        // //         loadingBuilder:
                        // //             (context, child, loadingProgress) {
                        // //           if (loadingProgress == null) {
                        // //             return child;
                        // //           } else {
                        // //             return Center(
                        // //               child: CircularProgressIndicator(
                        // //                 value:
                        // //                     loadingProgress.expectedTotalBytes !=
                        // //                             null
                        // //                         ? loadingProgress
                        // //                                 .cumulativeBytesLoaded /
                        // //                             loadingProgress
                        // //                                 .expectedTotalBytes!
                        // //                         : null,
                        // //               ),
                        // //             );
                        // //           }
                        // //         },
                        // //         errorBuilder: (context, error, stackTrace) {
                        // //           return const Text('Failed to load image');
                        // //         },
                        // //       ),
                        // //     ),
                        // //   ),

                        // // Helping words section
                        // if (words != null && words.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 20.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         buildWordsColumn(firstHalf),
                        //         buildWordsColumn(secondHalf),
                        //       ],
                        //     ),
                        //   ),
                        Spacer(),
                        if (_buttonClicked && isStartCard)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Await Next User',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isStartCard || isCurrentSpeaker)
                          AppButton(
                            _buttonClicked ? 'Next' : 'Start',
                            onTap: (!_buttonClicked || !isStartCard)
                                ? () {
                                    context
                                        .read<WaitingRoomCubit>()
                                        .getNextCard(
                                            currentRoom, currentCard.id);
                                    setState(() {
                                      _buttonClicked = true;
                                    });
                                  }
                                : () {},
                            color: (!_buttonClicked || !isStartCard)
                                ? ColorConstants.primaryBlue
                                : Colors.grey,
                            textColor: Colors.white,
                            height: 48,
                            width: 500,
                            circular: 4,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildWordsColumn(List<String> words) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: words
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
                      style: TextStyle(fontSize: 23),
                    ),
                    TextSpan(
                      text: word,
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

List<TextSpan> parseTextWithHighlights(String text) {
  final regex = RegExp(r'###(.*?)###');
  final matches = regex.allMatches(text);
  final spans = <TextSpan>[];

  int currentIndex = 0;
  for (final match in matches) {
    final highlightedText = match.group(1);
    if (highlightedText != null) {
      final beforeText = text.substring(currentIndex, match.start);
      if (beforeText.isNotEmpty) {
        spans.add(TextSpan(text: beforeText));
      }
      spans.add(
        TextSpan(
          text: highlightedText,
          style: const TextStyle(color: Colors.blue),
        ),
      );
      currentIndex = match.end;
    }
  }

  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return spans;
}
