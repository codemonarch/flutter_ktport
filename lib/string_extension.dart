import 'dart:convert';
import 'dart:io';
import 'package:ktflutter/list_extension.dart';
import 'package:ktflutter/pair_extension.dart';
import 'package:ktflutter/global_extension.dart';

class KFString {
    // common
    KFString(this._innerString);

    String _innerString;
    String toString() => _innerString;

    // origin
    Iterable<Match> allMatches(Object string, [int start = 0]) => _innerString.allMatches(string is String ? string : (string is KFString ? string._innerString : ""), start);
    Match matchAsPrefix(Object string, [int start = 0]) => _innerString.matchAsPrefix(string is String ? string : (string is KFString ? string._innerString : ""), start);
    KFString operator [](int index) => KFString(_innerString[index]);
    int codeUnitAt(int index) => _innerString.codeUnitAt(index);
    int get length => _innerString.length;
    int get hashCode => _innerString.hashCode;
    bool operator ==(Object other) => other is String ? _innerString == other : (other is KFString ? _innerString == other._innerString : false);
    int compareTo(Object other) => _innerString.compareTo(other is String ? other : (other is KFString ? other._innerString : ""));
    bool endsWith(Object other) => _innerString.endsWith(other is String ? other : (other is KFString ? other._innerString : ""));
    bool startsWith(Pattern pattern, [int index = 0]) => _innerString.startsWith(pattern, index);
    int indexOf(Pattern pattern, [int start]) => start == null ? _innerString.indexOf(pattern) : _innerString.indexOf(pattern, start);
    int lastIndexOf(Pattern pattern, [int start]) => start == null ? _innerString.lastIndexOf(pattern) : _innerString.lastIndexOf(pattern, start);
    bool get isEmpty => _innerString.isEmpty;
    bool get isNotEmpty => _innerString.isNotEmpty;
    KFString operator +(Object other) => KFString(_innerString + (other is String ? other : (other is KFString ? other._innerString : "")));
    KFString substring(int startIndex, [int endIndex]) => KFString(endIndex == null ? _innerString.substring(startIndex) : _innerString.substring(startIndex, endIndex));
    KFString trim() => KFString(_innerString.trim());
    KFString trimLeft() => KFString(_innerString.trimLeft());
    KFString trimRight() => KFString(_innerString.trimRight());
    KFString operator *(int times) => KFString(_innerString * times);
    KFString padLeft(int width, [Object padding = ' ']) => KFString(_innerString.padLeft(width, padding is String ? padding : (padding is KFString ? padding._innerString : "")));
    KFString padRight(int width, [Object padding = ' ']) => KFString(_innerString.padRight(width, padding is String ? padding : (padding is KFString ? padding._innerString : "")));
    bool contains(Pattern other, [int startIndex = 0]) => _innerString.contains(other, startIndex);
    KFString replaceFirst(Pattern from, Object to, [int startIndex = 0]) => KFString(_innerString.replaceFirst(from, to is String ? to : (to is KFString ? to._innerString : from), startIndex));
    KFString replaceFirstMapped(Pattern from, String replace(Match match), [int startIndex = 0]) => KFString(_innerString.replaceFirstMapped(from, replace, startIndex));
    KFString replaceAll(Pattern from, Object replace) => KFString(_innerString.replaceAll(from, replace is String ? replace : (replace is KFString ? replace._innerString : from)));
    KFString replaceAllMapped(Pattern from, String replace(Match match)) => KFString(_innerString.replaceAllMapped(from, replace));
    KFString replaceRange(int start, int end, Object replacement) => KFString(_innerString.replaceRange(start, end, replacement is String ? replacement : (replacement is KFString ? replacement._innerString : "")));
    KFList<KFString> split(Pattern pattern) => listOf(_innerString.split(pattern).map((it) => KFString(it)).toList());
    KFString splitMapJoin(Pattern pattern, {String onMatch(Match match), String onNonMatch(String nonMatch)}) => KFString(_innerString.splitMapJoin(pattern, onMatch: onMatch, onNonMatch: onNonMatch));
    KFList<int> get codeUnits => listOf(_innerString.codeUnits);
    Runes get runes => _innerString.runes;
    KFString toLowerCase() => KFString(_innerString.toLowerCase());
    KFString toUpperCase() => KFString(_innerString.toUpperCase());

