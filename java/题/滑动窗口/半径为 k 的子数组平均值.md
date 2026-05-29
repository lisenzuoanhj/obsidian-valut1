[半径为 k 的子数组平均值](https://leetcode.cn/problems/k-radius-subarray-averages/)
熊。这个题对我来说实在是有些难了，数学思维太差。
先把我的错误的放上来吧。
```java
class Solution {
    public int[] getAverages(int[] nums, int k) {
        int num = nums.length;
        int []avgs = new int [num];
            int plus = 0;
            int count = 0;
            int chu = 2*k+1;
        for(int i=0;i<num;i++){
            if(k==0){avgs[i]=nums[i];continue;}
            if(i-k<0||num-i<k+1){
                avgs[i]=-1;
                plus+=nums[i];
                count++;
                continue;
            }
            plus+=nums[i];
            count++;
            if(count == chu){
                avgs[i-k]=plus/ chu;
                count--;
                plus-=nums[i-2*k];
            }
        }
        return avgs;
    }
}
```
其实这个已经是我苦思冥想得出来的方法了，但是错误依旧非常大，我觉得是我太想当然了。
1.上下两个i的身份很混乱：for里面的i是把数组里面的每个都当成了中心的，但是for外的i又把他们当成了半径的最右端的数，想以此来推算中心点的平均值。这样就会导致在for里面就会把中心的右端大部分数都设为-1，然后跳过，实际上根本就没有对中心的几个点执行运算，最后得到的结果，中心几个点的值会全都为0。
感觉还是我想的太复杂了。

```java
class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int []avgs = new int [n];
        Arrays.fill(avgs,-1);//这一步提前把所有元素设置为-1，这样不满足的位置就直接是-1了
         long plus = 0;
        long chu = 2*k+1;
        for(int i=0;i<n;i++){
            plus+=nums[i];
            if(i<2*k)continue;//i<2k的都是窗口大小不符合的
            avgs[i-k]=(int) (plus/chu);
            plus-=nums[i-2*k];
        }
        return avgs;
    }
}
```