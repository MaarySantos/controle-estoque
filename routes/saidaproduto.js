var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('saidaproduto');
});

router.get('/search',function(req,res){
    var connection = db();
    connection.query('SELECT * from estoque where cd_produto like "%'+req.query.key+'%" or ds_produto like "%'+req.query.key+'%"',
        function(err, rows, fields) {
            if (err) throw err;
            var data=[];
            for(i=0;i<rows.length;i++)
            {
                let { cd_produto, ds_produto, qt_produto } = rows[i];
                data.push({ cd_produto, ds_produto, qt_produto });

            }
            res.end(JSON.stringify(data));
        });
});

router.get('/order', function(req, res, next) {
  var connection = db();
  var nome= req.param;
  connection.query('SELECT * from estoque where cd_produto like "%'+nome+'%" or ds_produto like "%'+nome+'%"',
  function(err, rows, fields) {
      if (err) throw err;
      var data=[];
      for(i=0;i<rows.length;i++)
      {
          let { cd_produto, ds_produto, qt_produto } = rows[i];
          data.push({ cd_produto, ds_produto, qt_produto });
      }
      res.send(data );
  });

});

module.exports = router;