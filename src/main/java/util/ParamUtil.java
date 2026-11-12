package util;

import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;

public final class ParamUtil {
    public static final DateTimeFormatter VN_DATE = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private ParamUtil() {}

    /** Đọc tham số số nguyên, sai định dạng -> null. */
    public static Integer parseInt(String s) {
        try {
            return s == null ? null : Integer.valueOf(s.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /** Đọc ngày dạng yyyy-MM-dd (input type="date"), sai định dạng -> null. */
    public static LocalDate parseDate(String s) {
        try {
            return (s == null || s.isBlank()) ? null : LocalDate.parse(s.trim());
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    /** 1500000 -> "1.500.000 đ" */
    public static String money(long v) {
        return NumberFormat.getInstance(new Locale("vi", "VN")).format(v) + " đ";
    }
}
