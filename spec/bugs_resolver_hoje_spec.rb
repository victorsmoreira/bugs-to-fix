# frozen_string_literal: true

require_relative '../app/bugs_resolver_hoje'

describe 'Bugs para resolver hoje:' do
  describe 'quando o bug é crítico' do
    before(:all) do
      @registros_de_bug = [
        { 'id' => 2, 'titulo' => 'Bug #2 - vencido', 'idade' => 2, 'prioridade' => 'Crítico' },
        { 'id' => 6, 'titulo' => 'Bug #6 - pra hoje', 'idade' => 1, 'prioridade' => 'Crítico' },
        { 'id' => 18, 'titulo' => 'Bug #18 - pra hoje', 'idade' => 1, 'prioridade' => 'Crítico' }
      ]
    end
    context 'e tem 1 dia' do
      it 'então pra hoje' do
        bugs_priorizados = bugs_resolver_hoje(@registros_de_bug)
        expect(bugs_priorizados['para_hoje'].count).to eq(2)
      end
    end

    context 'e maior que 1 dia' do
      it 'então prazo vencido' do
        bugs_priorizados = bugs_resolver_hoje(@registros_de_bug)
        expect(bugs_priorizados['vencidos'].count).to eq(1)
      end
    end
  end

  describe 'quando o bug é normal' do
    before(:all) do
      @registros_de_bug = [
        { 'id' => 4, 'titulo' => 'Bug #4 - pra hoje', 'idade' => 3, 'prioridade' => 'Normal' },
        { 'id' => 7, 'titulo' => 'Bug #7 - no prazo', 'idade' => 2, 'prioridade' => 'Normal' },
        { 'id' => 9, 'titulo' => 'Bug #9 - vencido', 'idade' => 4, 'prioridade' => 'Normal' },
        { 'id' => 15, 'titulo' => 'Bug #15 - no prazo', 'idade' => 1, 'prioridade' => 'Normal' },
        { 'id' => 16, 'titulo' => 'Bug #16 - pra hoje', 'idade' => 3, 'prioridade' => 'Normal' },
        { 'id' => 19, 'titulo' => 'Bug #19 - vencido', 'idade' => 4, 'prioridade' => 'Normal' },
        { 'id' => 29, 'titulo' => 'Bug #29 - pra hoje', 'idade' => 3, 'prioridade' => 'Normal' }
      ]
    end
    context 'e tem 3 dias' do
      it 'então pra hoje' do
        bugs_priorizados = bugs_resolver_hoje(@registros_de_bug)
        expect(bugs_priorizados['para_hoje'].count).to eq(3)
      end
    end

    context 'e maior que 3 dias' do
      it 'então prazo vencido' do
        bugs_priorizados = bugs_resolver_hoje(@registros_de_bug)
        expect(bugs_priorizados['vencidos'].count).to eq(2)
      end
    end
  end

  describe 'quando nenhum bug para o dia' do
    before(:all) do
      @registros_de_bug = [
        { 'id' => 7, 'titulo' => 'Bug #7 - no prazo', 'idade' => 2, 'prioridade' => 'Normal' },
        { 'id' => 15, 'titulo' => 'Bug #15 - no prazo', 'idade' => 1, 'prioridade' => 'Normal' }
      ]
    end
    it 'então retorna aviso' do
      bugs_priorizados = bugs_resolver_hoje(@registros_de_bug)
      expect(bugs_priorizados['para_hoje']).to eq(['Nenhum bug encontrado =D'])
      expect(bugs_priorizados['vencidos']).to eq(['Nenhum bug encontrado =D'])
    end
  end
end
