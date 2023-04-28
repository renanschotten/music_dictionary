import 'package:flutter/material.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class ContentPageHeaderWidget extends StatefulWidget {
  const ContentPageHeaderWidget({super.key});

  @override
  State<ContentPageHeaderWidget> createState() =>
      _ContentPageHeaderWidgetState();
}

class _ContentPageHeaderWidgetState extends State<ContentPageHeaderWidget> {
  late final ContentPageBloc bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = getIt<ContentPageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        separatorBuilder: (_, __) => SizedBox(width: 8),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bloc.chords.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            bloc.updateSelectedChord(index);
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: Align(
              alignment: Alignment.center,
              child: ValueListenableBuilder<int>(
                valueListenable: bloc.selectedChordIndex,
                builder: (_, selectedChordIndex, __) => Text(
                  bloc.chords[index].name,
                  style: index == selectedChordIndex
                      ? AppTextStyles.montserrat24w900
                      : AppTextStyles.montserrat16w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
