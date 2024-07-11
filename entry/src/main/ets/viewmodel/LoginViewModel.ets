import  router  from '@ohos.router';
import Prompt from '@system.prompt';

export class LoginViewModel{
  username: string = ''
  password: string = ''
  isSelected: boolean = false

  clickRegister(){
    router.pushUrl({
      url: 'pages/RegisterPage'
    })
  }

  async clickLogin(){
    if(!this.isSelected){
      Prompt.showToast({message: '请勾选用户协议和隐私政策'})
      return false
    }
    if(this.username == ''){
      Prompt.showToast({message: '用户名不可为空'})
      return false
    }else if(this.password == ''){
      Prompt.showToast({message: '密码不可为空'})
      return false
    }
    return true
  }

  forgetPassword(){
    Prompt.showToast({message:"我也不知道！"})
  }

}