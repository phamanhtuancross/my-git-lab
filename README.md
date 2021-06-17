# my-git-lab
This project created for some custom for gitlab freatures

##App Features

* 1. Fetch gettlapp issues of current repository iterm2

* 2. View dicusstion of current issues

* 3. Stote database offline by using SQLite

* 4. Add custom discussons to firebase app 


## App architecture `VIPER`

### my git lab used VIPER architure for takecrare business logic layer in app.

Not like MVC. VIPER can make the busisness logic layer in app become convinience for maitaince.
For  more infomation about VIPER Architecture template and VIPER architecture . Please view more infomation at the github repository below:

[VIPER tempalte](https://github.com/infinum/iOS-VIPER-Xcode-Templates)

## Installation

###  GraphQL code gen
#### For install GraphQL code gen
* 1. For setup GraphQL code generator in local please run:
```
```
* 2. For more infomation about `GraphQL setup` please visit the [page](https://www.apollographql.com/docs/ios/installation/) 



### Setup project
* 1. Run `pod install` before you run project
* 2. Open `MyGitLab.xcworkspace` and run project
* 3. If project have an error like `could not file code gen tool` then please add scrip below to `Build Pharse`
```# Type a script or drag a script file from your workspace to insert its path.
SCRIPT_PATH="${PODS_ROOT}/Apollo/scripts"
cd "${SRCROOT}/${TARGET_NAME}"
"${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --includes=./**/*.graphql --localSchemaFile="schema.json" API.swift
```




