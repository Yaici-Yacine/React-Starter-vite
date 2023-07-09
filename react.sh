#!/bin/bash
script=$1
name=$2
install=$3
parametre=$4
ouv(){
    cd $name
    code .
    cd src
    echo "*,::after,::before {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}"> App.css
    rm index.css
    pnpm install
    echo $parametre
    if [ $install == "-i" ]; then
        pnpm i $parametre
    fi
}
ouvrir(){
    ouv
    echo "import './App.css'

export default function App() {
    return (
        <div>App</div>
    )
}">App.jsx
    # pnpm dev
}
ouvrirTs(){
    ouv
    echo "import './App.css'

export default function App() {
    return (
        <div>App</div>
    )
}">App.tsx
    # pnpm dev
}
case "$script" in
    "-h"|"--help") 
    echo -e "\033[34mreact\033[0m [options] name [option 2] \"packages\"
    options: 
    -h --help  comment sa marche
    \033[33m-j\033[0m         avec javascript
    \033[34m-t\033[0m         avec typescript
    option 2:
    \033[37m-i\033[0m         installer des packages"
    ;;
    -j)
    pnpm create vite $name --template react
    ouvrir
    ;;
    -t)
    pnpm create vite $name --template react-ts
    ouvrirTs
    ;;
esac
# create(){
# }
# create&
# pid1=$!
# key(){
#     sleep 4
#     xdotool key Down
#     xdotool key Down
#     xdotool key Return
# }
# key&
# pid2=$!
# wait $pid1
# wait $pid2