import html2canvas from 'html2canvas';
window.jsPDF = window.jspdf.jsPDF;


function salvarPDF() {
  var doc = new jsPDF({unit: 'pt', format: [1400, 2000], orientation: 'portrait' });
  var printar = document.getElementById("printar_pdf")
  // const html2canvas = require('html2canvas');
  // window.html2canvas = html2canvas;
  window["html2canvas"] = html2canvas;
  doc.html(printar, {
    autoPaging: 'text',
    margin: [120, 0, 120, 0],
    callback: function (doc) {

      //criando um texto eTarta.com.br e centralizando o conteúdo
      var width = doc.internal.pageSize.getWidth()
      doc.setFontSize(15);
      doc.setTextColor("#204A65");
      doc.text(width/2, 202, "eTARTA.com.br", {align:  'center'});
      
      //salvando o pdf
      doc.save('Minhas_apostas.pdf');
    },
    // filename: ,
    // orientation: 'portrait',
    // format: 'a4',
    // unit: 'mm',
    // scale: 1,
    // width: 50,
    // autoPaging: 'text',
    x: 10,
    y: 10
});

}

export { salvarPDF };