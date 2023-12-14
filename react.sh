#!/bin/bash
packagem=$1
script=$2
name=$3
install=$4
parametre=$5

open(){
    cd $name
    code .
    cd src
    mkdir components
}
ouv(){
    echo "*,::after,::before {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}"> App.css
    rm index.css
    if [[ $install == "-i" ]]; then
        sass="sass"
        if echo "$parametre" | grep -q "$sass";then
            mv App.css App.scss
            echo "import './App.scss'

export default function App() {
    return (
        <div>App</div>
    )
}">App.jsx
        rename
        fi
        $1 i $parametre
    fi
    $1 install
}

rename(){
    if [[ $script == "-t" ]]; then
        mv App.jsx App.tsx
        sed -i '4d' main.tsx
    else
        sed -i '4d' main.jsx    
    fi
}

ouvrir(){
    open
    echo "import './App.css'

export default function App() {
    return (
        <div>App</div>
    )
}">App.jsx
    rename
    ouv $1
    # pnpm dev
}

langue(){
    if [[ $script == "-t" ]]; then
        echo "react-ts"
    else
        echo "react"
    fi
}
l=$(langue)
case "$packagem" in
    "-h"|"--help") 
    echo -e "\033[34mreact\033[0m [options] [options 2] name [option 3] "packages"
   options:
   -h --help  how it works
     package manager:
   -b         with bun
   -n         with npm
   -p         with pnpm
   -y         with yarn
   options 2:
   \033[33m-j\033[0m         with JavaScript
   \033[34m-t\033[0m         with TypeScript
   option 3:
   \033[37m-i\033[0m         install packages"
    ;;
    -b)
    bun create vite $name --template $l
    ouvrir bun
    ;;
    -n)
    npm create vite@latest $name -- --template $l
    ouvrir npm
    ;;
    -p)
    pnpm create vite $name --template $l
    ouvrir pnpm
    ;;
    -y)
    yarn create vite $name --template $l
    ouvrir yarn
    ;;
esac
