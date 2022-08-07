const express = require('express')
const app = express()
const port = 3000
const bodyParser = require('body-parser');
const cors = require("cors");
const sql = require('../backend/db');

const corsOptions = {
    origin: "http://localhost:3001"
};
app.use(cors(corsOptions));

app.use(express.json());

// create application/json parser
app.use(express.urlencoded({ extended: true }));

// respond with "hello world" when a GET request is made to the homepage
app.get('/', (req, res) => {
    sql.query('Select * from category', (err, rows) => {
        if (!err) {
            res.setHeader('Content-Type', 'application/json');
            res.status(200).send(JSON.stringify(
                {
                    'result': 'success',
                    'data': rows
                })
            );
        } else {
            res.status(400).send(err);
        }
    })
})

app.post('/customerLogin', (req, res) => {
    console.log('tester', req.body);
    const email = req.body.email;
    const password = req.body.password;
    sql.query('Select * from customer where email = ? and password = ?', [email, password], (err, rows) => {
        //console.log('checkresponse', res)
        if (!err) {
            if (rows.length > 0) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'User LoggedIn Successfully',
                        'data': rows[0]
                    })
                );
            } else {
                res.setHeader('Content-Type', 'application/json');
                res.status(400).send(JSON.stringify(
                    {
                        'status': 400,
                        'result': 'No Result Found',
                        'data': ''
                    })
                );
            }
        } else {
            res.status(400).send(err);
        }
    })
})

app.post('/customerRegister', (req, res) => {
    console.log('register', req.body);
    const fname = req.body.first_name;
    const lname = req.body.last_name;
    const phone = req.body.phone;
    const email = req.body.email;
    const password = req.body.password;
    const address = req.body.address;
    const pincode = req.body.pincode;
    sql.query('INSERT INTO customer (first_name, last_name, phone, email, password, address, pincode) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [fname, lname, phone, email, password, address, pincode], (err, rows) => {
            if (!err) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Information Saved Successfully',
                        'data': rows[0]
                    })
                );
            } else {
                res.status(400).send(err);
            }
        })
})

app.post('/providersLogin', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;
    sql.query('Select * from providers where email = ? and password = ?', [email, password], (err, rows) => {
        //console.log('checkresponse', res)
        if (!err) {
            if (rows.length > 0) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Provider LoggedIn Successfully',
                        'data': rows[0]
                    })
                );
            } else {
                res.setHeader('Content-Type', 'application/json');
                res.status(400).send(JSON.stringify(
                    {
                        'status': 400,
                        'result': 'No Result Found',
                        'data': ''
                    })
                );
            }
        } else {
            res.status(400).send(err);
        }
    })
})

app.post('/providersRegister', (req, res) => {
    const cname = req.body.company_name;
    const contact_no = req.body.last_name;
    const phone = req.body.phone;
    const email = req.body.email;
    const password = req.body.password;
    const address = req.body.address;
    const pincode = req.body.pincode;
    sql.query('INSERT INTO customer (first_name, last_name, phone, email, password, address, pincode) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [fname, lname, phone, email, password, address, pincode], (err, rows) => {
            if (!err) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Information Saved Successfully',
                        'data': rows[0]
                    })
                );
            } else {
                res.status(400).send(err);
            }
        })
})

app.get('/search', (req, res) => {
    var keyword = req.query.q;
    var squery = 'Select * from providers as p INNER JOIN service AS s ON s.category_id = p.category_id WHERE s.name LIKE "' + keyword + '%" GROUP BY p.provider_id';
    console.log('query', squery)

    sql.query(squery, (err, rows) => {
        if (!err) {
            if (rows.length > 0) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Search Successful',
                        'data': rows
                    })
                );
            } else {
                res.setHeader('Content-Type', 'application/json');
                res.status(400).send(JSON.stringify(
                    {
                        'status': 400,
                        'result': 'No Result Found',
                        'data': ''
                    })
                );
            }
        } else {
            res.status(400).send(err);
        }
    })
})

app.get('/providerDetail/:id', async (req, res) => {
    var squery = 'Select * from providers WHERE provider_id =' + req.params.id;
    console.log('query', squery)
    var serv_pro = [];
    sql.query(squery, (err, rows) => {
        if (!err) {
            if (rows.length > 0) {
                var serv = 'Select * from provider_service as ps INNER JOIN service AS s ON s.service_id = ps.service_id WHERE ps.provider_id =' + req.params.id;
                console.log('serv',serv);
                sql.query(serv, (errserv, rowserv) => {
                    console.log('rowserv',rowserv)
                    if (!errserv) {
                        if (rowserv.length > 0) {
                            rowserv.forEach((item) => {
                                serv_pro.push({'name': item.name, 'price': item.price})
                            })
                        }
                        console.log('testit', serv_pro)
                    }else {
                        res.status(400).send(err);
                    }
                })
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Detail successfully fetched',
                        'data': { 'detail': rows[0], 'service': serv_pro}
                    })
                );
            } else {
                res.setHeader('Content-Type', 'application/json');
                res.status(400).send(JSON.stringify(
                    {
                        'status': 400,
                        'result': 'No Result Found',
                        'data': ''
                    })
                );
            }
        } else {
            res.status(400).send(err);
        }
    })
})

app.post('/book', (req, res) => {
    let ts = Date.now();

let date_ob = new Date(ts);
let date = date_ob.getDate();
let month = date_ob.getMonth() + 1;
let year = date_ob.getFullYear();
let full_date = year + "-" + month + "-" + date

    console.log('tester', req.body);
    const service = req.body.service;
    const app_date = req.body.app_date;
    const app_time = req.body.app_time;
    const comment = req.body.comment;
    const customer = req.body.customer;
    const address = req.body.address;
    sql.query('INSERT INTO booking (customer_id, provider_service_id, comment, app_date, app_time, datetime, status, book_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
    [customer, service, comment, app_date, app_time, full_date,'P', address], (err, rows) => {
        if (!err) {
            res.setHeader('Content-Type', 'application/json');
            res.status(200).send(JSON.stringify(
                {
                    'status': 200,
                    'result': 'Information Saved Successfully',
                    'data': rows[0]
                })
            );
        } else {
            res.status(400).send(err);
        }
    })
})

app.get('/bookinglist/:id', (req, res) => {
    var squery = 'SELECT * FROM `booking` as b INNER JOIN provider_service AS ps ON ps.provider_service_id = b.provider_service_id INNER JOIN service AS s ON s.service_id = ps.service_id WHERE ps.provider_id ='+ req.params.id;
    console.log('query', squery)

    sql.query(squery, (err, rows) => {
        if (!err) {
            if (rows.length > 0) {
                res.setHeader('Content-Type', 'application/json');
                res.status(200).send(JSON.stringify(
                    {
                        'status': 200,
                        'result': 'Search Successful',
                        'data': rows
                    })
                );
            } else {
                res.setHeader('Content-Type', 'application/json');
                res.status(400).send(JSON.stringify(
                    {
                        'status': 400,
                        'result': 'No Result Found',
                        'data': ''
                    })
                );
            }
        } else {
            res.status(400).send(err);
        }
    })
})

app.get('/about', (req, res) => {
    res.send('About us')
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})