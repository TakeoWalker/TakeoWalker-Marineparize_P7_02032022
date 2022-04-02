const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");
const multer = require("../middleware/multer-config");

const commentControllers = require("../controllers/comment_controllers");

router
  .route("/")
  .get(auth, commentControllers.getAllComments)
  .post(auth, multer, commentControllers.createNewComment);

router
  .route("/:id")
  .get(auth, commentControllers.getOneComment)
  .put(auth, multer, commentControllers.modifyComment)
  .delete(auth, commentControllers.deleteComment);

module.exports = router;
