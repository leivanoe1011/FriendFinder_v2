
// Dependencies
var express = require("express");
var mysql = require("mysql");
var path = require("path"); // Allows to read html files

// Instantiate Express
var app = express();

var PORT = process.env.PORT || 8001;

// Create mysql connection
var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "FriendFinder_DB",
    multipleStatements: true // this must be enabled to run multiple queries at once
});

// Instantiate mysql connection
connection.connect(function(err){
    if(err){
        console.error(`Connection Error: ${err.stack}`);
        return;
    }
    console.log(`Successful connection. Connection Id: ${connection.threadId}`);
})

// Sets up the Express app to handle data parsing
app.use(express.urlencoded({ extended: true}));
app.use(express.json());

app.get("/", function(req, res){
    console.log("In Root Get");
    res.sendFile(path.join(__dirname,"home.html"));

})

app.get("/survey", (req,res) => {
    res.sendFile(path.join(__dirname, "survey.html"));
})

app.post("/addfriend", function(req, res) {
    // req.body hosts is equal to the JSON post sent from the user
    // This works because of our body parsing middleware
    console.log("In add friend POST");

    var newFriend = req.body;

    console.log(newFriend);

    var sqlQuery = `INSERT INTO friendFinder (person_name, image_link, question1,` + 
                        ` question2, question3, question4, question5, question6,` + 
                        ` question7, question8, question9, question10)` +
                        ` VALUES("${newFriend.name}", "${newFriend.imageLink}",` +
                        ` ${newFriend.question1}, ${newFriend.question2}, ${newFriend.question3},` +
                        ` ${newFriend.question4}, ${newFriend.question5}, ${newFriend.question6},` +
                        ` ${newFriend.question9}, ${newFriend.question8}, ${newFriend.question9},` +
                        ` ${newFriend.question10});`

    // 
    sqlQuery += " SELECT * FROM friendFinder WHERE ID = ( SELECT GetBestFriendMatch(LAST_INSERT_ID()) );";
    
    connection.query(sqlQuery, function(err,result){
        if(err) throw err;
        console.log(result[0]);
        console.log(result[1]);
        // res.redirect(301,"/");

        res.send(result[1]);
    });
})

app.listen(PORT, function(){
    
    console.log(`Server Listening on: http://localhost:${PORT}`);
    
})






























