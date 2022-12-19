import 'package:flutter/foundation.dart';

import '_service.dart';

Future<void> runService() async {
  late Service service;
  if (kDebugMode) {
    service = const DevelopmentService();
  } else {
    service = const ProductionService();
  }
  await service._initialize();

  LocaleService.instance().getLocale();
  await ClientService.instance().handle(const GetClient());
}

abstract class Service {
  const Service();

  Future<void> _initialize();
}

class DevelopmentService extends Service {
  const DevelopmentService();
  @override
  Future<void> _initialize() async {
    RepositoryService.development();
    await IsarService.developement();
    await HiveService.developement();
    await FirebaseService.development();
  }
}

class ProductionService extends Service {
  const ProductionService();

  @override
  Future<void> _initialize() async {
    RepositoryService.production();
    await IsarService.production();
    await HiveService.production();
    await FirebaseService.production();
  }
}
