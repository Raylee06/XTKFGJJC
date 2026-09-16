# Issue

环境：Ubuntu 20.04，Python 3.8.10，greetlab-24030021037 0.1.0
复现：sdt-greet --name "   "
期望：退出码 2，无输出
实际：输出 Hello,    !，退出码 0
待确认：空字符串是否同样处理

# 提交信息

标题：修复 sdt-greet 对空白名称未报错的问题
正文：main() 未校验 --name，空白字符仍输出问候语。现增加 isspace() 判断，空白或空字符串统一以退出码 2 结束。

# 评审意见

Blocking：cli.py 缺少空白校验，缺陷可复现。建议加入 isspace() 判断并补充测试。
Suggestion：补充空字符串用例，避免回归。
Nit：退出码 2 建议在文档中说明含义。
