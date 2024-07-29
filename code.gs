function doGet(e) {
  if (e.parameter.id) {
    return HtmlService.createHtmlOutputFromFile('UpdateProduct');
  }
 else{
  return HtmlService.createTemplateFromFile('Main').evaluate();
  }
}

// Include function for including stylesheet
function include(filename) {
  return HtmlService.createHtmlOutputFromFile(filename).getContent();
}

// Load partials
function loadPartialsHtml(partials) {
  return HtmlService.createTemplateFromFile(partials).evaluate().getContent();
}

function sendEmailIfNeeded(rowIndex) {

  // Spreadsheet ID and sheet name
  var spreadsheetId = '1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc';
  var sheetName = 'Sheet1';

  // Get the sheet
  var sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName(sheetName);

  // Get all data in the sheet
  var data = sheet.getDataRange().getValues();

  // Get the headers from the first row
  var headers = data[0];

  // Find the indices of the Quantity and Stock Level columns
  var quantityIndex = headers.indexOf('Stock Quantity');
  var alertThresholdIndex = headers.indexOf('Alert Threshold');
  var stockIdIndex = headers.indexOf('Stock ID');
    var stockNameIndex = headers.indexOf('Stock Name');
  // Ensure both headers are found
  if (quantityIndex === -1 || alertThresholdIndex === -1 || stockIdIndex === -1 || stockNameIndex === -1) {
    Logger.log('Quantity or Alert Threshold header  or Stock ID header or Stock Name header not found.');
    return;
  }

  // Get the data from the specified row
  var quantity = data[rowIndex][quantityIndex];
  var alertThreshold = data[rowIndex][alertThresholdIndex];
  var stockID = data[rowIndex][stockIdIndex];
  var stockName = data[rowIndex][stockNameIndex];

  // Check if quantity is lower than stock level
  if (quantity < alertThreshold) {
    var recipient = "alantang0410@gmail.com"; // Replace with the recipient's email address
      var subject = "⚠️ Stock Level Alert ⚠️";
      var message = "Dear Boss,\n\n" +
        "We are writing to inform you about the current stock levels:\n\n" +
        "Product ID: " + stockID + "\n" +
        "Stock Name: " + stockName + "\n" +
        "Stock Quantity: " + quantity + "\n" +
        "Alert Threshold: " + alertThreshold + "\n\n" +
        "Action Required: Please take necessary actions.\n\n" +
        "Thank you.\n\n" +
        "Best regards,\n";
    // Send the email
    GmailApp.sendEmail(recipient, subject, message);
  }
}

function loadDashboardView() {
  return loadPartialsHtml("page-Dashboard");
}

function loadManageStocksView() {
  return loadPartialsHtml("page-Manage-Stocks");
}

function loadWarehouseReportView() {
  return loadPartialsHtml("page-Warehouse-Report");
}

function loadCreateProduct()  {
  const url = ScriptApp.getService().getUrl() + "?create=" + true;
  return HtmlService.createHtmlOutput("<script>window.location.replace(" + url + ");<\/script>");
}

// Load spreadsheet and read data
function getSpreadsheetData() {
  try {
    const sheet = SpreadsheetApp.openById("1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc").getSheetByName("Sheet1");
    const lastRow = sheet.getLastRow();
    const data = sheet.getRange('A1:I'+lastRow).getValues();
    Logger.log(data); // Add logging to debug
    return JSON.stringify(data);
  } catch (error) {
    Logger.log("Error: " + error);
    return "Error fetching data"; // Return an error message if there is an issue
  }
}

function addSpreadsheetData(data) {
  try {
    var sheet = SpreadsheetApp.openById("1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc").getSheetByName("Sheet1");
    var jsonData = JSON.parse(data);
    const lastRow = sheet.getLastRow();

    const updateUrl = ScriptApp.getService().getUrl() + "?id=" + lastRow;
    const qrCodeUrl = generateQRCode(updateUrl);

    var row = [
      lastRow,
      jsonData.stockName,
      jsonData.stockQuantity,
      jsonData.expiryDate,
      jsonData.supplier,
      jsonData.stockPrice,
      jsonData.category,
      jsonData.latestIntakeDate,
      jsonData.threshold,
      updateUrl,
      qrCodeUrl
    ];

    sheet.appendRow(row);
    var rowIndex = sheet.getLastRow() - 1; // Row index of the newly added row

    sendEmailNotification(data.stockName, updateUrl, qrCodeUrl);

    // Send email if added data stock level is low
    sendEmailIfNeeded(rowIndex);
    return 'success';
  } catch (error) {
    Logger.log("Error: " + error);
    return 'error: ' + error;
  }
}

function checkQuota() {
  var remainingQuota = MailApp.getRemainingDailyQuota();
  Logger.log('Remaining email quota: ' + remainingQuota);
}