    // kotlin
    KFString also(void block(KFString s)) {
        block(this);
        return this;
    }

    R let<R>(R block(KFString s)) => block(this);
    KFString takeIf(bool block(KFString s)) => block(this) ? this : null;
    KFString takeUnless(bool block(KFString s)) => !block(this) ? this : null;

    KFString substringBefore(Pattern pattern) => klet(indexOf(pattern), (idx) => idx == -1 ? this : substring(0, idx));
    KFString substringAfter(Pattern pattern) => klet(indexOf(pattern), (idx) => idx == -1 ? this : substring(idx + pattern.toString().length, length));
    KFString substringBeforeLast(Pattern pattern) => klet(lastIndexOf(pattern), (idx) => idx == -1 ? this : substring(0, idx));
    KFString substringAfterLast(Pattern pattern) => klet(lastIndexOf(pattern), (idx) => idx == -1 ? this : substring(idx + pattern.toString().length, length));
    KFString removeRange(int startIdx, int endIdx) {
        if (endIdx < startIdx) throw Exception("End index ($endIdx) is less than start index ($startIdx).");
        return endIdx == startIdx ? this : replaceRange(startIdx, endIdx, "");
    }

    KFString removePrefix(Pattern pattern) => startsWith(pattern) ? substring(pattern.toString().length, length) : this;
    KFString removeSuffix(Pattern pattern) => endsWith(pattern.toString()) ? substring(0, length - pattern.toString().length) : this;
    KFString removeSurrounding(Pattern pattern) => removePrefix(pattern).removeSuffix(pattern);
    KFString replaceBefore(Pattern pattern, Object replacement) => klet(indexOf(pattern), (idx) => idx == -1 ? this : replaceRange(0, idx, replacement));
    KFString replaceAfter(Pattern pattern, Object replacement) => klet(indexOf(pattern), (idx) => idx == -1 ? this : replaceRange(idx + pattern.toString().length, length, replacement));
    KFString replaceAfterLast(Pattern pattern, Object replacement) => klet(lastIndexOf(pattern), (idx) => idx == -1 ? this : replaceRange(idx + pattern.toString().length, length, replacement));
    KFString replaceBeforeLast(Pattern pattern, Object replacement) => klet(lastIndexOf(pattern), (idx) => idx == -1 ? this : replaceRange(0, idx, replacement));
    KFList<KFString> lines() => listOf(_innerString.split("\n").map((it) => KFString(it)).toList());
    KFString drop(int n) => substring(n);
    KFString dropLast(int n) => substring(0, length - n);
    KFString filter(bool block(KFString str)) {
        var ret = "";
        for (int i = 0; i < length; i++) {
            if (block(KFString(_innerString[i]))) ret += _innerString[i];
        }
        return KFString(ret);
    }

    KFString filterIndexed(bool block(int idx, KFString str)) {
        var ret = "";
        for (int i = 0; i < length; i++) {
            if (block(i, KFString(_innerString[i]))) ret += _innerString[i];
        }
        return KFString(ret);
    }

    KFString filterNot(bool block(KFString str)) {
        var ret = "";
        for (int i = 0; i < length; i++) {
            if (!block(KFString(_innerString[i]))) ret += _innerString[i];
        }
        return KFString(ret);
    }

    KFString reversed() {
        var ret = "";
        for (int i = 0; i < length; i++) {
            ret = _innerString[i] + ret;
        }
        return KFString(ret);
    }

