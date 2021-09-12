package com.mysql.util;

import sun.net.www.protocol.file.FileURLConnection;

import java.io.*;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Collection;
import java.util.Enumeration;
import java.util.function.Consumer;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2019/9/5 16:07
 * description:  IoTools IO相关方法
 * version:      V1.0
 * ******************************
 */
public class IOTools {

    private IOTools() {}

    private final static String fileSeperator  = File.separator;

    public static void readLine(BufferedReader br, Consumer<String> handle, boolean close) {
        String s;
        try {
            while (((s = br.readLine()) != null)) {
                handle.accept(s);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (close && br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void readLine(BufferedReader br, Consumer<String> handle) {
        readLine(br, handle, true);
    }

    public static void readLine(String path, Consumer<String> handle, boolean close) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(path));
            readLine(br, handle, close);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void readLine(String path, Consumer<String> handle) {
        readLine(path, handle, true);
    }


    public static void writeLine(BufferedWriter bw, String content, boolean close) {
        try {
            bw.write(content);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (close) {
                try {
                    bw.flush();
                    bw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void writeLine(BufferedWriter bw, Collection<String> rows, boolean close) {
        for (String row : rows) {
            try {
                bw.write(row);
                bw.newLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (close) {
            try {
                bw.flush();
                bw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void writeLine(BufferedWriter bw, Collection<String> rows) {
        writeLine(bw, rows, false);
    }

    public static void writeLine(BufferedWriter bw, String content) {
        writeLine(bw, content, false);
    }

    public static void writeLine(String path, Collection<String> rows) {
        BufferedWriter bw = null;
        try {
            bw = new BufferedWriter(new FileWriter(path));
            for (String row : rows) {
                writeLine(bw, row);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bw != null) {
                try {
                    bw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /***
     * 复制文件夹 - 兼容文件夹及Jar两种方式
     * @param folderPath        文件夹
     * @param targetFolderPath  目标地址
     * @param clazz             类
     * @param originalPath      原地址
     *
     * Eg: IOTool.loadRecourseFromJarByFolder("/templates/code-generator/ui/lib", rootPath + "/src/main/resources/static/", this.getClass(),"/templates/code-generator/ui/lib");
     */
    public static void loadRecourseFromJarByFolder(String folderPath, String targetFolderPath, Class clazz, String originalPath) throws IOException {
        URL url = clazz.getResource(folderPath);
        URLConnection urlConnection = url.openConnection();
        if (urlConnection instanceof FileURLConnection) {
            copyFileResources(url, folderPath, targetFolderPath, clazz, originalPath);
        } else if (urlConnection instanceof JarURLConnection) {
            copyJarResources((JarURLConnection) urlConnection, folderPath, targetFolderPath, clazz, originalPath);
        }
    }

    /**
     * 当前运行环境资源文件是在文件里面的
     */
    private static void copyFileResources(URL url, String folderPath, String targetFolderPath, Class clazz, String originalPath) throws IOException {
        File root = new File(url.getPath());
        if (root.isDirectory()) {
            File[] files = root.listFiles();
            for (File file : files) {
                if (file.isDirectory()) {
                    loadRecourseFromJarByFolder(folderPath + "/" + file.getName(), targetFolderPath, clazz, originalPath);
                } else {
                    loadRecourseFromJar(folderPath + "/" + file.getName(), targetFolderPath, clazz, originalPath);
                }
            }
        }
    }

    /**
     * 当前运行环境资源文件是在jar里面的
     */
    private static void copyJarResources(JarURLConnection jarURLConnection, String folderPath, String targetFolderPath, Class clazz, String originalPath) throws IOException {
        JarFile jarFile = jarURLConnection.getJarFile();
        Enumeration<JarEntry> entrys = jarFile.entries();
        while (entrys.hasMoreElements()) {
            JarEntry entry = entrys.nextElement();
            if (entry.getName().startsWith(jarURLConnection.getEntryName()) && !entry.getName().endsWith("/")) {
                loadRecourseFromJar("/" + entry.getName(), targetFolderPath, clazz, originalPath);
            }
        }
        jarFile.close();
    }

    private static void loadRecourseFromJar(String path, String recourseFolder, Class clazz, String originalPath) throws IOException {
        if (!path.startsWith("/")) {
            throw new IllegalArgumentException("The path has to be absolute (start with '/').");
        }

        if (path.endsWith("/")) {
            throw new IllegalArgumentException("The path has to be absolute (cat not end with '/').");
        }
        // If the file does not exist yet, it will be created. If the file
        // exists already, it will be ignored
        String filename = recourseFolder + originalPath.substring(originalPath.lastIndexOf("/") + 1) +
                path.substring(path.indexOf(originalPath) + originalPath.length());
        File file = new File(filename);
        file.getParentFile().mkdirs();
        //logger.info("recourseFolder:{},filePath:{}", recourseFolder,filename);
        if (file.exists()) {
            return;
        }

        // Prepare buffer for data copying
        byte[] buffer = new byte[1024];
        int readBytes;

        // Open and check input stream
        URL url = clazz.getResource(path);
        URLConnection urlConnection = url.openConnection();
        InputStream is = urlConnection.getInputStream();

        if (is == null) {
            throw new FileNotFoundException("File " + path + " was not found inside JAR.");
        }
        OutputStream os = new FileOutputStream(file);
        try {
            while ((readBytes = is.read(buffer)) != -1) {
                os.write(buffer, 0, readBytes);
            }
        } finally {
            os.close();
            is.close();
        }
    }
}
