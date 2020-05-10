module.exports = {
    publicPath: process.env.NODE_ENV === 'production'
        ? '/doffa/'
        : '/',
    publicPath: process.env.NODE_ENV === 'development'
        ? '/doffa/'
        : '/'
}