    KFList<KFString> toList() {
        var ret = KFList<KFString>();
        for (int i = 0; i < length; i++) {
            ret.add(KFString(_innerString[i]));
        }
        return ret;
    }

    KFList<T> map<T>(T block(KFString s)) {
        var ret = KFList<T>();
        for (int i = 0; i < length; i++) {
            ret.add(block(KFString(_innerString[i])));
        }
        return ret;
    }

    KFList<T> mapIndexed<T>(T block(int idx, KFString s)) {
        var ret = KFList<T>();
        for (int i = 0; i < length; i++) {
            ret.add(block(i, KFString(_innerString[i])));
        }
        return ret;
    }

    forEach(void action(KFString s)) {
        for (int i = 0; i < length; i++) {
            action(KFString(_innerString[i]));
        }
    }

    forEachIndexed(void action(int idx, KFString s)) {
        for (int i = 0; i < length; i++) {
            action(i, KFString(_innerString[i]));
        }
    }

    KFString reduce(KFString oper(KFString acc, KFString s)) {
        var accumulator = KFString(_innerString[0]);
        for (int i = 1; i < length; i++) {
            accumulator = oper(accumulator, KFString(_innerString[i]));
        }
        return accumulator;
    }

    KFString reduceIndexed(KFString oper(int idx, KFString acc, KFString s)) {
        var accumulator = KFString(_innerString[0]);
        for (int i = 1; i < length; i++) {
            accumulator = oper(i, accumulator, KFString(_innerString[i]));
        }
        return accumulator;
    }

    int toInt() => int.parse(_innerString);
    double toDouble() => double.parse(_innerString);
    bool toBool() => _innerString.toLowerCase() == "true";

    // ktor
    // base64encode
    KFString base64Encode() => stringOf(base64.encode(utf8.encode(_innerString)));

    // base64decode
    KFString base64decode() => stringOf(utf8.decode(base64.decode(_innerString)));

    // toByteArray
    KFList<int> toIntList() => map((it) => it.codeUnitAt(0));

    // swift
    KFString lastPathComponent() => substringAfterLast("/");
    KFString getPathDirectory() => klet(substringBeforeLast("/"), (it) => it == "" ? "/" : it);

    // rarnu
    KFString toJsonEncoded() => replaceAll("\\", "\\\\").replaceAll("\n", "\\n").replaceAll("\"", "\\\"");
    KFString toTitleUpperCase() => substring(0, 1).toUpperCase() + substring(1);
    KFString appendPathPart(Object part) {
        var ret = _innerString;
        if (!ret.endsWith("/")) ret += "/";
        ret += part is String ? part : (part is KFString ? part._innerString : "");
        return KFString(ret);
    }

    KFString extension() => klet(indexOf("."), (idx) => idx == -1 ? "" : substringAfterLast("."));
    KFString replaceTag(String tag, KFString block()) => replaceAll(tag, block());
    KFString skipEmptyLine() => lines().filterNot((it) => it.trim() == stringOf("")).joinToString("\n");
    KFPair<KFString, KFString> toPair() => split("=").map((it) => it.trim()).let((it) => KFPair(it[0], it[1]));
    save(File f) => f.writeAsStringSync(_innerString);
    File asFileWriteText(Object s) {
        klet(Directory(substringBeforeLast("/")._innerString), (dfile) {
            if (!dfile.existsSync()) dfile.createSync(recursive: true);
        });
        return kalso(File(_innerString), (ffile) => ffile.writeAsStringSync(s is String ? s : (s is KFString ? s._innerString : "")));
    }

    KFString asFileReadText() => klet(File(_innerString), (ffile) => KFString(ffile.existsSync() ? ffile.readAsStringSync() : ""));
    asFileMkdirs() => klet(Directory(_innerString), (dir) {
        if (!dir.existsSync()) dir.createSync(recursive: true);
    });
    File asFile() => File(_innerString);
}

KFString stringOf(String str) => KFString(str);
