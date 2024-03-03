document.getElementById("add").addEventListener("click", addDevice);
document.getElementById("createXML").addEventListener("click", exportXML);
document.getElementById("createPDF").addEventListener("click", createPdf);

function addDevice() {
  var name = document.getElementById("name").value;
  var runtime = document.getElementById("runtime").value;
  var power = document.getElementById("power").value;

  if (name === "" || runtime === "" || power === "") {
    alert("Please fill in all the required fields.");
    return;
  }

  var powerusage = (runtime * power) / 1000;

  var table = document.getElementById("deviceTable");
  var row = table.insertRow(-1);
  var nameCell = row.insertCell(0);
  var runtimeCell = row.insertCell(1);
  var powerCell = row.insertCell(2);
  var totalCell = row.insertCell(3);

  nameCell.innerHTML = name;
  runtimeCell.innerHTML = runtime;
  powerCell.innerHTML = powerusage.toFixed(2);
  totalCell.innerHTML = calculateTotal();
}

function calculateTotal() {
  var table = document.getElementById("deviceTable");
  var total = 0;

  for (var i = 1; i < table.rows.length; i++) {
    var powerusage = parseFloat(table.rows[i].cells[2].innerHTML);
    total += powerusage;
  }

  return total.toFixed(3);
}

function createXML() {
  var table = document.getElementById("deviceTable");
  var xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
  xml += "<table>\n";

  for (var i = 1; i < table.rows.length; i++) {
    var name = table.rows[i].cells[0].innerHTML;
    var runtime = table.rows[i].cells[1].innerHTML;
    var power = table.rows[i].cells[2].innerHTML;

    xml += "  <device>\n";
    xml += "    <name>" + name + "</name>\n";
    xml += "    <runtime>" + runtime + "</runtime>\n";
    xml += "    <power>" + power + "</power>\n";
    xml += "  </device>\n";
  }

  xml += "</table>";

  return xml;
}

function loadXMLDoc(filename) {
  if (window.ActiveXObject) {
    xhttp = new ActiveXObject("Msxml2.XMLHTTP");
  } else {
    xhttp = new XMLHttpRequest();
  }
  xhttp.open("GET", filename, false);
  xhttp.send("");
  return xhttp.responseXML;
}

function exportXML() {
  const xmlString = createXML();
  const blob = new Blob([xmlString], { type: "application/xml" });
  const link = document.getElementById("dummyXML");
  link.href = window.URL.createObjectURL(blob);
  link.download = "myReport.xml";
  link.click();
}

async function createPdf() {
  var xmlString = createXML();
  var parser = new DOMParser();
  var xmlDoc = parser.parseFromString(xmlString, "application/xml");
  var xsl = loadXMLDoc("calculator/fo.xsl");
  xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(xsl);
  resultDocument = xsltProcessor.transformToFragment(xmlDoc, document);

  const serializer = new XMLSerializer();
  const document_fragment_string = serializer.serializeToString(resultDocument);

  const response = await fetch("/convertToPdf", {
    method: "POST",
    body: document_fragment_string,
  });

  if (response.status === 200) {
    const buffer = await response.arrayBuffer();
    const blob = new Blob([buffer], { type: "application/pdf" });
    const link = document.getElementById("dummyPDF");
    link.href = window.URL.createObjectURL(blob);
    link.download = "myReport.pdf";
    link.click();
  }
}
