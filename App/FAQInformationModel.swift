//
//  InformationModel.swift
//  Cami
//
//  Created by Guillaume Coquard on 09/02/24.
//

import Foundation

class FAQInformationModel {

    static let shared: FAQInformationModel = .init()

    // swiftlint:disable line_length
    public let list: [FAQInformation] = [
        .init(title: "Why does Cami request full access to Calendars?", description: "iOS requires applications to either request access to calendars in order to be able to edit events OR read and edit events. We need to read every events from every calendars, hence the request for \"Full Access\"."),
        .init(title: "Why does Cami request access to Contacts?", description: "Cami presents by default the next birthday from your contacts in the top right corner of the widget, therefore Cami needs to access your contacts. If you disable contact access, next birthday won't be displayed."),
        .init(title: "Why does my widget content seem outdated?", description: "Cami relies completely on iOS features and mechanisms. According to documentation provided by Apple, a widget can be updated every five minutes at most. If you want to force the update of your actual widgets, you just have to open the app and close it right after. This automatically refreshes widgets. If it does not work, you can try long pressing the \"Everything is fine.\" green box on the welcome screen of Cami and then tap on \"Refresh widgets\".")
    ]
    // swiftlint:enable line_length

    private init() {}
}
