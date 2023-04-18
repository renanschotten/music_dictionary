import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_dictionary/presentation/pages/chords_page/bloc/chords_page_bloc.dart';
import 'package:music_dictionary/presentation/widgets/error/error_page_widget.dart';
import 'package:music_dictionary/presentation/widgets/loading/loading_widget.dart';
import 'package:music_dictionary/shared/config/routes.dart';

class ChordsPage extends StatefulWidget {
  const ChordsPage({Key? key}) : super(key: key);

  @override
  State<ChordsPage> createState() => _ChordsPageState();
}

class _ChordsPageState extends State<ChordsPage> {
  late final ChordsPageBloc bloc;

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
        appBar: AppBar(
          title: Text('Acordes'),
        ),
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
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Text(state.response[index].name),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    try {
                      Navigator.pushNamed(
                        context,
                        Routes.chordDetails,
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
      ),
    );
  }
}
