-- BAI 2:
-- Hiển thị toàn bộ nội dung của bảng Architect
    SELECT * FROM architect;
-- Hiển thị danh sách gồm họ tên và giới tính của kiến trúc sư
    SELECT name, sex FROM architect;
-- Hiển thị những năm sinh có thể có của các kiến trúc sư
    SELECT birthday FROM architect;
-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh tăng dần)
    SELECT birthday, name FROM architect
    ORDER BY birthday;
-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh giảm dần)
    SELECT birthday, name FROM architect
    ORDER BY birthday DESC;
-- Hiển thị danh sách các công trình có chi phí từ thấp đến cao. Nếu 2 công trình có chi phí bằng nhau sắp xếp tên thành phố theo bảng chữ cái building
    SELECT name, city, cost
    FROM building
    ORDER BY cost, city;


-- BAI 4:
-- Hiển thị tất cả thông tin của kiến trúc sư "le thanh tung"
   SELECT * FROM `architect` WHERE id=1;
-- Hiển thị tên, năm sinh các công nhân có chuyên môn hàn hoặc điện
   SELECT * FROM worker
   WHERE skill='han' OR skill='dien';
-- Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn 1948
    SELECT * FROM worker
    WHERE  skill='han' OR skill='dien' AND birthday >1948 ;
-- Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 (birthday + 20 > year)
    SELECT * FROM worker WHERE birthday + 20 > year;
-- Hiển thị những công nhân có năm sinh 1945, 1940, 1948
    SELECT * FROM worker WHERE birthday = '1945' OR birthday = '1940' OR birthday = '1948';
-- Tìm những công trình có chi phí đầu tư từ 200 đến 500 triệu đồng
   SELECT * FROM `building` WHERE cost BETWEEN 200 AND 500;
-- Tìm kiếm những kiến trúc sư có họ là nguyen: % chuỗi
   SELECT * FROM `architect` WHERE name LIKE 'nguyen%';
-- Tìm kiếm những kiến trúc sư có tên đệm là anh
   SELECT * FROM `architect` WHERE name LIKE '% anh%';
-- Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
   SELECT * FROM `architect` WHERE name LIKE '%th_';
-- Tìm chủ thầu không có phone
   SELECT * FROM `contractor` WHERE phone IS NULL;


-- BAI 5:
-- Thống kê tổng số kiến trúc sư
   SELECT COUNT(*) AS total_kien_truc_su FROM `architect`;
-- Thống kê tổng số kiến trúc sư nam
   SELECT COUNT(*) AS total_men_architects FROM architect WHERE sex = 1;
-- Tìm ngày tham gia công trình nhiều nhất của công nhân
   SELECT date, COUNT(worker_id) AS total_workers FROM work GROUP BY date ORDER BY total_workers DESC LIMIT 1;
-- Tìm ngày tham gia công trình ít nhất của công nhân
   SELECT date, COUNT(worker_id) AS total_workers FROM work GROUP BY date HAVING total_workers = 1 ORDER BY total_workers;
-- Tìm tổng số ngày tham gia công trình của tất cả công nhân

-- Tìm tổng chi phí phải trả cho việc thiết kế công trình của kiến trúc sư có Mã số 1

-- Tìm trung bình số ngày tham gia công trình của công nhân

-- Hiển thị thông tin kiến trúc sư: họ tên, tuổi
   SELECT name, YEAR(CURRENT_DATE()) - birthday AS tuoi FROM architect;
-- Tính thù lao của kiến trúc sư: Thù lao = benefit * 1000
   


-- BAI 6:
-- Hiển thị thông tin công trình có chi phí cao nhất
   SELECT MAX(cost) AS maxCost FROM building;
-- Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
-- Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
-- Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
-- Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
