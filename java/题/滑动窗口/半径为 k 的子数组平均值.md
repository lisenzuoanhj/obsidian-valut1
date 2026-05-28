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
1.在我的for循环里面，上下两个i的身份很混乱。