#! /bin/bash
generatedDirs=("myframework")
projectName=("golang-binary-package-generator")

goversion=`go version`
echo $goversion
IFS='  ' read -ra array <<< $goversion
pkgSystemName="${array[@]: -1:1}"
pkgSystemName=`echo "$pkgSystemName" | tr / _`
echo $pkgSystemName

pkgDirectory=$GOPATH/pkg/$pkgSystemName/$projectName
echo $pkgDirectory
fakeGoPackagesPath=fakeGoPackages/$projectName
rm -Rf $fakeGoPackagesPath
rm -Rf $pkgDirectory
mkdir -p $fakeGoPackagesPath
for generatedDir in ${generatedDirs[@]}; do
    frameworkDirs=`find $generatedDir -type d`
    for frameworkDir in $frameworkDirs; do

        mkdir -p $fakeGoPackagesPath/$frameworkDir


        #generate .a files
        echo "generate $frameworkDir.a"
        echo "CDIN $frameworkDir"
        cd $frameworkDir
        go build -i -o $pkgDirectory/$frameworkDir.a

        if [ $? -eq 0 ]; then
            cd -
            #generate .go files
            IFS='/ ' read -ra array <<< $frameworkDir
            packagename="${array[@]: -1:1}"
            echo  "generate $fakeGoPackagesPath/$frameworkDir/$packagename.go"
            echo -e "//go:binary-only-package\n\npackage $packagename" > "$fakeGoPackagesPath/$frameworkDir/$packagename.go"
        else
            cd -
        fi

    done
done
