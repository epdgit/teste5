
function trocarSeletorNumerosConjuntos() {

  var conjuntoArraydaSorteDiretoDoForm = document.getElementById("numeros-da-sorte-fim2").value.split(",")
  var conjuntoFim = []
  for(var i = 0; i < conjuntoArraydaSorteDiretoDoForm.length; i++) {
    conjuntoFim.push(parseInt(conjuntoArraydaSorteDiretoDoForm[i])) // convetendo o array de strings para array de integers
  }
 
 
 
 //POSSIBILIDADE DE NÚMEROS POR APOSTA
  var numerosPossiveis =  [6,7,8,9,10,11,12,13,14,15]
    //criando seletores para números a apostar
  var seletorNumeros = document.getElementById("opcoesDaAposta2");
  var length = numerosPossiveis.length;
  var opcoesDeNumeros = "";
  var quantidadeMarcada = conjuntoFim.length
  var arrayTemp = []
  for (var i = 0; i < length; i++) { //aqui, i é o elemento do array
    if (quantidadeMarcada >= numerosPossiveis[i]) {
      arrayTemp.push(numerosPossiveis[i])
    }
  };
  var len2 = arrayTemp.length
  for (var i = 0; i < len2; i++) { //aqui, i é o elemento do array
      opcoesDeNumeros += "<option value='" + arrayTemp[i] + "'"+ " >" + arrayTemp[i] + "</option>"; 
  };
  seletorNumeros.innerHTML = opcoesDeNumeros; //seletor de números a apostas
}

export { trocarSeletorNumerosConjuntos };