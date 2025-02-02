const path = require('path');
const webpack = require('webpack');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const TerserJSPlugin = require('terser-webpack-plugin');

module.exports = {
  entry: {
    // layout
    'layout/layout': './templates/layout/layout.js',
    'layout/gallery': './templates/layout/_gallery.js',
    'layout/datatables': './templates/layout/datatables.js',
    //admin
    'web/payment': './templates/web/payment.js',
    'web/room': './templates/web/room.js',
    'web/users': './templates/web/users.js',
    'web/booking': './templates/web/booking.js',
    'web/bookingCheckIn': './templates/web/bookingCheckIn.js',
    'web/bookingCheckOut': './templates/web/bookingCheckOut.js',
    
    //user 
    'web/bookingUser': './templates/web/bookingUser.js',
    'web/bookingUserHistory': './templates/web/bookingUserHistory.js',
    'web/singUpUser': './templates/web/singUpUser.js',
  },
  output: {
    path: path.resolve(__dirname, 'public/assets'),
    publicPath: 'assets/',
  },
  optimization: {
    minimizer: [new TerserJSPlugin({}), new OptimizeCSSAssetsPlugin({})],
  },
  performance: {
    maxEntrypointSize: 1024000,
    maxAssetSize: 1024000
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      },
      {
        test: /\.(ttf|eot|svg|woff|woff2)(\?[\s\S]+)?$/,
        include: path.resolve(__dirname, './node_modules/@fortawesome/fontawesome-free/webfonts'),
        use: {
          loader: 'file-loader',
          options: {
            name: '[name].[ext]',
            outputPath: 'webfonts',
            publicPath: '../webfonts',
          },
        }
      },
      {
        test: /\.js$/,
        exclude: path.resolve('node_modules'),
        use: [{
          loader: 'babel-loader',
          options: {
            presets: [
              ['@babel/preset-env']
            ]
          }
        }]
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new ManifestPlugin(),
    new MiniCssExtractPlugin({
      ignoreOrder: false
    }),
  ],
  watchOptions: {
    ignored: ['./node_modules/']
  },
  mode: "development"
};