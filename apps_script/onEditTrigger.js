// https://developers.google.com/apps-script/guides/triggers/events
// https://developers.google.com/apps-script/reference/spreadsheet/sheet
// https://developers.google.com/apps-script/reference/spreadsheet/range
// https://developers.google.com/apps-script/reference/drive

const MasterSheetName       = 'Funnel';
const MasterSheetColumn     = 2;
const MasterSheetLinkColumn = 4;
const MasterSpreadshhetID   = '15n_YlCCqxadfqwdwdqrfemSa60Zttg'; 
const TemplateDirectoryID   = '15n_YlCCqxadfrgO8O5fQNmSa60Zttg';
const ParrentDirecotryID    = '15n_YlCCqxadfrgO8Osa2dmSa60Zttg';

// =================== ENTRY POINT ===================
// this function is a watcher/trigger handler
// ===================================================
function installableOnEdit(e) {
    // checking if we deal with an event triggered on a single cell
    const eventColumn     = e.range.getColumn()
    const eventLastColumn = e.range.getLastColumn()
    const eventRow        = e.range.getRow()
    const eventLastRow    = e.range.getLastRow()
    if (eventColumn !== eventLastColumn || eventRow !== eventLastRow) {
        // this is not a single cell, we simply ignore this event without prompt
        return
    }

    // checking if we deal with an event triggered on correct sheet and column
    const eventSheet  = e.range.getSheet()
    if (eventSheet.getName() !== MasterSheetName || eventColumn !== MasterSheetColumn) {
        // wrong sheet or wrong column, we simply ignore this event without prompt
        return
    }
    
    // checking if we deal with an event triggered on fresh (untouched) cell
    const oldValue = e.oldValue
    const newValue = e.value
    if (typeof oldValue !== 'undefined' || typeof newValue === 'undefined') {
        // oldValue !== 'undefined' => this means that edited cell was not empty
        // newValue === 'undefined' => this means that edited cell is empty (like just hiting Enter key without data)
        // we simply ignore this event without prompt
        return
    }
    
    // event sanity is ok, we can proced with directory creation
    const newDirName = newValue.trim()
    if (newDirName) {
        Logger.log(`creation of ${newDirName} triggered by ${e.user}`)
        
        // checking if provided value is uniqe accross column B ("Lead name")
        // we want to prompt to the user when not unique
        if (!isLeadNameUnique(newDirName, eventSheet)) {
            SpreadsheetApp.getUi().alert(`Lead name ${newDirName} is already taken`)
            return
        }
                
        // create direcotory in Google Drive
        const parentDir = DriveApp.getFolderById(ParrentDirecotryID)
        const newDir    = parentDir.createFolder(newValue)
        
        // store the URL of new directory into Master spreadsheet
        const newDirURL = newDir.getUrl()
        eventSheet.getRange(eventRow, MasterSheetLinkColumn).setValue(newDirURL)
        
        // fill new dir with template data
        const templateDir = DriveApp.getFolderById(TemplateDirectoryID)
        copyContent(templateDir, newDir)
    }
}


// checking if provided value is uniqe accross column B ("Lead name")
function isLeadNameUnique(name, sheet) {
    const range    = sheet.getRange(1, MasterSheetColumn, sheet.getMaxRows(), MasterSheetColumn)
    const values   = range.getValues().map(item => item[0]) // the Range is always of type Object[][], but we need only first column
    const filtered = values.filter(item => item.trim() === name)
    if (filtered.length === 1) {
        return true
    }
    return false
}

// get content of source directory and copy it into target directory
function copyContent(source, target) {
    const folders = source.getFolders();
    const files   = source.getFiles();

    while(files.hasNext()) {
        let file = files.next();
        file.makeCopy(file.getName(), target);
    }

    while(folders.hasNext()) {
        const subFolder    = folders.next();
        const folderName   = subFolder.getName();
        const targetFolder = target.createFolder(folderName);
        // recursion on purpose
        copyContent(subFolder, targetFolder);
    }
}
