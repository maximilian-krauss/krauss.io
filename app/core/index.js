function Core() {
  return {
    teaserRoulette: require('./teaser-roulette'),
    feedFetcher: require('./feed-fetcher'),
    log: require('./log')
  };
};

module.exports = new Core();
