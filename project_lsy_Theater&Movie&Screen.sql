--CREATE TABLE THEATER(
--	THEATER_NO NUMBER PRIMARY KEY,
--	THEATER_NM VARCHAR(10)
--);

--INSERT INTO THEATER 
--VALUES (1,'서울점');
--INSERT INTO THEATER 
--VALUES (2,'부산점');
--INSERT INTO THEATER 
--VALUES (3,'인천점');
--INSERT INTO THEATER 
--VALUES (4,'대구점');
--INSERT INTO THEATER 
--VALUES (5,'대전점');
--INSERT INTO THEATER 
--VALUES (6,'광주점');
--INSERT INTO THEATER 
--VALUES (7,'울산점');
--INSERT INTO THEATER 
--VALUES (8,'제주점');

SELECT * FROM THEATER;
COMMIT;
-------------------------------------------------------------
CREATE TABLE SCREEN(
	SCREEN_NO NUMBER PRIMARY KEY,
	THEATER_NO NUMBER REFERENCES THEATER ,
	SCREEN_NAME VARCHAR2(30)
);
SELECT * FROM SCREEN;
COMMIT;
--------------------------------------------------------------
CREATE TABLE MOVIE(
	MOVIE_NO NUMBER PRIMARY KEY,
	MOVIE_TITLE VARCHAR2(20),
	MOVIE_CONTENT VARCHAR2(4000),
	RUNNING_TIME VARCHAR2(20),
	MOVIE_YEAR NUMBER,
	RATING VARCHAR2(30),
	COUNTRY VARCHAR2(10)

);
SELECT * FROM MOVIE;

--INSERT INTO MOVIE 
--VALUES (1,'샤이닝',
--'겨울 동안 호텔을 관리하며 느긋하게 소설을 쓸 수 있는 기회를 잡은 ‘잭’은 
--가족들을 데리고 눈 내리는 고요한 오버룩 호텔로 향한다. 
--보이지 않는 영혼을 볼 수 있는 ‘샤이닝’ 능력을 가진 아들 ‘대니’는 이 호텔에 드리워진 음산한 기운을 직감적으로 느낀다.
-- 폭설로 호텔이 고립되자 환상과 현실의 경계에서 점점 미쳐가는 ‘잭’, 그리고 그를 지켜보는 아내 ‘웬디’와 아들 ‘대니’.
--가까워져 오는 극한의 공포. 스탠리 큐브릭 감독이 남긴 스릴러 영화의 바이블.',
--'2시간 24분',1980,'청소년 관람 불가', '미국');
--INSERT INTO MOVIE
--VALUES(2,'스크림',
--'작은 소도시 우즈버러에 사는 케이시에게 이상한 남자로부터 전화가 걸려온다. 
--비디오를 보려는 케이시에게 그 남자는 케이시의 남자 친구인 스티브의 목숨을 걸고 게임을 하자고 한다. 
--케이시가 문제를 맞추면 살고, 틀리면 남자친구가 죽는다. 문제는 "13일의 금요일"에 나오는 살인마의 이름을 맞추는 것. 
--케이시는 문제를 풀지 못하고, 스티브는 처참하게 죽임을 당한다. 이튿날, 혼자 집에 있는 시드니에게도 이상한 전화가 걸려온다. 
--시드니는 케이시와는 달리 힘들게 괴전화의 마수에서 빠져 나온다. 
--그러나 시드니의 남자 친구 빌리가 살인 용의자로 체포되는데, 조사 후 무혐의로 풀려난다.',
--'1시간 40분',1996,'청소년관람불가','미국');

--INSERT INTO MOVIE
--VALUES(3,'떼시스',
--'안젤라는 사진을 전공하는 학생으로 "영화에 나타난 폭력"이란 제목의 논문을 준비하고 있다. 
--지도교수는 비디오테크에서 폭력 영화테입을 찾아주기로 하고, 동료인 케마는 자신의 집에서 스너프 무비를 보여준다. 
--교수는 비디오테크에서 우연히 수백개의 비디오테입으로 채워진 미로를 발견하고 그중 하나를 가져온다. 
--다음날 아침, 안젤라는 프로젝션 룸에서 그가 숨져있는 것을 발견하고, 무의식중에 테입을 집으로 가져간다. 
--살인현장에서 발견된 비디오 테입. 너무나 두려운 나머지, 화면은 보지않고 소리만을 들어본 안젤라는 비디오 테입에서 들리는 소리에 경악을 하고 마는데, 
--그녀가 들은 건 죽어가는 여인의 비명 소리였다. 
--케마와 함께 비디오테입을 보던 안젤라가 발견한 건 살인의 기록을 담은 영화였다. 
--안젤라는 화면 속의 여자가 사지가 잘려나가는 고통을 당하는 것을 보고 극도의 공포에 사로잡힌다. 
--테입속에 담진 여인의 살해장면. 
--케마는 화면의 상태를 보고 살인자의 카메라 모델을 알아내고 그 며칠 후, 안젤라는 학교에서 그 카메라를 가지고 있는 보스코라는 청년을 만난다. 
--그리고 그는 비디오에서 보았던 바네사의 친한 친구라는 것도 알게 된다. 그러나 살인자가 사용한 카메라는 몇 년 전 학교에서 몇대씩이나 구입했다는 것이 밝혀진다. 
--살해당한 교수 대신 안젤라의 논문을 지도하는 카스트로 교수. 그는 논문에 대해 논의하던 도중 보안 카메라에 잡힌 안젤라의 모습을 보여준다. 
--그녀가 테입을 훔치는 순간을 잡은 테입을. 카스트로는 그녀가 가져간 테입을 돌려줄 것을 요구하고 안젤라는 사력을 다해 도망친다. 
--안젤라는 자신이 그 테입에서 보았던 소녀와 같이 희생될 지도 모른다는 사실에 치를 떠는데...',
--'2시간 5분',1996,'청소년관람불가','스페인');

