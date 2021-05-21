# desafio_festalab

## Contexto
Esse método é utilizado para priorizar a resolução de bugs em uma plataforma.
Os bugs são classificados entre normais e críticos. Bugs normais devem ser resolvidos em até 3 dias e bugs críticos devem ser resolvidos no mesmo dia.

## Como usar

1. Clonar o repositório
2. Instalar dependências
```bash 
bundle
```
3. Rodar os testes
```bash 
rspec -fd
```
4. Rodar a aplicação do método
```bash 
aplicacao_do_metodo.rb
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
    "titulo" => "Bug #1 - no prazo",
    "idade" => 1,
    "prioridade" => "Normal"
  },
  {
    "id" => 2,
    "titulo" => "Bug #2 - vencido",
    "idade" => 2,
    "prioridade" => "Crítico"
  },
  ...
]
```

- Saída: Hash com duas chaves - 'vencidos' e 'para_hoje' - contendo uma array en cada. As arrays contém os IDs dos bugs vencidos e a serem resolvidos no dia. Caso não exista nenhum bug para alguma das chaves, uma mensagem é retornada ao usuário.

Exemplo
```ruby
{
  'vencidos' => ['Nenhum bug encontrado =D'],
  'para_hoje' => [00, 01, 02, ...]
}
```
