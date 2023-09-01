import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/meet_model.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class MeetApiService {
  Future<Either<Failure, List<MeetModel>>> list();
  Future<Either<Failure, void>> delete(MeetModel meet);
}

class MeetApiServiceImpl implements MeetApiService {
  final HttpService httpService;

  MeetApiServiceImpl({required this.httpService});

  @override
  Future<Either<Failure, List<MeetModel>>> list() async {
    final result = await httpService.request(path: "/meet", method: "GET");

    return result.fold((failure) => Left(AppFailure("Cannot load meets")),
        (response) {
      List<MeetModel> meets = [];
      meets = response.data
          .map<MeetModel>((data) => MeetModel.fromJson(data))
          .toList();
      return Right(meets);
    });
  }

  @override
  Future<Either<Failure, void>> delete(MeetModel meet) async {
    final result =
        await httpService.request(path: "/meet/${meet.id}", method: "DELETE");

    return result.fold((l) => Left(AppFailure("Cannot delete meet")),
        (r) => const Right(null));
  }
}
