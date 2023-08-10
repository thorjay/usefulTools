#!/bin/bash
#利用apksigner对apk签名
echo -n "请输入秘钥文件的路径(keyfilepath):"
read keypath
echo -n "请输入秘钥文件的别名(keyalias):"
read keyalias
echo -n "请输入秘钥文件密码(storepassword):"
read -s storepassword
echo -n "请输入秘钥密码(keypassword):"
read -s keypassword
echo -n "请输入需要签名的文件路径(unsignedapk path):"
read unsignedapk
echo -n "请输入签名后的文件存放路径(signedapk path):"
read signedapk
result="`apksigner sign --ks $keypath --ks-key-alias $keyalias --ks-pass pass:$storepassword --key-pass pass:$keypassword --out $signedapk $unsignedapk`" && echo $result 
if [ ！$result ]; then 
verifyResult="`apksigner verify -v $signedapk`" && echo $verifyResult
fi
