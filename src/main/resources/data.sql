-- 초기에 아이템 옵션 추가를 위한 SQL
INSERT INTO item_options (id, created_at, modified_at, item_id, name, option_price) VALUES
    (1, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 104, '카라멜 시럽', 300),
    (2, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 104, '헤이즐넛 시럽', 300),
    (3, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 107, '카라멜 시럽', 300),
    (4, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 111, '헤이즐넛 시럽', 300),
    (5, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 112, '바닐라 시럽', 300 ),
    (6, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 114, '카라멜 시럽', 300),
    (7, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 114, '헤이즐넛 시럽', 300),
    (8, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 116, '카라멜 시럽', 300),
    (9, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 118, '헤이즐넛 시럽', 300),
    (10, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 129, '바닐라 시럽', 300);




-- 1. beverage_items (init.sql의 데이터 기반)
INSERT INTO public.beverage_items (
    id, created_at, modified_at, name_en, name_ko, description, price, shot_name, supported_temperatures, hot_img_url, ice_img_url, is_coffee
) VALUES
      (101, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Caffe Americano', '카페 아메리카노', '진한 에스프레소에 뜨거운 물을 더한 커피', 4700, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B94%5D_20210430103337006.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110563%5D_20250626094353711.jpg', true),
      (102, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Caffe Latte', '카페 라떼', '에스프레소에 스팀 밀크를 더한 부드러운 커피', 5300, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B41%5D_20210415133833725.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110569%5D_20250626094801903.jpg', true),
      (103, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Cappuccino', '카푸치노', '에스프레소와 풍부한 우유 거품의 조화', 5200, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B38%5D_20210415154821846.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110601%5D_20250626095213930.jpg', true),
      (104, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Caramel Macchiato', '카라멜 마키아또', '바닐라 시럽, 스팀 밀크, 카라멜 소스의 만남', 5900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B126197%5D_20210415154609863.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110582%5D_20250626095111658.jpg', true),
      (105, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'White Chocolate Mocha', '화이트 초콜릿 모카', '화이트 초콜릿과 에스프레소의 부드러운 맛', 6100, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B128192%5D_20210415155639126.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110572%5D_20250626113205748.jpg', true),
      (106, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Caffe Mocha', '카페 모카', '초콜릿, 에스프레소, 스팀 밀크의 조화', 5700, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B46%5D_20210415134438165.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110566%5D_20250626113005628.jpg', true),
      (107, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Flat White', '플랫 화이트', '벨벳 같은 미세 거품과 진한 에스프레소', 5800, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2024/03/%5B9200000005178%5D_20240326103727795.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000005181%5D_20250626095819133.jpg', true),
      (108, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Starbucks Dolce Latte', '스타벅스 돌체 라떼', '달콤한 돌체 시럽과 스팀 밀크', 5900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B128692%5D_20210426091933665.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B128695%5D_20250626095651684.jpg', true),
      (109, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Espresso Con Panna', '에스프레소 콘 파나', '에스프레소에 휘핑크림을 얹은 진한 커피', 3900, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B30%5D_20210415144252244.jpg', NULL, true),
      (110, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Espresso Macchiato', '에스프레소 마키아또', '에스프레소에 우유 거품을 얹은 커피', 3900, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B25%5D_20210415144211211.jpg', NULL, true),
      (111, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Cold Brew', '콜드 브루', '찬물로 오랜 시간 우려낸 깊은 커피', 5100, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000000038%5D_20250626095744182.jpg', true),
      (112, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Nitro Cold Brew', '나이트로 콜드 브루', '질소를 주입해 부드럽고 크리미한 커피', 5900, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000000479%5D_20250626095418324.jpg', true),
      (113, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Vanilla Cream Cold Brew', '바닐라 크림 콜드 브루', '바닐라 크림과 콜드 브루의 조화', 5900, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000000487%5D_20250626095703208.jpg', true),
      (114, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Sea Salt Caramel Cold Brew', '씨솔트 카라멜 콜드 브루', '씨솔트와 카라멜이 어우러진 콜드 브루', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/05/%5B9200000004544%5D_20250521092626287.jpg', true),
      (115, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Grapefruit Honey Black Tea', '자몽 허니 블랙 티', '자몽과 꿀, 블랙티의 상큼달콤한 조화', 5900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B9200000000187%5D_20210419131229539.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000000190%5D_20250626093924488.jpg', false),
      (126, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Green Tea Frappuccino', '제주 말차 크림 프라푸치노', '깊고 진한 말차 본연의 맛과 향을 시원하고 부드럽게 즐길 수 있는 프라푸치노', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000002502%5D_20250626100915378.jpg', true),
      (127, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Strawberry Acai Lemonade Refresher', '딸기 아사이 레모네이드 리프레셔', '딸기와 아사이, 레몬의 상큼한 음료', 6100, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000003763%5D_20250626093913823.jpg', false),
      (128, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Signature Hot Chocolate', '시그니처 핫 초콜릿', '진한 초콜릿의 풍미가 가득한 핫초코', 5700, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B72%5D_20210415140949967.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B110621%5D_20250626113323062.jpg', false),
      (129, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Milk', '우유', '부드러운 우유', 4100, NULL, 'ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B17%5D_20210426095334934.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B18%5D_20250626093838261.jpg', false),
      (130, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Brewed Coffee', '오늘의 커피', '매일 다른 원두로 내린 신선한 커피', 4700, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B2%5D_20210430111934117.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B106509%5D_20250626092521116.jpg', true),
      (116, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Yuja Mint Tea', '유자 민트 티', '유자와 민트가 어우러진 상큼한 티', 5900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2022/04/%5B9200000002956%5D_20220411155551915.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000002959%5D_20250626095858925.jpg', false),
      (117, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Hibiscus Blend Tea', '히비스커스 블렌드 티', '히비스커스와 허브의 상큼한 블렌드', 5900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B4004000000066%5D_20210415155836395.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B4004000000069%5D_20250626095350549.jpg', false),
      (118, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Chai Tea Latte', '스타벅스 클래식 밀크 티', '스타벅스가 선보이는 클래식한 밀크 티로, 진하게 오래 우려낸 티바나 블랙 티의 깊은 풍미와 우유의 조화로움을 담아낸 ''맛''에 집중한 밀크 티', 5900, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/01/%5B9200000004933%5D_20250102105625904.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000004936%5D_20250626095136814.jpg', false),
      (119, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'English Breakfast Tea', '잉글리쉬 브렉퍼스트 티', '깊고 진한 풍미의 클래식 블랙티', 4900, NULL, 'HOT', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B4004000000016%5D_20210415153648533.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B4004000000019%5D_20250626094722001.jpg', false),
      (120, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Mint Blend Tea', '민트 블렌드 티', '상쾌한 민트 향의 허브티', 4900, NULL, 'HOT_ICE', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B4004000000056%5D_20210415135215632.jpg', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B4004000000059%5D_20250626095245748.jpg', false),
      (121, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Strawberry Delight Yogurt Blended', '딸기 딜라이트 요거트 블렌디드', '딸기와 요거트가 어우러진 상큼한 음료', 6800, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9200000003276%5D_20250626100054304.jpg', false),
      (122, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Mango Banana Blended', '망고 바나나 블렌디드', '망고와 바나나가 어우러진 시원한 음료', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B169001%5D_20250626100121981.jpg', false),
      (123, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Java Chip Frappuccino', '자바 칩 프라푸치노', '초콜릿 칩이 씹히는 진한 커피 프라푸치노', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B168016%5D_20250626113600873.jpg', true),
      (124, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Caramel Frappuccino', '카라멜 프라푸치노', '달콤한 카라멜과 커피의 조화', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B168010%5D_20250626113443023.jpg', true),
      (125, '2025-07-03 08:34:17', '2025-07-03 08:34:17', 'Vanilla Cream Frappuccino', '바나나 아몬드 오트 프라푸치노', '로스티드 아몬드, 오트와 진짜 바나나 한 개를 통째로 넣어 여행 전 달콤하고 든든하게 즐기는 공항 전용 프라푸치노', 6300, NULL, 'ICE', NULL, 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/05/%5B9200000006220%5D_20250523150821265.jpg', true);

-- 2. beverage_item_supported_sizes (음료-사이즈 매핑)
INSERT INTO public.beverage_item_supported_sizes (beverage_item_id, supported_size_id) VALUES
    (101, 1), (101, 2), (101, 3),
    (102, 1), (102, 2), (102, 3),
    (103, 1), (103, 2), (103, 3),
    (104, 1), (104, 2), (104, 3),
    (105, 1), (105, 2), (105, 3),
    (106, 1), (106, 2), (106, 3),
    (107, 4), (107, 1), (107, 2), (107, 3),
    (108, 4), (108, 1), (108, 2), (108, 3),
    (109, 5), (109, 6),
    (110, 5), (110, 6),
    (111, 1), (111, 2), (111, 3),
    (112, 1), (112, 2), (112, 3),
    (113, 1), (113, 2), (113, 3),
    (114, 1), (114, 2), (114, 3),
    (115, 4), (115, 1), (115, 2), (115, 3),
    (116, 1), (116, 2), (116, 3),
    (117, 1), (117, 3),
    (118, 1), (118, 3),
    (119, 1), (119, 3),
    (120, 1), (120, 3),
    (121, 1), (121, 2), (121, 3),
    (122, 2),
    (123, 1), (123, 2), (123, 3),
    (124, 1), (124, 2), (124, 3),
    (125, 1), (125, 2), (125, 3),
    (126, 1), (126, 2), (126, 3),
    (127, 1), (127, 2), (127, 3),
    (128, 4), (128, 1), (128, 2), (128, 3),
    (129, 1), (129, 4),
(130, 4), (130, 1), (130, 2), (130, 3);
-- 실제 운영 데이터에 맞춰 조합을 추가/수정하세요.
INSERT INTO dessert_items (id, created_at, modified_at, description, name_en, name_ko, image_url, price) VALUES
     (201, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '바게트 빵처럼 토스트 된 겉면과 쫄깃한 빵 속 그리고 버터가 녹여진 바삭한 바닥면까지 다양한 식감을 즐길 수 있는 소금빵입니다.', 'Salt Bread', '바게트 소금빵', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/05/%5B9300000005856%5D_20250523093416978.jpg', 3800),
     (202, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '풍부한 크루아상 본연의 버터 맛과 식감으로 커피와 함께 드시기 좋은 빵입니다.', 'Croissant', '프렌치 크루아상', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/06/%5B9300000005986%5D_20250611092836112.jpg', 4200),
     (203, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '촉촉한 카스텔라와 듬뿍 들어간 생크림', 'Soft Fresh Cream Castella', '부드러운 생크림 카스텔라', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B5110007181%5D_20210421164728509.jpg', 4500),
     (204, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '새콤달콤한 딸기와 키위를 마스카포네 요거트 크림으로 층층이 샌드하여 여름의 싱그러운 색감을 표현한 과일 케이크입니다.', 'Fruit Fresh Cream Cake', '과일 생크림 케이크', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/05/%5B9300000005952%5D_20250508103152562.jpg', 5900),
     (205, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '고온에서 짧게 구워 겉면은 스모키하고 속은 크리미한 특징의 바스크 치즈 케이크에 초코의 달콤한 풍미를 더해 다채로운 맛을 즐길 수 있는 케이크입니다.', 'Basque Choco Cheese Cake', '바스크 초코 치즈 케이크', 'https://image.istarbucks.co.kr/upload/store/skuimg/2024/09/%5B9300000005454%5D_20240926125347818.jpg', 7300),
     (206, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '하트 모양의 겉은 바삭하고 속은 쫄깃한 상큼한 딸기 맛 마카롱입니다.', 'Heart Strawberry Macaron', '하트 스트로베리 마카롱', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/01/%5B9300000004517%5D_20250116140423596.jpg', 3200),
     (207, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '겉은 바삭하고 속은 쫄깃한 초코 가나슈가 샌드된 진한 맛의 초콜릿 마카롱입니다.', 'Dark Chocolate Macaron', '다크 초콜릿 마카롱', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/04/%5B9300000001924%5D_20210421133005814.jpg', 3500),
     (208, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '프렌치토스트 스타일로 구워낸 빵 사이에 에그 스프레드를 샌드하고 빵 위에 치즈와 베이컨을 얹어 구운 토스트입니다.', 'Melting Cheese Bacon Toast', '멜팅 치즈 베이컨 토스트', 'https://image.istarbucks.co.kr/upload/store/skuimg/2025/01/%5B9300000005813%5D_20250110155406172.jpg', 6800),
     (209, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '유기농 우유와 유산균으로 만든 정통 그릭 방식의 플레인 요거트 입니다.', 'Organic Greek Yogurt Plain', '오가닉 그릭 요거트 플레인', 'https://image.istarbucks.co.kr/upload/store/skuimg/2021/08/%5B9300000003231%5D_20210826102030647.jpg', 4500),
     (210, '2025-07-03 08:34:17', '2025-07-03 08:34:17', '마다가스카르산 바닐라 빈이 들어있는 부드럽고 깔끔한 맛의 젤라또입니다.', 'Vanilla Bean Gelato', '바닐라 빈 젤라또', 'https://image.istarbucks.co.kr/upload/store/skuimg/2024/08/%5B9300000005404%5D_20240814124112398.jpg', 4800);


-- 상점(Merchant) 더미 데이터 예시
INSERT INTO merchant (id, name, email, password) VALUES
     (1, '스타벅스코리아', 'starbucks1@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (2, '카페베네', 'starbucks2@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (3, '투썸플레이스', 'starbucks3@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (4, '이디야커피', 'starbucks4@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (5, '커피빈', 'starbucks5@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (6, '할리스커피', 'starbucks6@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (7, '빽다방', 'starbucks7@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (8, '메가커피', 'starbucks8@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (9, '탐앤탐스', 'starbucks9@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO'),
     (10, '폴바셋', 'starbucks10@corp.com', '$2a$10$Hb00ncX7ugBIsXAzkAR6WuCVGm7OL5ytmKV4rfFpy9pqNAVSObxcO');


INSERT INTO stores (
    id, created_at, modified_at, address, crowd_level, has_drive_through, image_url, latitude, longitude, name, opening_hours, phone, seating_capacity, merchant_id
) VALUES
      (1, NULL, NULL, '서울 강남구 강남대로 390', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2017/08/%5B3478%5D_20170822020135_a2lao.png', NULL, NULL, '강남R점', '07:00-22:30', '1522-3230', 100, 1),
      (2, NULL, NULL, '서울 강남구 강남대로 456 한석타워 2층 1-2호', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2023/02/%5B9824%5D_20230203102338_io5t7.jpg', NULL, NULL, '강남대로점', '08:00-22:00', '1522-3231', 60, 2),
      (3, NULL, NULL, '서울 강남구 학동로 419', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2017/03/%5B3397%5D_20170328092242_kyldo.jpg', NULL, NULL, '강남구청정문DT점', '07:00-22:00', '1522-3232', 50, 3),
      (4, NULL, NULL, '서울 강남구 테헤란로 520', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2022/07/%5B4319%5D_20220704024046_xwja3.jpg', NULL, NULL, '삼성역점', '07:00-22:00', '1522-3233', 65, 4),
      (5, NULL, NULL, '서울 강남구 도산대로 108', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2022/01/%5B3858%5D_20220127064243_5khni.jpg', NULL, NULL, '신사역성일빌딩점', '07:00-22:00', '1522-3234', 40, 5),
      (6, NULL, NULL, '서울 강남구 도산대로 442', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2020/09/%5B3366%5D_20200919014258_y0mzi.jpg', NULL, NULL, '청담스타R점', '07:00-23:00', '1522-3235', 80, 6),
      (7, NULL, NULL, '서울 강남구 압구정로 328', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2020/10/%5B9545%5D_20201027103930_nyjip.jpg', NULL, NULL, '압구정로데오역점', '08:00-22:00', '1522-3236', 45, 7),
      (8, NULL, NULL, '서울 강남구 테헤란로 145', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2022/05/%5B4293%5D_20220511055826_8m4a3.jpg', NULL, NULL, '역삼역점', '07:00-22:00', '1522-3237', 55, 8),
      (9, NULL, NULL, '서울 강남구 도곡로 112', 'LOW', false, 'https://image.istarbucks.co.kr//upload/store/2023/01/%5B3009%5D_20230118065252_xpepz.jpg', NULL, NULL, '도곡DT점', '07:00-21:00', '1522-3238', 25, 9),
      (10, NULL, NULL,	'서울 강남구 테헤란로 334',	'LOW',	false,	'https://image.istarbucks.co.kr//upload/store/2020/05/%5B9308%5D_20200508124414_siviz.jpg',	NULL,	NULL,'선릉역점',	'07:00-22:00',	'1522-3239',	'50',	10);



INSERT INTO order_daily_counters (date, store_id, count)
SELECT CURRENT_DATE, s.id, 0
FROM stores s
WHERE NOT EXISTS (
    SELECT 1
    FROM order_daily_counters odc
    WHERE odc.date = CURRENT_DATE AND odc.store_id = s.id
);