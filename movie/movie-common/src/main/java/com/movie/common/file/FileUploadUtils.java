package com.movie.common.file;

import com.movie.common.exception.FileNameLengthLimitExceededException;
import com.movie.common.exception.FileSizeLimitExceededException;
import com.movie.common.exception.InvalidExtensionException;
import com.movie.common.utils.StringUtil;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.util.ClassUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

/**
 * 文件上传工具类
 * 功能：处理图片上传、自动创建日期文件夹、路径拼接、文件校验
 */
public class FileUploadUtils {
    /**
     * 默认大小 50M
     */
    public static final long DEFAULT_MAX_SIZE = 50 * 1024 * 1024;

    /**
     * 默认的文件名最大长度 100
     */
    public static final int DEFAULT_FILE_NAME_LENGTH = 100;

    /**
     * 默认存储图片目录（修复中文/空格路径编码问题）
     */
    private static final String parentPath;

    static {
        try {
            // 解码中文/空格路径，解决Windows下路径乱码问题
            String rawPath = ClassUtils.getDefaultClassLoader().getResource("static/images").getPath();
            parentPath = URLDecoder.decode(rawPath, StandardCharsets.UTF_8.name());
        } catch (Exception e) {
            throw new RuntimeException("初始化文件上传根路径失败：" + e.getMessage(), e);
        }
    }

    public static final String actorPath = "/actor";
    public static final String cinemaPath = "/cinema";
    public static final String moviePath = "/movie";
    public static final String userPath = "/user";

    /**
     * 默认上传的地址
     */
    private static String defaultBaseDir = userPath;

    public static void setDefaultBaseDir(String defaultBaseDir) {
        FileUploadUtils.defaultBaseDir = defaultBaseDir;
    }

    public static String getDefaultBaseDir() {
        return defaultBaseDir;
    }

    public static String getParentPath() {
        return parentPath;
    }

