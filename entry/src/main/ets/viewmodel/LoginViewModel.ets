import  router  from '@ohos.router';
import Prompt from '@system.prompt';
import { resourceManager } from '@kit.LocalizationKit';

export class LoginViewModel{
  username: string = ''
  password: string = ''
  isSelected: boolean = false

  clickRegister(){
    router.pushUrl({
      url:'pages/RegisterPage'
    })
  }

  clickLogin(){
    if(!this.isSelected){
      Prompt.showToast({message: '请勾选用户协议和隐私政策'})
      return
    }
    if(this.username === "" && this.password === "") {
      router.replaceUrl({
        url: 'pages/Transition',
        params: {
          username: this.username,
          password: this.password
        }
      })
    } else {
      Prompt.showToast({message:"账号或密码错误！"})
    }
  }

  forgetPassword(){
    Prompt.showToast({message:"我也不知道！"})
  }

}