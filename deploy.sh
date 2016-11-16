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
rm -Rf $pkgDirectory
for generatedDir in ${generatedDirs[@]}; do
    frameworkDirs=`find $generatedDir -type d`
    for frameworkDir in $frameworkDirs; do
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
            echo  "generate $frameworkDir/$packagename-import.go"
            echo "//go:binary-only-package\n\npackage $packagename" > "$frameworkDir/$packagename-import.go"
        else
            cd -
        fi

    done
done
