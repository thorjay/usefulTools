#!/bin/bash

read -p "请输入groupId:" dgroupId
read -p "请输入actifactId:" dartifactId
read -p "请输入packging,例如jar|aar:" dpackaging
read -p "请输入版本号:" dversion
read -p "请输入上传文件路径:" dfile
read -p "请输入上传的仓库地址:" durl

if [[ ! $dgroupId ]]; then
	read -p "请输入groupId:" dgroupId
fi

if [[ ! $dartifactId ]];then
	read -p "请输入actifactId:" dartifactId
fi

if [[ ! $dpackaging ]];then
	read -p "请输入packging,例如jar|aar:" dpackaging
fi

if [[ ! $dversion ]];then
	read -p "请输入版本号:" dversion
fi

if [[ ! $dfile ]]; then
	read -p "请输入上传文件路径:" dfile
fi

if [[ ! $durl ]]; then
	read -p "请输入上传的仓库地址:" durl
fi

echo $dgroupId" "$dartifactId" "$dpackaging" "$dversion" "$dfile" "$durl

mvn deploy:deploy-file -Dfile=$dfile -Durl=$durl -Dpackaging=$dpackaging -DgroupId=$dgroupId -DartifactId=$dartifactId -Dversion=$dversion -DrepositoryId=ipu-mobile-deploy
