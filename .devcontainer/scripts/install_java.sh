#!/bin/bash
echo "Java setup"
curl -s "https://get.sdkman.io" | bash

# Aguarda alguns segundos para garantir a finalização do SDKMAN
sleep 5

# Carrega o SDKMAN e verifica se foi instalado corretamente
export SDKMAN_DIR="$HOME/.sdkman"
if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"

    # Se o sdk estiver disponível, continua com a instalação do Java e do Maven
    sdk install java 21.0.5-tem
    sdk install maven 3.9.9
else
    echo "SDKMAN não foi instalado corretamente."
    exit 1
fi

