//
//  TestData.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import Foundation

class TestData {
    static let shared = TestData()

    let honeymoonTestData: [DestinationData] = [
        DestinationData(
          place: "Veligandu",
          country: "Maldives",
          image: "photo-veligandu-island-maldives"
        ),
        DestinationData(
          place: "Paris",
          country: "France",
          image: "photo-paris-france"
        ),
        DestinationData(
          place: "Athens",
          country: "Greece",
          image: "photo-athens-greece"
        ),
        DestinationData(
          place: "Dubai",
          country: "United Arab Emirates",
          image: "photo-dubai-emirates"
        ),
        DestinationData(
          place: "Grand Canyon",
          country: "United States of America",
          image: "photo-grandcanyon-usa"
        ),
        DestinationData(
          place: "Venice",
          country: "Italy",
          image: "photo-venice-italy"
        ),
        DestinationData(
          place: "Budapest",
          country: "Hungary",
          image: "photo-budapest-hungary"
        ),
        DestinationData(
          place: "High Tatras",
          country: "Poland",
          image: "photo-tatras-poland"
        ),
        DestinationData(
          place: "Lake Bled",
          country: "Slovenia",
          image: "photo-lakebled-slovenia"
        ),
        DestinationData(
          place: "Barcelona",
          country: "Spain",
          image: "photo-barcelona-spain"
        ),
        DestinationData(
          place: "San Francisco",
          country: "United States of America",
          image: "photo-sanfrancisco-usa"
        ),
        DestinationData(
          place: "Emerald Lake",
          country: "Canada",
          image: "photo-emaraldlake-canada"
        ),
        DestinationData(
          place: "Krabi",
          country: "Thailand",
          image: "photo-krabi-thailand"
        ),
        DestinationData(
          place: "Rome",
          country: "Italy",
          image: "photo-rome-italy"
        ),
        DestinationData(
          place: "Seoraksan",
          country: "South Korea",
          image: "photo-seoraksan-southkorea"
        ),
        DestinationData(
          place: "New York",
          country: "USA",
          image: "photo-newyork-usa"
        ),
        DestinationData(
          place: "Tulum",
          country: "Mexico",
          image: "photo-tulum-mexico"
        ),
        DestinationData(
          place: "London",
          country: "United Kingdom",
          image: "photo-london-uk"
        ),
        DestinationData(
          place: "Yosemite",
          country: "USA",
          image: "photo-yosemite-usa"
        ),
        DestinationData(
          place: "Rio de Janeiro",
          country: "Brazil",
          image: "photo-riodejaneiro-brazil"
        ),
        DestinationData(
          place: "Sydney",
          country: "Australia",
          image: "photo-sydney-australia"
        )
    ]

    var guidTestData: GuidDatas = [
        .init(title: "Like", subTitle: "Swipe right", description: "この目的地はお気に入りですか？画面をタッチして右にスワイプすると、お気に入りに保存されます。", image: "heart.circle"),
        .init(title: "Dismiss", subTitle: "Swipe left", description: "この場所をスキップしますか？画面に触れて左にスワイプすると、これ以降表示されなくなります。", image: "xmark.circle"),
        .init(title: "Book", subTitle: "Tap the button", description: "私たちの選ぶハネムーンリゾートは、新たな人生のスタートにふさわしい完璧な場所です。", image: "checkmark.square")
    ]
}