function editSpreadsheetData(data) {
  try {
    var sheet = SpreadsheetApp.openById("1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc").getSheetByName("Sheet1");
    var jsonData = JSON.parse(data);

    var stockId = jsonData.stockId;

    const lastRow = sheet.getLastRow();
    const range = sheet.getRange('A1:I'+lastRow).getValues();
    var values = range.getValues();

    for (var i = 0; i < values.length; i++) {
      if (values[i][0] === stockId) { // Compare with stock ID in the first column
        var row = [
          stockId,
          jsonData.stockName,
          jsonData.stockQuantity,
          jsonData.expiryDate,
          jsonData.supplier,
          jsonData.stockPrice,
          jsonData.category,
          jsonData.latestIntakeDate,
          jsonData.threshold
        ];
        sheet.getRange(i + 1, 1, 1, row.length).setValues([row]);

        // Send email if edited data stock level is low
        sendEmailIfNeeded(i);
        return 'success';
      }
    }
    return 'error: stockId not found';
  } catch (error) {
    Logger.log("Error: " + error);
    return 'error: ' + error;
  }
}

function deleteSpreadsheetData(uniqueId) {
  try {
    var sheet = SpreadsheetApp.openById("1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc").getSheetByName("Sheet1");
    const lastRow = sheet.getLastRow();
    const range = sheet.getRange('A1:I'+lastRow).getValues();
    var values = range.getValues();

    for (var i = 0; i < values.length; i++) {
      if (values[i][0] === uniqueId) { // Compare with unique ID in the first column
        sheet.deleteRow(i + 1);
        return 'success';
      }
    }
    return 'error: uniqueId not found';
  } catch (error) {
    Logger.log("Error: " + error);
    return 'error: ' + error;
  }
}


function createProduct(data) {
  const sheet = SpreadsheetApp.openById('1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc').getActiveSheet();
  const lastRow = sheet.getLastRow();
  
  const updateUrl = ScriptApp.getService().getUrl() + "?id=" + lastRow;
  const qrCodeUrl = generateQRCode(updateUrl);

  const newRow = [
    lastRow,  // Auto-generate stock ID based on the row number
    data.stockName,
    data.stockQuantity,
    data.expiryDate,
    data.supplier,
    data.stockPrice,
    data.category,
    data.latestIntakeDate,
    data.alertThreshold,
    updateUrl,
    qrCodeUrl
  ];

  
  sheet.appendRow(newRow);

  sendEmailNotification(data.stockName, updateUrl, qrCodeUrl);
}

function generateQRCode(url) {
  return qrCodeUrl = "https://qrcode.tec-it.com/API/QRCode?data=" + encodeURIComponent(url);
}

function sendEmailNotification(productName, updateUrl, qrCodeUrl) {
  const emailAddress = Session.getActiveUser().getEmail();
  const subject = 'New Product Created: ' + productName;
  const qrCode =  {
    htmlBody: "<p>A new product has been created.</p>" + "<p>Product Name: " + productName + "</p>" + "<p>Update URL:" + "<a href="+updateUrl+"> Update Form</a></p>" +"<br><img src='"+ qrCodeUrl +"'width=200px>"
  };
  
  MailApp.sendEmail(emailAddress, subject,'Body of the email', qrCode);
}

function getProductData(stockId) {
  const sheet = SpreadsheetApp.openById('1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc').getActiveSheet();
  const data = sheet.getDataRange().getValues();

  for (let i = 1; i < data.length; i++) {
    if (data[i][0].toString() === stockId) {
      var output = {
        stockName: data[i][1],
        stockQuantity: data[i][2],
        expiryDate: data[i][3],
        supplier: data[i][4],
        stockPrice: data[i][5],
        category: data[i][6],
        latestIntakeDate: data[i][7],
        alertThreshold: data[i][8]
      };
      return JSON.stringify(output);
    }
  }
  return {};  // Return an empty object if no matching stock is found
}

function submitUpdateData(input_data) {
  const data = JSON.parse(input_data);
  const sheet = SpreadsheetApp.openById('1muWAQD8h5a4Ks_ypTAQLVUHWdIZrN5kt1i7Us7qgTYc').getActiveSheet();
  const dataRange = sheet.getDataRange();
  const values = dataRange.getValues();
  
  for (let i = 1; i < values.length; i++) {
    if (values[i][0].toString() === data.stockId) {
      sheet.getRange(i + 1, 2).setValue(data.stockName);
      sheet.getRange(i + 1, 3).setValue(data.stockQuantity);
      sheet.getRange(i + 1, 4).setValue(data.expiryDate);
      sheet.getRange(i + 1, 5).setValue(data.supplier);
      sheet.getRange(i + 1, 6).setValue(data.stockPrice);
      sheet.getRange(i + 1, 7).setValue(data.category);
      sheet.getRange(i + 1, 8).setValue(data.latestIntakeDate);
      sheet.getRange(i + 1, 9).setValue(data.alertThreshold);
      return;
    }
  }
}

