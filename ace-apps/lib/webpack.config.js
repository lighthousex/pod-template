const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: `${path.resolve(__dirname)}/index.js`,
  output: {
    path: `${path.resolve(__dirname)}/../../${POD_NAME}/Assets/`,
    libraryTarget: 'umd',
    filename: 'index.min.js',
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        loader: 'babel-loader',
      },
    ],
  },
  externals: {
    '@zitao/lighthousex-ios': 'WatIOS',
    '@zitao/lighthousex-ios-core': 'Wat',
    bluebird: 'Promise',
    lodash: '_',
    ramda: 'R',
  },
  plugins: [
    new webpack.LoaderOptionsPlugin({
      minimize: true,
      debug: false,
    }),
  ],
};
