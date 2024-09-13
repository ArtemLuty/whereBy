import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/chime_cubit/chime_cubit.dart';
import 'package:whereby_app/modules/chime_module/chime_cubit/chime_state.dart';
import 'package:whereby_app/utils/scalable_size.dart';
import 'package:whereby_app/widgets/app_button.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  CardWidgetState createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  final PageController _pageController = PageController();
  bool _buttonClicked = false;
  bool _showCardLoud = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaitingRoomCubit, WaitingRoomState>(
      listener: (context, state) {
        if (state.cards != null && state.cards!.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients && _pageController.page != null) {
              int nextPage = state.cards!.length - 2;
              _pageController.animateToPage(nextPage,
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.linear);
            }
          });
        }
      },
      child: BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
        builder: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            return _buildError(state.errorMessage!);
          }

          if (state.cards == null || state.cards!.isEmpty) {
            return const Center(child: Text("No cards available."));
          }

          final currentRoom = state.data!.users[state.logInUserId]?.roomId;
          final currentSpeakerId =
              state.data!.rooms[currentRoom]?.currentSpeakerId;
          final speakerName = currentSpeakerId != null &&
                  state.data!.rooms[currentRoom]?.users != null
              ? state.data!.rooms[currentRoom]?.users[currentSpeakerId]?.name
              : null;
          _showCardLoud = state.showCardLoud;

          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: context.getScalableHeight(580),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (card.type == 'start_cards')
                                const SizedBox(height: 150),
                              if (card.type == 'start_cards')
                                _buildStartCardText(card.content.text),
                              if (card.type != 'start_cards')
                                _buildDescription(card.content.description),
                              if (card.type != 'start_cards' &&
                                  card.content.question != null)
                                _buildQuestion(
                                    speakerName, card.content.question),
                              if (card.type != 'start_cards' &&
                                  card.content.task != null &&
                                  card.type != "general_topics_1")
                                _buildTask(speakerName, card.content.task,
                                    card.content.sentences?[0] != null),
                              if (card.type != 'start_cards' &&
                                  card.content.sentences?[0] != null)
                                _buildSentence(card.content.sentences?[0]),
                              if (card.content.image != null &&
                                  card.type != "general_topics_1")
                                _buildImage(card.content.image),
                              if (card.type != 'start_cards' &&
                                  card.content.idiom != null &&
                                  card.type != "general_topics_1")
                                _buildIdiom(card.content.idiom),
                              if (card.type != 'start_cards' &&
                                  card.content.explanation != null &&
                                  card.type != "general_topics_1")
                                _buildExplanation(card.content.explanation),
                              if (words != null &&
                                  words.isNotEmpty &&
                                  card.type == "helping_words")
                                _buildHelpingWordsTitle(),
                              const SizedBox(height: 10),
                              if (words != null && words.isNotEmpty)
                                _buildWords(firstHalf, secondHalf),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_buttonClicked && isStartCard)
                      _buildWaitingForPartner(),
                    if (_showCardLoud && !isStartCard) _buildCardLoading(),
                    if (isStartCard && !_buttonClicked ||
                        isCurrentSpeaker && !_showCardLoud && _buttonClicked)
                      _buildAppButton(currentRoom, currentCard.id, isStartCard,
                          isCurrentSpeaker),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Text(
        'Error: $errorMessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildStartCardText(String? text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 12),
      child: Center(
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: ColorConstants.summaryDGreu),
        ),
      ),
    );
  }

  Widget _buildDescription(String? description) {
    return Text(
      description ?? '',
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget _buildQuestion(String? speakerName, String? question) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: speakerName,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ', $question' ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTask(String? speakerName, String? task, bool hasSentences) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: speakerName,
                style: GoogleFonts.poppins(
                  fontSize: hasSentences ? 18 : 28,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ', $task' ?? '',
                style: GoogleFonts.poppins(
                  fontSize: hasSentences ? 18 : 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSentence(String? sentence) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$sentence',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(
          'https://test.wetalk.co$imageUrl',
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 500,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIdiom(String? idiom) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 52.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$idiom' ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanation(String? explanation) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$explanation' ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpingWordsTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 12),
      child: Text(
        'Helping words:',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildWords(List<String> firstHalf, List<String> secondHalf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildWordsColumn(firstHalf, isFirstColumn: true),
        _buildWordsColumn(secondHalf, isFirstColumn: false),
      ],
    );
  }

  Widget _buildWordsColumn(List<String> words, {required bool isFirstColumn}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: words.asMap().entries.map((entry) {
        int index = entry.key;
        String word = entry.value;
        return RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: isFirstColumn && index == 0 ? '•  ' : '• ',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              TextSpan(
                text: word,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWaitingForPartner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Waiting for your partner',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardLoading() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Card is loading',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppButton(String? currentRoom, String? currentCardId,
      bool isStartCard, bool isCurrentSpeaker) {
    return AppButton(
      _buttonClicked ? 'Next' : 'Start',
      fontSize: !_buttonClicked ? 24 : 16,
      fontWeight: !_buttonClicked ? FontWeight.w500 : FontWeight.w600,
      onTap: (!_buttonClicked || !isStartCard)
          ? () {
              context
                  .read<WaitingRoomCubit>()
                  .getNextCard(currentRoom, currentCardId);
              context.read<WaitingRoomCubit>().onCardButtonClick();
              setState(() {
                _buttonClicked = true;
                _showCardLoud = true;
              });
            }
          : () {},
      color: (!_buttonClicked) ? Colors.white : ColorConstants.primaryBlue,
      textColor: !_buttonClicked ? ColorConstants.primaryBlue : Colors.white,
      filled: false,
      height: !_buttonClicked ? 62 : 48,
      width: !_buttonClicked ? 320 : 500,
      circular: !_buttonClicked ? 106 : 26,
      borderColor: !_buttonClicked
          ? const Color.fromARGB(255, 140, 163, 255)
          : ColorConstants.primaryBlue,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
