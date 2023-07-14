/** The tokens returned by the scanner. */
class Yytoken {
  public int m_index;
  public String m_text;
  public String m_type;
  public int m_line;
  public long m_column;
 /// public long m_charEnd;

  Yytoken(int index, String text,String type, int line, long column/*, long charEnd*/) {
    checkArgument("index", index >= 0);
    checkArgument("line", line >= 0);
    checkArgument("charBegin", column >= 0);
   //checkArgument("charEnd", charEnd > 0);
    m_index = index;
    m_text = text;
    m_type = type;
    m_line = line;
    m_column = column;
   // m_charEnd = charEnd;
  }

  @Override
  public String toString() {
    return "  value : "
        + m_text
        + "  type : "
        + m_type
        + "  line : "
        + m_line
        + "  column : "
        + m_column +"\n";
       // + "\ncEnd. : "
       // + m_charEnd;
  }

  private static void checkArgument(String argName, boolean expectation) {
    if (!expectation) {
      throw new IllegalArgumentException(argName);
    }
  }
}
