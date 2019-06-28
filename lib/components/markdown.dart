import 'package:markdown/markdown.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

markdownWidget(String text) {
  return parse(markdownToHtml(text, inlineSyntaxes: [new InlineHtmlSyntax()]));;
  //return HtmlView(
  //    data: markdownToHtml(text, inlineSyntaxes: [new InlineHtmlSyntax()]));
}
