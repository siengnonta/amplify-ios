//
// Copyright 2018-2019 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

import Amplify

class MockHubCategoryPlugin: MessageReporter, HubCategoryPlugin {
    func listen(to channel: HubChannel?,
                filteringWith filter: @escaping HubFilter,
                onEvent: @escaping HubListener) -> UnsubscribeToken {
        return UUID()
    }

    var key: String {
        return "MockHubCategoryPlugin"
    }

    func configure(using configuration: Any) throws {
        notify()
    }

    func reset(onComplete: @escaping (() -> Void)) {
        notify("reset")
        onComplete()
    }

    func dispatch(to channel: HubChannel, payload: HubPayload) {
        notify()
    }

    func listen(to channel: HubChannel,
                filteringWith filter: @escaping HubFilter,
                onEvent: @escaping HubListener) -> UnsubscribeToken {
        notify()
        return UUID()
    }

    func removeListener(_ token: UnsubscribeToken) {
        notify()
    }
}

class MockSecondHubCategoryPlugin: MockHubCategoryPlugin {
    override var key: String {
        return "MockSecondHubCategoryPlugin"
    }
}

final class MockHubCategoryPluginSelector: MessageReporter, HubPluginSelector {
    func listen(to channel: HubChannel?,
                filteringWith filter: @escaping HubFilter,
                onEvent: @escaping HubListener) -> UnsubscribeToken {
        return UUID()
    }

    var selectedPluginKey: PluginKey? = "MockHubCategoryPlugin"

    func dispatch(to channel: HubChannel, payload: HubPayload) {
        notify()
    }

    func listen(to channel: HubChannel,
                filteringWith filter: @escaping HubFilter,
                onEvent: @escaping HubListener) -> UnsubscribeToken {
        notify()
        return UUID()
    }

    func removeListener(_ token: UnsubscribeToken) {
        notify()
    }
}

class MockHubPluginSelectorFactory: MessageReporter, PluginSelectorFactory {
    var categoryType = CategoryType.hub

    func makeSelector() -> PluginSelector {
        notify()
        return MockHubCategoryPluginSelector()
    }

    func add(plugin: Plugin) {
        notify()
    }

    func removePlugin(for key: PluginKey) {
        notify()
    }

}
