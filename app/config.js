'use strict'

class Config {
  constructor() {
    this.production = (process.env.NODE_ENV === 'production');
    this.kugelblitz = {
      endpoint: process.env.KUGELBLITZ_ENDPOINT,
      token: process.env.KUGELBLITZ_TOKEN,
      callbackUrl: process.env.KUGELBLITZ_CALLBACK
    };
  }
}

module.exports = new Config;
