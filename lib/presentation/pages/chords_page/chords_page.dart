import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/presentation/pages/chords_page/bloc/chords_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class ChordsPage extends StatefulWidget {
  const ChordsPage({Key? key}) : super(key: key);

  @override
  State<ChordsPage> createState() => _ChordsPageState();
}

class _ChordsPageState extends State<ChordsPage> {
  late final ChordsPageBloc bloc;
  int selectedChord = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<ChordsPageBloc>(context);
    bloc.add(FetchChordsPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Acordes'),
        body: BlocBuilder<ChordsPageBloc, ChordsPageState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ChordsPageLoading) {
              return LoadingWidget();
            } else if (state is ChordsPageFailure) {
              return ErrorPageWidget(
                onTapButton: () => bloc.add(
                  FetchChordsPageEvent(),
                ),
              );
            } else if (state is ChordsPageSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.response.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          selectedChord = index;
                          setState(() {});
                        },
                        child: SizedBox(
                          //color: Colors.amber,
                          width: 48,
                          height: 48,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              state.response[index].name,
                              style: index == selectedChord
                                  ? AppTextStyles.montserrat24w900
                                  : AppTextStyles.montserrat16w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ContentDetailWidget(
                    chord: state.response[selectedChord],
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class ContentDetailWidget extends StatelessWidget {
  const ContentDetailWidget({
    super.key,
    required this.chord,
  });

  final Chord chord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.memory(base64Decode(chord.images.first)),
          SizedBox(height: 16.0),
          Text(
            chord.description,
            style: AppTextStyles.montserrat16w500,
          ),
        ],
      ),
    );
  }
}
