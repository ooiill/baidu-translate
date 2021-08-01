# baidu-translate

Translate base on fanyi.baidu.com by curl.

## Install luarocks

```shell
brew update
brew install luarocks
```

## Install step

* git clone https://github.com/ooiill/baidu-translate.git
* cd baidu-translate
* chmod a+x main.lua
* luarocks install --server=http://rocks.moonscript.org/manifests/amrhassan --local json4Lua
* ./main.lua `hello`
* ./main.lua `你好` `zh` `en`

## Fixed not found "json"

```shell
ln -s ~/.luarocks/share/lua/5.4 /usr/local/share/lua
```

## Email

* jiangxilee@gmail.com
