import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TLinkPreview extends StatelessWidget {
  const TLinkPreview({
    super.key,
    required this.imageUrl,
    required this.title,
    this.description,
    this.tapCallback,
    required this.url,
  });
  final String? imageUrl;
  final String? title;
  final String? description;
  final VoidCallback? tapCallback;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback ?? () => {},
      child: SizedBox(
        // width: double.infinity,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: 50,
                height: MediaQuery.of(context).size.height * 0.2,
                imageBuilder: (context, imageProvider) {
                  Completer<ui.Image> completer = Completer<ui.Image>();
                  imageProvider.resolve(const ImageConfiguration()).addListener(
                      ImageStreamListener((ImageInfo info, bool _) {
                    // to prevent completer complete multiple times.
                    if (completer.isCompleted == false) {
                      completer.complete(info.image);
                    }
                  }));
                  return FutureBuilder<ui.Image>(
                    future: completer.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ui.Image image = snapshot.data!;
                        if (image.width > 800) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image(
                                image: imageProvider,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.fitWidth,
                              ),
                              Text(
                                title!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                description ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ],
                          );
                        }
                        return SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: Row(
                            children: [
                              Image(
                                  image: imageProvider,
                                  fit: BoxFit.fitHeight,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            description ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  );
                },
              )
            : SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title ?? "미리보기가 없습니다.",
                        style: Theme.of(context).textTheme.headline6?.merge(
                            title == null
                                ? Theme.of(context).textTheme.bodyText2
                                : null),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            description ?? url,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
