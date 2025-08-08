# Comment Analyzer

Um serviço de análise de comentários que importa dados da [JSONPlaceholder](https://jsonplaceholder.typicode.com/), traduz os conteúdos para português usando [LibreTranslate](https://libretranslate.com/) e oferece endpoints para análise.

## Tecnologias

- Ruby 3.4+
- Rails 8.0+
- PostgreSQL
- Docker & Docker Compose
- LibreTranslate

## Configuração

### Pré-requisitos

- Docker e Docker Compose instalados
- Git

### Instalação

1. Clone o repositório:
```bash
git clone git@github.com:dayvidemerson/comment-analyzer.git
cd comment-analyzer
```

2. Inicie os serviços:
```bash
docker compose up -d
```

3. Configure o banco de dados:
```bash
docker compose exec app rails db:setup
```

## Uso

[Coleção de Endpoints do Insomnia](CommentAnalyzer-Insomnia.yaml)

## Desenvolvimento

### Estrutura do Projeto

```
app/
├── controllers/       # Controladores da API
├── jobs/              # Processos Executados em Segundo Plano
├── models/            # Modelos do Active Record
│   └── importer/      # Classes de importação
└── lib/
    └── json_place_holder/  # Cliente da API JSONPlaceholder
    └── libre_translate.rb  # Cliente da API LibreTranslate
```

### Testes

O projeto usa RSpec para testes. Para executar os testes:

```bash
docker compose exec app rspec
```

### Tradução

O serviço usa LibreTranslate para tradução. Para traduzir um texto:

```ruby
LibreTranslate.translate(text: "Hello World")
# => "Olá, Mundo"
```

## Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/amazing-feature`)
3. Commit suas mudanças (`git commit -m 'Add amazing feature'`)
4. Push para a branch (`git push origin feature/amazing-feature`)
5. Abra um Pull Request

## License

Este projeto está licenciado sob a [MIT License](LICENSE).
