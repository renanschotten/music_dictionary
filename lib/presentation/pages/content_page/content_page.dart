import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/presentation/widgets/content_page_header/content_page_header_widget.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';
import 'package:music_dictionary/presentation/widgets/content_page_details/content_page_details_widget.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late final ContentPageBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<ContentPageBloc>(context);
    bloc.add(FetchContentPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Acordes'),
        body: BlocBuilder<ContentPageBloc, ContentPageState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ContentPageLoading) {
              return LoadingWidget();
            } else if (state is ContentPageFailure) {
              return ErrorPageWidget(
                onTapButton: () => bloc.add(
                  FetchContentPageEvent(),
                ),
              );
            } else if (state is ContentPageSuccess) {
              return Column(
                children: const [
                  ContentPageHeaderWidget(),
                  SizedBox(height: 24),
                  ContentPageDetailsWidget()
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
