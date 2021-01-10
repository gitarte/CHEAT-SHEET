# node.js application as Windows10 service

## Install node.js
https://nodejs.org/en/download/

## Install Non-Sucking Service Manager
https://nssm.cc/download

##Create the application 
```bash
# Powershell
mkdir C:\myapp
cd C:\myapp
npm init (entry point: index.js)
npm install express --save
```

Where `index.js` is
```javascript
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get('/exception', (req, res) => {
    let i = 1 / 0; // LOL
    res.send(i)
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
```

## Create the service (where "myapp" is the name of ther application)
```bash
# Powershell as Administrator
nssm.exe install myapp "C:\Program Files\nodejs\node.exe"
nssm.exe set     myapp AppDirectory  "C:\myapp"
nssm.exe set     myapp AppParameters "index.js"
nssm.exe start   myapp
```

## Verify
```bash
# Powershell (yes Win10 coms with curl preinstalled
curl.exe http://localhost:3000/
services.msc
```
