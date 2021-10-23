import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image: DecorationImage(

                image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Text(

                  '${article['title']}',

                  style: Theme.of(context).textTheme.bodyText1,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child:   Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey,
  ),
);

Widget articleBuilder(list, {isSearch = false}) =>
    list.length > 0 ?
    ListView.separated(
  itemBuilder: (context, index)=> buildArticleItem(list[index],context),
  separatorBuilder: (context, index)=> myDivider(),
  itemCount: 10,
  physics: BouncingScrollPhysics(),
) :
    isSearch? Container() : Center(child: CircularProgressIndicator());

Widget defaultFormField ({
  required String lable,
  required TextInputType type,
  required TextEditingController controller,
  required Icon prefix,
  required String? Function(String?)? validator,
  bool isClickable = true,
  bool isPassword = false,
  Icon? suffix,
  void Function()? suffixOnPress,
  void Function()? onTap,
  void Function(String)? onChange,
  void Function(String)? onSubmit,

}) => TextFormField(
  enabled: isClickable,
  onTap: onTap,
  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  keyboardType: type,
  controller: controller ,
  obscureText: isPassword,
  validator: validator,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white70,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: prefix,
    suffixIcon: suffix!=null ? IconButton(onPressed: suffixOnPress, icon: suffix): null,
    labelText: lable,

  ),
);

void navigateTo (context, widget) => Navigator.push(
    context,
  MaterialPageRoute(
      builder: (context)=> widget ,
  ),

);