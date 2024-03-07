# Xtended-Market-Logger
Der Xtended-Market-Logger&trade; ermöglicht es, die Strompreise von verschiedenen Standorten zu erfassen und zu analysieren. Die Kunden werden auf Ihre Verbrauchsgewohnheiten aufmerksam gemacht und können so ihre Stromkosten senken. 

Der Xtended-Market-Logger&trade; ist ein Produkt aus der XML & JSON Technologies Blockwoche an der Hochschule Luzern.

## Architektur


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

## Einsatz von nicht XML Technologien
Für den Aufbau von in memory XML-Dokumenten wurde JavaScript benutzt. Hierfür wurde die Bibliothek [`libxmljs`](https://www.npmjs.com/package/libxmljs) verwendet. Diese Bibliothek ermöglicht es, XML-Dokumente in JavaScript zu erstellen und zu manipulieren.

Auch wurde JavaScript verwendet, um Manipulationen am DOM vorzunehmen und diesen ansprechlicher zu gestalten.

Die Anfragen an das Backend wurden mit JSON gestaltet. Dies hat den Grund, dass die JavaScript Objekte, welche an das Backend übertragen werden, besonders einfach in JSON umgewandelt werden können. Auch verwenden wir ```fetch```, welches standardmässig JSON verwendet. Das bauen von XML-Requests wäre möglich, dann könnte aber ```libxmljs```nicht mehr verwendet werden und wir müssten auf eine andere Bibliothek oder string interpolation zurückgreifen. Um die Komplexität des Projektes zu reduzieren, haben wir uns deshalb für Kommunukation in JSON entschieden.

## Fazit
Das detaillierte Arbeiten mit XML war neu für uns. Vor dieser Blockwoche hatten wir nur oberflächliche Kenntnisse über XML. Uns war nicht bewusst, wie mächtig XML ist und wie viele Anwendungsmöglichkeiten es gibt.

Mit dem Resultat sind wir zufrieden. Wir konnten die Anforderungen erfüllen und haben ein Produkt entwickelt, welches die Fähigkeiten von XML aufzeigt.

## Autoren
- Andrin Geiger
- Dario Portmann
- Jonas Fink
- Vithursiya Vijayasingam