class WordressModel {
  int? id;
  Title? title;
  Content? content;
  Excerpt? excerpt;

  WordressModel({
    this.title,
    this.excerpt,
    this.content,
  });

  WordressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = Title.fromJson(json['title']);
    content = Content.fromJson(json['content']);
    excerpt = Excerpt.fromJson(json['excerpt']);
  }
}

class Title {
  String? rendered;
  Title({
    this.rendered,
  });

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }
  @override
  String toString() {
    return removeAllHtmlTags(rendered.toString());
  }
}

class Content {
  String? rendered;
  Content({
    this.rendered,
  });

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }
  @override
  String toString() {
    return removeAllHtmlTags(rendered.toString());
  }
}

class Excerpt {
  String? rendered;
  Excerpt({
    this.rendered,
  });

  Excerpt.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }
  @override
  String toString() {
    return removeAllHtmlTags(rendered.toString());
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
