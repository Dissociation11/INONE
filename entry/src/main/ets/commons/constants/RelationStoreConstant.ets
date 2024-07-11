
export class RelationStoreConstant{

  //关系型数据库名
  static readonly RELATION_STORE_NAME = 'INONEDatabase'

  //关系型数据库安全等级
  static readonly RELATION_STORE_SECURITY_LEVEL = 1;

  //用户表名
  static readonly USER_TABLE_NAME = 'USER'

  //整数类型
  static readonly  INTEGER_CLASS = 'INTEGER'

  //文本类型
  static readonly TEXT_CLASS = 'TEXT'

  //主键约束
  static readonly PRIMARY_KEY = 'PRIMARY KEY AUTOINCREMENT'

  //非空约束
  static readonly NOT_NULL = 'NOT NULL'

  //ID字段
  static readonly ID = 'ID'

  //username字段
  static readonly USERNAME = 'USERNAME'

  //password字段
  static readonly PASSWORD = 'PASSWORD'

  //name字段
  static readonly NAME = 'NAME'

  //url字段
  static readonly URL = 'URL'

  //phone字段
  static readonly PHONE = 'PHONE'

  //role字段
  static readonly ROLE = 'ROLE'

  //建表SQL语句
  static readonly CREATE_TABLE_SQL = 'CREATE TABLE IF NOT EXISTS ' + ' '+ this.USER_TABLE_NAME + ' (' +
    this.ID + ' ' + this.INTEGER_CLASS + ' ' + this.PRIMARY_KEY + ',' +
    this.USERNAME + ' ' + this.TEXT_CLASS + ' ' + this.NOT_NULL + ',' +
    this.PASSWORD + ' ' + this.TEXT_CLASS + ' ' + this.NOT_NULL + ',' +
    this.NAME + ' ' + this.TEXT_CLASS + ' ' + this.NOT_NULL + ',' +
    this.URL + ' ' + this.TEXT_CLASS + ',' +
    this.PHONE + ' ' + this.TEXT_CLASS + ' ' + this.NOT_NULL + ',' +
    this.ROLE + ' ' + this.INTEGER_CLASS + ' ' + this.NOT_NULL + ')'

}