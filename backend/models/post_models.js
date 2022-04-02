const db = require("../config/db");

class Post {
  constructor(title, body) {
    this.title = title;
    this.body = body;
  }

  async create(userId) {
    let d = new Date();
    let yyyy = d.getFullYear();
    let mm = d.getMonth() + 1;
    let dd = d.getDate();
    let hh = d.getHours();
    let min = d.getMinutes();
    let sec = d.getSeconds();

    let createAtDate = `${yyyy}-${mm}-${dd} ${hh}:${min}:${sec}`;

    let sql = `
    INSERT INTO posts(
        user_id,
        post_title,
        post_body,
        create_post_at
    )
    VALUES(
        '${userId}',
        '${this.title}',
        '${this.body}',
        '${createAtDate}' 
    )
    `;

    return await db.execute(sql);
  }

  static findAll() {
    let sql = `SELECT*FROM posts ORDER BY create_post_at DESC;`;

    return db.execute(sql);
  }

  static findOne(id) {
    let sql = `SELECT*FROM posts WHERE id = '${id}';`;

    return db.execute(sql);
  }

  async updateOne(id) {
    let d = new Date();
    let yyyy = d.getFullYear();
    let mm = d.getMonth() + 1;
    let dd = d.getDate();
    let hh = d.getHours();
    let min = d.getMinutes();
    let sec = d.getSeconds();

    let modifiedAtDate = `${yyyy}-${mm}-${dd} ${hh}:${min}:${sec}`;

    let sql = `
    UPDATE posts
    SET
      post_title = '${this.title}',
      post_body = '${this.body}',
      modified_post_at = '${modifiedAtDate}'
    WHERE
      id = '${id}';
    `;

    return await db.execute(sql);
  }

  async delete(id) {
    let sql = `
    DELETE FROM posts
    WHERE id = '${id}';
    `;

    return await db.execute(sql);
  }
}

module.exports = Post;
