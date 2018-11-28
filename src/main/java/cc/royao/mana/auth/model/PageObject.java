package cc.royao.mana.auth.model;

/**
 * Created by libia on 2016/1/3.
 */
public class PageObject {
    private final static int DEFAULT_PAGE_SIZE = 10;
    protected int pageNo = 1;
    protected int pageSize = DEFAULT_PAGE_SIZE;
    protected long total = 0;
    
    
    private int begin = 0;
    private int end  = 0 ;


    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
    	
    	
    	
        this.pageNo = pageNo;
        
        begin = (this.pageNo - 1) * this.pageSize;
        end = (this.pageNo) * this.pageSize; 
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
        
        begin = (this.pageNo - 1) * this.pageSize;
        end = (this.pageNo) * this.pageSize; 
    }

    /**
     * 获取总的记录数
     *
     * @return
     */
    public long getTotal() {
        return total;
    }


    public void setTotal(final long totalCount) {
        this.total = totalCount;
    }


    /**
     * 获取总的页数
     *
     * @return
     */
    public long getTotalPages() {
        long count = total / pageSize;
        if (total % pageSize > 0) {
            count++;
        }
        return count;
    }


    public boolean isHasNext() {
        return (pageNo + 1 <= getTotalPages());
    }

    /**
     * 获取下一页页码
     *
     * @return
     */
    public int getNextPage() {
        if (isHasNext()) {
            return pageNo + 1;
        } else {
            return pageNo;
        }
    }


    public boolean isHasPre() {
        return (pageNo - 1 >= 1);
    }


    public int getPrePage() {
        if (isHasPre()) {
            return pageNo - 1;
        } else {
            return pageNo;
        }
    }
}
