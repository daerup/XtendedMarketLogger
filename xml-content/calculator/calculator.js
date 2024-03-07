document.getElementById("add").addEventListener("click", addDevice);
document.getElementById("createXML").addEventListener("click", exportXML);
document.getElementById("createPDF").addEventListener("click", createPdf);

function addDevice() {
  const name = document.getElementById("name").value;
  const runtime = document.getElementById("runtime").value;
  const power = document.getElementById("power").value;

  if (name === "" || runtime === "" || power === "") {
    alert("Please fill in all the required fields.");
    return;
  }

  const powerusage = (runtime * power) / 1000;

  const table = document.getElementById("deviceTable");
  const row = table.insertRow(-1);
  const nameCell = row.insertCell(0);
  const runtimeCell = row.insertCell(1);
  const powerCell = row.insertCell(2);
  const totalCell = row.insertCell(3);

  nameCell.innerHTML = name;
  runtimeCell.innerHTML = runtime;
  powerCell.innerHTML = powerusage.toFixed(2);
  totalCell.innerHTML = calculateTotal();
}

function calculateTotal() {
  let total = 0;
  const table = document.getElementById("deviceTable");

  for (const i = 1; i < table.rows.length; i++) {
    const powerusage = parseFloat(table.rows[i].cells[2].innerHTML);
    total += powerusage;
  }

  return total.toFixed(3);
}

async function createXML() {
  const table = document.getElementById("deviceTable");
  const data = Array.from(table.rows)
    .slice(1)
    .map((row) => ({
      name: row.cells[0].innerHTML,
      runtime: row.cells[1].innerHTML,
      power: row.cells[2].innerHTML,
    }));
  const response = await fetch("/buildXML", {
    method: "POST",
    body: JSON.stringify(data),
  });

  if (response.status !== 200) {
    throw new Error("Failed to create XML");
  }
  return await response.text();
}

function loadXMLDoc(filename) {
  let xhttp;
  if (window.ActiveXObject) {
    xhttp = new ActiveXObject("Msxml2.XMLHTTP");
  } else {
    xhttp = new XMLHttpRequest();
  }
  xhttp.open("GET", filename, false);
  xhttp.send("");
  return xhttp.responseXML;
}

async function exportXML() {
  const xmlString = await createXML();
  const blob = new Blob([xmlString], { type: "application/xml" });
  const link = document.getElementById("dummyXML");
  link.href = window.URL.createObjectURL(blob);
  link.download = "myReport.xml";
  link.click();
}

async function createPdf() {
  const xmlString = await createXML();
  const parser = new DOMParser();
  const xmlDoc = parser.parseFromString(xmlString, "application/xml");
  const xsl = loadXMLDoc("calculator/fo.xsl");
  const xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(xsl);
  const resultDocument = xsltProcessor.transformToFragment(xmlDoc, document);

  const serializer = new XMLSerializer();
  const documentFragmentString = serializer.serializeToString(resultDocument);

  const response = await fetch("/convertToPdf", {
    method: "POST",
    body: documentFragmentString,
  });

  if (response.status !== 200) {
    throw new Error("Failed to create PDF");
  }

  const buffer = await response.arrayBuffer();
  const blob = new Blob([buffer], { type: "application/pdf" });
  const link = document.getElementById("dummyPDF");
  link.href = window.URL.createObjectURL(blob);
  link.download = "myReport.pdf";
  link.click();
}
