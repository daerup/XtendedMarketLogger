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

    const xmlUrl = URL.createObjectURL(blob);

    const xsltRequest = new XMLHttpRequest();
    xsltRequest.open('GET', xsltUrl);
    xsltRequest.onload = async () => {
        const xsltText = xsltRequest.responseText;
        const parser = new DOMParser();
        const xsltDoc = parser.parseFromString(xsltText, 'text/xml');
        const transformedXml = applyXsltTransformation(xmlUrl, xsltDoc);
        document.body.innerHTML = transformedXml;
        await setDownloadLink(blob)
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

async function setDownloadLink(blob) {
    const url = URL.createObjectURL(blob);
    const link = document.getElementById('download');
    link.href = url;
    link.download = 'comparison.xml';
}