// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_dictionary/app/di/injection_container.dart';

import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/list_tile/custom_list_tile.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';
import 'package:music_dictionary/shared/config/routes.dart';
import 'package:music_dictionary/shared/core/ads/ad_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageBloc bloc = getIt<HomePageBloc>();
  late final AdController adController = getIt<AdController>();

  @override
  void initState() {
    super.initState();
    adController.initBanner();
    bloc.add(FetchHomePageEvent());
  }

  @override
  void dispose() {
    adController.banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Dicionário Musical'),
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
            BlocBuilder<HomePageBloc, HomePageState>(
              bloc: getIt<HomePageBloc>(),
              builder: (context, state) {
                if (state is HomePageLoading) {
                  return Expanded(child: LoadingWidget());
                } else if (state is HomePageFailure) {
                  return ErrorPageWidget(
                    onTapButton: () => bloc.add(
                      FetchHomePageEvent(),
                    ),
                  );
                } else if (state is HomePageSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.response.length,
                    itemBuilder: (context, index) => CustomListTile(
                      title: state.response[index].name,
                      onTap: () {
                        try {
                          Navigator.pushNamed(
                            context,
                            Routes.contentDetails,
                            arguments: state.response[index],
                          );
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rota nao encontrada'),
                            ),
                          );
                        }
                      },
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
