// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/app/di/injection_container.dart';

import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/list_tile/custom_list_tile.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = getIt<HomePageBloc>();
    bloc.add(FetchHomePageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Dicionário Musical'),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          bloc: getIt<HomePageBloc>(),
          builder: (context, state) {
            if (state is HomePageLoading) {
              return LoadingWidget();
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
                        state.response[index].path,
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
      ),
    );
  }
}
