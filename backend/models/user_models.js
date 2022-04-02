const db = require("../config/db");

class User {
  constructor(username, email, password) {
    this.username = username;
    this.email = email;
    this.password = password;
  }

  async save() {
    let d = new Date();
    let yyyy = d.getFullYear();
    let mm = d.getMonth() + 1;
    let dd = d.getDate();
    let hh = d.getHours();
    let min = d.getMinutes();
    let sec = d.getSeconds();

    let createAtDate = `${yyyy}-${mm}-${dd} ${hh}:${min}:${sec}`;

    let sql = `
    INSERT INTO user(
        username,
        email,
        password,
        created_on
    )
    VALUES(
        '${this.username}',
        '${this.email}',
        '${this.password}',
        '${createAtDate}'
    )
    `;

    return await db.execute(sql);
  }

  async findOne(email) {
    let sql = `
      SELECT * FROM user 
      WHERE email = '${email}'`;

    return await db.execute(sql);
  }

  static display(userId) {
    let sql = `
      SELECT * FROM user
      WHERE id = '${userId}'`;

    return db.execute(sql);
  }

  async delete(userId) {
    let sql = `
    DELETE FROM user
    WHERE id = '${userId}'`;
    return await db.execute(sql);
  }

  async update(id, image) {
    let sql = `
    UPDATE user
    SET
      username = '${this.username}',
      email = '${this.email}',
      icon_url = '${image}'
    WHERE
      id = '${id}';`;

    return await db.execute(sql);
  }
}
module.exports = User;
