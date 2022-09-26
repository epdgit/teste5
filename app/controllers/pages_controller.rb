class PagesController < ApplicationController


  def home
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
        @array_apostadores << "_____________"
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
        @valor_por_quota = "Valor da quota (aproximado): #{valor_temp_formato_brasil[0..(indice_da_virgula + 4)]}"
      end
    end
  end


  def sorte
    @array_sorte = []
    @conferir_sorte = []
    numeros = params[:meusNumeros]
    if numeros
      @numeros_da_sorte = numeros.split(/,/).map(&:to_i).sort # SE FUNCIONAR Isso cria um array com os números selecionados
      @sorteios = Sorteio.all
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
    contador = 1
    todos_numeros = []
    @mais_saem = []
    @menos_saem = [] 
    @array17 = [] 
    @array13 = []
    
    # ARRAY DE 13 E DE 17
    while contador < 18 
      numeros = @sorteios[- contador].numeros.split(/,/).map {|x| x.to_i} 
      for x in numeros 
        @array17 << x 
        if contador < 14 
          @array13 << x 
        end     
      end   
      contador += 1 
    end
    @array17 = @array17.to_set.to_a.sort
    @array13 = @array13.to_set.to_a.sort

    # MAIS SAEM
    tamanho = @sorteios.size
    while tamanho > 0
      conta += 1
      tamanho -= 1
    end
    @teste = conta




    # DAQUI PARA BAIXO, SÓ COPIEI DA HOME VIEW
    apostas_desejadas = params[:quantidadeJogos2].to_i # LANÇAR AQUI QUANTAS APOSTAS VOCÊ DESEJA
    numeros_cada_aposta = params[:quantidadeNumeros2].to_i
    numeros = params[:meusNumeros2]
    if numeros
      @numeros_da_sorte = numeros.split(/,/).map(&:to_i).sort # SE FUNCIONAR Isso cria um array com os números selecionados
      
    end    
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