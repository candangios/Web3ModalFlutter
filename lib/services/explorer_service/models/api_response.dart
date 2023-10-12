import 'dart:convert';

// TODO this should be placed somewhere else
class ApiResponse {
  final int count;
  final List<Listing> data;

  ApiResponse({required this.count, required this.data});

  ApiResponse copyWith({int? count, List<Listing>? data}) => ApiResponse(
        count: count ?? this.count,
        data: data ?? this.data,
      );

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        count: json['count'],
        data: List<Listing>.from(json['data'].map((x) => Listing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Listing {
  final String id;
  final String name;
  final String homepage;
  final String imageId;
  final int order;
  final String? mobileLink;
  final String? desktopLink;
  final String? webappLink;
  final String? appStore;
  final String? playStore;
  final String? rdns;
  final List<Injected>? injected;

  Listing({
    required this.id,
    required this.name,
    required this.homepage,
    required this.imageId,
    required this.order,
    this.mobileLink,
    this.desktopLink,
    this.webappLink,
    this.appStore,
    this.playStore,
    this.rdns,
    this.injected,
  });

  Listing copyWith({
    String? id,
    String? name,
    String? homepage,
    String? imageId,
    int? order,
    String? mobileLink,
    String? desktopLink,
    String? webappLink,
    String? appStore,
    String? playStore,
    String? rdns,
    List<Injected>? injected,
  }) =>
      Listing(
        id: id ?? this.id,
        name: name ?? this.name,
        homepage: homepage ?? this.homepage,
        imageId: imageId ?? this.imageId,
        order: order ?? this.order,
        mobileLink: mobileLink ?? this.mobileLink,
        desktopLink: desktopLink ?? this.desktopLink,
        webappLink: webappLink ?? this.webappLink,
        appStore: appStore ?? this.appStore,
        playStore: playStore ?? this.playStore,
        rdns: rdns ?? this.rdns,
        injected: injected ?? this.injected,
      );

  factory Listing.fromRawJson(String str) => Listing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        id: json['id'],
        name: json['name'],
        homepage: json['homepage'],
        imageId: json['image_id'],
        order: json['order'],
        mobileLink: json['mobile_link'],
        desktopLink: json['desktop_link'],
        webappLink: json['webapp_link'],
        appStore: json['app_store'],
        playStore: json['play_store'],
        rdns: json['rdns'],
        injected: json['injected'] == null
            ? []
            : List<Injected>.from(
                json['injected']!.map((x) => Injected.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'homepage': homepage,
        'image_id': imageId,
        'order': order,
        'mobile_link': mobileLink,
        'desktop_link': desktopLink,
        'webapp_link': webappLink,
        'app_store': appStore,
        'play_store': playStore,
        'rdns': rdns,
        'injected': injected == null
            ? []
            : List<dynamic>.from(injected!.map((x) => x.toJson())),
      };
}

class Injected {
  final String namespace;
  final String injectedId;

  Injected({required this.namespace, required this.injectedId});

  Injected copyWith({String? namespace, String? injectedId}) => Injected(
        namespace: namespace ?? this.namespace,
        injectedId: injectedId ?? this.injectedId,
      );

  factory Injected.fromRawJson(String str) =>
      Injected.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Injected.fromJson(Map<String, dynamic> json) => Injected(
        namespace: json['namespace'],
        injectedId: json['injected_id'],
      );

  Map<String, dynamic> toJson() => {
        'namespace': namespace,
        'injected_id': injectedId,
      };
}

class RequestParams {
  final int page; // eg. 1
  final int entries; // eg. 100
  final String? search; // eg. MetaMa...
  final String? include; // eg. id1,id2,id3
  final String? exclude; // eg. id1,id2,id3
  final String? platform; // 'ios' | 'android'

  const RequestParams({
    required this.page,
    required this.entries,
    this.search,
    this.include,
    this.exclude,
    this.platform,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {
      'page': page.toString(),
      'entries': entries.toString(),
    };
    if ((search ?? '').isNotEmpty) {
      params['search'] = search;
    }
    if ((include ?? '').isNotEmpty) {
      params['include'] = include;
    }
    if ((exclude ?? '').isNotEmpty) {
      params['exclude'] = exclude;
    }
    if ((platform ?? '').isNotEmpty) {
      params['platform'] = platform;
    }

    return params;
  }

  RequestParams copyWith({
    int? page,
    int? entries,
    String? search,
    String? include,
    String? exclude,
    String? platform,
  }) =>
      RequestParams(
        page: page ?? this.page,
        entries: entries ?? this.entries,
        search: search ?? this.search,
        include: include ?? this.include,
        exclude: exclude ?? this.exclude,
        platform: platform ?? this.platform,
      );

  RequestParams nextPage() => RequestParams(
        page: page + 1,
        entries: entries,
        search: search,
        include: include,
        exclude: exclude,
        platform: platform,
      );
}
