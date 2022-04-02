const jwt = require("jsonwebtoken");
const User = require("../models/user_models");

// vérification de l'authentification de l'utilisateur
// et savoir si il est autorisé ou pas
module.exports = async (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, "RANDOM_TOKEN_SECRET");
    const userId = decodedToken.userId;
    let result = await User.display(userId);
    const user = result[0][0];
    req.auth = { token: token, user: user };
    if (result && user.id !== userId) {
      throw "Invalid user ID";
    } else {
      next();
    }
  } catch {
    res.status(403).json({
      error: new Error("Unauthorized request"),
    });
  }
};
