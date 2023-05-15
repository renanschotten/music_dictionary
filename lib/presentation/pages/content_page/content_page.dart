import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/domain/entities/home_page_content.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/presentation/widgets/content_page_header/content_page_header_widget.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';
import 'package:music_dictionary/presentation/widgets/content_page_details/content_page_details_widget.dart';
import 'package:music_dictionary/shared/core/ads/ad_controller.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key, required this.homePageContent})
      : super(key: key);

  final HomePageContent homePageContent;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late final ContentPageBloc bloc = getIt<ContentPageBloc>();
  late final AdController adController = getIt<AdController>();

  @override
  void initState() {
    super.initState();
    adController.initBanner();
    bloc.add(FetchContentPageEvent(id: widget.homePageContent.id));
  }

  @override
  void dispose() {
    adController.banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: widget.homePageContent.name),
        body: Column(
          children: [
            ValueListenableBuilder<BannerAd?>(
              valueListenable: adController.banner,
              builder: (context, banner, child) {
                if (banner != null) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: banner.size.width.toDouble(),
                      height: banner.size.height.toDouble(),
                      child: AdWidget(ad: banner),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            BlocBuilder<ContentPageBloc, ContentPageState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is ContentPageLoading) {
                  return Expanded(child: LoadingWidget());
                } else if (state is ContentPageFailure) {
                  return ErrorPageWidget(
                    onTapButton: () => bloc.add(
                      FetchContentPageEvent(id: widget.homePageContent.id),
                    ),
                  );
                } else if (state is ContentPageSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: const [
                        ContentPageHeaderWidget(),
                        SizedBox(height: 24),
                        ContentPageDetailsWidget()
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
