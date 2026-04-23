module.exports = {
    // 前端运行端口（保持你原来的8081）
    devServer: {
        port: 8081,
        // 新增代理配置，解决跨域问题
        proxy: {
            // 匹配所有以 /sysMovie 开头的请求
            '/sysMovie': {
                target: 'http://localhost:8181', // 后端服务地址
                changeOrigin: true, // 开启跨域代理（核心）
                pathRewrite: { '^/sysMovie': '/sysMovie' } // 路径不修改，直接转发
            },
            // 同时代理图片请求（确保图片也能跨域访问）
            '/images': {
                target: 'http://localhost:8181',
                changeOrigin: true,
                pathRewrite: { '^/images': '/images' }
            }
        }
    }
}