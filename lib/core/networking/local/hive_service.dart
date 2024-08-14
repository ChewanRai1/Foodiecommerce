import 'package:flaviourfleet/app/constants/hive_table_constant.dart';
import 'package:flaviourfleet/features/auth/data/model/auth_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(BatchHiveModelAdapter());
    // Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // // ======================== Batch Queries ========================
  // Future<void> addBatch(BatchHiveModel batch) async {
  //   var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
  //   await box.put(batch.batchId, batch);
  // }

  // Future<List<BatchHiveModel>> getAllBatches() async {
  //   var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
  //   var batches = box.values.toList();
  //   return batches;
  // }

  // // ======================== Course Queries ========================
  // Future<void> addCourse(CourseHiveModel course) async {
  //   var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
  //   await box.put(course.courseId, course);
  // }

  // Future<List<CourseHiveModel>> getAllCourses() async {
  //   var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
  //   var courses = box.values.toList();
  //   box.close();
  //   return courses;
  // }
  //=================User Queries===========
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  // Future<List<AuthHiveModel>> getAllUsers() async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
  //   var users = box.values.toList();
  //   box.close();
  //   return users;
  // }

  //Login
  Future<AuthHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }
}
