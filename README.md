# Pictale - Rede Social para Fotógrafos

**Pictale** é uma plataforma inovadora para fotógrafos compartilharem seu trabalho, conectarem-se e se destacarem na comunidade. Desenvolvida para ser uma rede social intuitiva, Pictale permite que fotógrafos mostrem seu portfólio, interajam com outros profissionais e se conectem com oportunidades.

## Funcionalidades

- **Cadastro de fotógrafos e upload de fotos**: Permite que fotógrafos criem perfis, compartilhem suas fotos e mostrem seu trabalho.
- **Compartilhamento de fotos**: Encontre, curta e compartilhe fotos incríveis na rede social.
- **Comentários e curtidas**: Interaja com as fotos publicadas, deixando comentários e curtindo suas favoritas.
- **Busca por fotos**: Encontre fotos por tags, categorias e nomes de fotógrafos.
- **Perfis de fotógrafos**: Cada fotógrafo tem um perfil com suas informações de contato e portfólio.

---

## Tecnologias Utilizadas

- **Java 21**: Linguagem orientada à objetos utilizada no desenvolvimento backend.
- **Spring Boot**: Framework robusto para a construção de aplicações Java modernas e escaláveis.
- **Thymeleaf**: Template engine para renderizar páginas dinâmicas no frontend.
- **PostgreSQL**: Banco de dados relacional para armazenamento eficiente de dados.
- **Bootstrap**: Framework de CSS para garantir uma interface responsiva e moderna.
- **Docker**:  Plataforma de containerização que facilita a criação, o empacotamento e a execução da aplicação e suas dependências em containers isolados.

---

## Instalação Via Docker

Para executar a aplicação via containers Docker, certifique-se de ter o Docker instalado, e siga os passos abaixo:

### 1. Clone o repositório
```bash
git clone https://github.com/dvcode/pictale.git
```

### 2. Execute a aplicação

- Abra o projeto no vscode.
- Pressione ctrl+shift+p, digite "Reabrir no container" e clique enter.
- Após a conclusão da montagem dos containers, abra o terminal interno do vscode e execute o seguinte comando:
  - ```run!```

## Instalação Local

Certifique-se de ter o java 21, maven e o Postgres instalados. Crie no Postgres um banco chamado pictale, e siga os passos abaixo:

### 1. Clone o repositório
```bash
git clone https://github.com/dvcode/pictale.git
```
### 2. Configure o banco de dados

Modifique as configurações do banco de dados no arquivo `src/main/resources/application.yml` para se conectar à sua instância local do PostgreSQL.

### 3. Execute a aplicação

Para rodar a aplicação localmente:
```bash
mvn spring-boot:run
```

---

## Contato

Se você tiver alguma dúvida ou precisar de ajuda, entre em contato conosco pelo e-mail:  
**petersvcosta@gmail.com**

---

### Contribua

Se você quiser contribuir para o projeto, fique à vontade para abrir uma *issue* ou enviar um *pull request*. Sua contribuição é muito bem-vinda!
