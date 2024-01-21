import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_it/core/common/view/page_under_construction.dart';
import 'package:learn_it/core/extensions/context_extensions.dart';
import 'package:learn_it/core/services/injection_container.dart';
import 'package:learn_it/src/auth/data/model/user_model.dart';
import 'package:learn_it/src/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:learn_it/src/auth/presentation/views/sign_in_screen.dart';
import 'package:learn_it/src/auth/presentation/views/sign_up_screen.dart';
import 'package:learn_it/src/dashboard/presentation/views/dashboard.dart';
import 'package:learn_it/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:learn_it/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:learn_it/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
