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
      valor: [2,50, 40.00, 340.00, 2040.00, 9690.00, 38760.00],
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

      chance = modalidade[:probabilidade][numeros_cada_aposta - indice_corretor]/apostas_desejadas
      @chance_printada = "Sua chance será de 1 em #{chance.to_s.reverse.scan(/.{1,3}/).join('.').reverse}"
    end
  end



  def apostas
  end
end

# // {"sorteio"=>"mega",
#   //  "quantidadeNumeros"=>"6",
#   //  "quantidadeJogos"=>"2",