--INSERT INTO MOVIE
--VALUES(4,'링',
--'아사가와 레이코는 조카 토모코의 죽음이 자신이 취재하고 있는 비디오와 연관이 있다고 생각하고 비디오를 찾아 나선다. 
--그러나 비디오를 본 그녀는 영상을 본 사람은 1주일 안에 죽는다는 것을 알아채고 전 남편인 류지에게 도움을 청한다. 
--비디오를 분석한 류지는 영상의 주인공인 시즈코라는 여인을 조사하고, 
--아들 요이치가 비디오를 본 사실을 알게 된 레이코는 그의 목숨을 살리기 위해 애쓴다. 
--마침내 1주일 후, 류지는 죽음을 당하지만 레이코와 요이치는 죽지 않고 살아 있는데...',
--'1시간 36분',1999,'청소년관람불가','일본');

INSERT INTO MOVIE
VALUES(5,'착신아리',
'어느 날 나에게서...
"1개의 새로운 메세지가 도착했습니다."
여대생인 유미(시바사키 코우 분)는 어느 날 친구가 주선한 미팅에 나갔다가 서로 휴대폰 번호를 교환한다. 
미팅이 끝나고 친구인 요코와 파트너에 대한 이야기를 하던 중 한번도 들어보지 못했던 벨소리가 울린다. 
발신번호는 요코 자신의 번호, 더군다나 발신자는 3일 후의 요코 자신! 
누가 장난치는 건가? 
내 번호로 어떻게 전화가 왔지? 
대수롭지 않게 여기던 요코는 메세지가 온 그 시각 전화 속에서와 똑같은 말을 남긴 채 전차에 치어 죽고 만다.
휴대폰 전원을 꺼도, 해지 신청을 해도!
"예고된 그대로, 죽음은 피할 수 없다."',
'1시간 52분',2003,'15세','일본');

INSERT INTO MOVIE
VALUES(6,'장화홍련',
'인적이 드문 시골, 이름 모를 들꽃들이 소담하게 피어 있는 신작로 끝에 일본식 목재 가옥이 홀로 서 있다.
낮이면 피아노 소리가 들려 올 듯 아름다운 그 집은 그러나, 어둠이 내리면 귀기 서린 음산함을 뿜기 시작한다.
예사롭지 않은 기운이 서려 있는 이 집에서 어른도 아이도 아닌 아름다운 두 자매 수미, 수연. 
아름답지만 신경이 예민한 새엄마와 함께 살게 된 그날. 그 가족의 괴담이 시작된다.
수연, 수미 자매가 서울에서 오랜 요양을 마치고 돌아 오던 날. 
새엄마 은주는 눈에 띄게 아이들을 반기지만, 자매는 그녀를 꺼리는 기색이 역력하다. 
함께 살게 된 첫날부터 집안에는 이상한 기운이 감돌고 가족들은 환영을 보거나 악몽에 시달린다. 
수미는 죽은 엄마를 대신해 아버지 무현과 동생 수연을 손수 챙기려 들고, 생모를 똑 닮은 수연은 늘 겁에 질려 있다. 
신경이 예민한 은주는 그런 두 자매와 번번히 다투게 되고, 아버지 무현은 그들의 불화를 그저 관망만 한다. 
은주는 정서불안 증세를 보이며 집안을 공포 분위기로 몰아가고, 동생을 지키기 위해 안간힘을 쓰는 수미가 이에 맞서는 가운데, 
집안 곳곳에서 괴이한 일들이 잇달아 벌어지기 시작하는데...',
'1시간 55분',2003,'12세','한국');

INSERT INTO MOVIE
VALUES(7,'기담',
'경성 최고의 의료기술이 갖춰진 `안생병원` 
동경 유학 중이던 엘리트 의사 부부 `인영`(김보경)과 
`동원`(김태우)이 부임하고 
병원 원장 딸과의 정략결혼을 앞둔 의대 실습생 `정남`(진구)
유년 시절 사고로 다리를 저는 천재 의사 `수인`(이동규)과 함께
경성에서의 생활을 시작한다.
그러나 저마다 비밀스런 사랑에 빠져든 이들은
점점 지독한 파멸의 공포와 마주하게 되는데…
1942년 경성 안생병원
우리는 죽은 자와 사랑을 시작했다',
'1시간 38분',2007,'15세','한국');

