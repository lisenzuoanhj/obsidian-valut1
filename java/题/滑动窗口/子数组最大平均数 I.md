[子数组最大平均数 I](https://leetcode.cn/problems/maximum-average-subarray-i/)
这题我在学完滑动窗口后第一次写时，忽略了负数的情况。
```java
class Solution {
    public double findMaxAverage(int[] nums, int k) {
        double ans=Integer.MIN_VALUE;//这一步就是把ans设置成了负无穷
        double anstemp=0.0;
        double plus=0;
        for(int i=0;i<nums.length;i++){
            plus+=nums[i];
            int left=i-k+1;
            if(left<0)continue;
            anstemp=plus/k;
            ans=Math.max(ans,anstemp);
            int out=nums[left];
            plus-=out;
        }
        return ans;
    }
}
```
还可以先只计算加和的最大值，最后再返回平均数。

```java
class Solution {
    public double findMaxAverage(int[] nums, int k) {
        int maxS = Integer.MIN_VALUE; // 窗口元素和的最大值
        int s = 0; // 维护窗口元素和
        for (int i = 0; i < nums.length; i++) {
            // 1. 进入窗口
            s += nums[i];
            if (i < k - 1) { // 窗口大小不足 k
                continue;
            }
            // 2. 更新答案
            maxS = Math.max(maxS, s);
            // 3. 离开窗口
            s -= nums[i - k + 1];
        }
        return (double) maxS / k;
    }
}
```