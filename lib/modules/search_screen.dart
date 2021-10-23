import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  type: TextInputType.text ,
                  prefix: Icon(Icons.search),
                  controller: searchController,
                  lable: 'Search',
                  validator: (String? value) {
                    if(value == ''){
                      return 'Search must not be empty';
                    }else
                      return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },

    );
  }
}