INSERT INTO MOVIE
VALUES(8,'불신지옥',
'지방의 낡은 아파트, 열네 살 소녀가 사라졌다!
기도에 빠진 엄마와 단둘이 살고 있던 동생 ‘소진’
어느 날 동생이 사라졌다는 소식에 서울에서 대학을 다니던 언니 희진은 급히 집으로 내려오지만, 엄마는 기도만 하면 소진이 돌아올 거라며 교회에만 들락거리고
담당 형사 태환은 단순 가출로 여기고 형식적인 수사를 진행한다.
소진이가 신 들렸어?
그러던 중 옥상에서 떨어져 죽은 여자 정미가 소진에게 남긴 유서가 발견되고,
경비원 귀갑과 아파트 주민 경자에게서 소진이가 신들린 아이였다는 말을 듣자
희진과 태환은 혼란에 빠진다.
죽은 정미가 엄마와 같은 교회에 다녔다는 사실이 드러나고, 다음날 경비원 귀갑이 죽은 채 발견되지만 엄마는 침묵을 지킨 채 기도에만 매달린다.
소진의 행방은 점점 미궁 속으로 빠지고, 동생이 사라진 이후부터 희진의 꿈에는 죽은 사람의 환영이 나타나기 시작하는데…
소진이 사라지던 날, 무슨 일이 있었던 것일까?',
'1시간 46분',2009,'15세','한국');

INSERT INTO MOVIE
VALUES(9,'화차',
'그녀가 사라졌다!
결혼 한 달 전, 부모님 댁에 내려가던 중 휴게소에 들른 문호와 선영. 
커피를 사러 간 사이 선영은 한 통의 전화를 받고 급하게 나가고, 돌아온 문호를 기다리고 있는 건 문이 열린 채 공회전 중인 차 뿐이다. 
몇 번을 걸어봐도 꺼져있는 휴대폰, 내리는 빗속으로 약혼녀가 사라졌다.
그녀의 모든 것은 가짜다!
미친 듯 선영을 찾는 문호. 돌아온 그녀의 집은 급하게 치운 흔적이 역력하고 다니던 회사의 이력서까지 허위다. 
단서가 사라질 즈음, 선영이 개인파산을 했었고 정작 면책 서류에 남은 그녀의 필적과 사진은 다른 사람의 것이라는 충격적인 사실이 밝혀진다.
가족도 없고… 친구도 없고… 지문도 없다! 내가 사랑했던 그녀는 누구인가?
그녀를 찾으려면 진짜 이름부터 알아내야 하는 문호는 전직 강력계 형사인 사촌 형 종근에게 도움을 청한다. 
통장 잔액을 인출하고, 지문까지 지우고 완벽하게 사라진 그녀의 행적에 범상치 않은 사건임을 직감하는 종근. 
결국 그는 선영의 실종이 살인사건과 연관되어 있음을 본능적으로 느끼는데...
추적하면 할수록 드러나는 충격적 진실
과연, 그녀의 정체는 무엇인가.',
'1시간 57분',2012,'15세','한국');

SELECT * FROM MOVIE;

INSERT INTO MOVIE
VALUES(10,'곡성',
'낯선 외지인이 나타난 후 벌어지는 의문의 연쇄 사건들로 마을이 발칵 뒤집힌다. 
경찰은 집단 야생 버섯 중독으로 잠정적 결론을 내리지만 모든 사건의 원인이 그 외지인 때문이라는 소문과 의심이 걷잡을 수 없이 퍼져 나간다.
경찰 ‘종구’(곽도원)는 현장을 목격했다는 여인 ‘무명’(천우희)을 만나면서 외지인에 대한 소문을 확신하기 시작한다.
딸 ‘효진’이 피해자들과 비슷한 증상으로 아파오기 시작하자 다급해진 ‘종구’. 외지인을 찾아 난동을 부리고, 무속인 ‘일광’(황정민)을 불러 들이는데...',
'2시간 36분',2016,'15세','한국');

INSERT INTO MOVIE
VALUES(11,'겟아웃',
'흑인 남자가 백인 여자친구 집에 초대 받으면서 벌어지는 이야기를 그린 영화',
'1시간 44분',2017,'15세','미국');

INSERT INTO MOVIE
VALUES(12,'유전',
'가족이기에 피할 수 없는 운명이 그들을 덮쳤다!
‘애니’는 일주일 전 돌아가신 엄마의 유령이 집에 나타나는 것을 느낀다. 
애니가 엄마와 닮았다며 접근한 수상한 이웃 ‘조안’을 통해 엄마의 비밀을 발견하고, 
자신이 엄마와 똑같은 일을 저질렀음을 알게 된다. 
그리고 마침내 애니의 엄마로부터 시작돼 아들 ‘피터’와 딸 ’찰리’에게까지 이어진 저주의 실체가 정체를 드러내는데…',
'2시간 7분',2018,'15세','미국');

COMMIT;

SELECT * FROM MOVIE;