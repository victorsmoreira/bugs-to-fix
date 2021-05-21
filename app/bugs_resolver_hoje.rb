# frozen_string_literal: true

class RegistroDeBug
  attr_accessor :id, :titulo, :idade, :prioridade, :prioridade_cod, :idade_limite

  def initialize(id, titulo, idade, prioridade)
    self.id = id
    self.titulo = titulo
    self.idade = idade
    self.prioridade = prioridade
  end
end

# Método para ordenar listas de bugs e separar o id
def ordenar_bugs(lista_de_bugs)
  if lista_de_bugs.any?
    bugs_ordenados = lista_de_bugs.sort_by { |bug| [bug.prioridade_cod, -bug.idade] }
    id_bugs_ordenados = []
    bugs_ordenados.each { |obj_bug| id_bugs_ordenados.append(obj_bug.id) }
    id_bugs_ordenados
  else
    ['Nenhum bug encontrado =D']
  end
end

# Método que retorna o id dos bugs a serem resolvidos no dia de forma priorizada
def bugs_resolver_hoje(array_bugs)
  # Hashes com regra de negócio e codificação de prioridade
  codigo_prioridades = {
    'Crítico' => 0,
    'Normal' => 1
  }
  limites_idade = {
    'Crítico' => 1,
    'Normal' => 3
  }

  # Inicialização das arrays que receberão os bugs filtrados
  id_bugs_resolver_hoje = []
  id_bugs_prazo_vencido = []

  if array_bugs.any?
    # Iteração dos bugs vindos do JSON
    array_bugs.each do |bug|
      # Codificação da prioridade
      prioridade_cod = codigo_prioridades[bug['prioridade']]
      # Definição da idade limite
      idade_limite = limites_idade[bug['prioridade']]
      # Criação do objeto
      bug = RegistroDeBug.new(bug['id'], bug['titulo'], bug['idade'], bug['prioridade'])
      bug.idade_limite = idade_limite
      bug.prioridade_cod = prioridade_cod

      # Separação de bugs para hoje e vencidos. Os demais serão descartados
      if bug.idade > bug.idade_limite
        id_bugs_prazo_vencido.append(bug)
      elsif bug.idade == bug.idade_limite
        id_bugs_resolver_hoje.append(bug)
      end
    end
  end

  # Hash com os bugs separados e ordenados
  {
    'vencidos' => ordenar_bugs(id_bugs_prazo_vencido),
    'para_hoje' => ordenar_bugs(id_bugs_resolver_hoje)
  }
end
