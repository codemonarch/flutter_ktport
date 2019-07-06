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
                Map<String, String> postParam,
                Map<String, String> fileParam,
                Map<String, String> headers,
                int timeout=15}) async {
    assert(url.isNotEmpty);
    Uri uri = Uri.parse(_buildUrl(url, _buildQueryStr(param)));

    try {
        HttpClient client = HttpClient();
        client.connectionTimeout = Duration(seconds: timeout); 

        HttpClientRequest request = await _buildRequest(client, uri, method);

        _assembleRequest(request, mimeType, headers, body, postParam, fileParam);
        
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
                {Map<String, String> param,
                String body,
                Map<String, String> headers}) async {
    return http(url, 
            HttpMethod.POST,
            param: param,
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

void _assembleRequest(HttpClientRequest request, [String mimeType, Map<String, String> headers, String body, Map<String, String> param, Map<String, String> file]) {
    if (request == null) {
        return;
    }

    // assemble headers
    if (headers != null) {
        headers.forEach((k, v) {
            request.headers.add(k, v);
        });
    }

    // assemble body
    if (body != null) {
        request.headers.contentType = ContentType.parse(mimeType);
        request.write(body);
    } else {
        if (file != null) { // upload file
            const BOUNDARY_STR = "--";
            const RANDOM_ID_STR = "_hjreq_";
            
            request.headers.contentType = ContentType.parse('multipart/form-data; boundary=$RANDOM_ID_STR');

            if (param != null) {
                param.forEach((k, v) {
                    request.write('$BOUNDARY_STR$RANDOM_ID_STR\r\n');
                    request.write('Content-Disposition:form-data; name=\"$k\"\r\n\r\n');
                    request.write('$v\r\n');
                });
            }
            file.forEach((uploadId, uploadFile) {
                request.write('$BOUNDARY_STR$RANDOM_ID_STR\r\n');
                File file = File(uploadFile);
                String filename = uploadFile.split(new RegExp(r"[/|\\]")).last;
                request.write('Content-Disposition: form-data; name=\"$uploadId\"; filename=\"$filename\"\r\nContent-Type: application/octet-stream\r\n\r\n');
                request.write(file.readAsBytesSync());
                request.write('\r\n');
            });
            request.write('$BOUNDARY_STR$RANDOM_ID_STR$BOUNDARY_STR\r\n');
        } else if (param != null) { // param transform k1=v1&k2=v2&...
            param.forEach((k, v) {
                request.write('$k=$v&');
            });
        }
    }
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