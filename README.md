# bugs-to-fix

## Contexto
./app/bugs_to_fix.rb é um método utilizado para priorizar a resolução de bugs em uma plataforma.
Os bugs são classificados entre normais e críticos. Bugs normais devem ser resolvidos em até 3 dias e bugs críticos devem ser resolvidos no mesmo dia.

## Como usar

1. Clonar o repositório
2. Instalar dependências
```bash 
$ bundle
```
3. Rodar os testes
```bash 
$ rspec -fd
```
4. Rodar a aplicação do método
```bash 
$ method_application.rb
```

## Documentação do método
- Entradas: Array de bugs em hashes contendo as quatro chaves:
    - id
    - titulo
    - idade
    - prioridade 

Exemplo
```ruby
[
  { 
    "id" => 1,
    "title" => "Bug #1 - within time",
    "age" => 1,
    "priority" => "Regular"
  },
  {
    "id" => 2,
    "title" => "Bug #2 - dued",
    "age" => 2,
    "priority" => "Critical"
  },
  ...
]
```

- Saída: Hash com duas chaves - 'expired' e 'para_hoje' - contendo uma array en cada. As arrays contém os IDs dos bugs vencidos e a serem resolvidos no dia. Caso não exista nenhum bug para alguma das chaves, uma mensagem é retornada ao usuário.

Exemplo
```ruby
{
  :expired => [],   # Quando não são encontrados bugs, a array retorna vazia
  :fix_today => [00, 01, 02, ...]
}
```
