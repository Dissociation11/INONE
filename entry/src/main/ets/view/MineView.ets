import { CommonConstants as Common } from '../commons/constants/CommonConstants'
import { Spacer } from '../component/Spacer';
import { MineItem, MineItemMode } from '../model/MineModel';
import viewModel, {MineViewModel} from '../viewmodel/MineViewModel'
import userViewModel, { UserViewModel} from '../viewmodel/UserViewModel'
import { Prompt, router } from '@kit.ArkUI';
import PreferenceUtil from '../commons/utils/preferenceUtil'
import { PreferenceConstant } from '../commons/constants/PreferenceConstant'


@Component
export struct MineView{

  @State viewModel: MineViewModel = viewModel
  @StorageLink("UserViewModel") userViewModel:UserViewModel  = userViewModel
  @StorageLink("isDark") isDark: boolean = false

  aboutToAppear(): void {

    this.userViewModel.initViewModel()

  }

  //空行
  @Builder Spacer(){

    //空行
    Spacer({spaceHeight : Common.SPACE_PERCENT , spaceWidth : Common.FULL_PERCENT})

  }

  @Builder TopBar(){

    Column(){

      Row(){

        Image(this.isDark ? $r('app.media.light_mode') :$r("app.media.dark_mode"))
          .size({height : Common.FULL_PERCENT})

        Text(this.isDark ? "明亮模式" : "夜间模式")
          .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
          .fontSize(20)
          .onClick(() => {
            this.isDark = !this.isDark
            PreferenceUtil.putPreferenceValue(PreferenceConstant.IS_DARK,this.isDark)
          })

        Spacer({spaceWidth : Common.SPACE_PERCENT})

      }.alignSelf(ItemAlign.End)

    }.size({height : Common.SPACE_PERCENT, width : Common.FULL_PERCENT})

  }

  //登录用户简要信息栏
  @Builder UserInfoBarBuilder(){

    Row() {

      Spacer({spaceHeight : Common.FULL_PERCENT , spaceWidth : "7%"})


      Image(this.userViewModel.isLogin ? "http://10.33.34.177:8800/ImgLib/c3f36b77-6e56-4465-b3bc-e0445c38530c.jpg" : $r("app.media.user_not_login")).size({ height: "85%" })
        .borderRadius(90)

      Spacer({spaceHeight : Common.FULL_PERCENT , spaceWidth : Common.SPACE_PERCENT})

      Column() {
        Text(this.userViewModel.isLogin ? this.userViewModel.currentUser?.userName : $r("app.string.NotLogin")).fontSize(28)
          .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
        Text(this.userViewModel.isLogin ? $r("app.string.ClickTOInformation") : $r("app.string.ClickToLogin")).fontSize(20)
          .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
      }.size({height : "65%"})
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)

    }.size({height : "15%", width : Common.FULL_PERCENT})
    .onClick(() => {
      if(this.userViewModel.isLogin){
        this.viewModel.toInformation()
      }else{
        this.viewModel.toLogin()
      }
    })

  }

  //中部信息栏
  @Builder MidBar(){

    Row(){

      Text("关注")
        .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
        .onClick(() => {
          Prompt.showToast({ message: '暂未开放功能' })
        })

      Line().size({height : 30, width : 1})
        .backgroundColor(Color.Black)

      Text("收藏")
        .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
        .onClick(() => {
        Prompt.showToast({ message: '暂未开放功能' })
      })

    }.size({width : "90%"})
    .justifyContent(FlexAlign.SpaceEvenly)

  }

  //信息提示栏
  @Builder tipsBar(message : Resource){
    Column(){
      this.Spacer()
      Row(){
        Spacer({spaceWidth : Common.SPACE_PERCENT})
        Text(message).fontSize(24)
          .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))
      }
    }.size({width : Common.FULL_PERCENT})
    .alignItems(HorizontalAlign.Start)
  }

  //推荐服务
  @Builder MineMainItem(item : MineItem){

    GridItem(){

      Column(){

        Spacer({spaceHeight : "2%"})

        Image(item.icon).size({height : Common.SPACE_PERCENT})

        Text(item.name).fontSize(16)
          .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))

      }.onClick(() => {
        Prompt.showToast({ message: '暂未开放功能' })
      })

    }

  }

  //更多服务
  @Builder MineMoreItem(item : MineItem){

    ListItem(){

      Column(){

        Spacer({spaceHeight : "2%" , spaceWidth : Common.FULL_PERCENT})

        Row(){

          Row(){

            Image(item.icon)
              .size({ height : "90%"})

            Spacer({spaceHeight : Common.FULL_PERCENT , spaceWidth : Common.SPACE_PERCENT})

            Text(item.name).fontSize(20)
              .fontColor(this.isDark ? $r('app.color.DARK_FONT') : $r('app.color.DEFAULT_FONT'))

          }.size({height : Common.FULL_PERCENT})

          Image($r("app.media.right"))
            .size({ height : "80%"})

        }.size({ height : "6%" , width : "88%"})
        .justifyContent(FlexAlign.SpaceBetween)

      }.size({ width : Common.FULL_PERCENT})
      .onClick(() => {
        if(item.mode == MineItemMode.Setting)
        {
          router.pushUrl({
            url: 'pages/SettingPage'
          })
        }else{
          Prompt.showToast({ message: '暂未开放功能' })
        }
      })
    }
  }

  build() {

    Column(){

      //顶部栏
      this.TopBar()

      //用户简要信息栏
      this.UserInfoBarBuilder()

      this.Spacer()

      //关注收藏信息
      this.MidBar()

      List(){

        ListItem(){
          this.tipsBar($r("app.string.MainItem"))
        }

        //推荐服务信息
        ListItem(){
          Grid(){
            ForEach(this.viewModel.MineMainItemList, (item : MineItem) => {
              this.MineMainItem(item)
            })
          }.size({width : Common.FULL_PERCENT})
          .columnsTemplate("1fr 1fr 1fr 1fr")
        }

        ListItem(){
          this.tipsBar($r("app.string.MoreItem"))
        }

        //更多服务信息
        ForEach(this.viewModel.MineMoreItemList, (item : MineItem) => {
          this.MineMoreItem(item)
        })

      }.size({ width : Common.FULL_PERCENT})

    }.size({ height : Common.FULL_PERCENT,
      width : Common.FULL_PERCENT })
    .backgroundColor(this.isDark ? $r('app.color.main_background_color_dark'): $r("app.color.mine_backgroun_color"))

  }
}