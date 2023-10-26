const express = require('express');
const router = express.Router();
const prisma = new (require("@prisma/client")).PrismaClient()
const exception = require('../js/erro')



/* retorna todas as lojas. */
router.get("/allMapaLojas", async function (req, res, next) {
  try {
    const lojas = await prisma.loja_recarga.findMany() 

    // const lojas = 
    //   [
    //     {
    //       "id": 1,
    //       "nome": "Tech Pass",
    //       "cep": "11660-000",
    //       "endereco": "Rua dos Pescadores, 102 - Centro, Caraguatatuba",
          
    //     }
    //   ]

    res.send(lojas)

  } catch (er) {
    console.log(er)
      const erro = exception(er)
      
      res.status(erro.code).send(erro.msg)
  }
});

module.exports = router;
  