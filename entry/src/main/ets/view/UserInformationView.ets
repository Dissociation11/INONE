import { Prompt, router } from '@kit.ArkUI'
import { Spacer } from '../component/Spacer'
import userViewModel, { UserViewModel} from '../viewmodel/UserViewModel'

@Component
export struct UserInformationView {
  @StorageLink("UserViewModel") userViewModel: UserViewModel = userViewModel
  title: string = '个人信息'

  build() {

    Column() {
      Column() {
        // 导航栏
        Row({ space: 20 }) {
          Image($r('app.media.back_white')).width(24)
            .onClick(() => {
              router.back()
            })
          Text(this.title).fontSize(18).fontColor($r('app.color.DARK_FONT'))
          Text()
        }.width('100%').height(50).padding({ left: 15, right: 15 }).justifyContent(FlexAlign.SpaceBetween)

        // 头像
        Column() {
          Image($r('app.media.user_not_login'))
            .objectFit(ImageFit.Fill).width(60).height(60).borderRadius(30)
            .onClick(() => {
              Prompt.showToast({ message: '暂未开放功能' })
            })
          Text('点击头像修改').fontSize(12).fontColor($r('app.color.DARK_FONT')).margin({ top: 8 })
        }.margin({ top: 20 })
      }.width('100%').height(170).backgroundColor($r('app.color.INFORMATION_IMAGE_COLOR'))

      // 表单
      Column() {

        Spacer({spaceHeight: '2%'})

        // 表单内容
        Row() {
          Spacer({ spaceWidth: '8%' })
          Row(){
            Text('昵称：')
              .fontSize(20)
              .fontColor($r('app.color.DEFAULT_FONT'))
          }.size({width: "25%"})
          Spacer({spaceWidth: '4%'})
          Text(this.userViewModel.currentUser?.name).fontSize(20)
        }.size({width: '100%'})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Divider().margin({ top: 10, bottom: 10 }).opacity(0.5)

        Row() {
          Spacer({ spaceWidth: '8%' })
          Row(){
            Text('用户名：')
              .fontSize(20)
              .fontColor($r('app.color.DEFAULT_FONT'))
          }.size({width: "25%"})
          Spacer({spaceWidth: '4%'})
          Text(this.userViewModel.currentUser?.userName).fontSize(20)
        }.size({width: '100%'})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Divider().margin({ top: 10, bottom: 10 }).opacity(0.5)

        Row() {
          Spacer({ spaceWidth: '8%' })
          Row(){
            Text('手机号：')
              .fontSize(20)
              .fontColor($r('app.color.DEFAULT_FONT'))
          }.size({width: "25%"})
          Spacer({spaceWidth: '4%'})
          Text(this.userViewModel.currentUser?.phone).fontSize(20)
        }.size({width: '100%'})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Divider().margin({ top: 10, bottom: 10 }).opacity(0.5)

      }.width('100%').layoutWeight(1).padding({ left: 20, right: 20 }).backgroundColor($r('app.color.main_background_color'))

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background_color'))
  }
}