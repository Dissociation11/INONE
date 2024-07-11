export interface User{

  //在本地持久层数据库中的ID
  id : number

  //用户名
  userName: string

  //密码
  passWord: string

  //用户昵称
  name: string

  //手机号
  phone: string

  //用户权限
  role: number

}