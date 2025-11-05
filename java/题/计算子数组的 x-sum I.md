[计算子数组的 x-sum I](https://leetcode.cn/problems/find-x-sum-of-all-k-long-subarrays-i/)

这个 题能这样暴力写都是因为数据量小好过。。Ⅱ从50直接变成10^5根本没法过。复杂度太大了。
```java
class Solution {
    public int[] findXSum(int[] nums, int k, int x) 
    {
      int m=nums.length-k+1;
      int []ans=new int [m];//这个数组宽度要限制住啊。。
      for(int i=0;i<nums.length-k+1;i++){
        int []n=new int[51];//为每个窗口创建新的频率数组
        for(int j=i;j<i+k;j++)
        {
            n[nums[j]]++;
        }
        int rex=x;
        while(rex-->0)
        {
            int alpha=0;
            for(int z=0;z<n.length;z++)
            {
                if(n[alpha]<n[z]||(n[alpha]==n[z]&&alpha<z))
                {
                    alpha=z;
                }
            }
            ans[i]+=alpha*n[alpha];
            n[alpha]=0;//这个卡了我半天。不知道怎么想的
        }
      }
      return ans;
    }
}
```