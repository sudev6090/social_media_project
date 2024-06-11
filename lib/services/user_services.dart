import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/models/usersmodel.dart';
import 'package:social_media/services/auth_service.dart';

class UserService {
  static Future<List<UsersModel>> fetchAllUsers() async {
    Dio dio = Dio();
    final response =
        await dio.get('https://socialmedia-api-v1.onrender.com/user');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => UsersModel.fromJson(json)).toList();
    } else {
      throw Exception('Unable to load data');
    }
  }

  Future<void> followUser(BuildContext context, String id) async {
    final loggeduser = await AuthService().getLoggedUser(context);

    final loggedId = loggeduser!.id;

    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('Token');
    final data = {"_id": id};
    try {
      final response = await dio.put(
          'https://socialmedia-api-v1.onrender.com/user/$loggedId/follow',
          data: jsonEncode(data),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        log('followed');
      } else {
        log('unable to follow');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> unFollowUser(BuildContext context, String id) async {
    final loggeduser = await AuthService().getLoggedUser(context);

    final loggedId = loggeduser!.id;

    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('Token');
    final data = {"_id": id};
    try {
      final response = await dio.put(
          'https://socialmedia-api-v1.onrender.com/user/$loggedId/unfollow',
          data: jsonEncode(data),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        log('Unfollowed');
      } else {
        log('unable to unfollow');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
