function Core() {
  return {
    teaserRoulette: require('./teaser-roulette'),
    feedFetcher: require('./feed-fetcher'),
    metaphor: require('./metaphor'),
    log: require('./log')
  };
};

module.exports = new Core();
