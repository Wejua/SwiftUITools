//
//  CustomAlert.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/26.
//

import SwiftUI

public struct CustomAlert: View {
    @Binding var isPresent: Bool
    var agree: () -> Void
    var disagree: () -> Void
    
    public init(isPresent: Binding<Bool>, agree: @escaping () -> Void, disagree: @escaping () -> Void) {
        self._isPresent = isPresent
        self.agree = agree
        self.disagree = disagree
    }
    
    public var body: some View {
        let transition = AnyTransition.scale(scale: 1.2).combined(with: .opacity).animation(.easeOut(duration: 0.15))
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Text("隐私小弹窗")
                    .padding(.top, 20)
                    .bold()
                    .padding([.leading, .trailing], 20)
                Text("用户协议和隐私政策概要\n感谢您使用我的小组件！为保障您的权利，请您在使用我们的服务前通过[《用户协议》](https://dy.yiqiyouwan.cn/imgs/yyxy.html)和[《隐私政策》](https://dy.yiqiyouwan.cn/imgs/ysxy.html)了解我们对于个人信息的使用情况和您享有的相关权利。我们将严格按照上述文件标准执行为您提供服务。\n您可以通过阅读完整版[《用户协议》](https://dy.yiqiyouwan.cn/imgs/yyxy.html)和][《隐私政策》](https://dy.yiqiyouwan.cn/imgs/ysxy.html)了解详细情况。\n如您同意，请您点击“同意”开始接受我们的服务。")
                    .font(.caption)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .padding([.leading, .trailing], 20)
                Divider()
                HStack (spacing: 0) {
                    Button {
                        isPresent.toggle()
                        agree()
                    } label: {
                        ZStack {
                            Rectangle().fill(Color(red: 38.0/255.0, green: 38.0/255.0, blue: 38.0/255.0))
                                .frame(width: 120, height: 40)
                            Text("同意")
                        }
                    }
                    Divider()
                    Button {
                        isPresent.toggle()
                        disagree()
                    } label: {
                        ZStack {
                            Rectangle().fill(Color(red: 38.0/255.0, green: 38.0/255.0, blue: 38.0/255.0))
                                .frame(width: 120, height: 40)
                            Text("不同意")
                        }
                    }
                }
                .frame(height: 40)
            }
            .background((Color(red: 38.0/255.0, green: 38.0/255.0, blue: 38.0/255.0)))
            .cornerRadius(14, corners: .allCorners)
            Spacer()
        }
        .frame(width: 280)
        .transition(transition)
    }
}

public extension View {
    @ViewBuilder func customAlert(isPresent: Binding<Bool>, content: () -> CustomAlert) -> some View {
        ZStack {
            self
            content()
                .ifdo(!isPresent.wrappedValue, transform: { alert in
                    alert.hidden()
                })
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isPresent: .constant(true), agree: {}, disagree: {})
    }
}
