const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth.js");
const multer = require("../middleware/multer-config");

const userCtrl = require("../controllers/user_controllers");

router.post("/signup", userCtrl.signup);

router.post("/login", userCtrl.login);
router.get("/me", auth, userCtrl.me);
router.delete("/:id", auth, userCtrl.deleteUser);
router.get("/:id", auth, userCtrl.displayUser);
router.put("/:id", auth, multer, userCtrl.updateUser);

module.exports = router;
