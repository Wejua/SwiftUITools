//
//  CustomTabView.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/15.
//

import SwiftUI

public enum TabType: CaseIterable, Hashable {
    case chatRoom, rooms, messages, mine
    
    func textColor(selectedItem: TabType) -> Color {
        if self == selectedItem {
            return "#FCCC46".color!
        } else {
            return .white
        }
    }
   
    func imageName(selectedItem: TabType) -> String {
        switch self {
        case .chatRoom:
            return selectedItem == .chatRoom ? "tabHome_selected" : "tab_home"
        case .rooms:
            return selectedItem == .rooms ? "tab_rooms_selected" : "tabRoomType"
        case .messages:
            return selectedItem == .messages ? "tabbar_xiaoxi_selected" : "tabMessage"
        case .mine:
            return selectedItem == .mine ? "tab_mine_selected" : "tabMine"
        }
    }
    
    var title: String {
        switch self {
        case .chatRoom:
            return "聊天室"
        case .rooms:
            return "分类"
        case .messages:
            return "消息"
        case .mine:
            return "我的"
        }
    }
}

public struct TabItemsPreferenceKey: PreferenceKey {
    public static var defaultValue: [TabType] = []
    
    public static func reduce(value: inout [TabType], nextValue: () -> [TabType]) {
        value.append(contentsOf: nextValue())
    }
}

//struct TabBarItemModifier: ViewModifier {
//    let item: TabType
//    @Binding var currentItem: TabType
//
//    func body(content: Content) -> some View {
//        if currentItem == item {
//            content
//        } else {
//            EmptyView()
//        }
//    }
//}

public extension View {
    @ViewBuilder func tabBarItem(item: TabType, currentItem: Binding<TabType>) -> some View {
        self
            .opacity(item == currentItem.wrappedValue ? 1.0 : 0.0)
            .preference(key: TabItemsPreferenceKey.self, value: [item])
    }
}

public struct CustomTabView<T: View>: View {
    @Binding public var selectedItem: TabType
    @ViewBuilder public var content: () -> T
    @State public var items: [TabType] = []
    
    public init(selectedItem: Binding<TabType>, @ViewBuilder content: @escaping () -> T) {
        _selectedItem = selectedItem
        self.content = content
    }
    
    public var body: some View {
        GeometryReader{ geo in
            let tabHeight = 53.0
            ZStack(alignment: .bottom) {
                content()
                "#191527".color!
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                    .ignoresSafeArea()
                    .frame(height: tabHeight)
                    .overlay(alignment: .top) {
                        HStack(spacing: 0) {
                            ForEach(items, id: \.title) { item in
                                itemView(item: item)
                                    .frame(width: geo.size.width/CGFloat(items.count))
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                            }
                        }
                        .padding(.top, 5)
                    }
            }
            .onPreferenceChange(TabItemsPreferenceKey.self) { items in
                self.items = items
            }
        }
    }
    
    private func itemView(item: TabType) -> some View {
        VStack(spacing: 0) {
            Image(item.imageName(selectedItem: selectedItem))
                .resizable().aspectRatio(contentMode: .fit)
                .frame(height: 32)
            Text(item.title)
                .foregroundColor(item.textColor(selectedItem: selectedItem))
                .frame(height: 16)
                .font(name: selectedItem == item ? .PingFangSCSemibold : .PingFangSCRegular, size: 11)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    @State static var currentItem: TabType = .chatRoom
    static var previews: some View {
        CustomTabView(selectedItem: $currentItem) {
            Rectangle().fill(.red)
                .tabBarItem(item: .chatRoom, currentItem: $currentItem)
            Rectangle().fill(.cyan)
                .tabBarItem(item: .rooms, currentItem: $currentItem)
            Rectangle().fill(.blue)
                .tabBarItem(item: .messages, currentItem: $currentItem)
            Rectangle().fill(.pink)
                .tabBarItem(item: .mine, currentItem: $currentItem)
        }
    }
}
