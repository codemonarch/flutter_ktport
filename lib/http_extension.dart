/* TODO: wangwang's task

    a) need a HTTP client for request, response with parameters, files, headers, etc. @link https://github.com/codemonarch/kotlin-monarch/blob/master/kt-common-jvm/src/main/kotlin/HttpUtil.kt
    b) need a download tool for get file from url. @link https://github.com/codemonarch/kotlin-monarch/blob/master/kt-common-jvm/src/main/kotlin/DownloadUtils.kt

 */
import 'dart:async';
import 'dart:convert';
import 'dart:io';

enum HttpMethod { GET, HEAD, POST, PUT, DELETE }

// http response
class HttpResponse {
    final int status;
    final String body;

    HttpResponse(this.status, this.body);

    @override
    String toString() {
        return "$status, $body";
    }
}

// http error, etc. timeout, 503
class HttpError extends Error {
    int code;
    String message;
    HttpError([this.code, this.message]);

    @override
    String toString() {
        return "$code, $message";
    }
}

// common http 
Future<HttpResponse> http(String url, 
                HttpMethod method, 
                {Map<String, String> param,
                String mimeType='application/json',
                String body,
                Map<String, String> file,
                Map<String, String> headers,
                int timeout=15}) async {
    assert(url.isNotEmpty);
    Uri uri = Uri.parse(_buildUrl(url, _buildQueryStr(param)));

    try {
        HttpClient client = HttpClient();
        client.connectionTimeout = Duration(seconds: timeout); 

        HttpClientRequest request = await _buildRequest(client, uri, method);
        // assemble headers
        if (headers != null) {
            headers.forEach((k, v) {
                request.headers.add(k, v);
            });
        }
        // assemble body
        if (body != null) {
            request.headers.add(HttpHeaders.contentTypeHeader, mimeType);
            request.write(body);
        }
        HttpClientResponse response = await request.close();
        String result = await response.transform(utf8.decoder).join();
        return HttpResponse(response.statusCode, result);
    } on Error catch (error) {
        throw HttpError(-1, error.toString());
    } on Exception catch (exception) {
        throw HttpError(-1, exception.toString());
    }
}

// GET
Future<HttpResponse> httpGet(String url, 
                {Map<String, String> param,
                Map<String, String> headers}) async {
    return http(url, HttpMethod.GET,
            param: param,
            headers: headers);
}

// POST
Future<HttpResponse> httpPost(String url, 
                {String body,
                Map<String, String> headers}) async {
    return http(url, 
            HttpMethod.POST,
            body: body,
            headers: headers);
}

// build HttpClientRequest
Future<HttpClientRequest> _buildRequest(HttpClient client, Uri uri, HttpMethod method) async {
    Future<HttpClientRequest> request;
    switch(method) {
        case HttpMethod.GET:
            request = client.getUrl(uri);
            break;
        case HttpMethod.POST:
            request = client.postUrl(uri);
            break;
        case HttpMethod.PUT:
            request = client.putUrl(uri);
            break;
        case HttpMethod.DELETE:
            request = client.deleteUrl(uri);
            break;
        case HttpMethod.HEAD:
            request = client.headUrl(uri);
            break;
    }
    return request;
}

// concat url and query
String _buildUrl(String url, String query) {
    if (query == null || query.isEmpty) {
        return url;
    }
    if (url.contains("?")) {
        return '$url&$query';
    } else {
        return '$url?$query';
    }
}

// map to query string
String _buildQueryStr(Map<String, String> params) {
    if (params == null) {
        return null;
    }
    final queryList = <String>[];
    params.forEach((key, name) => queryList.add('$key=$name'));
    return queryList.join('&');
}