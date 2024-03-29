const express = require("express");
const path = require("path");
const fs = require("fs");
const libxmljs = require("libxmljs2");
const app = express();

const payloadLimit = '10mb'
app.use(express.static(path.join(__dirname, 'xml-content')));
app.use(express.text({ limit: payloadLimit }));
app.use(express.urlencoded({ limit: payloadLimit, extended: false }));

app.get('/', (req, res) => {
    res.sendFile(path.resolve('xml-content', 'index.xml'));
})

app.post("/buildXML", async (req, res) => {
  const data = JSON.parse(req.body);
  const xmlDoc = new libxmljs.Document();
  const tableNode = xmlDoc.node("table");
  data.forEach((row) => {
    const deviceNode = tableNode.node("device");
    deviceNode.node("name", row.name);
    deviceNode.node("runtime", row.runtime);
    deviceNode.node("power", row.power);
  });

  res.setHeader("Content-Type", "application/xml");
  res.setHeader("Content-Disposition", 'attachment; filename="response.xml"');
  res.send(xmlDoc.toString());
});

app.post("/convertToPdf", async (req, res) => {
  const response = await fetch("https://fop.xml.hslu-edu.ch/fop.php", {
    method: "POST",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    body: req.body,
  });
  const responseText = await (await response.blob()).arrayBuffer();
  const buffer = Buffer.from(responseText);
  fs.writeFileSync(path.resolve("temp.pdf"), buffer);
  res.sendFile(path.resolve("temp.pdf"));
});

app.post("/updateData", (req, res) => {
  const dataToUpdate = req.body;
  // read database xml
  const databasePath = path.resolve("xml-content", "database", "database.xml");
  const databaseXml = fs.readFileSync(databasePath, "utf-8");
  const xmlDocDatabase = libxmljs.parseXml(databaseXml);
  // select node to update
  const plantStatistics = xmlDocDatabase.get(
    `//plant[name="${dataToUpdate.plant}"]/statistics`,
  );

  // create new node with attribute etc.
  plantStatistics
    .node("price", dataToUpdate.price)
    .attr("date", dataToUpdate.date);

  // validate new database against schema
  const valid = validateDatabase(xmlDocDatabase);
  if (!valid) {
    res.status(400).send("Invalid XML");
    return;
  }

  // write new database.xml
  fs.writeFileSync(databasePath, xmlDocDatabase.toString(), "utf-8");

  res.sendStatus(200);
});

app.post("/newPlant", (req, res) => {
    try {
        const xmlData = req.body.xmlFileText;

        const uploadValid = validationXML(libxmljs.parseXml(xmlData), 'uploadXML.xsd')
        if (!uploadValid) {
            res.status(400).send('Invalid XML structure');
            return;
        }

        const databasePath = path.resolve('xml-content', 'database', 'database.xml');
        const databaseXml = fs.readFileSync(databasePath, 'utf-8');
        const xmlDocDatabase = libxmljs.parseXml(databaseXml);
        const newPlantNode = libxmljs.parseXml(xmlData).root();
        const alreadyExists = xmlDocDatabase.get(`//plant[name="${newPlantNode.get('name').text()}"]`);
        if (alreadyExists) {
            res.status(400).send('Plant already exists');
            return;
        }

        const plantInDatabase = xmlDocDatabase.root().get('energie-plant');
        plantInDatabase.addChild(newPlantNode);

        const xmlDocument = libxmljs.parseXml(xmlDocDatabase, { noblanks: true });
        const formattedXmlString = xmlDocument.toString({ format: true });

        fs.writeFileSync(databasePath, formattedXmlString, 'utf-8');
        res.sendStatus(200);
    } catch (error) {
        console.error('Error:', error.message);
        res.status(400).send(error.message);
    }
});


app.post("/comparePlants", (req, res) => {
  const timeframe = JSON.parse(req.body);
  const startDate = new Date(timeframe.start);
  const endDate = new Date(timeframe.end);
  if (startDate == undefined || endDate == undefined) {
    res.status(400).send("Invalid dates provided");
    return;
  }
  if (startDate > endDate) {
    res.status(400).send("Invalid date range");
    return;
  }

  const databasePath = path.resolve("xml-content", "database", "database.xml");
  const databaseXml = fs.readFileSync(databasePath, "utf-8");
  const xmlDbDoc = libxmljs.parseXml(databaseXml);

  const xmlCompareDoc = libxmljs.parseXml(databaseXml);
  xmlCompareDoc.find("//price").forEach((price) => price.remove());
  xmlCompareDoc.find("//text()").forEach((textNode) => {
    if (textNode.text().trim() === "") {
      textNode.remove();
    }
  });

  const toDateString = (date) =>
    `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, "0")}-${date.getDate().toString().padStart(2, "0")}`;
  const toComparableDate = (date) =>
    Number(toDateString(date).replaceAll("-", ""));
  for (
    const date = startDate;
    date <= endDate;
    date.setDate(date.getDate() + 1)
  ) {
    const comparableDate = toComparableDate(date);
    xmlDbDoc.find("//plant").forEach((plant) => {
      const plantName = plant.get("name").text();
      const plantStatistics = plant.get("statistics");
      const price = plantStatistics.get(
        `price[number(translate(@date,'-','')) <= ${comparableDate}][last()]`,
      );
      if (price) {
        xmlCompareDoc
          .get(`//plant[name="${plantName}"]/statistics`)
          .node("price", price.text())
          .attr("date", toDateString(date));
      }
    });
  }

  // send as xml
  res.setHeader("Content-Type", "application/xml");
  res.setHeader("Content-Disposition", 'attachment; filename="response.xml"');
  res.send(xmlCompareDoc.toString());
});

app.post('/vis', (req, res) => {
    try {
        const xmlData = req.body;
        if(!validationXML(libxmljs.parseXml(xmlData), 'database.xsd')) {
            res.status(400).send('Invalid XML structure');
            return;
        }

        res.send(xmlData);
    }
    catch (error) {
        console.error('Error:', error.message);
        res.status(400).send(error.message);
    }
});

function validateDatabase(xmlDocDatabase) {
  const databaseXsd = fs.readFileSync(
    path.resolve("xml-content", "database", "database.xsd"),
    "utf-8",
  );
  const xmlDocDatabaseXsd = libxmljs.parseXml(databaseXsd);
  return xmlDocDatabase.validate(xmlDocDatabaseXsd);
}

function validationXML(xmlFile, xsdPath){
    const upoloadXsd = fs.readFileSync(path.resolve('xml-content', 'database', xsdPath), 'utf-8');
    const uploadXMLXsd = libxmljs.parseXml(upoloadXsd);

    return xmlFile.validate(uploadXMLXsd);
}

const port = 6969;
app.listen(port, () => {
  const url = `http://localhost:${port}`;
  console.log("listening on port", url);
});
