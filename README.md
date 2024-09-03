# Projeto Template para Site usando Next.js

## Criação de Novo Repositório

1. Crie um novo repositório, selecionando a opção _Repository template_. Escolha `inteegramice/site-next-js`.
2. Em _Repository name_, crie o nome do repositório seguindo o padrão `<PROJETO>-site`, substituindo `<PROJETO>` pelo nome da aplicação. O nome deve:
   - Ser em letras minúsculas
   - Não incluir caracteres especiais
   - Usar hífen para separar palavras compostas ou frases (Ex.: `inteegra-plus` para "Inteegra Plus")

## Adição de _Secrets_ no Repositório

1. Acesse _Settings_.
2. Na coluna à esquerda, em _Security_, selecione _Secrets and variables_ e clique em _Actions_.
3. Adicione os seguintes _secrets_, clicando em _New repository secret_ para cada um:

   - `KUBE_NAMESPACE`
   - `KUBE_CONFIG_DATA_DEV`
   - `KUBE_CONFIG_DATA_PROD`
   - `AWS_ACCOUNT_ID`
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_SUB_DOMAIN`
   - `AWS_CNAME_DEV`
   - `AWS_CNAME_PROD`
   - `AWS_HOSTED_ZONE_ID_DEV`
   - `AWS_HOSTED_ZONE_ID_PROD`
   - `OPEN_VPN_AUTH`
   - `OPEN_VPN_CONFIG`
   - `OPEN_VPN_CRT`
   - `OPEN_VPN_KEY`

### Descrição dos _Secrets_:

- `KUBE_NAMESPACE`: Namespace existente no Kubernetes onde deseja que a aplicação seja criada.
- `KUBE_CONFIG_DATA_DEV`: Configuração do Kubernetes para o ambiente de desenvolvimento.
- `KUBE_CONFIG_DATA_PROD`: Configuração do Kubernetes para o ambiente de produção.
- `AWS_ACCOUNT_ID`: ID da conta AWS.
- `AWS_ACCESS_KEY_ID`: ID da chave de acesso AWS.
- `AWS_SECRET_ACCESS_KEY`: Chave de acesso secreta AWS.
- `AWS_SUB_DOMAIN`: Subdomínio desejado. Verifique se já não está em uso nos domínios `inteegratec.com.br` e `sistemasinteegra.com.br`.
- `AWS_CNAME_DEV`: CNAME para o ambiente de desenvolvimento na AWS.
- `AWS_CNAME_PROD`: CNAME para o ambiente de produção na AWS.
- `AWS_HOSTED_ZONE_ID_DEV`: ID da zona hospedada na AWS para o ambiente de desenvolvimento.
- `AWS_HOSTED_ZONE_ID_PROD`: ID da zona hospedada na AWS para o ambiente de produção.
- `OPEN_VPN_AUTH`: Credenciais de autenticação do OpenVPN.
- `OPEN_VPN_CONFIG`: Configuração do cliente OpenVPN.
- `OPEN_VPN_CRT`: Certificado do OpenVPN.
- `OPEN_VPN_KEY`: Chave privada do OpenVPN.

## Execução das Actions

Para a execução da pipeline:

1. Depois de adicionar os _secrets_, acesse a aba _Actions_.
2. Localize `Initial commit` e clique nele.
3. No botão _Re-run jobs_, clique e, em seguida, selecione _Re-run all jobs_.

## Instalação

1. Certifique-se de ter o [Node.js](https://nodejs.org) instalado em seu ambiente de desenvolvimento local.
2. Faça o clone deste repositório para o diretório desejado em sua máquina.
3. Navegue até o diretório raiz do projeto no terminal.
4. Execute o seguinte comando para instalar as dependências:

   ```bash
   yarn install
   ```

## Uso

1. No diretório raiz do projeto, execute o seguinte comando para iniciar a aplicação:

   ```bash
   yarn dev
   ```

2. Abra o navegador e acesse `http://localhost:3000` para visualizar a aplicação.

---
