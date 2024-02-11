document.getElementById('compare').addEventListener('click', createComparison);

async function createComparison() {
    const start = document.getElementById('start').value
    const end = document.getElementById('end').value
    const response = await fetch('/comparePlants', {
        method: 'POST',
        body: JSON.stringify({ start, end }),
    })

    const xmlString = await response.text()
    const xsltUrl = '../ortschaftenvergleich/ortschaftenvergleich.done.xsl'; // URL to your XSLT file
    const blob = new Blob([xmlString], { type: 'text/xml' });

    // Create a URL for the Blob
    const xmlUrl = URL.createObjectURL(blob);

    // Load XSLT file
    const xsltRequest = new XMLHttpRequest();
    xsltRequest.open('GET', xsltUrl);
    xsltRequest.onload = () => {
        const xsltText = xsltRequest.responseText;
        const parser = new DOMParser();
        const xsltDoc = parser.parseFromString(xsltText, 'text/xml');
        const transformedXml = applyXsltTransformation(xmlUrl, xsltDoc);
        document.body.innerHTML = transformedXml;
    };
    xsltRequest.send();
}

function applyXsltTransformation(xmlUrl, xsltDoc) {
    try {
        const processor = new XSLTProcessor();
        processor.importStylesheet(xsltDoc);

        const xmlRequest = new XMLHttpRequest();
        xmlRequest.open('GET', xmlUrl, false);
        xmlRequest.send();
        const xmlDoc = xmlRequest.responseXML;

        const transformedDoc = processor.transformToFragment(xmlDoc, document);


        const serializer = new XMLSerializer();
        const transformedXml = serializer.serializeToString(transformedDoc);
        return transformedXml;
    } catch (error) {
        console.error('Error applying XSLT transformation');
        console.error(JSON.stringify(error));
    }
}