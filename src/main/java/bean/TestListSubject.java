package bean;

import java.util.HashMap;
import java.util.Map;

public class TestListSubject {

    // 入学年度
    private int entYear;

    // 学生番号
    private String studentNo;

    // 学生氏名
    private String studentName;

    // クラス番号
    private String classNum;

    // 点数一覧
    // key   : 回数
    // value : 点数
    private Map<Integer, Integer> points = new HashMap<>();


    // =========================
    // 入学年度
    // =========================
    public int getEntYear() {
        return entYear;
    }

    public void setEntYear(int entYear) {
        this.entYear = entYear;
    }


    // =========================
    // 学生番号
    // =========================
    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }


    // =========================
    // 学生氏名
    // =========================
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }


    // =========================
    // クラス番号
    // =========================
    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }


    // =========================
    // 点数一覧
    // =========================
    public Map<Integer, Integer> getPoints() {
        return points;
    }

    public void setPoints(Map<Integer, Integer> points) {
        this.points = points;
    }


    // =========================
    // 点数取得
    // =========================
    public String getPoint(int key) {

        Integer point = points.get(key);

        if (point == null) {
            return "";
        }

        return point.toString();
    }


    // =========================
    // 点数追加
    // =========================
    public void putPoint(int key, int value) {
        points.put(key, value);
    }
}