const Post = require("../models/post_models");
const fs = require("fs");
const jwt = require("jsonwebtoken");

// Création d'un post
exports.createNewPost = async (req, res, next) => {
  try {
    let post = JSON.parse(req.body.post);
    let imageUrl = null;
    const userId = post.user_id;
    const postObject_title = post.title;
    const postObject_body = post.body;
    if (!req.file) {
      let post = new Post(postObject_title, postObject_body, imageUrl);

      post = await post.create(userId);
      res.status(201).json({
        message: "Post enregistré !",
      });
    } else {
      imageUrl = `${req.protocol}://${req.get("host")}/images/${
        req.file.filename
      }`;
      let post = new Post(postObject_title, postObject_body, imageUrl);
      post = await post.create(userId);
      res.status(201).json({
        message: "Post enregistré !",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(400).json({
      error: error,
    });
  }
};

// Reprendre un post
exports.getOnePost = (req, res, next) => {
  Post.findOne(req.params.id)
    .then((post) => {
      res.status(200).json(post[0]);
    })
    .catch((error) => {
      res.status(404).json({
        error: error,
      });
    });
};

// Modification d'un post
exports.modifyPost = async (req, res, next) => {
  try {
    let post = JSON.parse(req.body.post);
    let imageUrl = post.image_url;
    const userId = post.user_id;
    const postObject_title = post.title;
    const postObject_body = post.body;
    if (!req.file) {
      let post = new Post(postObject_title, postObject_body, imageUrl);
      post = await post.updateOne(req.params.id);
      res.status(201).json({
        message: "Post modifié !",
      });
    } else {
      imageUrl = `${req.protocol}://${req.get("host")}/images/${
        req.file.filename
      }`;
      let post = new Post(postObject_title, postObject_body, imageUrl);
      post = await post.updateOne(req.params.id);
      res.status(201).json({
        message: "Post modifié !",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(400).json({
      error: error,
    });
  }
};

// Suppression d'un post
exports.deletePost = (req, res, next) => {
  Post.delete(req.params.id)
    .then(() => res.status(200).json({ message: "Objet supprimé !" }))
    .catch((error) => {
      console.log(error);
      res.status(400).json({ error });
    });
};

// Reprendre la liste de tous les posts créés
exports.getAllPosts = (req, res, next) => {
  Post.findAll()
    .then((posts) => {
      res.status(200).json(posts[0]);
    })
    .catch((error) => {
      res.status(400).json({
        error: error,
      });
    });
};
