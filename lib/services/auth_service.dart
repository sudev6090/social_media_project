// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/models/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:social_media/utils/snackbar_helper.dart';

class AuthService {
  Dio dio = Dio();
  Future<AuthModel?> signUp(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'https://socialmedia-api-v1.onrender.com/auth/register',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 201) {
        log('account created');

        successMessage(context, message: 'Account Created Successfully');
        final jsonData = AuthModel.fromJson(response.data);
        return jsonData;
      }
    } catch (e) {
      errorMessage(context, message: 'Unable to create Account');
      throw Exception(e);
    }
    return null;
  }

  Future<String> login(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'https://socialmedia-api-v1.onrender.com/auth/login',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 200) {
        successMessage(context, message: 'Login successfully');
        log('login success');
        final jsonData = response.data as Map<String, dynamic>;
        String token = jsonData['token'];
        String status = jsonData['status'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('Token', token);
        pref.setString('Status', status);
        return status;
      } else {
        errorMessage(context, message: 'User not Found');
        throw Exception('user not found ${response.statusCode}');
      }
    } catch (e) {
      errorMessage(context, message: 'Unable to login something went wrong');
      throw Exception('Something went wrong $e');
    }
  }

  Future<void> changePassword(BuildContext context, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('Token');
    final data = {'password': password};
    try {
      final response = await dio.post(
          'https://socialmedia-api-v1.onrender.com/auth/changepassword',
          data: jsonEncode(data),
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        successMessage(context, message: 'Password Changed');
        log('password changed');
      } else {
        errorMessage(context, message: 'Unable to change password');
        print('password change failed${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel?> getLoggedUser(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('Token');
      final response = await dio.get(
        'https://socialmedia-api-v1.onrender.com/auth/loggeduser',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = UserModel.fromJson(response.data);
        return jsonData;
      } else {
        errorMessage(context, message: 'failed to Login');
        throw Exception('Failed to get logged-in user: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage(context, message: 'something went wrong');
      throw Exception('Something went wrong: $e');
    }
  }
}