    /**
     * 以默认配置进行文件上传
     *
     * @param file 上传的文件
     * @return 文件名称
     * @throws IOException 上传异常
     */
    public static final String upload(MultipartFile file) throws IOException {
        try {
            return upload(getParentPath() + getDefaultBaseDir(), file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
        } catch (Exception e) {
            throw new IOException(e.getMessage(), e);
        }
    }

    /**
     * 文件上传核心方法
     *
     * @param baseDir          相对应用的基目录
     * @param file             上传的文件
     * @param allowedExtension 上传文件类型
     * @return 返回上传成功的文件名
     * @throws FileSizeLimitExceededException       文件大小超出限制
     * @throws FileNameLengthLimitExceededException 文件名长度超出限制
     * @throws IOException                          IO异常
     * @throws InvalidExtensionException            文件格式不支持
     */
    public static final String upload(String baseDir, MultipartFile file, String[] allowedExtension)
            throws FileSizeLimitExceededException, IOException, FileNameLengthLimitExceededException,
            InvalidExtensionException {
        // 校验文件名长度
        int fileNamelength = file.getOriginalFilename().length();
        if (fileNamelength > FileUploadUtils.DEFAULT_FILE_NAME_LENGTH) {
            throw new FileNameLengthLimitExceededException("文件名称长度不能超过" + FileUploadUtils.DEFAULT_FILE_NAME_LENGTH);
        }

        // 校验文件大小和格式
        assertAllowed(file, allowedExtension);

        // 生成带日期路径的唯一文件名
        String fileName = extractFilename(file);

        // 获取文件存储对象（自动创建文件夹）
        File desc = getAbsoluteFile(baseDir, fileName);
        // 保存文件到服务器
        file.transferTo(desc);

        // 生成数据库存储的相对路径
        return getPathFileName(baseDir, fileName);
    }

    /**
     * 生成带日期路径的唯一文件名
     * 格式：yyyy/MM/dd/UUID.后缀
     *
     * @param file 上传文件
     * @return 带日期路径的文件名
     */
    public static final String extractFilename(MultipartFile file) {
        String fileName = file.getOriginalFilename();
        String extension = getExtension(file);
        // 按年月日生成路径 + UUID避免文件名重复
        return DateFormatUtils.format(new Date(), "yyyy/MM/dd") + "/" +
                UUID.randomUUID().toString().replaceAll("-", "") + "." + extension;
    }

    /**
     * 获取文件存储对象，自动创建不存在的父文件夹
     *
     * @param uploadDir 上传目录
     * @param fileName  文件名
     * @return 文件对象
     * @throws IOException IO异常
     */
    private static final File getAbsoluteFile(String uploadDir, String fileName) throws IOException {
        // 适配Windows/Linux路径分隔符
        File desc = new File(uploadDir + File.separator + fileName);
        // 自动创建所有不存在的父文件夹（包括年月日层级）
        if (!desc.getParentFile().exists()) {
            desc.getParentFile().mkdirs();
        }
        // 创建空文件（如果不存在）
        if (!desc.exists()) {
            desc.createNewFile();
        }
        return desc;
    }

    /**
     * 生成数据库存储的相对路径
     * 格式：/images/模块名/yyyy/MM/dd/UUID.后缀
     *
     * @param uploadDir 上传目录
     * @param fileName  文件名
     * @return 相对路径
     * @throws IOException IO异常
     */
    private static final String getPathFileName(String uploadDir, String fileName) throws IOException {
        int dirLastIndex = parentPath.length() + 1;
        String currentDir = StringUtils.substring(uploadDir, dirLastIndex);
        // 空值判断，避免生成多余斜杠的路径（修复核心）
        return "/images/" + (StringUtils.isNotBlank(currentDir) ? currentDir + "/" : "") + fileName;
    }

    /**
     * 校验文件大小和格式
     *
     * @param file             上传文件
     * @param allowedExtension 允许的文件格式
     * @throws FileSizeLimitExceededException 文件大小超限
     * @throws InvalidExtensionException      文件格式不支持
     */
    public static final void assertAllowed(MultipartFile file, String[] allowedExtension)
            throws FileSizeLimitExceededException, InvalidExtensionException {
        // 校验文件大小
        long size = file.getSize();
        if (DEFAULT_MAX_SIZE != -1 && size > DEFAULT_MAX_SIZE) {
            throw new FileSizeLimitExceededException("文件大小不能超过" + DEFAULT_MAX_SIZE / 1024 / 1024 + "MB");
        }

        // 校验文件格式
        String extension = getExtension(file);
        if (allowedExtension != null && !isAllowedExtension(extension, allowedExtension)) {
            if (allowedExtension == MimeTypeUtils.IMAGE_EXTENSION) {
                throw new InvalidExtensionException("图片格式不支持" + extension + "格式");
            }
        }
    }

    /**
     * 判断文件格式是否允许
     *
     * @param extension        文件后缀
     * @param allowedExtension 允许的后缀列表
     * @return 是否允许
     */
    public static final boolean isAllowedExtension(String extension, String[] allowedExtension) {
        for (String str : allowedExtension) {
            if (str.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取文件后缀（无点号）
     *
     * @param file 上传文件
     * @return 后缀名
     */
    public static final String getExtension(MultipartFile file) {
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        // 如果原文件名无后缀，从Content-Type获取
        if (!StringUtil.isNotEmpty(extension)) {
            extension = MimeTypeUtils.getExtension(file.getContentType());
        }
        return extension;
    }

    /**
     * 删除文件
     *
     * @param filePath 文件完整路径
     * @return 是否删除成功
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        // 路径为文件且存在则删除
        if (file.isFile() && file.exists()) {
            return file.delete();
        }
        return false;
    }

    /**
     * 内置MIME类型工具类
     * 解决外部依赖缺失问题，保证工具类独立可用
     */
    public static class MimeTypeUtils {
        /**
         * 允许的图片格式
         */
        public static final String[] IMAGE_EXTENSION = {"bmp", "gif", "jpg", "jpeg", "png"};

        /**
         * 默认允许的文件格式（图片）
         */
        public static final String[] DEFAULT_ALLOWED_EXTENSION = IMAGE_EXTENSION;

        /**
         * 从Content-Type获取文件后缀
         *
         * @param contentType Content-Type
         * @return 后缀名
         */
        public static String getExtension(String contentType) {
            if (contentType == null) {
                return "";
            }
            String[] parts = contentType.split("/");
            return parts.length > 1 ? parts[1] : "";
        }
    }
}