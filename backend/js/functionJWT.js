const jwt = require("jsonwebtoken");

function gerarCookieToken(id, miliSeg = 15000) {
  return `token = ${jwt.sign({ id }, process.env.SECRET_KEY, { expiresIn: miliSeg })}; max-age=${miliSeg}`
}

function autenticar(req, res, next) {    
  const token = req.cookies.access_token;

  if (!token) {
    return res.status(403).send("token nâo fornecido");
  }

  jwt.verify(token, process.env.SECRET_KEY, (er, decoded) => {
    if (er) return res.status(401).sen("falha na autenticacâo do token");


    req.userId = decoded.id;

     next();
  });

}

module.exports = { gerarCookieToken, autenticar };
