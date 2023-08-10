#!/bin/bash
echo "-----请输入签名相关信息------"

# 获取密钥库文件名

read -p "请输入密钥库文件名(storeFile 后缀名已设定为.jks):" keyfileName
while [ ! $keyfileName ]
	do read -p "文件名不能为空，请输入密钥库文件名:" keyfileName
done
# if [[ ! $keyfileName ]]; then
# 	read -p "文件名不能为空，请输入密钥库文件名:" keyfileName
# fi

# 获取别名
read -p "请输入别名(keyAlias):" keyalias
while [ ! $keyalias ]
	do read -p "别名不能为空，请输入别名:" keyalias
done
# if [[ ! $keyalias ]]; then
# 	read -p "别名不能为空，请输入别名:" keyalias
# fi

# 获取密钥库密码
read -p "请输入密钥库密码(storePassword至少必须为6个字符):" storepass
while [[ ! $storepass ]]
	do read -p "密钥库密码不能为空，请输入密钥库密码:" storepass
done

# echo "storepass is : ${#storepass}"
while [[ ${#storepass} -lt 6 ]]
	# echo "storepass is : ${#storepass} in while"
 	do read -p "密钥库口令至少必须为6个字符,请重新输入:" storepass
done
# if [[ ! $storepass ]]; then
# 	read -p "密钥库密码不能为空，请输入密钥库密码:" storepass
# fi
# if [[ ${#storepass} < 6 ]];then
# 	read -p "密钥口令至少必须为 6 个字符,请重新输入:" storepass
# fi

# 获取密钥口令
read -p "请输入密钥密码(keyPassword与storePassword保持一致):" keypass
while [[ ! $keypass ]]
	do read -p "密钥密码不能为空，请输入密钥密码:" keypass
done
while [[ ${#keypass} -lt 6 ]]
 	do read -p "密钥口令至少必须为6个字符,请重新输入:" keypass
done
# while [[ ! $keypass = $storepass ]]
# 	do read -p "密钥密码与密钥库密码不一致，请重新输入密钥密码:" keypass
# done

# if [[ ! $keypass ]]; then
# 	read -p "密钥密码不能为空，请输入密钥密码:" keypass
# fi	
# if [[ ! $keypass = $storepass ]]; then
# 	read -p "密钥密码与密钥库密码不一致，请重新输入密钥密码:" keypass
# fi

read -p "请输入有效期(单位:天):" validity
read -p "请输入密钥长度(jks至少是512,缺省为2048):" keysize
read -p "请输入加密算法(RSA/DSA/...,缺省为RSA):"  algorithm 
read -p "请输入密钥库类型(缺省storetype为pkcs12):" storetype


if [[ ! $validity ]]; then
	validity=36500
	echo "默认有效期天数为36500天"
fi
if [[ ! $keysize ]]; then
	keysize=2048
	echo "默认keysize 为 2048"
fi
if [[ ! $algorithm ]]; then
	algorithm=RSA
	echo "默认algorithm 为 RSA"
fi
if [[ ! $storetype ]]; then
	storetype=pkcs12
	echo "默认storetype为pkcs12"
fi
echo '文件名:'$keyfileName';别名:'$keyalias';密钥库口令:'$storepass';密钥口令:'$keypass
# echo keytool -genkey -v -alias $keyalias -keystore $keyfileName'.jks' -keypass $keypass -storepass $storepass -validity $validity -keysize $keysize -keyalg $algorithm -storetype $storetype

echo "-----请输入签名者您的相关信息-------"
read -p "您的名字与形式是什么:" cn
read -p "您的组织单位名称是什么:" ou
read -p "您的组织名称是什么:" o
read -p "您所在的城市或区域名称是什么:" l
read -p "您所在的省/市/自治区名称是什么:" st
read -p "该单位的双字母国家/地区代码是什么:" c

echo "-----请确认你所输入的信息:"
echo "CN=$cn, OU=$ou, O=$o, L=$l, ST=$st, C=$c"
read -p "请确认:" confirm
if [[ !confirm ]];then
	confirm=y
fi

cur_dir=$(pwd)
keyinfo_fie="${cur_dir}/${keyfileName}密钥信息.yaml"

# 利用管道 |  或者 重定向输入 < 
echo -e "$cn\n$ou\n$o\n$l\n$st\n$c\n$confirm" | keytool -genkey -v -alias $keyalias -keystore './'$keyfileName'.jks' -keypass $keypass -storepass $storepass -validity $validity -keysize $keysize -keyalg $algorithm -storetype $storetype
echo "#######生成密钥库及密钥文件#######\n#                      #\n#         genrateing      #\n，文件路径:${pwd}/${keyfileName}.jks"

echo "storeFile:$keyfileName\n\nkeyAlias:$keyalias\n\nstorepass:$storepass\n\nkeypass:$keypass
\n\n==================\n\n有效期:$validity" > $keyinfo_fie
echo "输出密钥信息备份文件,文件路径:$keyinfo_fie"
