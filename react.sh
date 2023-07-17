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
    if [ $install == "-i" ]; then
        scss="scss"
        if echo "$packages" | grep -q "$sass";then
            mv App.css App.scss
        fi
        pnpm i $parametre
    fi
    pnpm install
}

ouvrir(){  
    echo "import './App.css'

export default function App() {
    return (
        <div>App</div>
    )
}">App.jsx
    ouv
    # pnpm dev
}

ouvrirTs(){
    echo "import './App.css'

export default function App() {
    return (
        <div>App</div>
    )
}">App.tsx
    ouv
    # pnpm dev
}

case "$script" in
    "-h"|"--help") 
    echo -e "\033[34mreact\033[0m [options] name [option 2] "packages"
   options:
   -h --help  how it works
   \033[33m-j\033[0m         with JavaScript
   \033[34m-t\033[0m         with TypeScript
   option 2:
   \033[37m-i\033[0m         install packages"
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

