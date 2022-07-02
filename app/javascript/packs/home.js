
var quantidadeJogos = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
var mega = {
  numeros: [6,7,8,9,10,11,12,13,14,15],
  valor: ["R$ 4,50", "R$ 31,50", "R$ 126,00", "R$ 378,00", "R$ 945,00", "R$ 2.079,00", "R$ 4.158,00","R$ 7.722,00","R$ 13.513,50","R$ 22.522,50"],
  probabilidade: ["50.063.860", "7.151.980", "1.787.995", "595.998", "238.399", "108.363", "54.182", "29.175", "16.671", "10.003"]
};

var dupla = {
  numeros: [6,7,8,9,10,11,12,13,14,15],
  valor: ["R$ 4,50", "R$ 31,50", "R$ 126,00", "R$ 378,00", "R$ 945,00", "R$ 2.079,00", "R$ 4.158,00","R$ 7.722,00","R$ 13.513,50","R$ 22.522,50"],
  probabilidade: ["50.063.860", "7.151.980", "1.787.995", "595.998", "238.399", "108.363", "54.182", "29.175", "16.671", "10.003"]
};

var quina = {
  numeros: [5,6,7,8,9,10,11,12,13,14,15],
  valor: ["R$ 2,00", "R$ 12,00", "R$ 42,00", "R$ 112,00", "R$ 252,00", "R$ 504,00", "R$ 924,00","R$ 1.584,00","R$ 2.574,00","R$ 4.004,00", "R$ 6.006,00"],
  probabilidade: ["24.040.016", "4.006.669", "1.144.763", "429.286", "190.794", "95.396", "52.035", "30.354", "18.679", "12.008", "8.005"]
};

var lotof = {
  numeros: [15, 16, 17, 18, 19, 20],
  valor: ["R$ 2,50", "R$ 40,00", "R$ 340,00", "R$ 2.040,00", "R$ 9.690,00", "R$ 38.760,00"],
  probabilidade: ["3.268.760", "204.298", "24.035", "4.006", "843", "211"]
};

// console.log(quina.numeros[1])

function trocarSeletorNumeros() {
  var sorteioEscolhido = document.getElementById("sorteio");
  var sorteio ;
  if (sorteioEscolhido.value == "mega") {
    sorteio = mega
  } else if (sorteioEscolhido.value == "quina") {
    sorteio = quina
  } else if (sorteioEscolhido.value == "dupla") {
    sorteio = dupla
  } else if (sorteioEscolhido.value == "lotof") {
    sorteio = lotof
  };
  //criando seletores para números a apostar
  var seletorNumeros = document.getElementById("opcoesDaAposta");
  var length = sorteio.numeros.length;
  var opcoesDeNumeros = ""; 
  for (var i = 0; i < length; i++) { //aqui, i é o elemento do array
    opcoesDeNumeros += "<option value='" + sorteio.numeros[i] + "'"+ " >" + sorteio.numeros[i] + "</option>"; 
  };
  
  //criando seletores para quantidade de apostas
  var seletorQuantidade = document.getElementById("quantidade");
  var opcoesQuantidadeJogos = '<option value="">Selecione</option>';
  var lengthQuantidade = quantidadeJogos.length;
  for (var i = 0; i < lengthQuantidade; i++) { //aqui, i é o elemento do array
    opcoesQuantidadeJogos += "<option value='" + quantidadeJogos[i] + "'"+ " >" + quantidadeJogos[i] + "</option>"; 
  };
  seletorNumeros.innerHTML = opcoesDeNumeros; //seletor de números a apostas
  seletorQuantidade.innerHTML = opcoesQuantidadeJogos; //quantidade de apostas
}


  // FUNÇÃO PARA SELECIONAR TODAS AS QUOTAS COMO PAGAS
  function selectAll() {
      var blnChecked = document.getElementById("todos_pagos").checked;
      var check_pagamentoS = document.getElementsByClassName("pagamento");
      var intLength = check_pagamentoS.length;
      for(var i = 0; i < intLength; i++) {
          var check_pagamento = check_pagamentoS[i];
          check_pagamento.checked = blnChecked;
      }
  }


