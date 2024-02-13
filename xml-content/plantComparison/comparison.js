document.getElementById('compare').addEventListener('click', createComparison);

async function createComparison() {
    const start = document.getElementById('start').value
    const end = document.getElementById('end').value
    const response = await fetch('/comparePlants', {
        method: 'POST',
        body: JSON.stringify({ start, end }),
    })

    if (!response.ok) {
        const error = await response.text()
        alert(`Could not compare plants:\n${error}`)
        return
    }
    const xmlString = await response.text()
    const xsltUrl = '../plantComparison/plantComparison.done.xsl';
    const blob = new Blob([xmlString], { type: 'text/xml' });

    const xmlUrl = URL.createObjectURL(blob);

    const xsltRequest = new XMLHttpRequest();
    xsltRequest.open('GET', xsltUrl);
    xsltRequest.onload = () => {
        const xsltText = xsltRequest.responseText;
        const parser = new DOMParser();
        const xsltDoc = parser.parseFromString(xsltText, 'text/xml');
        const transformedXml = applyXsltTransformation(xmlUrl, xsltDoc);
        document.body.innerHTML = transformedXml;
        setDownloadLink(blob)
        setCardColors();
    };
    xsltRequest.send();
}

function applyXsltTransformation(xmlUrl, xsltDoc) {
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
}

function setDownloadLink(blob) {
    const url = URL.createObjectURL(blob);
    const link = document.getElementById('download');
    link.href = url;
    link.download = 'comparison.xml';
}

function setCardColors() {
    const firstColor = { r: 13, g: 106, b: 83 };
    const lastColor = { r: 219, g: 84, b: 90 };

    const cards = document.querySelectorAll('#comparison .card');
    const totalCards = cards.length;

    const calculateGradientColor = (firstColor, lastColor, index, totalCards) => {
        const currentR = firstColor.r + (lastColor.r - firstColor.r) / (totalCards - 1) * index;
        const currentG = firstColor.g + (lastColor.g - firstColor.g) / (totalCards - 1) * index;
        const currentB = firstColor.b + (lastColor.b - firstColor.b) / (totalCards - 1) * index;
        return `rgb(${currentR}, ${currentG}, ${currentB})`;
    };


    const groups = Array.from(cards).reduce((acc, card) => {
        const key = card.getElementsByTagName('div')[0].innerText;
        if (!acc[key]) {
            acc[key] = [];
        }
        acc[key].push(card);
        return acc;
    }, {});

    Object.entries(groups).forEach(([key, value], index) => {
        const color = calculateGradientColor(firstColor, lastColor, index, Object.keys(groups).length);
        value.forEach(card => {
            card.style.backgroundColor = color;
        });
    });
}