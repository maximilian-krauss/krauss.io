function Core() {
  return {
    teaserRoulette: require('./teaser-roulette'),
    log: require('./log')
  };
};

module.exports = new Core();
