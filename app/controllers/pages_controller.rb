class PagesController < ApplicationController
  MEGA = {
    numeros: [6,7,8,9,10,11,12,13,14,15],
    valor: [4.50, 31.50, 126.00, 378.00, 945.00, 2079.00, 4158.00,7722.00, 13513.50, 22522.50],
    probabilidade: [50063860, 7151980, 1787995, 595998, 238399, 108363, 54182, 29175, 16671, 10003]
  };

  def home
    @mega = MEGA
    # @mega = {
    #   numeros: [6,7,8,9,10,11,12,13,14,15],
    #   valor: [4.50, 31.50, 126.00, 378.00, 945.00, 2079.00, 4158.00,7722.00, 13513.50, 22522.50],
    #   probabilidade: [50063860, 7151980, 1787995, 595998, 238399, 108363, 54182, 29175, 16671, 10003]
    # };
    
    @dupla = {
      numeros: [6,7,8,9,10,11,12,13,14,15],
      valor: [2.50, 17.50, 70.00, 210.00, 525.00, 1155.00, 2310.00, 4290.00, 7507.50, 12512.50],
      probabilidade: [15890700, 2270100, 567525, 189175, 75670, 34395, 17197, 9260, 5291, 3174]
    };
    
    @quina = {
      numeros: [5,6,7,8,9,10,11,12,13,14,15],
      valor: [2.00, 12.00, 42.00, 112.00, 252.00, 504.00, 924.00, 1584.00, 2574.00, 4004.00, 6006.00],
      probabilidade: [24040016, 4006669, 1144763, 429286, 190794, 95396, 52035, 30354, 18679, 12008, 8005]
    };
    
    @lotof = {
      numeros: [15, 16, 17, 18, 19, 20],
      valor: [2.50, 40.00, 340.00, 2040.00, 9690.00, 38760.00],
      probabilidade: [3268760, 204298, 24035, 4006, 843, 211]
    };
    
    
    @array = []
    @conferir = []   # guardará os jogos que serão feitos, mas em um array
    sorteio = params[:sorteio]
    apostas_desejadas = params[:quantidadeJogos].to_i # LANÇAR AQUI QUANTAS APOSTAS VOCÊ DESEJA
    numeros_cada_aposta = params[:quantidadeNumeros].to_i


    if sorteio == "mega"
      (1...61).each { |n| @array << n}
      indice_corretor = 6
      modalidade = @mega
      @nome = 'Mega-sena'
    elsif sorteio == "dupla"
      (1...51).each { |n| @array << n}
      indice_corretor = 6
      modalidade = @dupla
      @nome = 'Dupla sena'
    elsif sorteio == "quina"
      (1...81).each { |n| @array << n}
      indice_corretor = 5
      modalidade = @quina
      @nome = 'Quina'
    elsif sorteio == "lotof"
      (1...26).each { |n| @array << n}
      indice_corretor = 15
      modalidade = @lotof
      @nome = 'Lotofácil'
    end



    while @conferir.count < apostas_desejadas
      if @array.count < numeros_cada_aposta
        @array = []
        if sorteio == "mega"
          (1...61).each { |n| @array << n}
        elsif sorteio == "dupla"
          (1...51).each { |n| @array << n}
        elsif sorteio == "quina"
          (1...81).each { |n| @array << n}
        elsif sorteio == "lotof"
          (1...26).each { |n| @array << n}
        end
      end

      aposta = @array.sample(numeros_cada_aposta).sort
      @conferir << aposta
      @conferir.uniq!
      for x in aposta
        @array.delete(x)
      end

    end

    if numeros_cada_aposta > 0
      valor_total = modalidade[:valor][numeros_cada_aposta - indice_corretor]*apostas_desejadas*100
      formato_money = Money.from_cents(valor_total, "BRL").format
      formato_brasil = formato_money.gsub!(".","*")
      if formato_brasil.include? ","
        formato_brasil.gsub!(",",".")
      end
      formato_brasil.gsub!("*",",")
      @valor = "Valor: #{formato_brasil}"

      @id_div_apostas = "apostas-geradas"

      chance = modalidade[:probabilidade][numeros_cada_aposta - indice_corretor]/apostas_desejadas
      @chance_printada = "Sua chance será de 1 em #{chance.to_s.reverse.scan(/.{1,3}/).join('.').reverse}"
    end
  end



  def apostas
    @aposta = params

    @mega = {
      numeros: [6,7,8,9,10,11,12,13,14,15],
      valor: [4.50, 31.50, 126.00, 378.00, 945.00, 2079.00, 4158.00,7722.00, 13513.50, 22522.50],
      probabilidade: [50063860, 7151980, 1787995, 595998, 238399, 108363, 54182, 29175, 16671, 10003]
    };
    
    @dupla = {
      numeros: [6,7,8,9,10,11,12,13,14,15],
      valor: [2.50, 17.50, 70.00, 210.00, 525.00, 1155.00, 2310.00, 4290.00, 7507.50, 12512.50],
      probabilidade: [15890700, 2270100, 567525, 189175, 75670, 34395, 17197, 9260, 5291, 3174]
    };
    
    @quina = {
      numeros: [5,6,7,8,9,10,11,12,13,14,15],
      valor: [2.00, 12.00, 42.00, 112.00, 252.00, 504.00, 924.00, 1584.00, 2574.00, 4004.00, 6006.00],
      probabilidade: [24040016, 4006669, 1144763, 429286, 190794, 95396, 52035, 30354, 18679, 12008, 8005]
    };
    
    @lotof = {
      numeros: [15, 16, 17, 18, 19, 20],
      valor: [2.50, 40.00, 340.00, 2040.00, 9690.00, 38760.00],
      probabilidade: [3268760, 204298, 24035, 4006, 843, 211]
    };
    
    
    @array = []
    @conferir = []   # guardará os jogos que serão feitos, mas em um array
    sorteio = @aposta[:sorteio]
    apostas_desejadas = @aposta[:quantidadeJogos].to_i # LANÇAR AQUI QUANTAS APOSTAS VOCÊ DESEJA
    numeros_cada_aposta = @aposta[:quantidadeNumeros].to_i
    quantidade_apostadores = @aposta[:quantidadeApostadores2].to_i
    quotas_diferentes = @aposta[:bolaoQuotas]

    contador = 1
    @array_apostadores = []
    @array_pagamento = []
    @array_quotas = []
    while quantidade_apostadores >= contador
      apostador_symbol = ("apostador"+contador.to_s).to_sym
      if @aposta[apostador_symbol] != ""
        @array_apostadores << @aposta[apostador_symbol]
      else
        @array_apostadores << "____________________"
      end

      pagamento_symbol = ("pagamento"+contador.to_s).to_sym
      @array_pagamento << @aposta[pagamento_symbol]

      quotas_symbol = ("Quotas"+contador.to_s).to_sym
      if @aposta[quotas_symbol] == nil
        @array_quotas << 1
      else
        @array_quotas << @aposta[quotas_symbol]
      end

      contador += 1
    end



    if @aposta[:data] != ""
      @data =  "Sorteio: #{@aposta[:data].to_time.strftime('%d/%m/%Y')}"
    end

    if sorteio == "mega"
      (1...61).each { |n| @array << n}
      indice_corretor = 6
      modalidade = @mega
      @nome = 'Mega-sena'
    elsif sorteio == "dupla"
      (1...51).each { |n| @array << n}
      indice_corretor = 6
      modalidade = @dupla
      @nome = 'Dupla sena'
    elsif sorteio == "quina"
      (1...81).each { |n| @array << n}
      indice_corretor = 5
      modalidade = @quina
      @nome = 'Quina'
    elsif sorteio == "lotof"
      (1...26).each { |n| @array << n}
      indice_corretor = 15
      modalidade = @lotof
      @nome = 'Lotofácil'
    end



    while @conferir.count < apostas_desejadas
      if @array.count < numeros_cada_aposta
        @array = []
        if sorteio == "mega"
          (1...61).each { |n| @array << n}
        elsif sorteio == "dupla"
          (1...51).each { |n| @array << n}
        elsif sorteio == "quina"
          (1...81).each { |n| @array << n}
        elsif sorteio == "lotof"
          (1...26).each { |n| @array << n}
        end
      end

      aposta = @array.sample(numeros_cada_aposta).sort
      @conferir << aposta
      @conferir.uniq!
      for x in aposta
        @array.delete(x)
      end

    end

    if numeros_cada_aposta > 0
      valor_total = modalidade[:valor][numeros_cada_aposta - indice_corretor]*apostas_desejadas*100
      formato_money = Money.from_cents(valor_total, "BRL").format
      formato_brasil = formato_money.gsub!(".","*")
      if formato_brasil.include? ","
        formato_brasil.gsub!(",",".")
      end
      formato_brasil.gsub!("*",",")
      @valor = "Valor: #{formato_brasil}"

      @id_div_apostas = "apostas-geradas"

      chance = modalidade[:probabilidade][numeros_cada_aposta - indice_corretor]/apostas_desejadas
      @chance_printada = "Sua chance será de 1 em #{chance.to_s.reverse.scan(/.{1,3}/).join('.').reverse}"



      # RELATÓRIO SOBRE QUOTAS:
      quotas = 0
      for x in @array_quotas
        quotas += x.to_f
      end
      #TOTAL DE QUOTAS:
      if quotas.to_s.include? ".0"
        formato_brasil_quotas = quotas.to_s.gsub(".0","")
      else
        formato_brasil_quotas = quotas.to_s.gsub(".",",")
      end
      @total_quotas = "Total de quotas: #{formato_brasil_quotas}"
      
      #VALOR POR QUOTA:
      Money.default_infinite_precision = true # isso é para pegar todos os centavos e não arredondar, que estava acontecendo
      valor_temp_formato_money = (Money.from_cents(valor_total, "BRL") / Money.from_cents(quotas, "BRL"))
      valor_temp_formato_brasil = Money.from_cents(valor_temp_formato_money, "BRL").format.gsub!(".","*")
      if valor_temp_formato_brasil.include? ","
        valor_temp_formato_brasil.gsub!(",",".")
      end
      valor_temp_formato_brasil.gsub!("*",",")
      indice_da_virgula = valor_temp_formato_brasil.index(",") # isso para pegar só 2 casas decimais
      if valor_temp_formato_brasil[(indice_da_virgula + 3)] == "0" or valor_temp_formato_brasil[(indice_da_virgula + 3)] == nil # ou seja, se eu tenho um zero depois de duas casas da vírgula: ,__0
        @valor_por_quota = "Valor da quota: #{valor_temp_formato_brasil[0..(indice_da_virgula + 2)]}" # então eu pego só duas casas decimais depois da vírgula
      else
        @valor_por_quota = "Valor da quota ( aproximado ): #{valor_temp_formato_brasil[0..(indice_da_virgula + 4)]}"
      end
    end
  end


  def sorte
    @quantidade_sorteios = Sorteio.all.size.to_s.reverse.scan(/.{1,3}/).join('.').reverse
    @array_sorte = []
    @conferir_sorte = []
    numeros = params[:meusNumeros]
    if numeros
      @numeros_da_sorte = numeros.split(/,/).map(&:to_i).sort # SE FUNCIONAR Isso cria um array com os números selecionados
      @sorteios = Sorteio.all
      @id_div_apostas = "apostas-geradas"
      # @sorteios.each do |sorteio|
      #   sorteio.numeros
      # end
      
    end
    # @teste = request[:meusNumeros].split(/,/).map(&:to_i).sort
    # @teste3 = params[:meusNumeros].present?
    
    # {"meusNumeros"=>"1,2,25,26,3,4"}
  end


  def conjuntos
    @sorteios = Sorteio.all
    todos_numeros = []
    @mais_saem = []
    @menos_saem = []
    @media = []
    @media_mil = []
    @array17 = [] 
    @array13 = []
    @array10 = []
    
    # ARRAY DE 13 E DE 17
    contador = 1
    while contador < 18 
      numeros = @sorteios[- contador].numeros.split(/,/).map {|x| x.to_i} 
      for x in numeros 
        @array17 << x 
        if contador < 14 
          @array13 << x
          if contador < 11
            @array10 << x
          end 
        end     
      end   
      contador += 1 
    end
    @array17 = @array17.to_set.to_a.sort
    @array13 = @array13.to_set.to_a.sort
    @array10 = @array10.to_set.to_a.sort

    # OBTENDO NÚMEROS NA MÉDIA ÚLTIMOS 1000 JOGOS
    contador_mil = 1
    todos_numeros_mil_temp = []
    while contador_mil < 1001
      numeros_mil = @sorteios[- contador_mil].numeros.split(/,/).map {|x| x.to_i} 
      for x in numeros_mil 
        todos_numeros_mil_temp << x 
      end   
      contador_mil += 1 
    end
    hashruby_mil = todos_numeros_mil_temp.group_by { |v| v }.map { |k, v| [k.to_i, v.size] }.to_h
    hash_final_todos_numeros_mil = hashruby_mil.sort_by {|_key, value| value}.to_h
    array_ordenado_menos_saem_ate_mais_saem_mil = hash_final_todos_numeros_mil.keys
    @mais_saem_mil = array_ordenado_menos_saem_ate_mais_saem_mil.last(30).reverse # NÃO UTILIZADO!!!! começa do que mais sai
    @menos_saem_mil = array_ordenado_menos_saem_ate_mais_saem_mil.first(30) # NÃO UTILIZADO!!!!  começa do que menos sai
    contador_media_mil = 15
    while contador_media_mil < 45
      @media_mil << array_ordenado_menos_saem_ate_mais_saem_mil[contador_media_mil]
      contador_media_mil += 1
    end  



    # MAIS SAEM E MENOS SAEM (UTILIZADO PELO JAVA SCRIPT)
    @sorteios.each { |sorteio|
      array_temp = sorteio.numeros.split(/,/).map {|x| x.to_i}
      for x in array_temp
        todos_numeros << x
      end
    }

    hashruby = todos_numeros.group_by { |v| v }.map { |k, v| [k.to_i, v.size] }.to_h
    hash_final_todos_numeros = hashruby.sort_by {|_key, value| value}.to_h
    array_ordenado_menos_saem_ate_mais_saem = hash_final_todos_numeros.keys
    @mais_saem = array_ordenado_menos_saem_ate_mais_saem.last(30).reverse # começa do que mais sai
    @menos_saem = array_ordenado_menos_saem_ate_mais_saem.first(30) # começa do que menos sai
  
    contador_media = 15
    while contador_media < 45
      @media << array_ordenado_menos_saem_ate_mais_saem[contador_media]
      contador_media += 1
    end


  
    # DAQUI PARA BAIXO, SÓ COPIEI DA HOME VIEW
    @mega = MEGA

    if params[:meusNumeros2]
      @nome = "Mega-sena"
      # @conjunto_para_view = params[:meusNumeros2]
      @conjunto = params[:meusNumeros2].split(/,/).map(&:to_i).sort # SE FUNCIONAR Isso cria um array com os números selecionados
    end
    numeros_cada_aposta = params[:quantidadeNumeros2].to_i
    apostas_desejadas = params[:quantidadeJogos2].to_i # LANÇAR AQUI QUANTAS APOSTAS VOCÊ DESEJA
    indice_corretor = 6
    @conferir = []   # guardará os jogos que serão feitos, mas em um array
    # {"meusNumeros2"=>"47,48,49,50,51,52,53", "quantidadeNumeros2"=>"6", "quantidadeJogos2"=>"1", "controller"=>"pages", "action"=>"conjuntos"}



    # ESSE ALGORITMO ABAIXO  GERA AS APOSTAS COM REPETIÇÃO
    # while @conferir.count < apostas_desejadas
    #   aposta = @conjunto.sample(numeros_cada_aposta).sort
    #   @conferir << aposta
    #   @conferir.uniq!
    # end


    # ESSE ALGORITMO ABAIXO  GERA AS APOSTAS SEM REPETIÇÃO
    array_conjunto = []
    while @conferir.count < apostas_desejadas
      conjunto_apontado = params[:meusNumeros2].split(/,/).map(&:to_i).sort
      if array_conjunto.count < numeros_cada_aposta
        array_conjunto = conjunto_apontado
      end
      aposta = array_conjunto.sample(numeros_cada_aposta).sort
      @conferir << aposta
      @conferir.uniq!
      for x in aposta
        array_conjunto.delete(x)
      end
    end

 


    if numeros_cada_aposta > 0
      valor_total = @mega[:valor][numeros_cada_aposta - indice_corretor]*apostas_desejadas*100
      formato_money = Money.from_cents(valor_total, "BRL").format
      formato_brasil = formato_money.gsub!(".","*")
      if formato_brasil.include? ","
        formato_brasil.gsub!(",",".")
      end
      formato_brasil.gsub!("*",",")
      @valor = "Valor: #{formato_brasil}"

      @id_div_apostas = "apostas-geradas"

      chance = @mega[:probabilidade][numeros_cada_aposta - indice_corretor]/apostas_desejadas
      @chance_printada = "Sua chance será de 1 em #{chance.to_s.reverse.scan(/.{1,3}/).join('.').reverse}"
  


      # CALCULANDO ESTATÍSTICA PARA O CONJUNTO. PARA A APOSTA ESPECÍFICA DO CONJUNTO TIVE PROBLEMAS COM CONJUNTOS PEQUENOS, POIS PODEM HAVER APOSTAS REPETIDAS, O QUE TRAZ ERRO PARA A ESTATÍSTICA
      def fatorial(n)
        if n == 1
          return 1
        else
          return n*fatorial(n - 1)
        end
      end
      
      def probabilidade(conjunto, numeros_do_sorteio)
        prob_se_numeros_sorteados_no_conjunto = fatorial(conjunto)/(fatorial(numeros_do_sorteio)*fatorial(conjunto-numeros_do_sorteio))
        return prob_se_numeros_sorteados_no_conjunto
        # if numeros_por_aposta == numeros_do_sorteio
        #   quantidade_apostas_feitas_tomando_6x6 = total_de_apostas
        # else
        #   quantidade_apostas_feitas_tomando_6x6 = total_de_apostas*(fatorial(numeros_por_aposta)/(fatorial(numeros_do_sorteio)*fatorial(numeros_por_aposta-numeros_do_sorteio)))
        # end
        # return prob_se_numeros_sorteados_no_conjunto/quantidade_apostas_feitas_tomando_6x6
      end
      chance_no_escopo = probabilidade(@conjunto.size, 6)
      chance_mega = probabilidade(60, 6)
      @chance_escopo_printada = "A Mega possui #{chance_mega.to_s.reverse.scan(/.{1,3}/).join('.').reverse} de combinações, das quais #{chance_no_escopo.to_s.reverse.scan(/.{1,3}/).join('.').reverse} estão contidas no seu conjunto da sorte."
    end






    
    
    # numeros = params[:meusNumeros2]
    # if numeros
    #   @numeros_da_sorte = numeros.split(/,/).map(&:to_i).sort # SE FUNCIONAR Isso cria um array com os números selecionados
      
    # end    
  end

  # private

  # def apostas_params
  #   params.require(:request).permit(:sorteio, :quantidadeNumeros, :)
  # end
end

# // {"sorteio"=>"mega",
#   //  "quantidadeNumeros"=>"6",
#   //  "quantidadeJogos"=>"2",
# {"authenticity_token"=>"vy8YC/oWh4Bq5ZaBHU+talKy5cVX8p0TeDqMc8sZcHJkjYuD5L9e2+f3mwOWvzAva5oVDx2Ruy/Hgi1SwJ4qUQ==",
#   "sorteio"=>"mega",
#   "quantidadeNumeros"=>"6",
#   "quantidadeJogos"=>"5",
#   "bolao"=>"sim",
#   "quantidadeApostadores2"=>"2",
#   "data"=>"",
#   "bolaoQuotas"=>"sim",
#   "apostador1"=>"Gretchen",
#   "pagamento1"=>"on",
#   "Quotas1"=>"1.5",
#   "apostador2"=>"Eduardo",
#   "Quotas2"=>"1",
#   "quantidadeQuotas"=>"1",
#   "cota1"=>"0",
#   "cota2"=>"0",
#   "cota3"=>"0"}

#   quantidadeJogos, bolao, quantidadeApostadores2, data, bolaoQuotas 