function checaPagamentos() {
  var blnChecked = document.getElementById("todos_pagos")
  var check_pagamentoS = document.getElementsByClassName("pagamento");
  var intLength = check_pagamentoS.length;
  var total = 0;
  for(var i = 0; i < intLength; i++) {
      var check_pagamento = check_pagamentoS[i];
      if (check_pagamento.checked == false) {
        total += 1
      };
  if ( total > 0 ) {
    blnChecked.checked = false;
  } else if (total == 0) {
    blnChecked.checked = true;
  }
  }
}


function opcoesBolao() {
  var fazerBolaoSim = document.getElementById("bolaoSim");
  var fazerBolaoNao = document.getElementById("bolaoNao");

  if (fazerBolaoSim.checked) {
    document.getElementById("divDoBolao").setAttribute("style", "")
    document.getElementById("quantidadeApostadores2").required = true

    //criando seletores para o número de apostadores do bolão:
    var arrayDeCem = Array.from(Array(100).keys()); // cria array de 0 a 99
    var arrayDeCemNovo = arrayDeCem.map(num => num + 1); // soma 1 a cada elemento do array anterior, ou seja, cria array de 1 a 100
    arrayDeCemNovo.splice(0, 1); // isso retira 1 item do array, começando pelo índice 0, fazendo ele começar pelo número 2
    var seletorApostadores = document.getElementById("quantidadeApostadores2");
    // seletorApostadores.required = true
    var length = arrayDeCemNovo.length;
    var opcoesDeApostadores = '<option value="">Selecione</option>'; 
    for (var i = 0; i < length; i++) { //aqui, i é o elemento do array
      opcoesDeApostadores += "<option value='" + arrayDeCemNovo[i] + "'"+ " >" + arrayDeCemNovo[i] + "</option>"; 
    };
    seletorApostadores.innerHTML = opcoesDeApostadores; //seletor de apostadores criado



  } else if (fazerBolaoNao.checked) {
    document.getElementById("divDoBolao").setAttribute("style", "display: none")
    document.getElementById("quantidadeApostadores2").required = false
  };
};

function opcoesQuotas() {
  var bolaoQuotasSim = document.getElementById("bolaoQuotasSim");
  var bolaoQuotasNao = document.getElementById("bolaoQuotasNao");
  if (bolaoQuotasSim.checked) {
    // fazerBolaoNao.checked == false
    document.getElementById("divDasQuotas").setAttribute("style", "")
  } else if (bolaoQuotasNao.checked) {
    document.getElementById("divDasQuotas").setAttribute("style", "display: none")
  };
};  



// ARRUMAR ISSO PARA TOTALIZAR AS COTAS
function logKey() {
  var input = document.getElementsByClassName("my-input");
  var total = 0;
  for (var i = 0; i < input.length; i++) { //aqui, i é o elemento do array
    var valor = parseFloat(input[i].value);
    total += valor; 
  };
  var inputTotal = document.getElementById("total")
  inputTotal.innerHTML = total  
};


var arrayDeCem = Array.from(Array(100).keys()) // cria array de 0 a 99
var arrayDeCemNovo = arrayDeCem.map(num => num + 1); // soma 1 a cada elemento do array anterior, ou seja, cria array de 1 a 100
// Criar html <select name="hour"> // com a quantidade de jogadores e isso abrirá campos para preencher jogador, pagamento e quotas, se for o caso
//               <option value="1">1</option>
//            </select>


// ACESSAR:
// https://www.w3schools.com/tags/tag_label.asp
// https://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_input_type_text
// https://www.w3schools.com/tags/att_input_maxlength.asp
// https://getbootstrap.com/docs/4.0/components/forms/
// Acessando parâmetros: request.parameters["sorteio"] 
// Resposta do request:
// {"sorteio"=>"mega",
//  "quantidadeNumeros"=>"6",
//  "quantidadeJogos"=>"2",
//  "data"=>"2022-05-11",
//  "bolao"=>"sim",
//  "quatidadeApostadores"=>"4",
//  "apostador1"=>"Gretchen",
//  "pagamento1"=>"on",
//  "apostador2"=>"Eduardo",
//  "pagamento2"=>"on",
//  "bolaoQuotas"=>"sim",
//  "quatidadeQuotas"=>"2"}

export { trocarSeletorNumeros };
export { selectAll };
export { opcoesBolao };
export { opcoesQuotas };
export { logKey };
export { checaPagamentos };



