const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");
const multer = require("../middleware/multer-config");

const postControllers = require("../controllers/post_controllers");

router
  .route("/")
  .get(auth, postControllers.getAllPosts)
  .post(auth, postControllers.createNewPost);

router
  .route("/:id")
  .get(auth, postControllers.getOnePost)
  .put(auth, postControllers.modifyPost)
  .delete(auth, postControllers.deletePost);

module.exports = router;
