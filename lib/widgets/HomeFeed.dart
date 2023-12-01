import 'package:flutter/material.dart';
import 'package:se_project/widgets/postwidget.dart';

import '../classes/comment.dart';

class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Row(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                // addRepaintBoundaries: ,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                  PostWidget(
                    description:
                        "some description long aodjnqokwdnoqkwdoqknwdoqnwodknqowkdnqowd ja sdkj qkwdj kwk ajsdkqj wdkj  ajdnqwjdn ajwdd k",
                    key: key,
                    id: "1",
                    title: "DataScience",
                    upvotes: 10,
                    author: "Mubashir",
                    comments: [
                      Comment(
                          author: "Mubashir", authorid: "1", text: "Some text")
                    ],
                    text: 'smth',
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
