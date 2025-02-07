#!/bin/bash
echo "Baixando o NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Carrega o NVM no ambiente atual
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carrega o nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carrega o bash_completion do nvm (opcional)

nvm install --lts
npm -g install yarn

