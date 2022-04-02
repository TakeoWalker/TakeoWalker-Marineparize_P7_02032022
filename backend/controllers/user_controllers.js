const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const db = require("../config/db");
const fs = require("fs");

const User = require("../models/user_models");

// Enregistrement d'un utilisateur
exports.signup = async (req, res, next) => {
  bcrypt
    .hash(req.body.password, 10)
    .then((hash) => {
      const user = new User(req.body.username, req.body.email, hash);

      user
        .save()
        .then(() => {
          res.status(201).json({
            message: "Utilisateur créé",
            user_info: user,
          });
        })
        .catch((error) => res.status(400).json({ error }));
    })
    .catch((error) => res.status(500).json({ error }));
};

// Connexion d'un utilisateur
exports.login = (req, res, next) => {
  const user = new User();
  user.findOne(req.body.email).then((result) => {
    const user = result[0][0];
    if (!user) {
      res.status(401).json({ error: "Utilisateur non trouvé !" });
    } else {
      bcrypt
        .compare(req.body.password, user.password)
        .then((valid) => {
          if (!valid) {
            res.status(401).json({ error: "Mot de passe incorrect !" });
          } else {
            res
              .status(200)
              .json({
                user: user,
                token: jwt.sign({ userId: user.id }, "RANDOM_TOKEN_SECRET", {
                  expiresIn: "24h",
                }),
              })
              .catch((error) => {
                return res.status(500).json({ error });
              });
          }
        })
        .catch((error) => {
          return res.status(500).json({ error });
        });
    }
  });
};

exports.me = async (req, res, next) => {
  const user = req.auth.user;
  res.status(200).json({ user: user });
};

exports.displayUser = (req, res, next) => {
  User.display(req.params.id)
    .then((result) => {
      res.status(200).json(result[0]);
    })
    .catch((err) => {
      return res.status(500).json({ error: err });
    });
};

exports.deleteUser = (req, res, next) => {
  try {
    const user = new User();
    console.log(user);
    const filename = req.file.filename;
    console.log(filename);
    fs.unlink(`images/${filename}`, () => {
      user
        .delete(req.params.id)
        .then(() => res.status(200).json({ message: "Utilisateur supprimé !" }))
        .catch((error) => {
          console.log(error);
          res.status(400).json({ error });
        });
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error });
  }
};

exports.updateUser = async (req, res, next) => {
  try {
    let user = JSON.parse(req.body.user);
    console.log(user.username);
    let imageUrl = user.image_url;
    const username = user.username;
    const email = user.email;
    if (!req.file) {
      let user = new User(username, email);
      user = await user.update(req.params.id, imageUrl);
      res.status(201).json({
        message: "Utilisateur modifié !",
      });
    } else {
      imageUrl = `${req.protocol}://${req.get("host")}/images/${
        req.file.filename
      }`;
      let user = new User(username, email);
      user = await user.update(req.params.id, imageUrl);
      res.status(201).json({
        message: "Utilisateur modifié !",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(400).json({
      error: error,
    });
  }
};
