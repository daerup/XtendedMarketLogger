# Xtended-Market-Logger

Der Xtended-Market-Logger&trade; ermöglicht es, die Strompreise von verschiedenen Standorten zu erfassen und zu analysieren. Die Kunden werden auf Ihre Verbrauchsgewohnheiten aufmerksam gemacht und können so ihre Stromkosten senken.

Der Xtended-Market-Logger&trade; ist ein Produkt aus der XML & JSON Technologies Blockwoche an der Hochschule Luzern.

## Architektur
Hier werden alle Architekturen für die einzelnen Features ausführlich dargestellt und erklärt.

### Plant Comparison

Hier wird zunächst ein Formular aufgebaut, welches Einschränkungen aus der Datenbank berücksichtigt (frühestes und spätestes Datum). Beim Bestätigen des Formulars werden die Daten im `comparison.js` ausgelesen und als JSON an `index.js` des Servers gesendet. Dieser erstellt dann anhand der mitgegebenen Daten und der bestehenden Datenbank in memory ein XML-Dokument. Dieses Dokument wird dann von `plantComparison.done.xsl` in XHTML umgewandelt. `comparison.js` nimmt das Resultat entgegen und überschreibt den Body von `plantComparison.xml` mit dem Resultat.

![alt text](./documentation/images/comparison.svg)

### Calculator

Neue Geräte werden zuerst in einer Tabelle auf der Website dargestellt. Diese Tabelle kann dann als XML oder PDF heruntergeladen werden. In beiden Fällen wird zuerest ein XML-Dokument auf dem serverseitigem `index.js` generiert. Dieses generierte XML kann mittels FO-Transformation im `calculator.js` in ein PDF umgewandelt werden.

![alt text](./documentation/images/calculator.svg)

### Data import
Mit diesem Feature können Benutzer eine XML-Datei hochladen. Die hochgeladene Datei wird validiert und in der Datenbank `database.xml` gespeichert. Benutzer haben ebenfalls die Möglichkeit, ein XML direkt zu schreiben und hochzuladen. Um die XML-Datei den Benutzern einfacher darzustellen, wird `validation.js` verwendet. Sobald eine XML-Datei ausgewählt wird, wird sie in der Preview-Textarea angezeigt. Mit dem 'Add'-Button im Formular kann bestätigt werden, dass die XML-Datei in die Datenbank geladen werden darf. Die Validierung der XML erfolgt serverseitig in `index.js` und basiert auf einem XSD-Schema `uploadXML.xsd`.

![alt text](./documentation/images/dataimport.svg)

## Comparison Visualization

Diese Funktion ermöglicht es Benutzern, die XML-Datei, die beim der 'Plant Comparison' heruntergeladen werden kann, zu visualisieren. Es kann eine XML-Datei ausgewählt werden, die dann mit einem Klick auf 'Visualisieren' an den Server gesendet wird. Der Server validiert das XML anhand des 'database.xsd' und sendet es zurück. Im Browser wird das XML dann mithilfe der comparisonVisualization.xsl-Datei in ein XHTML-Dokument mit eingebetteten SVGs umgewandelt. Das XHTML-Dokument wird nun in einem neuen Tab geöffnet.

![alt text](./documentation/images/comparisonVisualization.svg)

## Frameworks und Technologien

- XML
- JSON
- CSS
- HTML
- JavaScript
- Node
- Express

## Stolpersteine

Ein Herausforderung war es, bei 'plantComparison' das Resultierende XML-Dokument erneut für den Benutzer darzustellen. Gelöst werden konnte dies, indem auf der Client-Seite mittels XSLT Transformiert wurde und das Resultat mit JavaScript den DOM manipuliert wurde.

Ein Problem bei 'comparisonVisualization' ist, dass die XML-Datei an den Server gesendet werden muss. Ich wollte das XML-File lokal validieren und transformieren, aber ich habe keinen guten Weg gefunden, dies umzusetzen. Auch sollte das resultierende XHTML der Transformation mittels JavaScript in den DOM eingefügt werden. Aus unerklärlichen Gründen wurde dann aber der Linien-Graf nicht angezeigt. Als workaround wurde dann das XHTML in einem neuen Tab geöffnet.

## Einsatz von nicht XML Technologien

Für den Aufbau von in memory XML-Dokumenten wurde JavaScript benutzt. Hierfür wurde die Bibliothek [`libxmljs`](https://www.npmjs.com/package/libxmljs) verwendet. Diese Bibliothek ermöglicht es, XML-Dokumente in JavaScript zu erstellen und zu manipulieren.

Auch wurde JavaScript verwendet, um Manipulationen am DOM vorzunehmen und diesen ansprechlicher zu gestalten.

Die Anfragen an das Backend wurden mit JSON gestaltet. Dies hat den Grund, dass die JavaScript Objekte, welche an das Backend übertragen werden, besonders einfach in JSON umgewandelt werden können. Auch verwenden wir `fetch`, welches standardmässig JSON verwendet. Das bauen von XML-Requests wäre möglich, dann könnte aber `libxmljs`nicht mehr verwendet werden und wir müssten auf eine andere Bibliothek oder string interpolation zurückgreifen. Um die Komplexität des Projektes zu reduzieren, haben wir uns deshalb für Kommunukation in JSON entschieden.

#### Data import
Sobald eine XML-Datei ausgewählt wurde, kann sie als Vorschau angezeigt werden. Auf diese Weise kann sie überarbeitet werden, und die aktualisierte Version wird dann in die Datenbank geschrieben. Diese Funktion wurde mit JavaScript implementiert.

## Fazit

Das detaillierte Arbeiten mit XML war neu für uns. Vor dieser Blockwoche hatten wir nur oberflächliche Kenntnisse über XML. Uns war nicht bewusst, wie mächtig XML ist und wie viele Anwendungsmöglichkeiten es gibt.

Mit dem Resultat sind wir zufrieden. Wir konnten die Anforderungen erfüllen und haben ein Produkt entwickelt, welches die Fähigkeiten von XML aufzeigt.

## Autoren

- Andrin Geiger
- Dario Portmann
- Jonas Fink
- Vithursiya Vijayasingam
