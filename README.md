[![codecov](https://codecov.io/gh/cosmopool/pixlog-challenge/branch/main/graph/badge.svg?token=NWVIKT579Z)](https://codecov.io/gh/cosmopool/pixlog-challenge)

# Como Utilizar

Assim que o aplicativo abre ele já começa a carregar os recursos de tradução, é só esperar 😄.
Quando a lista de recursos estiver carregada já é possível abrir os filtros (é só clicar no ícone de funil no canto superior direito da tela).
Assim que clicar no ícone, os seguintes campos aparecerão:

- Dropdown menu para filtrar por 'language_id'
- Dropdown menu para filtrar por 'module_id'
- Campo de texto para filtrar os campos 'value'
- Botão para limpar todos os filtros

## Funcionalidades

- Visualização de recursos de tradução disponíveis em: http://portal.greenmilesoftware.com/get_resources_since
- Visualização do 'resource_id'
- Visualização do 'updated_at'
- Visualização do 'value'
- Filtro por 'language_id'
- Filtro por 'module_id'
- Filtro do campo 'value' por busca textual do tipo "contém"
- Cache para utilização offline
- Design simples


## Tecnologia

- Modular: utilizado para injeção de dependências
- Bloc: utilizado para gerencia de estado
- Hive: utilizado para cache


## Padrão de código

Foi utilizado o Clean Dart, padrão que segue todas as guidelines da Clean Architecture e escrito testes (90.2% de coverage) para garantir a qualidade do código.

