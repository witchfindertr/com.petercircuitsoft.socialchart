import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:socialchart/models/model_user_insightcard.dart';

class LinkPreview extends StatelessWidget {
  const LinkPreview({
    super.key,
    required this.linkPreviewData,
    this.setImageSize,
    this.tapCallback,
  });
  final LinkPreviewData? linkPreviewData;
  final void Function(int, int)? setImageSize;
  final VoidCallback? tapCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback ?? () => {},
      child: SizedBox(
        width: double.infinity,
        child: linkPreviewData?.image != null
            ? CachedNetworkImage(
                imageUrl: linkPreviewData!.image!,
                width: 50,
                height: linkPreviewData?.size_x == null
                    ? null
                    : (linkPreviewData!.size_x! > 800)
                        ? MediaQuery.of(context).size.height * 0.25 + 60
                        : MediaQuery.of(context).size.width * 0.2,
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
                      if (!snapshot.hasData) {
                        if (setImageSize != null) setImageSize!(0, 0);
                        return SizedBox();
                      }
                      ui.Image image = snapshot.data!;
                      if (setImageSize != null) {
                        setImageSize!(image.width, image.height);
                      }
                      if (image.width > 800) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image(
                              image: imageProvider,
                              height: MediaQuery.of(context).size.height * 0.25,
                              fit: BoxFit.fitWidth,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              linkPreviewData?.title ?? "No title",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            Expanded(
                              child: Text(
                                linkPreviewData?.description ??
                                    "No description",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          children: [
                            Image(
                                image: imageProvider,
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width * 0.2),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      linkPreviewData?.title ?? "No title",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          linkPreviewData?.description ??
                                              "No description",
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

                      return SizedBox();
                    },
                  );
                },
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        linkPreviewData?.title ?? "미리보기가 없습니다.",
                        style: Theme.of(context).textTheme.headline6?.merge(
                            linkPreviewData?.title == null
                                ? Theme.of(context).textTheme.bodyText2
                                : null),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            linkPreviewData?.description ??
                                linkPreviewData?.url ??
                                "No URL: Something wrong!",
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
