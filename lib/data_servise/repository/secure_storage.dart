import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const USER_TOKEN = 'USER_TOKEN';
const FCM_TOKEN = 'FCM_TOKEN';
const ONBORD_DONE = 'ONBORD_DONE';
const USER_ID = 'USER_ID';
const NOTIFY_TIME = 'NOTIFY_TIME';
const STATUS = 'STATUS';
const ATTEMPT = 'ATTEMPT';

abstract class SecureStorageManager {
  Future<void> saveUserToken(String userToken);

  Future<String> getUserToken();

  Future<void> saveFcmToken(String fcmToken);

  Future<String> getFcmToken();

  Future<void> saveStatus(String status);

  Future<String> getStatus();

  Future<void> saveIsOnbordingDone(String isOnbordingDone);

  Future<String> getIsOnbordingDone();

  Future<void> saveUserId(String id);

  Future<String> getUserId();

  Future<void> saveAttemptId(String id);

  Future<String> getAttemptId();

  Future<void> saveNotifyTime(String notifyTime);

  Future<String> getNotifyTime();

  static SecureStorageManager of(BuildContext context) =>
      RepositoryProvider.of(context);
}

class SecureStorageManagerImpl extends SecureStorageManager {
  final FlutterSecureStorage storage;

  SecureStorageManagerImpl(this.storage);

  @override
  Future<String> getUserToken() async {
    return await storage.read(key: USER_TOKEN) ?? '';
  }

  @override
  Future<void> saveUserToken(String userToken) async {
    await storage.write(key: USER_TOKEN, value: userToken);
    print("userTokenInStorage--->$userToken");
  }

  @override
  Future<String> getFcmToken() async {
    return await storage.read(key: FCM_TOKEN) ?? '';
  }

  @override
  Future<void> saveFcmToken(String fcmToken) async {
    await storage.write(key: FCM_TOKEN, value: fcmToken);
    print("FCM-TokenIS$fcmToken");
  }

  @override
  Future<String> getStatus() async {
    return await storage.read(key: STATUS) ?? '';
  }

  @override
  Future<void> saveStatus(String status) async {
    await storage.write(key: STATUS, value: status);
    print("statusIS$status");
  }

  @override
  Future<void> saveIsOnbordingDone(String isOnbordingDone) async {
    await storage.write(key: ONBORD_DONE, value: isOnbordingDone);
    print("isOnbordingDone$isOnbordingDone");
  }

  @override
  Future<String> getIsOnbordingDone() async {
    return await storage.read(key: ONBORD_DONE) ?? '';
  }

  @override
  Future<String> getUserId() async {
    return await storage.read(key: USER_ID) ?? '';
  }

  @override
  Future<void> saveUserId(String id) async {
    await storage.write(key: USER_ID, value: id);
  }

// AttemptId

  @override
  Future<String> getAttemptId() async {
    return await storage.read(key: ATTEMPT) ?? '';
  }

  @override
  Future<void> saveAttemptId(String attemptId) async {
    await storage.write(key: ATTEMPT, value: attemptId);
  }

  @override
  Future<String> getNotifyTime() async {
    return await storage.read(key: NOTIFY_TIME) ?? '';
  }

  @override
  Future<void> saveNotifyTime(String notifyTime) async {
    await storage.write(key: NOTIFY_TIME, value: notifyTime);
  }
}
