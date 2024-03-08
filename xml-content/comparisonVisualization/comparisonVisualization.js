//copied from the import feature I just need it to but it is not my feature


document.getElementById('addPlant').addEventListener('click', uploadXmlFile);

//get xsl file
var xslFile = new XMLHttpRequest();
xslFile.open("GET", "comparisonVisualization/comparisonVisualization.xsl", false);
xslFile.send();
var xsl = xslFile.responseXML;


async function uploadXmlFile() {
    const fileInput = document.getElementById('xmlFileInput');

    if (fileInput.files.length === 0) {
        displayMessage('Please select an XML file.', 'error');
        return;
    }

    const xmlFile = fileInput.files[0];
    const xmlString = await readFileAsText(xmlFile);

    fetch('/vis', {
        method: 'POST',
        body: xmlString,
    })
        .then(response => {
            if (response.ok) {
                applyXSLOnXml(xmlString);
            } else {
                displayMessage('Error uploading the XML file.', 'error');
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
}

function applyXSLOnXml(xmlString) {

    var xml = new DOMParser().parseFromString(xmlString, "text/xml");

    var xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);
    var resultDocument = xsltProcessor.transformToDocument(xml);


    var resultString = new XMLSerializer().serializeToString(resultDocument);

    //load new page with teststring
    var newWindow = window.open();
    newWindow.document.write(resultString);
    newWindow.document.close();


}
function displayMessage(message, messageType) {
    const messageContainer = document.getElementById(messageType + 'Message');

    messageContainer.style.height = 'auto';
    const containerHeight = messageContainer.clientHeight + 'px';
    messageContainer.style.height = '0';

    setTimeout(() => {
        messageContainer.style.height = containerHeight;
        messageContainer.style.opacity = '1';
        messageContainer.style.visibility = 'visible';
    }, 10);

    messageContainer.textContent = message;

    setTimeout(() => {
        messageContainer.style.height = '0';
        messageContainer.style.opacity = '0';
        messageContainer.style.visibility = 'hidden';
        messageContainer.textContent = '';
    }, 3000);
}

async function readFileAsText(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = (event) => resolve(event.target.result);
        reader.onerror = (error) => reject(error);
        reader.readAsText(file);
    });
}
