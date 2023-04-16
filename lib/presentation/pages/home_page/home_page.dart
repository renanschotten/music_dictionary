import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/presentation/pages/home_page/bloc/home_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
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
    bloc = BlocProvider.of<HomePageBloc>(context);
    bloc.add(FetchHomePageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(title: Text('Folha de Dicas Musicais')),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          bloc: BlocProvider.of<HomePageBloc>(context),
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
                itemBuilder: (context, index) => ListTile(
                  leading: Text(state.response[index].name),
                  trailing: Icon(Icons.arrow_right),
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
