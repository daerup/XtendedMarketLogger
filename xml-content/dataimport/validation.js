document.getElementById('xmlFileInput').addEventListener('change', uploadXmlFile);

async function uploadXmlFile() {
    const fileInput = document.getElementById('xmlFileInput');
    const xmlFileText = document.getElementById('xmlFileText');

    if (fileInput.files.length === 0) {
        displayMessage('Please select an XML file.', 'error');
        return;
    }

    const xmlFile = fileInput.files[0];
    const xmlString = await readFileAsText(xmlFile);

    xmlFileText.value = xmlString;
}

async function readFileAsText(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = (event) => resolve(event.target.result);
        reader.onerror = (error) => reject(error);
        reader.readAsText(file);
    });
}
