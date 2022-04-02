const db = require("../config/db");

class Comment {
  constructor(body) {
    this.body = body;
  }

  async create(user_id, post_id) {
    let d = new Date();
    let yyyy = d.getFullYear();
    let mm = d.getMonth() + 1;
    let dd = d.getDate();
    let hh = d.getHours();
    let min = d.getMinutes();
    let sec = d.getSeconds();

    let createAtDate = `${yyyy}-${mm}-${dd} ${hh}:${min}:${sec}`;

    let sql = `
    INSERT INTO comments(
        user_id,
        post_id,
        comment_body,
        create_comment_at
        )
    VALUES(
        '${user_id}',
        '${post_id}',
        '${this.body}',
        '${createAtDate}' 
    )
    `;

    return await db.execute(sql);
  }

  static findAll() {
    let sql = `SELECT*FROM comments;`;

    return db.execute(sql);
  }

  static findOne(id) {
    let sql = `SELECT*FROM comments WHERE id = '${id};'`;

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
    UPDATE comments
    SET
      comment_body = '${this.body}',
      modified_comment_at = '${modifiedAtDate}'
    WHERE
      id = '${id}';
    `;

    return await db.execute(sql);
  }

  async deleteOne(id) {
    let sql = `
    DELETE FROM comments
    WHERE id = '${id}';
    `;

    return await db.execute(sql);
  }
}

module.exports = Comment;
