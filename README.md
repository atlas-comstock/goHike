# golang-binary-package-generator
A script of Go1.7 binary package generator, with a detail example.

# How to use it
1. Specify generatedDirs and projectName(which should be the deploy.sh 's parent directory name) in deploy.sh. Pay attention ! For projectName (which you want to use your binary package) you have to indicate all the projectName where you want to , for example `github.com/yonghaowu/myProject`.
2. Execute ```$  ./deploy.sh```
3. Delete your framework implementation (source code of your binary package) and move fakeGoPackagesPath 's fake go files to implementation's position.
4. Pack the .a files for your clients, which should be in $GOPATH/pkg/YourProjectName.

# Reference
* http://yonghaowu.github.io/2016/11/09/GolangBinaryPackage/
* https://tip.golang.org/pkg/go/build/#hdr-Binary_Only_Packages
* https://github.com/tcnksm/go-binary-only-package
* http://ju.outofmemory.cn/entry/256338
