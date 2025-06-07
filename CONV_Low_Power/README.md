# Convolution

Process: UMC18 1.2v 

Clock Cycle: 15ns 

---

## Thoughts

在 `syn.tcl` 加入以下指令優化 power，並自動 inference clock gating cell。

```tcl
set_dynamic_optimization true
set_leakage_optimization true
set_max_leakage_power 0u8
set_clock_gating_style -sequential_cell latch // 需要查看 lib 有哪些 CGC 可以用
```

>   [!Note] 
>
>   Clock Gating coding style
>
>   ```systemverilog
>     always_ff @(posedge clk) begin
>         if (enable) begin
>           // ...
>       end
>     end
>   ```
>
>   `enable` 可以寫成 `cs == STATE` ，在不同的 DFF 中重複使用這個 enable 條件即可復用相同的 gated clock。

---

嘗試過使用 desginware 三級 pipeline 乘法器 ip，但是搭配 compile_ultra 合成後 timing slack 可以 MET，卻在 Gate-level simulation 出現 $setuphold violation 的問題。綜合評估下，還是使用未 pipeline 的乘法器。

## Architecture

**Clock gating cell**

![image-20250604123039150](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250604123039150.png)

Reference: https://anysilicon.com/the-ultimate-guide-to-clock-gating/

**Dataflow**

![image-20250506221554782](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250506221554782.png)

**Conv** 

![image-20250506221612696](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250506221612696.png)

**Max-pooling**

![image-20250506221620813](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250506221620813.png)

## RTL

![image-20250604122310711](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250604122310711.png)

## GATE

![image-20250604122404809](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250604122404809.png)





## APR



### Result

-   Verify DRC
-   Verify Connectivity
-   Layout
    -   auto placement io


![image-20250604114838068](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250604114838068.png)

Timing Report

![image-20250605154545928](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250605154545928.png)

![image-20250605154659941](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250605154659941.png)



Post-simulation 

![image-20250604122049500](https://raw.githubusercontent.com/frankxaio/markdwon-image/main/data/image-20250604122049500.png)