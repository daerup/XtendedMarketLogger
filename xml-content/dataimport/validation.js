document.getElementById('addPlant').addEventListener('click', uploadXmlFile);

async function uploadXmlFile() {
    const fileInput = document.getElementById('xmlFileInput');

    if (fileInput.files.length === 0) {
        displayMessage('Please select an XML file.', 'error');
        return;
    }

    const xmlFile = fileInput.files[0];
    const xmlString = await readFileAsText(xmlFile);

    fetch('/newPlant', {
        method: 'POST',
        body: xmlString,
    })
    .then(response => {
        if (response.ok) {
            displayMessage('XML file uploaded and processed successfully.', 'success');
        } else {
            displayMessage('Error uploading the XML file.', 'error');
        }
    })
    .catch(error => {
        console.error('Fetch error:', error);
    });
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
