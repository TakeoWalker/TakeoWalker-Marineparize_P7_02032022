const Comment = require("../models/comment_models");
const fs = require("fs");
const jwt = require("jsonwebtoken");

// Création d'un comment
exports.createNewComment = async (req, res, next) => {
  try {
    const userId = req.body.user_id;
    const postId = req.body.post_id;
    const commentObject_body = req.body.body;

    let comment = new Comment(
      commentObject_body /* , {
      imageUrl: `${req.protocol}://${req.get("host")}/images/${
        req.file.filename
      }`,
    } */
    );
    comment = await comment.create(userId, postId);
    res.status(201).json({
      message: "Comment enregistré !",
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({
      error: error,
    });
  }
};

// Reprendre un comment
exports.getOneComment = (req, res, next) => {
  Comment.findOne(req.params.id)
    .then((comment) => {
      res.status(200).json(comment[0]);
    })
    .catch((error) => {
      res.status(404).json({
        error: error,
      });
    });
};

// Modification d'un comment
exports.modifyComment = async (req, res, next) => {
  try {
    const commentObject_body = req.body.body;

    let comment = new Comment(
      commentObject_body /*{
      imageUrl: `${req.protocol}://${req.get("host")}/images/${
        req.file.filename
      }`,
    }*/
    );
    comment = await comment.updateOne(req.params.id);
    res.status(201).json({
      message: "Comment modifié !",
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({
      error: error,
    });
  }
};

// Suppression d'un comment
exports.deleteComment = (req, res, next) => {
  try {
    let comment = new Comment();
    /* const filename = comment.imageUrl.split("/images/")[1];
      fs.unlink(`images/${filename}`, () => { */
    comment
      .deleteOne(req.params.id)
      .then(() => res.status(200).json({ message: "Objet supprimé !" }))
      .catch((error) => {
        console.log(error);
        res.status(400).json({ error });
        /* });*/
      });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error });
  }
};

// Reprendre la liste de tous les comments créés
exports.getAllComments = (req, res, next) => {
  Comment.findAll()
    .then((comment) => {
      res.status(200).json(comment[0]);
    })
    .catch((error) => {
      res.status(400).json({
        error: error,
      });
    });
};
