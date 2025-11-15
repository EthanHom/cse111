// Create express app
var express = require("express")
var app = express()

const Computers = require('./computers')
var computers = new Computers('../data.sqlite')

// Server port
var HTTP_PORT = 8092

app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);

    next();
});

// Start server
app.listen(HTTP_PORT, () => {
    console.log("Server running on port %PORT%".replace("%PORT%", HTTP_PORT))
});

// Root endpoint
app.get("/", (req, res, next) => {
    res.json({ "message": "Ok" })
});

// Insert here other API endpoints
app.get("/api/makers", (req, res, next) => {
    computers.allMakers()
        .then((makers) => {
            res.json({
                "message": "success",
                "data": makers
            })
        })
        .catch((err) => {
            res.status(400).json({ "error": err.message });
            return;
        })
});

app.get("/api/maker-prod/:maker-:prod", (req, res, next) => {
    if (req.params.prod == "All") {
        computers.allProductsByMaker(req.params.maker)
            .then((prods) => {
                res.json({
                    "message": `Products by ${req.params.maker}`,
                    "data": prods
                })
            })
            .catch((err) => {
                res.status(400).json({ "error": err.message });
                return;
            })
    }
    else {
        computers.productByMaker(req.params.prod, req.params.maker)
            .then((prods) => {
                res.json({
                    "message": `${req.params.prod} by ${req.params.maker}`,
                    "data": prods
                })
            })
            .catch((err) => {
                res.status(400).json({ "error": err.message });
                return;
            })
    }
});

// Default response for any other request
app.use(function (req, res) {
    res.status(404);
});
