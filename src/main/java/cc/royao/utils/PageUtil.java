package cc.royao.utils;

/**
 * Created by libia on 2016/2/17.
 */
public class PageUtil {


        private static int DEFAULT_SIZE  = 10 ;


        public static int [] getPageRange(int page)
        {
                int [] result = new int [2];
                int begin = ( ( page - 1 ) * DEFAULT_SIZE ) ;
                int end = DEFAULT_SIZE;
                result[0] = begin;
                result[1] = end;

                return  result;
        }
}
