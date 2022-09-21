# Learn-SQL
## Các kiểu JOIN :
![ảnh join](https://xuanthulab.net/photo/sql-joins-4213.jpg)
### JOIN(INNER JOIN)
```
SELECT cot
  FROM bang1
  INNER JOIN bang2
  ON bang1.cot = bang2.cot;
```
#### Ví dụ :
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
FROM nhacung
INNER JOIN donhang
ON nhacung.nhacung_id = donhang.nhacung_id;
```

### LEFT OUTER JOIN
```
SELECT cot
  FROM bang1
  LEFT [OUTER] JOIN bang2
  ON bang1.cot = bang2.cot;
```
#### Ví dụ : 
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
  FROM nhacung
  LEFT OUTER JOIN donhang
  ON nhacung.nhacung_id = donhang.nhacung_id;
  ```
### RIGHT OUTER JOIN
```
SELECT cot
 FROM bang1
 RIGHT [OUTER] JOIN bang2
 ON bang1.cot = bang2.cot;
```
#### Ví dụ :
```
SELECT donhang.donhang_id, donhang.donhang_ngay, nhacung.nhacung_ten
 FROM nhacung
 RIGHT OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
```

### FULL OUTER JOIN
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
 FROM nhacung
 FULL OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
```
#### Ví dụ : 
```
SELECT nhacung.nhacung_id, nhacung.nhacung_ten, donhang.donhang_ngay
 FROM nhacung
 FULL OUTER JOIN donhang
 ON nhacung.nhacung_id = donhang.nhacung_id;
 ```

