class ApiFeatures {
  constructor(query, queryString) {
    this.query = query;
    this.queryString = queryString;
  }

  paginate() {
    const page = Number(this.queryString.page || 1);
    const limit = Number(this.queryString.limit || 10);
    const skip = (page - 1) * limit;
    this.query = this.query.skip(skip).limit(limit);
    return { page, limit, skip };
  }
}

module.exports = ApiFeatures;
