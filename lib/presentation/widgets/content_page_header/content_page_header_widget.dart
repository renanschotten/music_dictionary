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
  final ScrollController scrollController = ScrollController();
  late final ContentPageBloc bloc;
  int previousIndex = 0;
  double currentPosition = 0;

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
        controller: scrollController,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bloc.content.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            previousIndex = bloc.selectedContentIndex.value;
            updateScrollPosition(index);
            bloc.updateSelectedChord(index);
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: Align(
              alignment: Alignment.center,
              child: ValueListenableBuilder<int>(
                valueListenable: bloc.selectedContentIndex,
                builder: (_, selectedContentIndex, __) => Text(
                  bloc.content[index].name,
                  style: index == selectedContentIndex
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

  void updateScrollPosition(int index) {
    if (index > previousIndex &&
        (currentPosition + 20) < scrollController.position.maxScrollExtent) {
      scrollController
          .jumpTo(currentPosition += (20 * (index - previousIndex)));
    } else if (index < previousIndex &&
        currentPosition > scrollController.position.minScrollExtent) {
      scrollController.jumpTo(currentPosition -= 20 * (previousIndex - index));
    }
  }
}
