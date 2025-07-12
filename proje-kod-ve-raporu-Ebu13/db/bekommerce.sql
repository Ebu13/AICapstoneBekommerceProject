--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: message_sender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.message_sender AS ENUM (
    'USER',
    'BOT'
);


ALTER TYPE public.message_sender OWNER TO postgres;

--
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status AS ENUM (
    'HAZIRLANIYOR',
    'KARGOYA_VERILDI',
    'TESLIM_EDILDI'
);


ALTER TYPE public.order_status OWNER TO postgres;

--
-- Name: product_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.product_category AS ENUM (
    'Elektronik',
    'Moda',
    'Ev_Yasam',
    'Spor',
    'Otomotiv',
    'Kozmetik'
);


ALTER TYPE public.product_category OWNER TO postgres;

--
-- Name: shipping_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipping_status AS ENUM (
    'YOLDA',
    'TESLIM_EDILDI'
);


ALTER TYPE public.shipping_status OWNER TO postgres;

--
-- Name: support_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.support_status AS ENUM (
    'ACIK',
    'CEVAPLANDI',
    'KAPALI'
);


ALTER TYPE public.support_status OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'BUYER',
    'SELLER',
    'ADMIN'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    address character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    zip_code character varying(255) NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_messages (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    sender character varying(255) NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.chat_messages OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chat_messages_id_seq OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_messages.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorites_id_seq OWNER TO postgres;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    total_price double precision NOT NULL,
    status character varying(255) DEFAULT 'HAZIRLANIYOR'::public.order_status NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_reviews (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    rating integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT product_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.product_reviews OWNER TO postgres;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_reviews_id_seq OWNER TO postgres;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    seller_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    price double precision NOT NULL,
    stock integer NOT NULL,
    category character varying(255) NOT NULL,
    image_url character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: seller_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller_details (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    business_name character varying(255) NOT NULL,
    business_address text NOT NULL,
    tax_number character varying(255) NOT NULL
);


ALTER TABLE public.seller_details OWNER TO postgres;

--
-- Name: seller_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seller_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seller_details_id_seq OWNER TO postgres;

--
-- Name: seller_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seller_details_id_seq OWNED BY public.seller_details.id;


--
-- Name: shipping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    tracking_number character varying(255) NOT NULL,
    carrier character varying(255) NOT NULL,
    estimated_delivery character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'YOLDA'::public.shipping_status NOT NULL
);


ALTER TABLE public.shipping OWNER TO postgres;

--
-- Name: shipping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shipping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shipping_id_seq OWNER TO postgres;

--
-- Name: shipping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shipping_id_seq OWNED BY public.shipping.id;


--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_tickets (
    id bigint NOT NULL,
    message character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    CONSTRAINT support_tickets_status_check CHECK (((status)::text = ANY ((ARRAY['ACIK'::character varying, 'CEVAPLANDI'::character varying, 'KAPALI'::character varying])::text[])))
);


ALTER TABLE public.support_tickets OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.support_tickets ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.support_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: chat_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: seller_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_details ALTER COLUMN id SET DEFAULT nextval('public.seller_details_id_seq'::regclass);


--
-- Name: shipping id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping ALTER COLUMN id SET DEFAULT nextval('public.shipping_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, user_id, address, city, country, zip_code) FROM stdin;
1	6	21541 Çamurcuoğlu Locks, Basriyefort, VT 76645	Mansıztown	Türkiye	93772
2	7	539 Fırat Locks Apt. 567, South Oymakland, AS 46483	Lake Denizalp	Türkiye	40137
3	7	94085 Yılmaz Spring, Bağdatland, MA 80553	West Doğanalp	Türkiye	32087
4	8	68620 Faize Extension Suite 549, Hurşideland, ND 75646	Semineberg	Türkiye	14697
5	9	794 Kısakürek Manors Suite 995, Hançerport, SD 12144	Demirelstad	Türkiye	78535
6	9	USNV Yüksel, FPO AA 28151	Eşrefburgh	Türkiye	79506
7	10	PSC 5259, Box 9416, APO AE 37704	Kardelenburgh	Türkiye	73514
8	11	Unit 2400 Box 9598, DPO AE 07472	Lake Vafirhaven	Türkiye	49876
9	12	40301 Hazine Flats, North Birsenhaven, OR 88380	Fıratshire	Türkiye	22641
10	12	1576 İlper Coves Suite 015, West Sevgenburgh, OH 20692	South Rehimeland	Türkiye	60344
11	13	7221 Heva Locks, North Başhanfurt, FL 22319	Hükümdarton	Türkiye	48973
12	13	804 Ergül Locks, West Bozbağberg, DC 68735	East Lerzestad	Türkiye	40967
13	14	3951 Ülker Rest Suite 540, Lake Merim, MO 98411	Lake Mahter	Türkiye	79481
14	15	0177 Yaman Rue Apt. 622, Akçayfurt, VT 29486	Lake Zihni	Türkiye	50833
15	15	36110 İhsanoğlu Shoal Apt. 921, Ergülside, OH 82331	East Buhari	Türkiye	89562
16	16	203 Duran Rue, South Sümerya, NJ 81038	Yurdanurchester	Türkiye	33420
17	16	094 Bilge Roads, Maynurhaven, RI 04623	Durmuşaliview	Türkiye	11565
18	17	02276 İklim Trafficway, Lake Seyfullah, NC 26001	North Akdoraview	Türkiye	52824
19	17	9403 Aslan Mission, North İzel, WI 39739	Öcalanstad	Türkiye	80934
20	18	996 Şener Groves, North Bozbağmouth, SD 80927	Tevetoğluview	Türkiye	35119
21	19	561 Kader Inlet Apt. 184, Saçıview, AR 49627	Süleylafort	Türkiye	99238
22	19	4986 Ülker Pike Suite 254, Hayretburgh, DC 88913	Doğuhanmouth	Türkiye	69447
23	20	626 Şama Turnpike Suite 210, New Rümeysaborough, MD 17094	Port Cangür	Türkiye	90630
24	21	7319 Coşkun Heights Suite 128, Ergülburgh, AK 45160	Sargınshire	Türkiye	34686
25	21	6372 Yılmaz Passage Suite 079, Akçachester, MD 51145	Soyluside	Türkiye	77211
26	22	79501 Artan Harbors Suite 263, East Kutay, KS 35469	South Sevsevilmouth	Türkiye	53350
27	23	56753 Şahinder Dam, Emine.bury, NY 28423	North Saçı	Türkiye	19188
28	24	Unit 3890 Box 7886, DPO AA 85706	Demirview	Türkiye	78776
29	25	9674 İhsanoğlu View, Lake Durmuşali, OK 07702	Öcalanmouth	Türkiye	15688
30	26	USNV Durmuş, FPO AE 43891	East Oğurata	Türkiye	20547
31	26	58596 Hayrioğlu Inlet Suite 836, Çamurcuoğlufort, RI 25996	West Oğurata	Türkiye	83520
32	27	12317 Akçay Avenue, North Feremez, MO 16437	West Nebiha	Türkiye	34796
33	28	PSC 3692, Box 2353, APO AP 85062	Lake Esenbaychester	Türkiye	55326
34	28	646 Şama Hollow Suite 644, Port Abiye, NV 91356	Lake Erdoganborough	Türkiye	90543
35	29	145 Türk Radial, Şamihastad, MP 39869	West Neribanport	Türkiye	13673
36	29	2857 Emine. Land Apt. 026, Lake Mihriyestad, MS 72741	Lake Şuayp	Türkiye	91519
37	30	277 Adal Plains, Port Zeride, MH 00609	West Simtenberg	Türkiye	64876
38	31	247 Çelikyürek Crossing, Şadımanstad, MS 13554	South Bediriyehaven	Türkiye	32287
39	31	8315 Gündüzalp Route, New Barişport, AS 16984	North Ortakhaven	Türkiye	06516
40	32	402 Koncagül Rapids, West Zülbiyemouth, MD 83848	Lake Ünekbury	Türkiye	87508
41	33	66795 Akgündüz Vista, West Nezihiside, WI 82727	Lake Sahirville	Türkiye	92977
42	33	609 Yüksel Inlet, Akarton, NY 73153	Port Anargül	Türkiye	68498
43	34	287 Aksu Roads, West Adasalfort, MS 73397	Yıldırside	Türkiye	74782
44	35	54337 Türk Spurs Apt. 558, West Annak, MD 94733	Gülburgh	Türkiye	70849
45	36	2624 Eraslan Fall Suite 359, South Anka, VT 30857	Odkanlıton	Türkiye	84585
46	37	5549 Züheyla Mountains Apt. 489, Lake Şeydaside, IL 87125	Kaderstad	Türkiye	83511
47	38	Unit 3732 Box 5853, DPO AA 49068	Hayrioğlubury	Türkiye	67074
48	38	8535 İmren Inlet Apt. 274, South Zahid, PR 37980	West Süleylaburgh	Türkiye	07770
49	39	9208 Emine. Springs Apt. 702, Bilgütayberg, VI 15877	West Tomurcukfort	Türkiye	91384
50	39	3562 Güçlü Ports, South Köktaş, NM 09615	Akgündüzberg	Türkiye	76612
51	40	442 Erdoğan Valley, Sairestad, GU 33860	East İslimefurt	Türkiye	28834
52	41	0036 Yılmaz Cliffs, New İncifir, UT 38322	Sakaryaton	Türkiye	11331
53	41	7914 Otay Canyon, East Toköz, AS 19418	Kısakürekshire	Türkiye	07066
54	42	938 Ertaş Village, West Haluktown, GA 21111	Rakidefort	Türkiye	77309
55	42	370 Akgöl Club Suite 004, Yılmazton, ID 75086	North Işımanville	Türkiye	26010
56	43	1558 Yıldırım Passage, Port Kiyasichester, RI 46613	West Demirizmouth	Türkiye	38301
57	43	567 Şener Cliffs, Ayşeanamouth, MI 05701	North Gülinaz	Türkiye	32204
58	44	840 Yılmaz Tunnel, Zorlumouth, AK 23118	Züferview	Türkiye	91523
59	45	7111 Zengin Forks, West Erkan, AK 06435	Port Karacaland	Türkiye	61244
60	45	028 Sabihe Station, Demirelshire, NC 83823	East Okgüçlüstad	Türkiye	77648
61	46	478 Soylu Bridge, Akarfurt, DE 93898	North Beseymouth	Türkiye	80183
62	46	606 Feden Fields, Lake Tanbayhaven, ME 96780	Gülenayberg	Türkiye	97571
63	47	76852 Çetin Trafficway, Bilirhaven, WA 64205	Hıfzullahfurt	Türkiye	82185
64	48	474 Akar Mountain Suite 660, South İlalmışchester, PA 50404	New Aksay	Türkiye	62833
65	49	592 Dumanlı Knoll, South Kırat, MI 69171	South Öztürkchester	Türkiye	02866
66	50	016 Arsoy Square Suite 698, Port Buhari, ND 62065	East Müritmouth	Türkiye	78171
67	50	8552 Bilgin Extensions Apt. 492, Lake Tiğinside, ME 31229	Aslanchester	Türkiye	07367
68	51	344 Gülen Neck, Mansızside, OK 15035	East Ummahaniport	Türkiye	19754
69	51	720 Yıldırım Motorway, Aksufurt, OK 67259	East Ballıstad	Türkiye	56854
70	52	315 Yorulmaz Passage, New Yekdafurt, FM 06392	East Ayaydın	Türkiye	74997
71	52	99316 Samahat Dam, North Kapaganfurt, DE 39730	Lake Sanurborough	Türkiye	37238
72	53	38086 Ertaş Camp, Çorluburgh, KY 11714	East Fadileland	Türkiye	19126
73	53	PSC 5593, Box 3554, APO AA 29027	Maşidestad	Türkiye	52817
74	54	1557 Aköz Villages, West Necilal, GU 72414	Selimeberg	Türkiye	07533
75	54	099 Dilder Avenue Apt. 087, Yılmazport, MH 44684	North Sejdaview	Türkiye	87364
76	55	10147 Aksu Lodge Suite 034, Şafakberg, DC 85577	New Ayşeanaport	Türkiye	09539
77	55	PSC 6458, Box 0310, APO AA 19193	New Idıkmouth	Türkiye	15071
78	56	1736 Ferzi Harbor, West Tezol, RI 10546	South Abdülhadi	Türkiye	11216
79	56	95203 Sidki Cape Suite 249, Port Esmanperi, FM 11385	Eraslanside	Türkiye	53961
80	57	63470 Susam Glen, North Canfezafurt, IN 59439	Saydamburgh	Türkiye	44887
81	57	6685 Türk Harbors, Ertaşview, NY 23606	Ülkerville	Türkiye	33013
82	58	8135 Türk Wells Suite 676, North Ügeberg, KY 81260	North Öngenburgh	Türkiye	82663
83	59	USNV Akgündüz, FPO AP 68594	Permunshire	Türkiye	27342
84	59	4642 Güçlü Orchard Suite 386, Erdoganside, MN 25688	Ünseverland	Türkiye	62836
85	60	566 Limon Highway, Uğurkantown, NY 69191	Port Bidayetton	Türkiye	17834
86	60	1769 Vargın Coves Apt. 524, Akdenizmouth, PW 03463	Mansızshire	Türkiye	53149
87	61	5539 İnönü Hill Apt. 477, Tarhanburgh, AL 84175	Necmettintown	Türkiye	79296
88	62	PSC 1013, Box 6539, APO AA 32409	Kanpulatburgh	Türkiye	56356
89	63	420 Gül Neck Suite 884, Soyluland, NY 00756	Sakaryaton	Türkiye	67783
90	64	14085 Kumral Garden Suite 952, New Seyyidehaven, AS 77522	Erdoğanmouth	Türkiye	33213
91	65	71032 Güçlü Highway Apt. 405, Mücevherland, KS 07756	Port Özdeştown	Türkiye	59853
92	66	4460 Mansız Islands, Hazinefurt, NM 87160	East Yücel	Türkiye	09860
93	67	7069 Salkın Ports Apt. 241, Münezzerport, LA 34055	South Tagangül	Türkiye	18422
94	68	68204 Ergül Bridge, East Sevdinar, NJ 92493	East Ticenton	Türkiye	79347
95	68	PSC 1254, Box 9346, APO AP 76518	Masumeville	Türkiye	17298
96	69	43389 Ecegül Rapids, Arslanmouth, MD 78162	Durmuşhaven	Türkiye	46886
97	69	5374 Güçlü Inlet Suite 992, Nazlimburgh, ID 16907	East Baturayton	Türkiye	90231
98	70	6636 Eraslan Summit, Port Nurseda, MT 17634	Sezerside	Türkiye	52884
99	71	0759 Akçay Burg Suite 406, East Neribanchester, ID 55057	Arcanshire	Türkiye	92499
100	72	62415 Gül Street, Aksumouth, AR 26279	East Özger	Türkiye	50838
101	73	50831 Sevgen Ports Suite 409, West Kıvılcım, PR 65994	North Kitanburgh	Türkiye	38793
102	74	1640 Erten Estates Suite 935, Fıratstad, OK 30272	Şafakton	Türkiye	39226
103	74	USNS Yılmaz, FPO AA 86028	West Azettinhaven	Türkiye	29245
104	75	838 İntihap Lane Apt. 235, West Macide, FL 94754	East Güçaltown	Türkiye	55141
105	75	6216 Akçay Drive, North Yalazabayberg, GU 09212	Güçlübury	Türkiye	74297
106	76	1152 Elifnur Club Apt. 715, West Aycagülhaven, PW 72480	New Turabifort	Türkiye	90639
107	76	01936 İhsanoğlu Corner Apt. 970, West Arıel, MA 54514	South Tanır	Türkiye	63508
108	77	77994 Dumanlı Union Apt. 782, Port Çağverenberg, ME 47782	South İldeşshire	Türkiye	67096
109	78	3415 Öcalan Estate Suite 491, Lake Gülhisarside, NJ 87309	West Evrimerland	Türkiye	20021
110	79	281 Ülker Freeway, Şensoytown, KY 14767	New Kandef	Türkiye	86880
111	79	528 Ünal Run, West Şevket, ME 28070	Hekmetburgh	Türkiye	44140
112	80	875 Demirel Harbors, Ergülborough, MD 87116	West Lezize	Türkiye	70655
113	80	05797 Oktüremiş Stream, Port Dündaralp, KS 32031	Aranburgh	Türkiye	73614
114	81	81797 Ufukay Rapids, Port Çokanmouth, AS 88269	Eflâtunhaven	Türkiye	61462
115	81	65023 Karadeniz Crest, Erksoybury, MT 28533	South Hasretside	Türkiye	12598
116	82	6115 Dolun Course, Mançofurt, NV 91880	West Erbilville	Türkiye	36119
117	82	867 Manço Crossroad, Akdenizfort, IL 45668	Korutürkshire	Türkiye	77789
118	83	7233 Bilge Islands, Özkutluhaven, DC 28336	Güçlüview	Türkiye	99719
119	83	290 Jaruthip Manors, West Şerafeddin, MI 20274	Kısakürekview	Türkiye	12320
120	84	5248 Yorulmaz Road Suite 412, New Ferayeborough, AS 14485	Erdursunbury	Türkiye	53652
121	85	807 Erdoğan Crest Apt. 170, New Zülbiye, MA 45252	New Aran	Türkiye	71191
122	86	6454 Ülker Meadows Suite 808, Port Hazine, TN 62475	Yaltıraktown	Türkiye	95742
123	86	48051 Şener Streets Apt. 532, North Dilfeza, VA 50459	Eraslanborough	Türkiye	17119
124	87	63300 Arpağ Shore, Abdulmenafmouth, MI 35014	Ülkermouth	Türkiye	35202
125	87	190 Türk Walks, Alemdartown, DC 37172	Dumanlıbury	Türkiye	46589
126	88	05505 Arsoy Circle Apt. 397, North Muhammet, MI 00873	Türkstad	Türkiye	70000
127	89	01171 Risalet Islands, Ferhanberg, HI 63456	Korutürkside	Türkiye	69990
128	90	45438 Akgündüz Manors, New Özgünton, AZ 08256	Akarton	Türkiye	53791
129	90	6076 Jaruthip Fort Suite 783, South Yazganalphaven, ND 63846	South Algış	Türkiye	33510
130	91	18636 Fatigül Estates Suite 773, Öcalanhaven, PA 25274	East Ledünhaven	Türkiye	99937
131	91	45113 Bekbay Neck Suite 236, West Okyalazside, ME 59219	Akisetown	Türkiye	09377
132	92	47392 Çorlu Gardens Suite 259, New Sıylıhan, ME 69073	Gülstad	Türkiye	57713
133	92	661 Salkın Branch, East Beray, IA 37842	Veisburgh	Türkiye	08863
134	93	651 Oğurata Keys Apt. 636, Ayhanfurt, SC 27955	Evrimertown	Türkiye	36836
135	94	05661 Kavurt Island Suite 084, Lake Risaletton, IA 27005	Ünübolbury	Türkiye	77366
136	94	157 Çorlu Avenue Suite 574, Erdoğanview, NH 18598	Port Cemiyle	Türkiye	81353
137	95	8805 Bağdaş Corner Suite 569, New Ismıkside, MS 29316	Şamastad	Türkiye	37735
138	95	389 Demir Tunnel Apt. 331, West Mehdiye, IL 42039	West Sayin	Türkiye	70832
139	96	6544 Sevcan Overpass Apt. 523, Karlukhanchester, IA 68817	West Çağlasın	Türkiye	91725
140	97	7979 Arsoy Forks, East Yücelmouth, MH 58760	Dağistanstad	Türkiye	76686
141	98	51815 Çamurcuoğlu Crossing Suite 192, West Rohat, UT 06280	Yadigarland	Türkiye	31949
142	98	2817 Yüksel Mill, Akçaytown, CT 88146	Akartown	Türkiye	53059
143	99	740 Kahir Hills Suite 025, West Hazrat, MN 08218	Çorluside	Türkiye	23653
144	100	50952 Adviye Falls, South Muratcan, WY 73147	Kısakürekmouth	Türkiye	67721
145	100	USNS Ergül, FPO AA 89522	Durduhaven	Türkiye	69766
146	101	453 Çorlu Cliff Suite 824, New Mihriye, NJ 15742	Akayburgh	Türkiye	35825
147	102	707 Yılmaz Expressway, Lake Över, NY 68341	South Aytekfurt	Türkiye	63961
148	103	1477 Zengin Bypass, South Bozerk, DE 17472	Zenginfort	Türkiye	29864
149	104	12483 Eraslan Landing, West Cangür, SD 90904	Otayport	Türkiye	90138
150	104	2418 İhsanoğlu Throughway Apt. 592, West Saba, FL 15744	Altınkayaton	Türkiye	58980
151	105	237 Seven Mission, Bilirport, AS 11829	Büşranurport	Türkiye	05955
152	105	PSC 7029, Box 2523, APO AP 74139	South Fadılahaven	Türkiye	23975
153	106	11964 Onuker Stream Suite 301, Karakucakburgh, KS 94230	Arslanland	Türkiye	42888
154	107	5007 Macide Bypass Apt. 581, Lake Övün, WV 29649	Baliton	Türkiye	69814
155	108	33228 Özüdoğru Villages Suite 930, West Rahmetshire, MI 74005	Port Ünüboltown	Türkiye	87333
156	109	60182 Güçlü Courts, East Dilşatchester, UT 19904	Yıldırımmouth	Türkiye	18706
157	109	486 Hayrioğlu Lock, North Zeynoland, TN 27497	Şensoybury	Türkiye	09183
158	110	4139 Mahsun Bridge, Çakırcahaven, CO 31141	Lütfiport	Türkiye	80605
159	111	050 Oranlı Trace Apt. 515, Lake Delilburgh, OK 83100	South İlbek	Türkiye	64074
160	111	57829 Mutluhan Passage, Çorluburgh, OH 77565	East Tüzenurview	Türkiye	54898
161	112	119 Hayrioğlu Junction Apt. 563, Durdufort, NM 48995	Mirayburgh	Türkiye	43678
162	112	97750 Akçay Field, Alemdarfurt, PW 51179	Port Sittik	Türkiye	96410
163	113	061 Cangür Passage, Mansızshire, CO 60433	East Gülfeza	Türkiye	12430
164	113	5783 Sakarya Manor, East Aclan, IL 80079	Kısakürektown	Türkiye	65045
165	114	Unit 6947 Box 6922, DPO AE 65242	South Tanırville	Türkiye	38195
166	114	99256 Öcalan Lock, Akdenizton, AR 18290	Yıldırımside	Türkiye	46583
167	115	9437 Eraslan Well Suite 144, Ferziborough, MO 10067	Yamanhaven	Türkiye	58570
168	115	4957 Tarhan Squares Suite 527, Bilgetown, AZ 63663	East Muhiyeville	Türkiye	42139
169	116	31601 Yurtgüven Prairie Suite 514, East Göksevhaven, CA 66379	Aferview	Türkiye	61979
170	116	53440 Zülfüye Mount, Lake Heyvetullahhaven, MN 95747	Emrullahstad	Türkiye	23863
171	117	46186 Borataş Alley, Tevschester, VI 68101	Oranlıfurt	Türkiye	65187
172	118	Unit 1171 Box 2182, DPO AP 59117	Lake Denkelborough	Türkiye	61098
173	118	8066 Şama Ferry Suite 199, South Şali, ME 64333	Hüsnühâlville	Türkiye	29579
174	119	261 Alemdar Manor Apt. 208, East Laze, AS 09852	Tezolfort	Türkiye	46500
175	119	910 Abdurrahman Pass Suite 808, Port Selvi, GA 06348	Bilayshire	Türkiye	09737
176	120	586 Kıvılcım Corner Suite 465, Fehmiyestad, VI 49801	Batırhanmouth	Türkiye	34167
177	121	6802 Hayrioğlu Shoal, Aslanberg, CA 56807	İnönüside	Türkiye	26912
178	121	370 Cenan Stream, Beylerfurt, WI 30980	West Cedideberg	Türkiye	21205
179	122	PSC 9399, Box 3438, APO AE 94042	Sezerport	Türkiye	79022
180	123	5728 Elifnur Plains Apt. 912, Çapkanview, TN 49121	West Gök	Türkiye	09191
181	123	339 Zülbiye Extensions Suite 652, Nebihport, UT 37974	Hasretview	Türkiye	37486
182	124	4404 Alemdar Divide Suite 561, New Rahiye, NC 88759	Tekinerland	Türkiye	61405
183	124	7492 Aksu Unions Apt. 767, Lake Resulcanland, TX 01851	Vecidehaven	Türkiye	66751
184	125	93622 Bellisan Turnpike Suite 132, East Gülserenfort, MI 95191	Musaffaville	Türkiye	59992
185	125	81159 Akdeniz Summit Suite 986, North Süheyda, OR 56459	Mançoview	Türkiye	46274
186	126	690 Alemdar Knolls, East Gülev, ID 79325	North Müferrihtown	Türkiye	97470
187	126	USNS Şafak, FPO AE 93740	Port Lütfiberg	Türkiye	24708
188	127	0342 Aran Skyway, Yılmazborough, WV 17736	Şamaside	Türkiye	64894
189	128	USNS Tarhan, FPO AE 39051	Ayparhaven	Türkiye	63579
190	128	USS Eraslan, FPO AP 46673	Aysevimhaven	Türkiye	83757
191	129	39754 Şener Springs Apt. 520, New Hatem, CT 80150	Aslanburgh	Türkiye	35104
192	130	220 İhsanoğlu Park, Lake Sitiport, NH 58668	Havseside	Türkiye	00816
193	131	793 Erten Center, Yağınchester, KS 10371	Şensoyborough	Türkiye	00564
194	132	131 Zengin Hollow Suite 733, South Sıylıhan, AK 68256	North Bağdatport	Türkiye	97490
195	132	66774 Ülker Parkway, Bilirland, LA 42577	Talayerhaven	Türkiye	36805
196	133	0399 Yorulmaz Trail, Nihaiborough, MT 45302	Ülkümberg	Türkiye	19199
197	133	6663 Günşen Curve, Akmanerville, OH 97671	South Arıkolfort	Türkiye	45295
198	134	75901 Elnur Squares Apt. 606, West Gülşahin, WA 24528	Işınchester	Türkiye	93333
199	135	49315 Fadile Springs Suite 063, Yahşistad, CA 60617	West Güngörenburgh	Türkiye	54702
200	136	20022 Çamurcuoğlu Forest, New Balca, OR 63104	Lake Berranstad	Türkiye	93188
201	136	7058 Müsemma Groves Suite 067, North Selvi, FL 88174	North Vargınview	Türkiye	59069
202	137	00320 Yıldırım Throughway Apt. 277, Tevetoğluhaven, GU 67346	New Benek	Türkiye	79091
203	137	71203 Akar Summit Apt. 520, North Özertemfort, PW 09119	Aslanmouth	Türkiye	16282
204	138	6106 Arıkol Overpass, Kandefside, VA 30479	South İklim	Türkiye	86289
205	138	662 Barışcan Spurs, Seyithanstad, DC 38167	West Ayhanmouth	Türkiye	02123
206	139	77913 Zengin Islands Suite 902, Port Çoğayhaven, OK 76146	Gülbury	Türkiye	68091
207	139	325 İnönü Light Suite 245, Tatuborough, NH 71115	Gürtenborough	Türkiye	98862
208	140	8392 Aslan Throughway Apt. 726, North Cedidefort, IL 93331	Lake Sehel	Türkiye	64281
209	141	USCGC Akgündüz, FPO AP 25015	Yurdanurfort	Türkiye	90438
210	141	55211 Sakarya Prairie Apt. 615, Tanbayside, WV 81457	Akdenizmouth	Türkiye	66115
211	142	198 Arsoy Vista Suite 031, Akdenizland, MA 12405	South Erdibayland	Türkiye	12237
212	142	Unit 9520 Box 9112, DPO AP 41226	Dorukhanside	Türkiye	99239
213	143	49895 Akça Plaza Suite 716, Akçaybury, GU 78990	Zorlufurt	Türkiye	50602
214	144	351 Yılmaz Mountains, Dumanlıstad, FM 19675	East Rüşenburgh	Türkiye	55407
215	145	9330 Yorulmaz Prairie, Port Risaletmouth, ME 56902	Port Zerafetton	Türkiye	51517
216	145	4548 Gülen Street, İnönümouth, MN 62047	East Öztürkberg	Türkiye	15882
217	146	413 Sezgin Village, Bilirland, HI 84453	Akçaberg	Türkiye	18114
218	147	8611 Soylu Views, North Oğurataview, NV 51029	West Tunahanfort	Türkiye	00851
219	147	Unit 8972 Box 0100, DPO AA 46005	Lake Gündüzalp	Türkiye	68501
220	148	58598 Sezgin Throughway, Lake Revza, OH 37535	Port Nurgilmouth	Türkiye	02912
221	148	90708 Demirel Forges, Mesturberg, FM 80538	South Dirlikton	Türkiye	21765
222	149	4526 Neşrin Parks, North Özdal, TN 52924	South Vafir	Türkiye	61323
223	150	099 Nafile Turnpike Apt. 240, South Sezal, CO 16118	Yuntmouth	Türkiye	14693
224	151	818 Tevetoğlu Vista, North Sulhi, NV 58039	Gülmouth	Türkiye	12532
225	152	37426 Soylu Ranch Apt. 313, Port Bahtinurside, WY 75256	New Mehrigül	Türkiye	75585
226	152	9490 Dumanlı Square Suite 981, East Koraymouth, OH 06574	West Yılma	Türkiye	48551
227	153	4129 Asiman Heights, Egenurchester, LA 69701	Aynilhayatland	Türkiye	08436
228	153	294 Gülfeza Lodge Suite 698, Aydarland, CO 61920	Özgürland	Türkiye	41005
229	154	51657 Yahşi Ramp Suite 258, Şüküfemouth, UT 83223	New Gönenville	Türkiye	44808
230	155	7716 Fermuta Circle Suite 473, North Çeviköz, WV 11988	North İslimeland	Türkiye	96878
231	156	2841 Çisem Harbors Suite 213, Öztekville, IL 52052	East Ergener	Türkiye	71822
232	157	38656 Yasemen Rue, Port Kamarburgh, SD 41861	Sılaberg	Türkiye	66780
233	157	307 Yılmaz Knolls Suite 170, Mansızside, MD 30706	West Müğberstad	Türkiye	29619
234	158	647 Özdeş Spur, West Türkalptown, TX 79921	Cavitview	Türkiye	22580
235	158	35595 Durdu Stravenue, Şafakchester, RI 15549	Fıratburgh	Türkiye	21698
236	159	6404 Şama Inlet Suite 891, North Yağın, PA 51107	Lake Altınçiçekborough	Türkiye	96052
237	160	813 Alaz Crest Apt. 153, Sonadborough, PW 55549	Port Usport	Türkiye	48974
238	161	4209 Çetin Point Apt. 755, Tınalborough, NE 57670	Ferziton	Türkiye	98468
239	162	875 Güçlü Throughway, South Şennurmouth, TX 28589	Uçbeyiburgh	Türkiye	98028
240	162	Unit 1979 Box 7391, DPO AE 30336	Tansevville	Türkiye	81789
241	163	63844 Şama Mall, New Ömriyeland, TN 56522	North Berrin	Türkiye	50037
242	163	398 Şendoğan Park, West Eraltown, MH 90991	New Utkucan	Türkiye	89992
243	164	92014 Yümun Fields, South Tartış, SC 38567	Hançerton	Türkiye	83927
244	165	4425 Esengün Meadow, Rengülview, CA 94863	Port Hariz	Türkiye	89860
245	165	319 Güçlü Square Apt. 168, Port Hanimview, ME 21297	Gülcegünton	Türkiye	59193
246	166	2369 Alışık Manor Suite 057, Lake Feza, GU 01456	Sevenmouth	Türkiye	67028
247	166	402 Şinasi Rapid, Çamurcuoğluberg, MO 42645	Yılmazview	Türkiye	45641
248	167	PSC 2098, Box 2467, APO AE 71666	Öncelville	Türkiye	16557
249	167	46642 Bilgin Vista, South Tulun, DC 13891	New Ersel	Türkiye	92165
250	168	4780 Zorlu Light Apt. 066, Ertaşfurt, MN 84280	Lake Tasvirchester	Türkiye	41373
251	169	562 Borataş Street, Nefaretberg, KS 63301	İyiyürekport	Türkiye	14792
252	170	871 Ayşan Passage Suite 938, East Baturay, MA 85770	New Aytenside	Türkiye	99329
253	171	985 Tangül Ranch, Port Arıkol, MO 47424	Özertemchester	Türkiye	08152
254	172	17516 Ünlen Burg Apt. 500, West Razıchester, AZ 90453	Sakipport	Türkiye	83691
255	172	0989 Dölensoy Spur, South Duyguhan, IL 84847	South İnançlı	Türkiye	40557
256	173	5004 Ağmur Lake Apt. 590, Port Münezzerport, MO 43202	Gülville	Türkiye	67338
257	173	02620 Karadeniz Stravenue, East Ferziport, WY 98802	Arsoytown	Türkiye	29055
258	174	75275 Mansız Vista Apt. 039, Sökmenview, RI 13342	Alpinchester	Türkiye	99890
259	174	2405 Sehel Street, Durmuşville, MP 99330	Port Oguşfort	Türkiye	70512
260	175	3906 Ülker Lakes Apt. 591, East Refik, MA 97214	Lake Haliyeborough	Türkiye	80203
261	176	62066 Güldünya Drive, Yamanchester, FL 90573	East Ushan	Türkiye	01687
262	176	224 Bilge Freeway, Yeneralland, OK 53286	Borahanburgh	Türkiye	63927
263	177	151 Akçay Wells, Hançermouth, IN 70428	Mutasımport	Türkiye	84326
264	178	747 Alparslan Pass Apt. 414, Âlemşahmouth, NM 16688	East Şerefside	Türkiye	05674
265	179	18135 Bilir Tunnel Suite 155, Tevetoğluport, OR 46252	Senihaland	Türkiye	54603
266	180	1681 Günaydin Manors Suite 451, West Altınçiçekshire, DC 51465	East Pembesinville	Türkiye	78535
267	181	62259 Adlan Parkway Apt. 292, Dilhuşhaven, AZ 44679	New Sevgenmouth	Türkiye	92549
268	182	4703 Akdeniz Plain Suite 642, West Arıkol, OR 77603	Port Özgertown	Türkiye	71244
269	182	USS Yılmaz, FPO AP 03693	North Uygunmouth	Türkiye	32790
270	183	0552 Akar Drive Suite 944, Korutürkmouth, CA 46543	North Tınalshire	Türkiye	78865
271	184	4771 Suat Mill, Akgündüzhaven, IA 09993	New Mümtaze	Türkiye	52320
272	184	341 Akçay Keys, South Akçabayview, NH 51914	Türcanfort	Türkiye	86142
273	185	1381 Üsame Shores Suite 698, South Gürarda, WA 62144	North Minibe	Türkiye	96221
274	185	5145 Sançar Lakes, New İlkim, RI 39242	Otayfurt	Türkiye	40941
275	186	515 Tevetoğlu Ports, İnançlıberg, AR 33531	New Benol	Türkiye	79175
276	187	789 Gül Island, North Necdatside, IA 34483	East Kayrabay	Türkiye	13878
277	188	94969 Soylu Forest Apt. 538, Lake Masumeside, MO 73884	North Cevaletown	Türkiye	08827
278	189	Unit 4494 Box 0184, DPO AA 13608	Önelfort	Türkiye	25245
279	189	61025 Aslan Junction Apt. 001, Akarport, ID 95636	Ertuncayton	Türkiye	89470
280	190	00751 Akdeniz Path Suite 634, Sezginfort, VT 11957	Lake Kiramettin	Türkiye	45944
281	190	813 Evde Unions, Nurdamouth, IL 37208	Akgündüzburgh	Türkiye	31646
282	191	8832 Alemdar Extensions Suite 480, Sezginview, NE 88312	New Zihniview	Türkiye	78704
283	192	Unit 6322 Box 0409, DPO AA 93658	Arıelstad	Türkiye	74962
284	193	3034 Akdeniz Isle Suite 311, Kısakürekfort, NY 08608	Akdenizfurt	Türkiye	95744
285	194	97253 Zengin Squares, Çapkanton, NY 24333	East Sidkiburgh	Türkiye	43267
286	195	99790 Sıylıhan Center Suite 625, Akgündüzville, AZ 19895	Sevenshire	Türkiye	29232
287	195	0167 Şafak Plain Apt. 482, North Nurseda, ND 26995	Feyruzberg	Türkiye	63078
288	196	307 Çorlu Port Apt. 026, North Atalay, NC 57040	Erdoğanburgh	Türkiye	66095
289	196	942 Elöve Trail, Sezerchester, FL 02517	West Deryanur	Türkiye	11791
290	197	USS Dumanlı, FPO AE 42036	East Mazlumberg	Türkiye	32822
291	197	1855 Bergen Glens, Demirelstad, GA 11992	Çetinhaven	Türkiye	40053
292	198	1689 Temirhan Rapids, North Hıfzullah, MA 38542	East Sarpkınstad	Türkiye	76062
293	198	212 Taşar Causeway Suite 508, Akarfurt, VA 96598	West Boynakburgh	Türkiye	78767
294	199	04504 Edgübay Views, Karadenizburgh, ME 72287	West Gülsüstad	Türkiye	06670
295	199	84184 Saçı Camp, New Tınalborough, OK 97574	Sarpkınmouth	Türkiye	78941
296	200	72393 Tezol Curve, Kandefland, IL 16473	Erkanborough	Türkiye	78282
297	200	1161 Eskinalp Wells, Lake Kapaganland, KS 73141	Kanpulatland	Türkiye	14582
298	201	3952 Masume Pass, Lake Dincershire, VT 96446	Şamabury	Türkiye	16204
299	202	95252 Yıldırım Trace, Aysevimfurt, WV 80607	Lake Baba	Türkiye	56437
300	203	94496 Veis Ridges, Yükselbury, OR 79695	Şenerton	Türkiye	96996
301	203	7784 Karadeniz Lane Suite 572, Soyluview, PW 22373	Alemdarville	Türkiye	62841
302	204	41153 Akça Spring Apt. 790, South Burakhan, ID 06190	North Aygönençfort	Türkiye	90283
303	205	PSC 1885, Box 2005, APO AE 54454	Durdustad	Türkiye	49533
304	206	3392 Tüzeer Ridge Apt. 305, Yıldırımport, MD 68481	Arsoyview	Türkiye	57426
305	207	62153 Okbay Cliff Apt. 246, Lake Seçgülhaven, SC 76978	New Elamiyechester	Türkiye	65308
306	207	0631 Bilir Fields Apt. 843, West Kuddusichester, VT 51366	New Aydinçton	Türkiye	11421
307	208	14113 Elvan Trace, Lake Yavuz, PW 48360	New Halenurtown	Türkiye	72610
308	209	52283 Yıldırım Meadows, East Mecideburgh, NM 80704	Port Elamiyemouth	Türkiye	46343
309	209	7677 Manço Ports Suite 324, Duranchester, MA 91394	Ergülberg	Türkiye	16860
310	210	USCGC Şafak, FPO AP 28848	South İzelberg	Türkiye	26257
311	210	9470 Durdu Turnpike Suite 621, West Tümkurt, ME 88068	South Hürmetmouth	Türkiye	92858
312	211	4759 Muhyettin Freeway Suite 726, South Sudi, WY 87802	Firdevisburgh	Türkiye	25798
313	211	745 Bozbağ Orchard, Dumanlıfurt, WA 46230	North Nurverenchester	Türkiye	09381
314	212	534 Şali Manor, North Dorukhanburgh, NH 93061	Aksuview	Türkiye	67926
315	213	80499 Dorukhan Square, East Tayganburgh, GU 01775	North Ayaydınmouth	Türkiye	40917
316	213	14158 Bilir Forest Suite 460, New Müjde, NJ 61252	South Amre	Türkiye	23975
317	214	79248 Fırat Manors Suite 268, Port Börteçinberg, AZ 50601	Tanyolaçport	Türkiye	26046
318	215	3428 Akça Rest Suite 724, Port Yıldızshire, MN 65799	South Arcan	Türkiye	49659
319	215	PSC 8815, Box 8172, APO AA 94008	Erdoğanchester	Türkiye	45966
320	216	91017 Sezer Circle Suite 221, West Toyberg, CT 95376	South Ergenerstad	Türkiye	02496
321	217	493 Sezgin Islands, Lake Büreyre, NE 11825	East Bozerk	Türkiye	80243
322	218	7557 Ergül Cove Suite 299, Kerimeburgh, AZ 52874	South Gücalton	Türkiye	08937
323	219	9542 Meleknur Hills Apt. 539, East Şafiiberg, MS 95827	North Çağverenberg	Türkiye	97683
324	220	USS Zengin, FPO AP 03072	Nazlimport	Türkiye	12220
325	220	1352 Tayaydın Passage Suite 923, Lake Nezize, MD 09048	Çamurcuoğluland	Türkiye	41861
326	221	255 Yüksel Mountain, Gülentown, TN 96416	New Başok	Türkiye	17574
327	221	62749 Duran Loop, İnönüton, MI 44153	Soyluburgh	Türkiye	27848
328	222	02836 Akçay Creek, Pirahmetfurt, IN 67260	Arsoyport	Türkiye	28159
329	222	2465 Temime Drives, East Gençayborough, MS 74720	New Arziyeland	Türkiye	84102
330	223	063 İhsanoğlu Burgs, Çetinstad, NE 48852	Lake Aygönenç	Türkiye	24168
331	224	24875 Şensoy Circle, Alemdarchester, KS 45975	South Günerimouth	Türkiye	15844
332	225	59147 Seven Mountains, Akçaytown, PA 14077	Lake Sencar	Türkiye	82339
333	225	8068 Abiye Plain Suite 801, North Kardelen, AK 30043	Lake Seler	Türkiye	76663
334	226	265 Demir Trafficway, Elövemouth, WI 57219	Port Özaslanview	Türkiye	05586
335	226	89428 Hudavent Street Apt. 817, Mihriyeton, FM 32078	East Vezatburgh	Türkiye	36425
336	227	29531 Yaman Tunnel, Demirelview, FL 72003	Dumanlıbury	Türkiye	44817
337	227	178 Dilder Cape, Şenerfurt, NC 52894	Port Aycagül	Türkiye	98296
338	228	2764 Yekda Glen Suite 551, Port Asımmouth, VI 49761	Müğberview	Türkiye	61600
339	228	27126 Gülenay Meadow, Ügeport, FL 88146	North Yahşikanborough	Türkiye	62955
340	229	18495 Yorulmaz Tunnel Suite 290, South Seçgül, VA 44129	Atalayside	Türkiye	21296
341	230	026 Ertaş Hill, Port Alaaddin, IN 99534	Yıldırımstad	Türkiye	13547
342	230	38900 Gözem Fords, İldembury, WI 82377	Akdenizland	Türkiye	13459
343	231	57528 Akgündüz Squares, East Tanyuhaven, GU 82303	Lake İsrastad	Türkiye	45326
344	231	98039 Akçay Ramp Suite 713, New Ünsever, OK 49519	Erkılıçbury	Türkiye	19161
345	232	737 Yorulmaz Flats Suite 447, South Ayhanside, FM 45066	Nuyanbury	Türkiye	45712
346	233	819 Çetin Knolls Apt. 510, West Fatigülshire, NC 13111	Durdalimouth	Türkiye	97138
347	233	29807 Arslan Flats, New Mutluhan, MT 86549	Buhariview	Türkiye	32852
348	234	609 Mansurali Knoll Suite 081, South Artanmouth, AZ 80861	Sezerfort	Türkiye	12784
349	388	041 Şehza Square, Port Ermutlu, MN 41633	Yorulmazton	Türkiye	67471
350	235	682 Çetin Views, New Umman, CO 31306	Arsoyburgh	Türkiye	16766
351	236	1284 Başok Groves Suite 681, Lake Süzer, GA 50772	Azizeland	Türkiye	94479
352	236	8227 Mücellib Junction Apt. 188, Ertaştown, GU 70102	Arslanbury	Türkiye	46670
353	237	659 Tan Mountain Suite 893, Zenginfort, FL 40363	Zubeydeton	Türkiye	08304
354	237	48981 Çamurcuoğlu Forest Suite 325, Duranton, SD 73762	New Büget	Türkiye	83178
355	238	29164 Korutürk Rest Suite 482, Sevenberg, SC 34811	West Muratcantown	Türkiye	90508
356	239	327 Duran Roads Suite 734, Kısakürekfurt, NY 97906	Karadenizshire	Türkiye	22212
357	239	25852 Zorlu Gateway Suite 146, Yılmazchester, OH 86968	East Cenan	Türkiye	27586
358	240	Unit 5347 Box 1556, DPO AE 26978	Hazratton	Türkiye	66064
359	241	PSC 5161, Box 3166, APO AP 08397	Ülkerburgh	Türkiye	01596
360	241	7387 Şafak Spur, Güçyeterburgh, GU 05812	Lake Kaver	Türkiye	55977
361	242	541 Ülküm Terrace, Güçlüfort, VT 81490	Karadenizside	Türkiye	46190
362	243	878 Gülper Mission Suite 690, Tarhanmouth, NJ 30636	Rezinhaven	Türkiye	34257
363	244	8759 Nursim Stream, North İlgi, GU 61998	Apaydınland	Türkiye	10558
364	245	USS Şama, FPO AP 83198	Mirayport	Türkiye	42468
365	246	6563 Yılmaz Hill, North Gerayshire, AS 88509	Ertaşland	Türkiye	41215
366	246	028 Artan Roads Suite 377, Lake Karataş, VI 15544	Akçayton	Türkiye	89037
367	247	614 Karcan Drives, Emrullahburgh, AL 91138	Cindorukfurt	Türkiye	18788
368	247	1958 Yaman Hill Suite 013, Göksevfurt, WA 59557	East Sevla	Türkiye	03697
369	248	8555 Binışık Inlet Suite 417, East Kenter, VT 40584	Ürfettinburgh	Türkiye	75419
370	249	648 Tekecan Villages, North Okyalazmouth, TX 37092	Yılmazville	Türkiye	25133
371	250	8212 Sözer Port Apt. 966, Ilgıberg, IL 83568	Port Sernur	Türkiye	61929
372	251	191 Şensoy Heights, North Aytöz, DE 05055	Şerefhaven	Türkiye	93495
373	252	7172 Hayrioğlu Lights Suite 219, West İlkimtown, CO 26153	Müğberland	Türkiye	87709
374	252	Unit 3183 Box 1657, DPO AA 49921	North Tercanside	Türkiye	59387
375	253	44024 Ülker Fords Apt. 136, East Eba, AK 97560	New Ertuncaychester	Türkiye	39005
376	254	474 Oluş Mountains, North Nerimstad, DC 19053	Port Uyansermouth	Türkiye	26448
377	254	9308 Soylu Courts, Türkfurt, GU 96964	North Ufukay	Türkiye	76970
378	255	720 Sezer Walks, Urhanview, AS 16614	Fıratview	Türkiye	46898
379	256	219 Fırat Ferry Suite 403, Bitülshire, FL 99877	North Altuğburgh	Türkiye	53299
380	257	6199 Seler Glens, North Şuaypfort, RI 40486	Şafakchester	Türkiye	21874
381	257	505 Akçay Course, North Sevdinartown, IA 51391	Bilgemouth	Türkiye	94327
382	258	USCGC Bilge, FPO AA 21512	New Aytek	Türkiye	20909
383	258	786 Lezize Drive Apt. 743, Öcalanton, CA 60101	Bilginside	Türkiye	89700
384	259	1050 Akça Bridge Apt. 843, East Adak, MH 48158	New Erdoganland	Türkiye	04587
385	259	606 Özay Burgs Suite 542, East Tülinchester, VT 94744	New Eröztown	Türkiye	54351
386	260	05139 Hakikat Walks, West Seyfullahtown, MO 08995	Zorlufurt	Türkiye	53491
387	261	8111 Tevetoğlu Prairie, Gülville, DE 18685	East Tanses	Türkiye	87129
388	262	54507 Mengi Place, Mahterfurt, ND 10070	New Gazelshire	Türkiye	22941
389	263	6516 İhsanoğlu Turnpike Suite 656, South Necdatbury, NY 68214	Ertaşburgh	Türkiye	70418
390	264	4963 Aytek Estates, Özinalchester, CT 20331	South Gülsiyefort	Türkiye	61380
391	265	6687 Gelengül Dale Suite 864, North Baydu, NE 48316	Tomurcukport	Türkiye	69015
392	266	64017 Durdu Isle Apt. 977, New Yankı, MS 84399	Erselburgh	Türkiye	45316
393	266	36416 Meleknur Lane Suite 739, North Abdülcemal, WV 84763	Ertaşfort	Türkiye	70053
394	267	893 Gül Turnpike Suite 698, West Amaçfort, WY 27642	East Abdulgazi	Türkiye	15138
395	268	49250 Bilgin Inlet, Zenginville, NV 59775	West Kâmilburgh	Türkiye	64392
396	268	3647 Bilgin Coves, Bilgeberg, TX 39631	New Ezgin	Türkiye	80428
397	269	PSC 4176, Box 7871, APO AA 46422	Soyluberg	Türkiye	79801
398	270	02778 Güçal Orchard, Şenerport, IL 71866	Şamaberg	Türkiye	70218
399	271	700 Hayrioğlu Mission Suite 816, Çamurcuoğluland, NJ 01522	North Güçalland	Türkiye	92975
400	272	85818 Bican Corner, Port Ferahdiba, WY 36804	East Hilayda	Türkiye	04195
401	272	57284 Yaman Inlet Suite 181, New İnsaf, VA 17794	Gülenland	Türkiye	70399
402	273	Unit 0986 Box 9097, DPO AA 23787	South Arpağ	Türkiye	01731
403	274	37839 Akçay Pines Suite 556, Port Vezrife, MI 03937	Dilhuşland	Türkiye	36967
404	274	Unit 7574 Box 0092, DPO AE 18944	Port Seydo	Türkiye	29153
405	275	828 Seven Trail, East Hazrat, MT 71343	Fersanport	Türkiye	37314
406	276	9706 Akçay Divide, Gelengülside, PR 91232	Edaviyeport	Türkiye	38517
407	276	580 Türk Extension Apt. 232, South Selcenmouth, AS 93504	West Miyesser	Türkiye	09802
408	277	162 Korutürk Hollow Apt. 788, Gökçilfort, PW 92602	Kalgaystad	Türkiye	34661
409	277	93183 Remazan Prairie Apt. 218, West Gencaslanstad, KS 01859	Lake Akverview	Türkiye	47926
410	278	8766 Yaman Cliff, Lake Türkmen, NM 49844	Ergülberg	Türkiye	91143
411	278	81872 Niğmet Junctions Apt. 489, Şafakland, MN 44239	Port Canal	Türkiye	88622
412	279	7507 Fügen Street, East Merimfort, NC 14303	Akçaburgh	Türkiye	66133
413	279	091 Çorlu Heights, South Altınkaya, CT 78779	Lake Gülağa	Türkiye	05849
414	280	52810 Hançer Road, Çamurcuoğluborough, DE 51917	East Remazanfurt	Türkiye	27783
415	280	253 Hürüyet Cove, Akçayland, FL 37941	Yılmazhaven	Türkiye	92475
416	281	3243 Bilir River Suite 630, Şalihaven, NM 00994	South Zümre	Türkiye	53985
417	281	60016 Bilgin Fords, North Eşim, MS 75549	Cansinfort	Türkiye	86388
418	282	18627 Çorlu Cliff, South Fedenborough, MS 54579	Tuyuğberg	Türkiye	63587
419	283	6949 Çorlu Ports, Akboğamouth, MT 47320	Dalanburgh	Türkiye	43558
420	283	788 Çorlu Divide Apt. 056, East Serfinaz, ND 22835	Lake Merim	Türkiye	87886
421	284	40137 Bilge Parks, Demirland, NE 18916	New Ülkeside	Türkiye	16043
422	285	1084 Hayrioğlu Garden Apt. 412, Günserville, AL 56446	Erdoğanburgh	Türkiye	86691
423	286	26023 Lezize Streets, East Ayhanside, MO 90937	Akçaberg	Türkiye	32953
424	287	085 Manço Unions, West Ganiye, VI 46548	Güllühantown	Türkiye	81369
425	288	Unit 2095 Box 8284, DPO AA 87820	Zorlumouth	Türkiye	37860
426	288	7118 Tevetoğlu Centers Suite 875, West Ünal, WA 19858	South Kuddusi	Türkiye	82591
427	289	62438 Manço Loaf Suite 011, Sahirberg, AR 88479	East Tanbaymouth	Türkiye	53843
428	290	465 Demirel Island Suite 078, Akarfurt, IN 20797	Elnurstad	Türkiye	44167
429	291	693 Peren Hill Apt. 255, Durduhaven, VI 43956	North Erenalpfurt	Türkiye	98264
430	291	82511 Günden Camp Apt. 466, Şafakstad, TX 91821	North Yahşikanfort	Türkiye	34795
431	292	5987 Sevgen Track Suite 204, South Okanay, WY 68117	Türkalpfurt	Türkiye	37145
432	292	486 Fildan Cliff Suite 190, Şensoyfort, NC 43396	Kiramettinside	Türkiye	44764
433	293	0738 Aysuna Fall Suite 381, East Fatigül, UT 50582	West Şadımanfort	Türkiye	88048
434	293	600 Çamurcuoğlu Crossroad, New Aközburgh, WI 80255	North Ferahdiba	Türkiye	19216
435	294	89387 Güçlüer Point Suite 144, Yekbunfurt, LA 50553	Port Gürtenborough	Türkiye	79208
436	295	USNV Gülen, FPO AA 94036	North Erdursun	Türkiye	17504
437	296	7399 Yaman Islands Suite 245, Tarhanbury, MI 31465	Havaliton	Türkiye	63728
438	296	3744 Konguralp Key Suite 023, East Gökçe, RI 32910	Ertaşshire	Türkiye	82731
439	297	7793 Demirel Pines Apt. 422, South Özdil, NH 69094	Mançofurt	Türkiye	84856
440	298	75463 Demir Harbor Apt. 121, Gazelborough, FM 82468	Aksuhaven	Türkiye	07643
441	298	425 Songurkan Ways, Hayrioğlubury, NV 79290	West Mufide	Türkiye	28268
442	299	4844 Toköz Course, Şafakhaven, IL 78850	Lake Yalın	Türkiye	82453
443	299	1356 Zorlu Radial Apt. 628, Akarmouth, NC 98797	Baydutown	Türkiye	73510
444	300	842 Günkurt Locks, South Okgüçlü, WI 52799	New Özaslanview	Türkiye	81755
445	301	6626 Yorulmaz Greens, West Ledün, SC 70987	Gülburgh	Türkiye	51880
446	301	5220 Çorlu Way Apt. 719, West Rebihatland, KS 98293	Port Çakarbury	Türkiye	03058
447	302	8732 İmren Hollow, Bişarton, PR 68299	Port Aytenview	Türkiye	58131
448	303	06400 İvecen Valley, Dinçkolton, MO 16732	South Akınal	Türkiye	04411
449	303	USNS Duran, FPO AE 27606	Arsoybury	Türkiye	03049
450	304	146 Gülözge Viaduct, New Nazlihanhaven, MA 78717	North Sançarberg	Türkiye	75581
451	305	329 Erkinel Springs, West Terlanborough, DE 13197	Çakarfurt	Türkiye	02411
452	305	8179 Arslan Bridge, Port Tanak, OH 31012	Port Özaytown	Türkiye	86875
453	306	467 Serol Square, Port Şafiiland, WA 18032	West Heyvetullahmouth	Türkiye	45936
454	306	548 Özaslan Mission, Erseçstad, DE 39836	Port Cumanfort	Türkiye	93883
455	307	6586 Yılmaz Wall, Kısakürekmouth, AK 00779	East Serverberg	Türkiye	97861
456	308	341 Sami Stream, Dinçkolmouth, PA 53305	Hindalhaven	Türkiye	87307
457	309	0090 Bilir Island Suite 934, New Selime, NV 44874	Eminland	Türkiye	37105
458	309	633 Canseven Pike, Lake Salimetville, FL 84827	North Sittik	Türkiye	03206
459	310	665 Mansurali Ports, Zenginberg, NM 60228	East Ömürland	Türkiye	76178
460	310	3549 İncifir Rapid, Hançerton, AS 73280	Şamaport	Türkiye	52310
461	311	89546 Durmuş Glens Apt. 281, Port Beraymouth, AR 21523	North Türcan	Türkiye	50301
462	311	7524 Dumanlı Plain, North Sebattinport, MH 57715	Mirayville	Türkiye	98301
463	312	Unit 0314 Box 4319, DPO AE 17591	South Taliview	Türkiye	01059
464	313	PSC 3918, Box 4579, APO AE 26158	East Üsameborough	Türkiye	28303
465	314	5286 Bilir Divide Suite 173, Sezginton, KY 08630	South Türkmenchester	Türkiye	02714
466	315	8394 Selmin Fort, Lake Tandoğdu, VI 76516	West Berranburgh	Türkiye	85690
467	315	392 Tevetoğlu Route Suite 286, Port Tanakview, ME 81034	Sernurshire	Türkiye	87757
468	316	74981 Sakarya Tunnel, Sayınshire, OR 79304	Toğanburgh	Türkiye	06146
469	316	140 Bağdat Ports Suite 703, West Tanbayside, VI 11067	New Tecimer	Türkiye	35212
470	317	7955 Akgündüz Pike, Eremland, NY 60090	East Umman	Türkiye	93996
471	318	Unit 8167 Box 0701, DPO AP 64832	Goncaferside	Türkiye	14052
472	318	9693 Öncel Mountains Apt. 095, North Ahatside, MH 94038	Port Mehmed	Türkiye	53531
473	319	608 Perinur Motorway Apt. 079, Port Gülerbury, DE 03000	Melihcanstad	Türkiye	75425
474	319	402 Sezer Trail, Port Güçalhaven, WI 04258	East Çağa	Türkiye	46955
475	320	73389 Nurda Vista Suite 997, New Nurkanfurt, OK 60303	South Ilgı	Türkiye	29022
476	321	63416 Mihriye Lake, East Feremezbury, ME 94373	West Sefer	Türkiye	36108
477	322	Unit 7460 Box 3634, DPO AP 86314	East Görgünayshire	Türkiye	23900
478	323	559 Çeviköz Mountain, Nerimbury, ID 73970	Lake Sarpkınland	Türkiye	62928
479	323	969 Ertaş Village Apt. 382, Lake Mefarettinburgh, GU 76178	Teknazchester	Türkiye	70045
480	324	9466 Arsoy Extensions Apt. 234, South Salkın, UT 68733	South Asalet	Türkiye	89479
481	324	USNV Zorlu, FPO AE 89220	Port Soykut	Türkiye	97581
482	325	2383 Hançer Point, West Celilayport, WA 68056	Lake Ayhanberg	Türkiye	30980
483	326	2714 Sezer Brook Suite 054, Alışıkside, MI 58016	New Lâlefurt	Türkiye	56601
484	327	304 Şener Lake Apt. 876, South Özgerhaven, OH 72049	East Kıratborough	Türkiye	05395
485	327	4974 Erseç Camp, Öztekside, VT 29480	Akçayport	Türkiye	66429
486	328	241 Fırat Mountains, Sümeryafurt, AK 14684	Port Koçkanburgh	Türkiye	34898
487	329	98208 Özay Courts Suite 121, Ünekborough, IA 58726	Lake Utkucanshire	Türkiye	79729
488	329	3691 Vahittin Flat Suite 733, Damlanurside, AR 94963	Zeynelabidinborough	Türkiye	85459
489	330	24401 Eşim Alley Suite 932, Port Tuğçemouth, FL 55366	Ergülland	Türkiye	66715
490	330	246 Candeniz Center Apt. 061, Özkutlutown, HI 87171	Alpcanmouth	Türkiye	72670
491	331	07153 Yalın Unions Suite 790, Soydanerberg, NJ 52598	North Teberport	Türkiye	26033
492	332	183 Çamurcuoğlu Vista, West Süvari, NE 36855	East Amre	Türkiye	45241
493	333	2987 Eryıldız Stravenue Suite 478, Gülbeyanport, OR 44944	Akdenizport	Türkiye	91871
494	334	852 Vargın Lakes, East Hacialiland, PR 63542	Yorulmazside	Türkiye	41331
495	334	PSC 4539, Box 9867, APO AE 54138	Aralland	Türkiye	73430
496	335	1830 Durdu Dam, Şamaview, IA 68293	New Binay	Türkiye	61095
497	336	541 Hamiyet Club, Port Andiçton, IL 10427	South Henifemouth	Türkiye	01643
498	337	839 Oğurata Divide, Akarton, PW 34397	Zemzembury	Türkiye	67847
499	338	5936 Demir Pine Apt. 869, Ayduruchester, MO 04793	Tanpınarhaven	Türkiye	18234
500	339	349 Büşranur Drives, Port Gülcegün, FL 09925	Habibechester	Türkiye	65451
501	339	1093 Seven Fort, Merzukmouth, DE 54244	Çakarland	Türkiye	93210
502	340	63199 Zahid Shoal, Akarburgh, VT 00725	Sidarmouth	Türkiye	59353
503	340	75491 Akçay Pike, Ezginmouth, WY 83648	South Ünekchester	Türkiye	60763
504	341	5544 Akçay Ports, South Cuman, IA 21256	Gökçilhaven	Türkiye	25157
505	342	63920 Ergül Road, Tecimerstad, WI 67751	Otayville	Türkiye	30027
506	343	2632 İmren Turnpike, West Bariş, VT 21182	Fıratshire	Türkiye	75173
507	344	9235 Sayın Highway, Zenginfort, SD 44000	Gülburgh	Türkiye	33719
508	344	2944 Begim Viaduct Apt. 662, East Yönetmenside, MN 95499	Port Ağbegimstad	Türkiye	00916
509	345	1637 Subutiye Avenue, Övünmouth, MD 75300	North Yeşilview	Türkiye	75882
510	345	936 Tarhan Mountains, Elifnurside, AR 43495	West Eremland	Türkiye	76604
511	346	36632 Gürarda Plaza Apt. 848, Akçayhaven, DE 87375	New Özkentchester	Türkiye	75376
512	346	Unit 6555 Box 9198, DPO AA 97799	Lake Sermaland	Türkiye	46898
513	347	5239 Taygan Ville, East Asimanstad, SC 13992	Zoralborough	Türkiye	65626
514	347	9224 Tan Stream, North Nurullahview, VA 83957	Port Kenter	Türkiye	23386
515	348	98234 Demirel Motorway Suite 465, East Yetişalhaven, DC 49603	New Dursadiyebury	Türkiye	55030
516	348	09134 Şeref Knolls Suite 790, East Altuğburgh, PR 41394	West Gülbeyantown	Türkiye	23393
517	349	982 Karadeniz Creek Apt. 216, New Yaltırak, DE 90515	Dilşatchester	Türkiye	11589
518	349	2847 Yıldırım Lodge Apt. 190, Eraslanmouth, TN 92423	Teknazland	Türkiye	71754
519	350	35378 Hançer Stravenue, Özdilborough, IN 80983	Bilirside	Türkiye	35023
520	350	264 Mehmetzahir Passage, North Akbaşfurt, ME 39452	Mahterstad	Türkiye	39621
521	351	2707 Akdeniz Turnpike, West Limon, LA 98280	West Demirbükenchester	Türkiye	92475
522	352	4501 Gökçe Port, Örfiyeburgh, CO 63855	Yükselview	Türkiye	98318
523	352	3380 Durdu Mission Suite 640, North Razı, MH 84948	Şenerfort	Türkiye	49139
524	353	889 İlmafer Streets Apt. 474, Alemdarchester, NV 17762	Kısakürekfort	Türkiye	40863
525	353	494 Çetin Coves, Lake Talibe, ID 04734	West Şerafeddinchester	Türkiye	10734
526	354	8016 Feremez Mountains Suite 488, Çamurcuoğluberg, VI 84378	Port Canberkburgh	Türkiye	95549
527	354	731 Korutürk Plaza Apt. 876, West Torhantown, WI 34972	North Müslum	Türkiye	80480
528	355	332 Dumanlı Street, Çorluhaven, AK 26217	Yıldırımtown	Türkiye	67434
529	355	6726 Çetin Turnpike Suite 163, Yaşattinshire, OR 95024	Ertaşberg	Türkiye	82818
530	356	9984 Gökçebalan Mission, South Tuğrulhanchester, UT 70819	Bilginmouth	Türkiye	50918
531	356	7883 Şavki Shore Apt. 216, South Amaç, TX 49452	Mevlüttown	Türkiye	69311
532	357	8951 İnönü Alley Suite 116, East Masume, SD 99633	Korutürkstad	Türkiye	55227
533	358	97086 Salami Groves, Sirapview, UT 12576	Alizechester	Türkiye	24422
534	358	Unit 7253 Box 7446, DPO AP 51609	Lake Beyzade	Türkiye	73666
535	359	9521 Hekime Causeway Apt. 026, Başayburgh, SC 12406	Torhanstad	Türkiye	64896
536	360	4689 İhsanoğlu Cliffs, South Şafii, WV 76412	Port Ayhanchester	Türkiye	56214
537	361	831 Gülen Roads Apt. 653, New Ergülton, CA 15578	New Tenvirmouth	Türkiye	64262
538	362	2616 Nas Ridges Apt. 212, New Revzaberg, PW 89400	East Gökenfurt	Türkiye	59627
539	362	4677 İnönü Expressway, Sevenshire, MA 81114	Erdoğanfort	Türkiye	30325
540	363	10711 Aksu Station, Arslanborough, IA 36900	Ezgütekintown	Türkiye	84709
541	364	7452 Ushan Causeway Suite 464, Şenerview, KY 38567	Eraslanmouth	Türkiye	72391
542	364	546 Tanpınar Point Suite 364, Lake Erinçer, NM 75357	South Tanyuchester	Türkiye	48407
543	365	3900 Bahittin Throughway Suite 124, Hayrioğluland, NV 88742	Alemdarborough	Türkiye	64578
544	366	114 Nirgül Harbor, Nesfemouth, VT 05951	Lake Zeynoland	Türkiye	09505
545	366	2818 Seven Lane Apt. 029, Korutürkton, IA 84507	South Kelâmiland	Türkiye	74344
546	367	194 Dumanlı Club, Amaçbury, ID 41675	New Hayret	Türkiye	93344
547	368	19844 Müjde Highway, Çamurcuoğluburgh, VI 58415	East Erselchester	Türkiye	23273
548	368	257 Şanlı Tunnel, Sevenstad, NJ 54981	Lake Şerafeddinberg	Türkiye	24128
549	369	102 Dumanlı Stravenue Suite 758, Ümmahanbury, OH 59489	Sabihbury	Türkiye	40217
550	370	81565 Zengin Drive Apt. 367, Durdumouth, MO 94148	South Maksüde	Türkiye	34538
551	371	720 Akatay Port Apt. 357, Dilderchester, DE 41011	Ayaydınfort	Türkiye	06904
552	372	PSC 5727, Box 4256, APO AP 32982	South Altınbikebury	Türkiye	40043
553	373	7998 Tagangül Bypass Suite 816, North Feryasville, PR 68367	North Karlukhanport	Türkiye	33851
554	373	98497 Yaman Track Apt. 145, South Atasagun, IA 80160	West Kanpulat	Türkiye	06289
555	374	75750 Akçay Gateway Apt. 047, Erdoğanborough, NH 13290	Tartışview	Türkiye	93495
556	375	974 Korutürk Crest, Port Tansevshire, DC 90248	West Bügetburgh	Türkiye	82298
557	375	40816 Alaz Place Apt. 715, Gülağachester, VT 73035	New Konguralpbury	Türkiye	48109
558	376	21098 Ayyaruk Causeway Suite 219, Irısstad, CA 08218	Korutürkmouth	Türkiye	62608
559	376	857 Yıldırım Drive Suite 671, Port Akarshire, MN 30862	Lake Sedife	Türkiye	02833
560	377	5533 Şener Mountains, Port Mecide, MS 97343	East İlbekton	Türkiye	74707
561	377	513 Çetin Radial, Gülborough, CT 61125	West Omaca	Türkiye	01604
562	378	452 Benol Landing, Tarhanview, OH 24738	North Mürit	Türkiye	98326
563	378	USNS Güçlü, FPO AP 72030	Kısakürekland	Türkiye	02168
564	379	163 Beyhatun Estates Apt. 739, Hudaventbury, ID 93909	Lake Sahil	Türkiye	36738
565	380	6236 Benek Plain, New Hüsnühâlville, AL 14877	Çorlushire	Türkiye	06570
566	380	84636 Hüsnühâl Spur Suite 420, Gülenland, PW 32258	Odkanlıborough	Türkiye	14855
567	381	924 Koray Keys, Bilgeburgh, MT 56616	South Gürtenmouth	Türkiye	63260
568	381	50500 Dincer Avenue Apt. 918, North Atalay, AL 21763	Koraymouth	Türkiye	26270
569	382	596 Özkent Pines Suite 253, Mançobury, FL 59319	New Sebigülstad	Türkiye	01291
570	383	509 Alparslan Light Apt. 024, New Erdemer, AS 21282	North Akmaralfort	Türkiye	01025
571	383	60612 Çetin Prairie, Ulumanburgh, IA 88388	South Adila	Türkiye	99346
572	384	440 Duracan Burg, Durmuşburgh, VA 56173	Port Abuzarburgh	Türkiye	15299
573	384	44736 Tarhan Green, Mançoview, KS 66057	Uğanside	Türkiye	51266
574	385	681 Karadeniz Common, Sökmenshire, KS 87118	Doğuhanmouth	Türkiye	16149
575	386	48953 Zeyno Via, West Mücevherchester, FM 69488	Mançoberg	Türkiye	74742
576	387	5726 Merdi Oval Suite 293, East Avşinchester, IL 11234	South Demiryürektown	Türkiye	50272
577	387	62384 Soylu Islands, East Söyler, NJ 30339	Akçayhaven	Türkiye	29149
578	389	91683 Çetin Lake, Ülkertown, KY 62831	North Sirapmouth	Türkiye	41167
579	390	6909 Manço Pike Apt. 610, East Samurtayhaven, ND 15056	Karakucakport	Türkiye	27198
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, buyer_id, product_id, quantity) FROM stdin;
1	101	167	3
2	101	223	1
3	102	17	3
4	103	285	1
5	103	20	1
6	103	28	3
7	103	152	1
8	103	164	2
9	104	188	1
10	105	69	2
11	105	93	1
12	105	96	1
13	106	74	2
14	106	45	3
15	106	242	2
16	106	277	2
17	107	218	2
18	107	145	3
19	108	238	3
20	109	250	2
21	109	165	2
22	110	28	1
23	110	268	1
24	110	158	1
25	110	213	3
26	110	280	2
27	111	103	2
28	111	188	2
29	112	207	2
30	112	273	1
31	112	201	3
32	112	202	2
33	112	196	2
34	113	42	2
35	113	50	2
36	113	3	3
37	114	82	1
38	114	107	3
39	114	58	1
40	114	115	1
41	115	196	2
42	115	101	1
43	116	69	3
44	116	232	3
45	116	158	1
46	117	61	2
47	117	108	1
48	117	94	2
49	117	273	3
50	118	216	2
51	118	259	2
52	118	268	1
53	119	231	1
54	119	207	1
55	119	196	1
56	120	29	2
57	120	277	3
58	120	222	2
59	121	232	1
60	122	8	3
61	122	121	1
62	122	65	2
63	123	82	2
64	123	41	2
65	123	56	1
66	124	149	1
67	125	187	2
68	125	162	2
69	125	163	1
70	125	76	3
71	125	135	1
72	126	122	3
73	127	208	3
74	127	207	3
75	127	25	3
76	128	136	2
77	128	229	3
78	128	16	2
79	129	69	1
80	129	6	2
81	130	276	1
82	131	91	2
83	132	111	3
84	132	32	3
85	132	269	1
86	132	143	3
87	133	213	1
88	133	276	2
89	133	257	2
90	133	68	3
91	133	232	3
92	134	41	3
93	134	208	2
94	134	45	3
95	135	149	2
96	135	125	2
97	135	262	3
98	136	105	1
99	136	53	2
100	137	232	3
101	137	33	3
102	137	103	1
103	137	221	3
104	138	15	1
105	138	12	1
106	138	246	3
107	138	30	2
108	138	166	1
109	139	154	1
110	139	102	3
111	139	76	1
112	140	138	1
113	140	56	3
114	141	183	2
115	142	51	1
116	142	185	2
117	143	286	2
118	144	51	2
119	144	128	3
120	145	37	2
121	145	3	2
122	145	132	2
123	145	156	3
124	145	125	3
125	146	125	2
126	147	249	2
127	147	138	2
128	148	11	2
129	148	203	2
130	148	87	1
131	149	23	1
132	150	182	2
133	150	279	3
134	150	49	2
135	150	121	2
136	150	228	3
137	151	37	1
138	151	252	3
139	152	153	2
140	152	282	3
141	153	231	1
142	153	33	3
143	153	85	3
144	154	19	3
145	155	34	1
146	155	45	1
147	155	61	2
148	156	2	3
149	156	35	3
150	156	230	1
151	157	153	3
152	158	254	2
153	158	95	2
154	158	279	2
155	159	276	1
156	159	261	2
157	159	253	2
158	160	153	3
159	160	99	1
160	160	165	1
161	160	121	1
162	161	185	1
163	161	251	2
164	162	175	3
165	162	118	3
166	162	271	2
167	162	73	2
168	163	153	3
169	164	136	3
170	164	259	1
171	164	274	2
172	164	114	2
173	165	245	1
174	165	43	1
175	165	233	1
176	166	180	1
177	166	89	1
178	166	93	3
179	166	255	3
180	166	99	3
181	167	243	2
182	167	202	2
183	167	246	2
184	168	282	1
185	168	216	3
186	168	204	1
187	168	255	3
188	169	58	1
189	169	209	1
190	169	55	3
191	169	142	3
192	169	192	1
193	170	206	3
194	171	271	2
195	171	33	1
196	171	99	2
197	171	274	1
198	172	129	2
199	173	174	2
200	173	184	3
201	174	165	2
202	175	109	1
203	175	144	2
204	175	53	3
205	176	5	2
206	176	51	2
207	177	248	2
208	177	99	2
209	177	57	3
210	177	119	1
211	177	158	1
212	178	71	3
213	178	255	2
214	178	94	1
215	178	192	1
216	178	13	1
217	179	244	1
218	179	266	3
219	179	37	3
220	180	266	2
221	180	254	3
222	180	125	1
223	180	123	2
224	180	175	3
225	181	25	3
226	181	246	3
227	181	155	2
228	181	66	2
229	181	181	1
230	182	64	3
231	182	261	2
232	182	179	2
233	182	281	2
234	183	279	3
235	183	14	2
236	183	137	1
237	184	179	1
238	184	90	2
239	184	218	1
240	185	96	2
241	185	135	1
242	185	166	3
243	185	170	1
244	186	60	3
245	186	166	1
246	186	127	3
247	186	265	1
248	187	11	3
249	187	10	3
250	187	167	1
251	187	99	1
252	187	80	2
253	188	221	2
254	189	259	2
255	189	128	1
256	190	53	1
257	190	265	2
258	190	120	2
259	190	192	1
260	190	21	1
261	191	244	2
262	191	279	2
263	191	27	3
264	192	260	2
265	192	62	2
266	192	78	1
267	192	205	3
268	193	256	2
269	194	260	1
270	195	123	1
271	195	73	2
272	195	4	1
273	195	118	2
274	195	257	1
275	196	126	3
276	197	35	1
277	197	111	3
278	197	99	3
279	197	287	1
280	198	110	2
281	198	136	3
282	198	163	3
283	198	186	3
284	199	165	2
285	200	53	2
286	200	249	1
287	200	230	1
288	200	36	2
289	201	101	3
290	201	28	2
291	201	186	3
292	202	160	1
293	202	86	3
294	202	178	2
295	203	252	2
296	203	178	1
297	203	112	1
298	203	115	3
299	203	31	2
300	204	101	1
301	204	91	1
302	204	127	1
303	205	48	1
304	205	13	3
305	205	178	1
306	205	197	3
307	205	71	1
308	206	87	1
309	206	68	3
310	206	47	3
311	206	54	3
312	207	116	3
313	208	225	1
314	208	159	2
315	208	85	2
316	209	139	1
317	209	100	2
318	209	68	2
319	209	183	3
320	209	38	3
321	210	124	2
322	210	280	2
323	210	5	3
324	210	172	3
325	211	143	3
326	211	61	1
327	212	259	3
328	213	125	2
329	213	136	2
330	213	54	3
331	213	201	3
332	214	97	1
333	214	214	2
334	214	236	2
335	215	9	1
336	215	16	2
337	215	189	2
338	215	115	1
339	216	30	2
340	216	218	1
341	217	176	3
342	217	192	2
343	218	42	1
344	218	80	1
345	219	249	3
346	219	7	3
347	219	194	1
348	219	3	1
349	220	143	2
350	221	122	3
351	221	266	1
352	221	76	2
353	222	118	2
354	222	22	1
355	223	205	2
356	223	256	2
357	223	140	3
358	223	4	3
359	223	78	1
360	224	87	1
361	224	209	3
362	224	281	3
363	224	232	1
364	225	116	2
365	226	99	3
366	226	248	1
367	226	62	1
368	227	182	1
369	227	22	2
370	227	203	3
371	227	208	1
372	227	280	2
373	228	214	2
374	228	139	1
375	228	169	2
376	228	201	3
377	228	197	2
378	229	157	3
379	229	237	3
380	229	178	3
381	229	134	2
382	230	229	2
383	230	100	2
384	231	34	1
385	231	275	2
386	231	209	1
387	232	63	1
388	232	219	2
389	232	235	2
390	233	16	3
391	234	228	1
392	234	62	3
393	234	179	3
394	234	107	3
395	234	16	3
396	388	167	2
397	388	260	3
398	388	212	3
399	388	75	3
400	388	265	1
401	235	207	1
402	235	34	1
403	236	285	1
404	237	55	3
405	237	57	1
406	238	288	3
407	238	232	2
408	238	254	1
409	238	61	1
410	238	120	1
411	239	219	3
412	239	217	3
413	240	2	1
414	240	8	1
415	240	144	1
416	240	227	2
417	240	171	1
418	241	161	3
419	242	40	2
420	242	286	2
421	242	57	2
422	242	116	2
423	243	32	2
424	243	217	2
425	243	24	1
426	243	88	2
427	244	90	3
428	244	36	2
429	245	246	2
430	245	230	3
431	245	192	1
432	245	55	1
433	246	263	1
434	246	178	2
435	247	219	2
436	247	242	3
437	247	287	3
438	247	5	3
439	247	51	3
440	248	135	3
441	248	164	3
442	248	53	3
443	249	124	2
444	249	58	2
445	249	286	2
446	249	73	1
447	250	217	1
448	250	186	1
449	250	269	3
450	251	26	2
451	251	238	2
452	251	271	3
453	252	167	2
454	252	258	3
455	253	205	3
456	254	258	2
457	254	125	2
458	254	142	3
459	254	80	3
460	255	21	1
461	255	228	1
462	255	93	3
463	255	25	3
464	256	88	3
465	256	190	3
466	256	117	3
467	257	125	2
468	258	204	2
469	258	122	2
470	258	125	1
471	258	198	2
472	259	172	3
473	259	62	2
474	259	216	1
475	259	158	3
476	260	122	2
477	260	70	1
478	260	78	2
479	261	222	2
480	261	114	2
481	261	110	3
482	261	277	3
483	262	166	1
484	262	252	1
485	262	44	2
486	263	208	2
487	264	141	2
488	264	34	2
489	264	90	2
490	265	111	3
491	265	277	1
492	265	10	3
493	265	174	1
494	265	191	2
495	266	68	3
496	266	173	3
497	267	97	1
498	267	256	3
499	268	147	3
500	268	91	3
501	269	256	1
502	269	79	3
503	269	272	1
504	269	132	3
505	269	60	2
506	270	152	1
507	270	212	3
508	271	194	1
509	271	89	1
510	271	216	3
511	271	33	3
512	271	192	3
513	272	261	3
514	272	52	2
515	272	148	2
516	273	187	1
517	273	29	1
518	273	205	2
519	274	238	1
520	274	241	3
521	275	189	3
522	275	44	1
523	275	209	3
524	275	137	2
525	275	191	1
526	276	31	3
527	276	110	2
528	276	158	2
529	276	48	2
530	276	11	3
531	277	287	3
532	278	165	2
533	278	178	3
534	278	25	1
535	278	163	2
536	279	242	3
537	279	160	2
538	279	32	2
539	279	153	1
540	280	172	3
541	281	191	2
542	281	1	3
543	281	36	1
544	281	138	1
545	281	166	2
546	282	282	2
547	282	99	1
548	282	272	3
549	283	121	3
550	283	96	3
551	283	32	1
552	284	147	1
553	284	115	3
554	284	190	1
555	284	242	2
556	285	265	1
557	285	134	1
558	286	155	2
559	287	41	2
560	288	127	3
561	288	140	1
562	288	138	3
563	288	284	1
564	289	34	2
565	289	153	3
566	290	80	1
567	291	166	1
568	292	189	1
569	292	195	2
570	293	197	3
571	294	228	2
572	295	140	2
573	295	142	3
574	295	116	1
575	295	186	2
576	295	108	1
577	296	150	1
578	296	124	3
579	297	219	1
580	298	148	2
581	298	30	1
582	298	130	2
583	298	47	3
584	298	1	1
585	299	241	3
586	299	49	1
587	299	61	1
588	300	154	3
589	300	58	1
590	300	162	1
591	300	35	2
592	301	17	2
593	301	138	2
594	302	284	2
595	302	167	1
596	302	189	2
597	302	121	3
598	302	287	2
599	303	231	1
600	303	204	1
601	303	33	1
602	304	264	1
603	305	5	3
604	305	112	1
605	305	235	1
606	306	278	3
607	306	206	3
608	306	37	2
609	306	249	1
610	306	174	1
611	307	169	2
612	307	189	1
613	307	26	1
614	307	235	2
615	307	131	3
616	308	29	1
617	308	265	2
618	309	18	1
619	309	192	1
620	309	181	1
621	309	105	1
622	310	107	3
623	310	156	1
624	310	205	1
625	310	232	3
626	311	94	2
627	311	109	3
628	311	187	3
629	311	248	1
630	312	287	2
631	313	54	1
632	313	277	2
633	314	226	1
634	314	29	3
635	315	165	1
636	315	276	1
637	316	151	1
638	316	150	2
639	316	163	1
640	317	230	3
641	317	279	1
642	317	19	3
643	317	254	3
644	317	47	1
645	318	175	3
646	318	144	1
647	319	213	1
648	319	107	3
649	320	90	3
650	320	130	2
651	321	16	2
652	321	204	2
653	321	18	2
654	321	248	1
655	321	106	2
656	322	165	1
657	322	137	3
658	322	175	2
659	323	174	1
660	323	200	2
661	324	145	1
662	324	80	1
663	324	123	1
664	324	200	1
665	325	179	1
666	325	68	3
667	325	238	3
668	325	178	1
669	325	67	1
670	326	193	2
671	327	5	3
672	327	242	1
673	328	241	3
674	328	192	1
675	328	284	3
676	329	157	1
677	329	163	1
678	329	252	2
679	330	208	1
680	330	3	1
681	330	109	2
682	330	283	1
683	330	287	1
684	331	203	2
685	331	137	2
686	331	269	1
687	332	31	1
688	333	40	3
689	333	63	1
690	334	9	2
691	334	129	3
692	334	24	1
693	334	267	1
694	335	44	2
695	335	74	1
696	335	31	3
697	335	121	1
698	336	3	3
699	336	100	1
700	336	219	1
701	336	173	3
702	336	227	3
703	337	258	3
704	338	39	3
705	338	129	2
706	339	119	2
707	340	72	1
708	340	251	3
709	340	209	3
710	341	123	2
711	341	111	1
712	341	227	3
713	342	154	1
714	342	167	2
715	342	228	2
716	342	55	3
717	343	263	3
718	343	269	3
719	343	69	1
720	343	197	1
721	344	21	2
722	344	189	3
723	344	100	2
724	345	48	1
725	345	9	1
726	345	130	3
727	345	167	1
728	345	201	3
729	346	196	2
730	346	185	2
731	347	205	3
732	347	261	2
733	347	190	2
734	347	103	1
735	347	286	3
736	348	12	1
737	349	159	1
738	350	103	1
739	350	141	1
740	350	14	2
741	350	145	3
742	351	37	1
743	351	268	1
744	351	242	1
745	351	102	1
746	351	250	3
747	352	35	2
748	352	53	3
749	352	163	1
750	352	43	1
751	353	228	1
752	353	32	1
753	353	281	3
754	353	38	3
755	353	38	3
756	354	213	1
757	355	161	2
758	355	58	2
759	355	54	2
760	355	77	3
761	356	187	3
762	356	85	3
763	356	58	2
764	357	212	2
765	357	271	2
766	357	163	2
767	357	17	1
768	357	239	1
769	358	201	2
770	358	154	1
771	358	46	2
772	358	66	3
773	359	82	1
774	359	268	2
775	359	148	1
776	360	211	1
777	360	66	2
778	360	75	2
779	360	115	3
780	361	245	1
781	361	188	2
782	362	273	3
783	362	146	1
784	362	226	2
785	362	109	1
786	363	274	2
787	364	235	1
788	365	143	3
789	365	182	3
790	366	224	1
791	366	128	3
792	367	64	1
793	367	46	3
794	368	154	3
795	368	25	1
796	369	237	2
797	369	67	3
798	369	132	2
799	370	34	1
800	370	278	1
801	370	233	3
802	370	137	2
803	371	146	1
804	372	259	2
805	372	280	1
806	372	278	3
807	372	74	3
808	372	185	2
809	373	165	1
810	373	277	1
811	373	119	3
812	373	33	1
813	374	68	3
814	374	280	2
815	374	276	3
816	374	23	1
817	374	119	1
818	375	124	2
819	375	273	2
820	375	114	3
821	376	26	1
822	376	79	1
823	376	174	3
824	377	103	2
825	378	102	3
826	378	184	2
827	378	257	1
828	378	21	3
829	379	252	2
830	380	106	2
831	380	123	3
832	380	187	3
833	381	10	2
834	382	196	1
835	382	266	2
836	382	283	2
837	382	246	1
838	383	164	1
839	383	29	2
840	383	13	1
841	383	272	2
842	383	47	1
843	384	272	1
844	385	222	2
845	385	101	3
846	385	126	2
847	386	230	1
848	386	60	1
849	387	83	1
850	387	11	2
851	387	83	1
852	387	215	3
853	387	147	1
854	389	282	1
855	389	192	3
856	390	140	3
857	390	224	1
858	390	139	1
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_messages (id, user_id, sender, message, created_at) FROM stdin;
1	6	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
2	6	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
3	6	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
4	6	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
5	7	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
6	7	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
7	7	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
8	8	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
9	8	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
10	8	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
11	8	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
12	9	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
13	9	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
14	9	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
15	9	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
16	10	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
17	10	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
18	10	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
19	10	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
20	10	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
21	11	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
22	11	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
23	11	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
24	11	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
25	12	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
26	12	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
27	12	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
28	12	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
29	12	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
30	13	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
31	13	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
32	13	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
33	13	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
34	13	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
35	14	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
36	15	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
37	15	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
38	15	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
39	15	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
40	15	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
41	16	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
42	16	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
43	17	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
44	18	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
45	19	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
46	19	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
47	20	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
48	21	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
49	21	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
50	21	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
51	22	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
52	23	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
53	23	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
54	23	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
55	23	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
56	23	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
57	24	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
58	24	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
59	24	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
60	25	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
61	26	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
62	26	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
63	26	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
64	26	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
65	27	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
66	27	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
67	27	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
68	28	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
69	29	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
70	29	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
71	29	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
72	29	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
73	29	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
74	30	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
75	30	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
76	30	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
77	31	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
78	31	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
79	32	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
80	32	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
81	33	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
82	33	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
83	34	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
84	34	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
85	34	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
86	34	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
87	34	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
88	35	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
89	35	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
90	36	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
91	36	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
92	36	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
93	36	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
94	37	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
95	37	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
96	38	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
97	38	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
98	39	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
99	39	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
100	40	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
101	40	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
102	40	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
103	40	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
104	40	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
105	41	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
106	41	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
107	41	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
108	42	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
109	42	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
110	43	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
111	43	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
112	43	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
113	44	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
114	44	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
115	44	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
116	45	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
117	45	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
118	46	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
119	46	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
120	46	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
121	47	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
122	47	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
123	47	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
124	47	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
125	48	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
126	49	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
127	49	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
128	50	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
129	50	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
130	50	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
131	50	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
132	50	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
133	51	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
134	51	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
135	51	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
136	51	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
137	51	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
138	52	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
139	52	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
140	52	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
141	53	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
142	53	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
143	54	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
144	54	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
145	55	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
146	55	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
147	55	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
148	55	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
149	55	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
150	56	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
151	56	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
152	56	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
153	56	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
154	57	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
155	57	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
156	58	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
157	58	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
158	59	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
159	60	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
160	61	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
161	61	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
162	62	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
163	63	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
164	64	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
165	65	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
166	65	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
167	65	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
168	65	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
169	66	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
170	66	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
171	67	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
172	68	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
173	68	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
174	68	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
175	68	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
176	68	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
177	69	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
178	69	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
179	69	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
180	69	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
181	69	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
182	70	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
183	70	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
184	71	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
185	71	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
186	71	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
187	72	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
188	72	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
189	72	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
190	72	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
191	73	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
192	73	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
193	73	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
194	74	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
195	74	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
196	74	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
197	74	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
198	75	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
199	75	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
200	76	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
201	76	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
202	76	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
203	76	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
204	77	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
205	77	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
206	77	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
207	77	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
208	78	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
209	78	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
210	78	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
211	78	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
212	78	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
213	79	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
214	79	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
215	80	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
216	80	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
217	80	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
218	81	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
219	81	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
220	82	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
221	82	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
222	83	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
223	83	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
224	83	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
225	83	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
226	84	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
227	84	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
228	84	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
229	85	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
230	85	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
231	85	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
232	85	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
233	85	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
234	86	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
235	86	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
236	86	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
237	86	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
238	87	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
239	87	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
240	87	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
241	87	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
242	87	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
243	88	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
244	88	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
245	88	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
246	88	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
247	89	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
248	89	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
249	89	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
250	89	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
251	89	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
252	90	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
253	90	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
254	90	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
255	90	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
256	90	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
257	91	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
258	91	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
259	92	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
260	92	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
261	92	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
262	92	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
263	92	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
264	93	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
265	93	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
266	93	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
267	94	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
268	94	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
269	94	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
270	94	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
271	94	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
272	95	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
273	95	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
274	95	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
275	96	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
276	97	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
277	98	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
278	98	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
279	98	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
280	98	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
281	99	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
282	99	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
283	99	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
284	100	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
285	100	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
286	100	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
287	101	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
288	102	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
289	103	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
290	103	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
291	103	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
292	103	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
293	104	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
294	104	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
295	104	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
296	104	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
297	104	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
298	105	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
299	105	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
300	105	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
301	105	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
302	106	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
303	106	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
304	106	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
305	106	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
306	107	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
307	107	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
308	108	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
309	109	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
310	109	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
311	109	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
312	110	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
313	110	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
314	110	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
315	110	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
316	110	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
317	111	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
318	111	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
319	111	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
320	111	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
321	111	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
322	112	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
323	112	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
324	112	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
325	113	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
326	113	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
327	113	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
328	113	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
329	113	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
330	114	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
331	114	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
332	114	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
333	114	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
334	115	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
335	116	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
336	116	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
337	117	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
338	118	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
339	118	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
340	118	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
341	118	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
342	118	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
343	119	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
344	119	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
345	119	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
346	119	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
347	119	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
348	120	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
349	121	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
350	121	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
351	121	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
352	121	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
353	121	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
354	122	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
355	122	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
356	122	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
357	123	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
358	124	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
359	124	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
360	124	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
361	124	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
362	125	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
363	125	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
364	125	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
365	125	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
366	126	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
367	126	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
368	126	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
369	127	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
370	127	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
371	128	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
372	128	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
373	129	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
374	129	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
375	129	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
376	129	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
377	130	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
378	130	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
379	130	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
380	130	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
381	130	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
382	131	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
383	132	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
384	132	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
385	132	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
386	132	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
387	132	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
388	133	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
389	133	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
390	133	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
391	133	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
392	134	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
393	134	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
394	134	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
395	135	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
396	135	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
397	135	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
398	135	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
399	135	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
400	136	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
401	136	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
402	136	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
403	136	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
404	137	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
405	138	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
406	139	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
407	139	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
408	140	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
409	140	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
410	140	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
411	140	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
412	140	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
413	141	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
414	141	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
415	141	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
416	141	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
417	141	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
418	142	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
419	142	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
420	142	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
421	143	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
422	143	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
423	143	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
424	143	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
425	143	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
426	144	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
427	144	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
428	144	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
429	144	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
430	144	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
431	145	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
432	145	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
433	145	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
434	145	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
435	146	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
436	146	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
437	146	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
438	146	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
439	146	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
440	147	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
441	147	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
442	147	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
443	147	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
444	148	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
445	148	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
446	148	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
447	148	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
448	149	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
449	149	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
450	149	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
451	149	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
452	150	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
453	150	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
454	150	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
455	150	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
456	150	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
457	151	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
458	151	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
459	152	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
460	152	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
461	152	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
462	152	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
463	153	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
464	153	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
465	153	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
466	153	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
467	154	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
468	155	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
469	155	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
470	156	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
471	156	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
472	157	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
473	157	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
474	157	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
475	157	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
476	158	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
477	159	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
478	159	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
479	159	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
480	160	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
481	160	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
482	160	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
483	160	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
484	160	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
485	161	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
486	162	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
487	162	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
488	162	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
489	162	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
490	162	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
491	163	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
492	163	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
493	163	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
494	163	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
495	164	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
496	164	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
497	165	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
498	165	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
499	165	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
500	165	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
501	165	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
502	166	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
503	166	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
504	167	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
505	167	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
506	167	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
507	167	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
508	168	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
509	168	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
510	168	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
511	168	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
512	169	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
513	170	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
514	170	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
515	171	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
516	172	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
517	172	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
518	172	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
519	173	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
520	173	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
521	173	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
522	174	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
523	175	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
524	175	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
525	175	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
526	175	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
527	176	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
528	176	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
529	176	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
530	177	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
531	177	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
532	178	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
533	178	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
534	178	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
535	178	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
536	179	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
537	179	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
538	180	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
539	181	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
540	182	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
541	182	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
542	182	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
543	182	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
544	182	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
545	183	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
546	183	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
547	184	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
548	184	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
549	184	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
550	184	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
551	185	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
552	185	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
553	185	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
554	185	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
555	186	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
556	186	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
557	186	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
558	187	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
559	187	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
560	188	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
561	188	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
562	188	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
563	188	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
564	188	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
565	189	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
566	190	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
567	190	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
568	190	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
569	191	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
570	192	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
571	192	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
572	192	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
573	192	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
574	192	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
575	193	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
576	193	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
577	194	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
578	194	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
579	194	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
580	195	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
581	195	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
582	196	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
583	196	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
584	197	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
585	197	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
586	197	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
587	197	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
588	197	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
589	198	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
590	198	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
591	198	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
592	199	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
593	199	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
594	199	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
595	200	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
596	200	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
597	200	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
598	201	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
599	201	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
600	201	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
601	202	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
602	202	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
603	202	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
604	202	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
605	202	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
606	203	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
607	203	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
608	203	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
609	203	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
610	203	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
611	204	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
612	204	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
613	204	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
614	205	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
615	205	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
616	206	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
617	206	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
618	207	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
619	207	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
620	207	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
621	208	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
622	209	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
623	209	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
624	210	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
625	211	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
626	212	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
627	212	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
628	213	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
629	213	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
630	214	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
631	214	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
632	214	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
633	215	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
634	215	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
635	215	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
636	216	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
637	216	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
638	216	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
639	216	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
640	216	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
641	217	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
642	217	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
643	217	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
644	217	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
645	217	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
646	218	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
647	218	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
648	218	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
649	218	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
650	219	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
651	219	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
652	219	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
653	219	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
654	219	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
655	220	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
656	220	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
657	220	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
658	220	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
659	221	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
660	221	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
661	221	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
662	221	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
663	222	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
664	222	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
665	222	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
666	222	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
667	223	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
668	223	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
669	224	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
670	225	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
671	226	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
672	226	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
673	226	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
674	226	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
675	227	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
676	227	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
677	227	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
678	227	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
679	228	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
680	228	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
681	229	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
682	229	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
683	229	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
684	229	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
685	230	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
686	230	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
687	230	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
688	230	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
689	231	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
690	231	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
691	232	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
692	233	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
693	233	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
694	234	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
695	234	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
696	234	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
697	234	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
698	234	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
699	388	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
700	388	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
701	235	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
702	235	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
703	236	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
704	236	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
705	237	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
706	237	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
707	238	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
708	239	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
709	239	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
710	239	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
711	240	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
712	241	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
713	241	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
714	242	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
715	242	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
716	242	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
717	243	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
718	243	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
719	243	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
720	243	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
721	243	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
722	244	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
723	245	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
724	245	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
725	246	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
726	246	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
727	247	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
728	247	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
729	247	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
730	247	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
731	248	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
732	248	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
733	248	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
734	248	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
735	249	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
736	249	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
737	250	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
738	250	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
739	250	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
740	250	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
741	251	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
742	251	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
743	252	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
744	253	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
745	253	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
746	253	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
747	253	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
748	253	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
749	254	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
750	255	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
751	255	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
752	255	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
753	255	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
754	256	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
755	256	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
756	256	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
757	256	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
758	257	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
759	257	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
760	257	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
761	258	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
762	258	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
763	259	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
764	260	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
765	260	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
766	261	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
767	261	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
768	261	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
769	261	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
770	262	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
771	263	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
772	263	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
773	263	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
774	263	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
775	263	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
776	264	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
777	264	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
778	264	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
779	265	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
780	266	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
781	266	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
782	266	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
783	266	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
784	267	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
785	267	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
786	267	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
787	268	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
788	268	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
789	268	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
790	269	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
791	269	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
792	269	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
793	269	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
794	269	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
795	270	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
796	271	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
797	272	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
798	272	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
799	272	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
800	272	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
801	273	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
802	273	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
803	273	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
804	273	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
805	273	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
806	274	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
807	274	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
808	274	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
809	274	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
810	275	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
811	275	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
812	275	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
813	275	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
814	275	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
815	276	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
816	276	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
817	277	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
818	277	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
819	278	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
820	278	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
821	279	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
822	279	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
823	279	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
824	279	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
825	280	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
826	280	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
827	280	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
828	281	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
829	281	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
830	281	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
831	281	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
832	281	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
833	282	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
834	282	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
835	282	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
836	282	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
837	283	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
838	283	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
839	283	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
840	284	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
841	284	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
842	284	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
843	284	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
844	284	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
845	285	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
846	285	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
847	285	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
848	286	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
849	286	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
850	287	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
851	287	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
852	287	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
853	288	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
854	288	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
855	288	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
856	288	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
857	289	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
858	289	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
859	289	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
860	290	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
861	291	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
862	292	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
863	292	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
864	293	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
865	293	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
866	294	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
867	294	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
868	294	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
869	294	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
870	295	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
871	295	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
872	295	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
873	295	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
874	296	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
875	296	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
876	296	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
877	296	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
878	296	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
879	297	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
880	297	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
881	297	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
882	297	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
883	298	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
884	299	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
885	300	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
886	301	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
887	301	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
888	301	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
889	302	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
890	302	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
891	303	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
892	303	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
893	304	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
894	305	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
895	305	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
896	305	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
897	306	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
898	307	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
899	307	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
900	307	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
901	307	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
902	307	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
903	308	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
904	308	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
905	308	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
906	309	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
907	309	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
908	309	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
909	309	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
910	310	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
911	310	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
912	310	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
913	310	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
914	311	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
915	312	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
916	312	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
917	313	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
918	313	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
919	313	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
920	313	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
921	314	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
922	314	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
923	314	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
924	315	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
925	315	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
926	315	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
927	315	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
928	315	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
929	316	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
930	316	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
931	316	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
932	316	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
933	317	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
934	318	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
935	319	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
936	319	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
937	320	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
938	320	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
939	320	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
940	320	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
941	320	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
942	321	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
943	321	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
944	321	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
945	321	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
946	321	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
947	322	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
948	323	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
949	323	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
950	323	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
951	324	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
952	324	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
953	324	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
954	325	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
955	325	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
956	325	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
957	326	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
958	326	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
959	327	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
960	328	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
961	328	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
962	328	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
963	328	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
964	328	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
965	329	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
966	330	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
967	330	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
968	331	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
969	332	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
970	332	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
971	333	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
972	333	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
973	333	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
974	334	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
975	334	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
976	335	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
977	335	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
978	335	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
979	336	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
980	337	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
981	337	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
982	337	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
983	337	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
984	338	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
985	338	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
986	339	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
987	340	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
988	340	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
989	341	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
990	341	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
991	342	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
992	342	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
993	342	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
994	343	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
995	343	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
996	343	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
997	343	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
998	343	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
999	344	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1000	344	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1001	345	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1002	345	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1003	345	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1004	345	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1005	345	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1006	346	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1007	346	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1008	347	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1009	347	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1010	347	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1011	348	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1012	348	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1013	348	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1014	348	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1015	349	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1016	350	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1017	350	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1018	350	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1019	351	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1020	351	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1021	351	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1022	351	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1023	351	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1024	352	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1025	352	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1026	353	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1027	353	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1028	353	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1029	354	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1030	355	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1031	356	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1032	356	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1033	357	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1034	357	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1035	358	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1036	358	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1037	358	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1038	359	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1039	359	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1040	359	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1041	359	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1042	360	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1043	360	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1044	360	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1045	360	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1046	361	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1047	361	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1048	361	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1049	361	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1050	361	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1051	362	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1052	362	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1053	362	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1054	362	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1055	363	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1056	363	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1057	363	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1058	363	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1059	364	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1060	364	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1061	364	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1062	365	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1063	365	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1064	365	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1065	365	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1066	365	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1067	366	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1068	366	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1069	366	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1070	367	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1071	367	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1072	367	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1073	367	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1074	367	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1075	368	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1076	368	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1077	368	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1078	368	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1079	368	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1080	369	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1081	369	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1082	370	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1083	370	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1084	370	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1085	371	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1086	372	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1087	372	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1088	372	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1089	373	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1090	373	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1091	374	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1092	374	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1093	374	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1094	374	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1095	374	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1096	375	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1097	375	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1098	375	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1099	375	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1100	376	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1101	376	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1102	376	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1103	376	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1104	377	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1105	377	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1106	378	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1107	378	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1108	378	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1109	379	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1110	379	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1111	379	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1112	379	USER	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1113	380	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1114	380	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1115	380	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1116	380	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1117	380	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1118	381	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1119	382	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1120	382	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1121	382	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1122	383	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1123	383	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1124	383	BOT	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1125	384	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1126	384	USER	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1127	384	BOT	Ürün stokta mı acaba?	2025-05-10 03:51:19.618588
1128	384	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1129	385	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1130	385	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1131	385	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1132	385	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1133	386	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1134	386	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1135	386	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1136	386	USER	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1137	386	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1138	387	USER	Bu ürün hakkında detay verir misiniz?	2025-05-10 03:51:19.618588
1139	389	BOT	Merhaba, yardım edebilir misiniz?	2025-05-10 03:51:19.618588
1140	389	USER	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
1141	389	BOT	İade işlemi nasıl yapılır?	2025-05-10 03:51:19.618588
1142	390	BOT	Siparişim gecikti, bilgi alabilir miyim?	2025-05-10 03:51:19.618588
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, buyer_id, product_id) FROM stdin;
1	101	215
2	101	231
3	101	238
4	101	120
5	101	115
6	101	139
7	101	270
8	102	9
9	102	207
10	102	109
11	102	206
12	103	75
13	103	138
14	103	175
15	103	149
16	103	61
17	104	150
18	104	111
19	104	265
20	104	187
21	104	93
22	104	210
23	104	102
24	104	201
25	105	104
26	106	56
27	106	207
28	106	253
29	106	228
30	106	284
31	106	191
32	106	73
33	106	263
34	106	101
35	107	165
36	107	81
37	107	121
38	107	219
39	107	48
40	107	93
41	107	19
42	107	203
43	107	86
44	107	172
45	108	105
46	108	138
47	108	203
48	108	51
49	108	128
50	108	66
51	109	123
52	109	167
53	109	223
54	110	20
55	110	103
56	110	153
57	110	274
58	111	38
59	111	89
60	111	148
61	111	106
62	111	65
63	111	246
64	112	74
65	112	252
66	112	278
67	112	274
68	112	35
69	113	97
70	113	249
71	113	202
72	113	22
73	114	115
74	114	206
75	114	188
76	114	225
77	114	27
78	115	50
79	115	214
80	115	215
81	115	165
82	115	64
83	115	61
84	115	80
85	115	130
86	115	33
87	116	95
88	116	115
89	116	161
90	116	13
91	116	147
92	116	5
93	116	107
94	116	15
95	117	172
96	117	128
97	117	232
98	117	211
99	117	6
100	117	136
101	117	117
102	118	98
103	118	183
104	118	96
105	118	251
106	118	223
107	118	18
108	119	35
109	119	111
110	120	181
111	120	220
112	120	2
113	120	48
114	120	131
115	120	32
116	121	60
117	122	228
118	122	117
119	122	225
120	122	66
121	122	141
122	122	175
123	122	219
124	122	48
125	122	261
126	123	121
127	123	99
128	123	189
129	123	90
130	124	187
131	124	136
132	124	153
133	124	248
134	125	286
135	125	28
136	125	120
137	125	224
138	125	250
139	125	288
140	125	71
141	125	199
142	125	192
143	126	167
144	127	61
145	127	49
146	127	66
147	127	259
148	127	2
149	127	18
150	127	30
151	127	264
152	128	97
153	128	17
154	128	245
155	128	171
156	128	186
157	128	140
158	129	285
159	129	131
160	130	283
161	130	117
162	130	263
163	130	66
164	131	245
165	131	153
166	132	210
167	132	176
168	132	127
169	132	285
170	132	231
171	132	8
172	133	133
173	133	3
174	133	159
175	133	27
176	133	176
177	133	98
178	133	138
179	134	2
180	134	287
181	134	151
182	134	226
183	134	121
184	135	138
185	135	167
186	135	55
187	135	58
188	135	199
189	135	129
190	135	22
191	135	159
192	135	45
193	135	5
194	136	24
195	136	217
196	136	191
197	136	193
198	136	28
199	136	173
200	136	88
201	136	156
202	136	21
203	137	203
204	138	29
205	139	218
206	139	41
207	140	4
208	140	65
209	140	86
210	140	271
211	141	69
212	141	240
213	141	210
214	141	245
215	142	44
216	142	237
217	142	238
218	142	144
219	142	283
220	142	168
221	142	262
222	142	288
223	142	262
224	143	106
225	143	103
226	143	58
227	143	144
228	143	129
229	143	148
230	144	171
231	144	98
232	144	49
233	144	133
234	144	276
235	145	4
236	145	218
237	145	279
238	145	153
239	145	181
240	145	196
241	145	141
242	145	204
243	146	245
244	146	186
245	146	43
246	146	241
247	146	49
248	146	286
249	146	175
250	146	230
251	146	268
252	147	2
253	147	127
254	147	38
255	148	272
256	148	131
257	148	177
258	148	89
259	148	252
260	148	249
261	148	106
262	148	149
263	148	166
264	148	142
265	149	141
266	149	223
267	149	286
268	149	76
269	150	222
270	150	78
271	150	239
272	150	201
273	151	224
274	151	167
275	151	144
276	152	160
277	153	159
278	153	2
279	153	286
280	153	50
281	153	170
282	153	133
283	153	74
284	153	224
285	153	71
286	153	251
287	154	74
288	154	283
289	155	221
290	155	16
291	155	272
292	155	91
293	155	109
294	155	14
295	155	122
296	156	109
297	156	227
298	157	106
299	157	73
300	157	72
301	157	91
302	158	6
303	158	282
304	158	56
305	158	273
306	158	186
307	159	61
308	159	134
309	159	239
310	160	240
311	160	150
312	160	200
313	160	153
314	161	217
315	161	68
316	161	85
317	161	172
318	161	221
319	161	30
320	161	44
321	161	230
322	161	18
323	161	228
324	162	209
325	162	231
326	162	285
327	162	224
328	162	116
329	162	20
330	162	286
331	162	228
332	162	91
333	162	161
334	163	34
335	163	286
336	163	196
337	163	29
338	163	27
339	164	208
340	164	169
341	164	104
342	165	239
343	165	267
344	165	191
345	165	271
346	165	134
347	165	143
348	165	192
349	165	285
350	165	288
351	165	179
352	166	272
353	166	229
354	166	2
355	166	234
356	166	229
357	166	175
358	167	272
359	167	76
360	167	185
361	167	135
362	168	273
363	168	174
364	168	106
365	168	46
366	168	202
367	168	248
368	169	172
369	170	281
370	170	212
371	170	204
372	170	134
373	170	194
374	170	99
375	170	17
376	171	277
377	171	137
378	171	103
379	171	127
380	171	238
381	171	19
382	172	222
383	172	90
384	172	175
385	172	48
386	172	28
387	173	198
388	173	74
389	173	124
390	173	39
391	173	42
392	173	261
393	174	20
394	174	175
395	174	11
396	174	257
397	174	38
398	174	81
399	174	206
400	174	155
401	175	93
402	175	209
403	175	8
404	175	197
405	175	263
406	175	256
407	175	8
408	176	252
409	176	162
410	177	103
411	178	242
412	178	110
413	178	18
414	178	272
415	179	39
416	179	133
417	179	130
418	179	147
419	179	249
420	179	108
421	180	200
422	180	23
423	180	23
424	180	119
425	180	267
426	180	156
427	180	18
428	181	59
429	181	277
430	181	52
431	181	13
432	181	187
433	181	54
434	182	185
435	182	103
436	182	45
437	182	108
438	182	33
439	182	142
440	182	210
441	182	243
442	182	247
443	183	94
444	183	70
445	183	174
446	184	269
447	184	30
448	184	262
449	184	146
450	184	121
451	184	109
452	184	244
453	185	36
454	185	151
455	185	63
456	185	77
457	186	277
458	186	119
459	186	107
460	186	44
461	186	208
462	186	64
463	186	17
464	186	78
465	186	226
466	187	273
467	187	74
468	187	171
469	187	142
470	187	201
471	187	74
472	187	264
473	187	45
474	187	49
475	187	13
476	188	201
477	188	160
478	188	58
479	188	67
480	188	71
481	188	12
482	188	281
483	188	72
484	189	83
485	189	248
486	189	179
487	189	243
488	189	100
489	189	76
490	189	26
491	189	146
492	190	282
493	190	194
494	190	50
495	190	54
496	190	18
497	191	37
498	191	68
499	191	65
500	191	117
501	191	257
502	191	36
503	191	202
504	192	138
505	192	231
506	192	62
507	192	78
508	192	288
509	192	80
510	193	161
511	193	86
512	193	266
513	193	153
514	193	183
515	193	56
516	193	146
517	193	80
518	194	49
519	194	178
520	194	288
521	194	149
522	194	33
523	194	71
524	194	112
525	194	279
526	195	218
527	195	132
528	195	116
529	195	45
530	195	178
531	195	26
532	195	157
533	195	29
534	196	188
535	196	48
536	196	89
537	196	243
538	196	167
539	196	166
540	196	7
541	196	1
542	197	262
543	197	171
544	197	179
545	197	185
546	197	278
547	197	215
548	197	187
549	198	171
550	198	212
551	198	249
552	198	230
553	199	117
554	199	227
555	200	227
556	200	192
557	200	208
558	201	117
559	201	1
560	202	51
561	202	276
562	202	237
563	203	69
564	203	195
565	204	54
566	204	114
567	204	43
568	204	209
569	204	155
570	204	180
571	204	279
572	205	159
573	205	245
574	205	255
575	205	8
576	205	206
577	205	190
578	205	47
579	205	161
580	205	22
581	205	228
582	206	39
583	206	284
584	206	80
585	207	245
586	207	248
587	207	263
588	207	259
589	207	47
590	207	236
591	207	175
592	207	258
593	207	94
594	208	156
595	208	23
596	208	53
597	209	43
598	209	230
599	209	31
600	209	114
601	209	33
602	209	112
603	209	57
604	209	20
605	209	86
606	210	194
607	210	113
608	210	142
609	210	143
610	210	123
611	210	170
612	210	242
613	210	183
614	211	126
615	211	209
616	211	160
617	211	267
618	211	36
619	211	14
620	211	85
621	211	213
622	212	227
623	212	97
624	212	148
625	212	95
626	212	150
627	212	157
628	212	232
629	213	140
630	214	278
631	214	32
632	214	219
633	214	174
634	215	191
635	215	192
636	215	208
637	215	205
638	215	261
639	215	247
640	215	215
641	215	74
642	215	28
643	215	166
644	216	98
645	216	98
646	216	186
647	216	141
648	216	19
649	216	28
650	216	29
651	216	43
652	216	107
653	216	108
654	217	216
655	218	285
656	218	154
657	219	113
658	219	10
659	219	193
660	219	26
661	219	137
662	219	183
663	219	67
664	219	260
665	219	170
666	220	229
667	220	222
668	221	189
669	221	30
670	222	257
671	222	288
672	223	265
673	223	23
674	223	170
675	223	219
676	223	29
677	223	39
678	223	239
679	224	252
680	224	213
681	224	91
682	224	155
683	224	93
684	225	108
685	225	44
686	226	216
687	226	139
688	226	170
689	226	69
690	226	186
691	226	64
692	226	235
693	226	218
694	227	134
695	227	231
696	227	167
697	227	7
698	227	148
699	227	31
700	227	35
701	228	50
702	228	218
703	228	222
704	228	71
705	228	282
706	228	286
707	228	59
708	228	45
709	229	122
710	229	237
711	229	272
712	229	197
713	229	222
714	229	48
715	229	221
716	229	113
717	230	271
718	230	235
719	230	130
720	230	116
721	230	223
722	230	79
723	230	28
724	231	119
725	231	1
726	231	52
727	231	232
728	231	66
729	231	71
730	231	188
731	232	254
732	232	94
733	232	106
734	232	92
735	232	214
736	232	210
737	232	66
738	232	219
739	233	229
740	233	58
741	233	218
742	233	260
743	234	259
744	388	103
745	388	268
746	235	252
747	235	193
748	235	170
749	235	203
750	235	39
751	235	91
752	236	174
753	236	2
754	236	286
755	237	158
756	237	268
757	237	46
758	237	129
759	237	138
760	237	165
761	237	201
762	237	69
763	237	11
764	238	278
765	238	109
766	239	256
767	239	269
768	239	1
769	239	123
770	239	221
771	239	26
772	239	123
773	240	221
774	241	89
775	241	274
776	241	282
777	242	50
778	242	68
779	242	150
780	242	227
781	242	133
782	243	30
783	244	162
784	244	52
785	244	237
786	244	176
787	245	275
788	245	149
789	245	78
790	245	110
791	245	109
792	245	144
793	245	167
794	246	60
795	246	151
796	246	252
797	246	237
798	246	56
799	246	49
800	246	1
801	246	61
802	247	124
803	247	46
804	247	94
805	247	262
806	247	78
807	247	47
808	247	61
809	247	283
810	248	266
811	248	222
812	248	121
813	248	93
814	248	65
815	248	14
816	248	77
817	248	270
818	249	155
819	249	286
820	249	249
821	249	221
822	249	136
823	249	176
824	250	162
825	250	180
826	250	21
827	250	251
828	250	19
829	250	172
830	250	20
831	251	206
832	251	161
833	251	50
834	251	61
835	251	251
836	251	280
837	251	21
838	252	278
839	252	99
840	252	57
841	253	216
842	253	61
843	253	88
844	253	52
845	253	267
846	254	197
847	254	71
848	254	215
849	254	20
850	254	175
851	254	182
852	254	95
853	254	32
854	254	203
855	254	111
856	255	265
857	255	271
858	255	160
859	256	118
860	256	179
861	256	91
862	256	167
863	256	143
864	256	186
865	256	276
866	256	63
867	256	83
868	256	31
869	257	164
870	258	78
871	258	82
872	258	248
873	258	152
874	258	14
875	258	142
876	258	196
877	258	140
878	259	231
879	259	112
880	260	191
881	260	286
882	261	127
883	261	84
884	261	90
885	261	26
886	262	41
887	262	250
888	262	50
889	262	132
890	262	53
891	262	126
892	262	109
893	262	102
894	262	73
895	263	55
896	263	263
897	263	40
898	263	38
899	263	77
900	263	270
901	263	46
902	263	3
903	264	48
904	264	219
905	264	14
906	264	248
907	264	243
908	265	223
909	265	158
910	265	261
911	265	203
912	265	71
913	265	254
914	265	167
915	266	261
916	266	190
917	266	31
918	266	180
919	266	207
920	266	123
921	266	282
922	267	194
923	267	81
924	267	91
925	267	202
926	267	253
927	267	276
928	267	59
929	268	127
930	268	271
931	268	190
932	268	116
933	268	219
934	269	175
935	269	94
936	269	124
937	269	239
938	269	171
939	269	250
940	269	73
941	269	39
942	270	248
943	270	124
944	270	246
945	270	124
946	270	50
947	270	160
948	270	193
949	270	126
950	271	36
951	271	182
952	271	219
953	271	48
954	271	205
955	271	167
956	271	207
957	271	227
958	272	245
959	272	64
960	272	82
961	272	233
962	272	80
963	272	145
964	272	270
965	272	132
966	273	229
967	273	125
968	273	126
969	273	182
970	273	275
971	273	170
972	274	209
973	274	140
974	274	21
975	274	91
976	274	257
977	274	252
978	274	199
979	275	93
980	275	70
981	275	189
982	275	216
983	275	167
984	275	208
985	275	20
986	275	29
987	276	37
988	276	229
989	276	231
990	276	10
991	276	204
992	276	175
993	277	82
994	277	117
995	277	32
996	277	270
997	277	236
998	277	171
999	277	62
1000	277	12
1001	278	160
1002	278	243
1003	278	133
1004	278	254
1005	278	104
1006	279	68
1007	279	218
1008	279	239
1009	279	228
1010	279	57
1011	279	91
1012	279	249
1013	280	49
1014	280	74
1015	280	127
1016	280	60
1017	280	234
1018	280	127
1019	280	223
1020	280	186
1021	281	185
1022	281	259
1023	281	234
1024	281	218
1025	282	10
1026	283	190
1027	284	253
1028	284	211
1029	284	217
1030	284	211
1031	284	41
1032	284	247
1033	284	284
1034	284	223
1035	285	104
1036	285	119
1037	285	97
1038	285	82
1039	285	125
1040	285	259
1041	285	202
1042	286	90
1043	286	117
1044	286	44
1045	286	112
1046	286	168
1047	286	237
1048	286	206
1049	286	227
1050	286	147
1051	286	34
1052	287	101
1053	287	19
1054	287	190
1055	287	16
1056	287	108
1057	287	82
1058	287	270
1059	288	282
1060	288	74
1061	288	159
1062	288	272
1063	288	271
1064	288	205
1065	288	112
1066	288	44
1067	288	158
1068	288	253
1069	289	96
1070	289	243
1071	289	82
1072	289	145
1073	289	89
1074	289	225
1075	289	95
1076	289	221
1077	290	249
1078	290	73
1079	290	26
1080	291	287
1081	291	182
1082	291	9
1083	291	170
1084	291	189
1085	291	86
1086	291	238
1087	291	76
1088	291	94
1089	291	34
1090	292	130
1091	292	43
1092	293	27
1093	293	93
1094	293	77
1095	293	141
1096	293	171
1097	293	161
1098	294	267
1099	294	3
1100	294	225
1101	294	97
1102	294	226
1103	294	164
1104	295	162
1105	295	254
1106	295	133
1107	295	55
1108	295	258
1109	295	41
1110	296	130
1111	296	17
1112	296	253
1113	296	16
1114	297	189
1115	297	181
1116	297	105
1117	297	255
1118	298	241
1119	298	237
1120	298	68
1121	298	253
1122	298	206
1123	298	43
1124	298	278
1125	299	74
1126	300	160
1127	300	272
1128	300	95
1129	301	103
1130	301	21
1131	301	26
1132	302	229
1133	302	124
1134	302	288
1135	302	87
1136	302	258
1137	303	271
1138	303	150
1139	303	29
1140	303	199
1141	304	72
1142	304	77
1143	304	107
1144	304	33
1145	304	235
1146	305	287
1147	305	48
1148	305	172
1149	305	71
1150	305	177
1151	306	25
1152	306	57
1153	306	183
1154	306	35
1155	307	137
1156	307	220
1157	307	216
1158	307	162
1159	307	115
1160	307	35
1161	307	190
1162	307	228
1163	307	166
1164	308	81
1165	309	71
1166	309	228
1167	309	231
1168	309	239
1169	309	65
1170	309	23
1171	310	107
1172	310	275
1173	310	12
1174	310	153
1175	310	76
1176	310	131
1177	310	240
1178	310	187
1179	310	137
1180	311	130
1181	311	146
1182	312	148
1183	312	7
1184	312	71
1185	313	172
1186	313	180
1187	313	129
1188	313	60
1189	313	234
1190	313	198
1191	313	234
1192	313	56
1193	313	164
1194	314	108
1195	314	137
1196	314	112
1197	314	48
1198	314	146
1199	314	139
1200	314	28
1201	314	270
1202	315	177
1203	315	24
1204	315	42
1205	315	194
1206	315	147
1207	315	238
1208	315	23
1209	315	94
1210	315	183
1211	316	76
1212	316	144
1213	316	19
1214	317	10
1215	317	112
1216	317	235
1217	317	286
1218	318	226
1219	319	123
1220	319	256
1221	319	1
1222	319	111
1223	319	220
1224	320	177
1225	320	42
1226	320	131
1227	320	101
1228	320	73
1229	320	165
1230	320	223
1231	320	73
1232	320	72
1233	320	104
1234	321	269
1235	321	199
1236	322	116
1237	322	232
1238	322	218
1239	322	167
1240	322	288
1241	322	251
1242	323	254
1243	323	281
1244	323	50
1245	323	182
1246	323	144
1247	323	260
1248	323	261
1249	323	55
1250	324	272
1251	324	286
1252	324	114
1253	324	133
1254	324	172
1255	324	276
1256	324	19
1257	324	105
1258	324	47
1259	324	231
1260	325	137
1261	325	100
1262	325	52
1263	325	125
1264	325	188
1265	326	280
1266	326	169
1267	326	278
1268	326	182
1269	326	271
1270	326	195
1271	326	104
1272	326	258
1273	326	180
1274	327	117
1275	327	64
1276	327	182
1277	327	156
1278	327	31
1279	328	162
1280	328	120
1281	328	90
1282	328	144
1283	328	113
1284	329	160
1285	329	20
1286	329	264
1287	329	47
1288	329	21
1289	329	244
1290	329	184
1291	329	268
1292	329	174
1293	329	202
1294	330	34
1295	331	147
1296	331	6
1297	331	284
1298	331	182
1299	331	269
1300	331	220
1301	331	74
1302	331	242
1303	331	254
1304	332	39
1305	332	189
1306	332	60
1307	332	275
1308	332	273
1309	332	225
1310	332	256
1311	332	169
1312	332	245
1313	332	27
1314	333	176
1315	333	6
1316	333	284
1317	333	100
1318	333	121
1319	333	284
1320	333	166
1321	334	84
1322	334	32
1323	334	78
1324	335	60
1325	335	281
1326	335	13
1327	335	194
1328	335	245
1329	335	119
1330	336	1
1331	336	60
1332	336	253
1333	336	227
1334	336	60
1335	336	139
1336	336	39
1337	336	143
1338	337	274
1339	338	259
1340	338	97
1341	338	154
1342	338	203
1343	338	160
1344	338	118
1345	338	176
1346	338	273
1347	338	31
1348	338	151
1349	339	130
1350	340	221
1351	340	52
1352	340	234
1353	340	268
1354	340	239
1355	340	242
1356	340	199
1357	340	38
1358	340	11
1359	341	118
1360	341	238
1361	341	96
1362	341	178
1363	341	157
1364	341	112
1365	342	262
1366	342	90
1367	342	101
1368	342	253
1369	342	107
1370	342	53
1371	342	84
1372	342	111
1373	342	123
1374	343	103
1375	344	184
1376	344	102
1377	344	38
1378	344	201
1379	344	208
1380	344	79
1381	345	47
1382	345	151
1383	345	219
1384	345	4
1385	345	276
1386	345	7
1387	345	85
1388	345	186
1389	346	13
1390	346	129
1391	346	250
1392	346	224
1393	346	132
1394	346	132
1395	346	222
1396	346	97
1397	347	183
1398	347	252
1399	347	286
1400	347	244
1401	347	36
1402	347	84
1403	347	101
1404	347	136
1405	348	273
1406	348	94
1407	348	220
1408	348	87
1409	348	132
1410	348	44
1411	348	40
1412	348	42
1413	348	202
1414	348	69
1415	349	245
1416	349	278
1417	349	226
1418	349	170
1419	349	88
1420	350	221
1421	350	249
1422	350	232
1423	350	120
1424	350	234
1425	350	268
1426	350	67
1427	351	147
1428	352	27
1429	353	146
1430	353	269
1431	354	112
1432	355	224
1433	355	191
1434	355	220
1435	355	170
1436	355	62
1437	355	23
1438	356	69
1439	356	206
1440	356	184
1441	356	36
1442	356	265
1443	356	214
1444	356	236
1445	356	257
1446	356	202
1447	357	58
1448	357	177
1449	357	286
1450	357	112
1451	357	52
1452	358	31
1453	358	102
1454	358	114
1455	358	93
1456	358	3
1457	358	2
1458	358	280
1459	358	70
1460	359	58
1461	359	124
1462	359	174
1463	359	56
1464	359	238
1465	360	10
1466	360	188
1467	360	217
1468	360	230
1469	360	107
1470	360	262
1471	360	220
1472	360	91
1473	361	250
1474	361	75
1475	361	81
1476	361	64
1477	361	211
1478	361	59
1479	362	270
1480	362	5
1481	363	43
1482	364	20
1483	364	41
1484	364	158
1485	364	2
1486	364	116
1487	364	113
1488	364	67
1489	364	99
1490	364	283
1491	365	217
1492	366	226
1493	366	219
1494	366	214
1495	366	169
1496	366	252
1497	366	183
1498	367	1
1499	368	93
1500	368	256
1501	368	151
1502	368	10
1503	368	30
1504	368	145
1505	368	72
1506	369	80
1507	369	116
1508	369	89
1509	370	162
1510	370	75
1511	370	200
1512	370	251
1513	370	2
1514	371	175
1515	371	128
1516	371	212
1517	371	175
1518	371	117
1519	371	14
1520	372	65
1521	373	225
1522	373	106
1523	374	86
1524	374	154
1525	374	30
1526	374	234
1527	374	276
1528	374	241
1529	375	100
1530	375	267
1531	375	162
1532	375	129
1533	375	211
1534	375	117
1535	375	12
1536	375	139
1537	376	172
1538	377	43
1539	377	30
1540	377	30
1541	377	91
1542	377	29
1543	377	79
1544	377	198
1545	378	251
1546	378	190
1547	379	29
1548	379	274
1549	379	119
1550	379	46
1551	379	91
1552	379	147
1553	379	225
1554	379	78
1555	380	11
1556	380	267
1557	380	18
1558	381	184
1559	381	58
1560	381	64
1561	381	233
1562	381	196
1563	381	59
1564	382	151
1565	382	20
1566	382	241
1567	382	237
1568	382	108
1569	383	200
1570	383	214
1571	383	218
1572	383	38
1573	383	191
1574	383	171
1575	383	155
1576	383	68
1577	384	133
1578	384	107
1579	384	14
1580	384	54
1581	385	149
1582	385	216
1583	385	84
1584	385	137
1585	385	15
1586	385	252
1587	385	211
1588	385	11
1589	385	209
1590	386	139
1591	386	272
1592	386	238
1593	386	128
1594	386	64
1595	386	22
1596	387	166
1597	387	187
1598	387	86
1599	387	182
1600	387	203
1601	389	124
1602	389	62
1603	389	84
1604	389	59
1605	389	275
1606	389	243
1607	389	188
1608	389	61
1609	389	156
1610	389	145
1611	390	68
1612	390	223
1613	390	96
1614	390	200
1615	390	42
1616	390	180
1617	390	117
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, price) FROM stdin;
1	1	219	1	2048.68
2	1	111	1	3620.9
3	1	73	2	1107.02
4	2	288	3	2851.1
5	2	79	3	2292.12
6	2	171	3	1695.63
7	3	16	1	102.83
8	3	95	1	1494.05
9	4	27	3	1223.17
10	5	132	3	4779.91
11	5	18	3	4524.74
12	5	255	1	2843.93
13	5	127	2	4223.36
14	6	160	1	2070.69
15	6	61	2	909.56
16	6	64	1	2660.67
17	6	193	3	4213.62
18	7	131	1	2342.86
19	8	282	1	2425.15
20	9	122	1	2787.78
21	9	84	1	4234.55
22	9	125	2	4769.92
23	9	206	1	2378.11
24	10	259	2	2013.76
25	11	35	2	4477.11
26	11	76	2	4613.91
27	11	216	3	3336.09
28	12	83	3	4417.39
29	12	281	1	3478.07
30	12	94	2	1034.65
31	13	46	3	2636.92
32	13	149	1	291.03
33	13	101	2	3245.12
34	14	35	1	4477.11
35	14	85	1	1637.43
36	14	249	2	4366.54
37	15	171	3	1695.63
38	16	49	2	2244.16
39	16	150	1	4133.82
40	16	169	2	712.16
41	17	168	3	39.25
42	17	20	1	1328.6
43	17	263	2	283.98
44	17	163	2	2710.75
45	18	220	3	2654.61
46	18	237	1	2692.44
47	19	45	3	3291.46
48	19	265	3	2047.67
49	20	37	2	1864.21
50	20	211	3	4341.33
51	20	60	1	1815.93
52	20	185	3	409.7
53	21	121	2	2118.88
54	22	143	3	3191.91
55	23	13	1	3965.42
56	23	45	2	3291.46
57	23	276	1	4043.27
58	23	170	1	2730.72
59	24	54	2	1431.17
60	24	88	1	4844.03
61	24	92	1	412.91
62	25	10	2	620.57
63	26	89	3	236.47
64	27	247	3	1184.86
65	27	175	3	2039.09
66	28	190	3	639.28
67	29	259	2	2013.76
68	29	26	3	3588.62
69	29	8	2	697.97
70	29	166	2	4892.93
71	30	38	2	3644.69
72	30	23	3	1005.52
73	30	41	1	2604.51
74	30	75	1	2446.53
75	31	264	2	21.64
76	31	46	3	2636.92
77	31	54	2	1431.17
78	32	178	2	2463.95
79	32	189	3	249.23
80	33	144	3	1750.96
81	33	269	3	3157.69
82	33	133	2	4849.77
83	34	9	2	66.48
84	34	246	2	1498.73
85	34	25	3	2062.34
86	35	61	1	909.56
87	35	165	2	87.49
88	36	181	2	749.09
89	36	141	3	1955.22
90	36	240	1	2323.41
91	37	151	1	4403.59
92	37	80	3	3236.37
93	38	256	2	415.16
94	38	150	2	4133.82
95	38	226	2	756.45
96	38	276	1	4043.27
97	39	191	3	942.59
98	39	234	2	932.4
99	39	104	3	4433.01
100	40	86	2	436.57
101	40	210	1	250.03
102	40	213	3	3862.89
103	40	282	1	2425.15
104	41	257	3	1295.43
105	41	65	1	2587.37
106	41	152	3	1416.85
107	42	265	3	2047.67
108	42	286	1	4172.2
109	42	270	2	722.62
110	43	238	3	2976.41
111	43	218	3	893.42
112	43	83	1	4417.39
113	43	250	2	810.55
114	44	16	2	102.83
115	44	62	1	2224.13
116	44	221	1	3045.81
117	45	119	3	1689.99
118	45	104	3	4433.01
119	45	94	2	1034.65
120	46	214	1	4910.07
121	46	126	3	2497.8
122	46	160	2	2070.69
123	46	104	2	4433.01
124	47	100	3	3569.72
125	47	287	3	940.45
126	48	46	3	2636.92
127	48	108	2	600.5
128	48	169	2	712.16
129	48	230	2	4283.99
130	49	22	3	4690.3
131	49	6	3	2486.1
132	49	84	2	4234.55
133	49	192	3	2536.07
134	50	17	3	2190.17
135	51	213	1	3862.89
136	51	79	2	2292.12
137	51	277	3	1515.88
138	52	59	1	730.65
139	53	15	2	2025.71
140	53	3	3	2367.32
141	54	132	2	4779.91
142	55	274	3	1474.35
143	55	273	1	4085.21
144	55	23	1	1005.52
145	56	29	1	2462.95
146	57	202	1	3909
147	57	267	2	2103.51
148	57	173	2	4817.58
149	58	243	3	1559.6
150	59	229	3	98.01
151	59	262	2	4423.65
152	59	279	2	226.9
153	59	176	2	72.99
154	60	238	2	2976.41
155	60	86	2	436.57
156	60	75	1	2446.53
157	60	244	2	2920.97
158	61	253	3	951.68
159	61	50	1	1046.08
160	61	279	1	226.9
161	61	96	2	2212.98
162	62	7	3	266.7
163	62	270	1	722.62
164	63	30	2	3703.24
165	63	180	1	4230.62
166	64	28	1	181.41
167	64	166	1	4892.93
168	65	276	3	4043.27
169	65	116	1	331.25
170	65	16	1	102.83
171	66	26	3	3588.62
172	67	32	1	1240.3
173	67	214	2	4910.07
174	67	201	1	4623.06
175	67	121	1	2118.88
176	68	127	3	4223.36
177	69	162	2	1795.78
178	69	132	3	4779.91
179	69	95	2	1494.05
180	70	170	2	2730.72
181	71	93	2	1816.18
182	71	63	1	2959.82
183	71	157	3	1068.08
184	71	198	1	364.63
185	72	190	3	639.28
186	72	249	3	4366.54
187	72	196	1	4031.56
188	73	71	2	1326.14
189	73	123	1	60.63
190	73	115	2	1288.82
191	74	164	2	1658.82
192	74	244	3	2920.97
193	74	142	1	1631.1
194	75	278	2	490.65
195	76	275	3	4006.2
196	76	35	1	4477.11
197	77	113	2	454.29
198	77	199	1	3626.05
199	77	170	3	2730.72
200	78	53	1	4126.49
201	79	41	3	2604.51
202	79	272	2	1745.88
203	80	284	3	4127.8
204	80	231	1	2475.99
205	80	145	1	2385.13
206	81	13	1	3965.42
207	82	52	1	923.7
208	82	82	3	4318.55
209	82	171	3	1695.63
210	83	84	3	4234.55
211	83	5	1	141.82
212	84	99	3	2939.03
213	84	11	1	506.08
214	85	225	1	1270.52
215	85	112	3	4900.94
216	86	239	2	944.49
217	86	141	1	1955.22
218	87	133	2	4849.77
219	88	150	3	4133.82
220	88	98	1	4615.67
221	88	235	2	3594.23
222	89	94	2	1034.65
223	89	115	2	1288.82
224	90	184	1	2992.36
225	91	254	3	3633.59
226	91	213	1	3862.89
227	92	237	1	2692.44
228	92	49	1	2244.16
229	93	265	1	2047.67
230	94	233	3	4106
231	94	207	3	2636.95
232	94	225	2	1270.52
233	94	70	2	2042.86
234	95	260	3	862.56
235	95	38	3	3644.69
236	96	4	2	4444.26
237	97	105	3	3439.98
238	97	176	1	72.99
239	97	210	1	250.03
240	98	132	1	4779.91
241	99	83	3	4417.39
242	99	225	1	1270.52
243	100	57	3	2713.28
244	101	239	2	944.49
245	101	46	3	2636.92
246	101	183	3	4624.85
247	101	282	2	2425.15
248	102	190	2	639.28
249	103	264	2	21.64
250	103	131	1	2342.86
251	103	105	3	3439.98
252	104	169	1	712.16
253	104	44	1	1915.58
254	104	251	3	1805.2
255	105	77	2	79.66
256	105	43	3	2806.51
257	105	125	2	4769.92
258	105	16	2	102.83
259	106	30	1	3703.24
260	107	150	3	4133.82
261	107	200	1	2691.81
262	107	201	2	4623.06
263	107	161	3	1090.52
264	108	286	2	4172.2
265	108	73	1	1107.02
266	108	96	2	2212.98
267	108	203	3	2771.23
268	109	280	2	4981.15
269	110	74	3	3566.61
270	110	268	2	1236.3
271	110	286	2	4172.2
272	111	65	1	2587.37
273	111	44	2	1915.58
274	111	224	2	1331.69
275	111	239	1	944.49
276	112	248	1	4741.62
277	112	284	3	4127.8
278	113	8	1	697.97
279	113	107	2	1221.14
280	113	225	3	1270.52
281	114	203	3	2771.23
282	114	186	2	2565.65
283	114	223	3	1505.96
284	115	190	3	639.28
285	115	96	2	2212.98
286	115	265	1	2047.67
287	115	35	2	4477.11
288	116	281	3	3478.07
289	116	205	2	3433.63
290	116	243	1	1559.6
291	117	41	3	2604.51
292	117	13	1	3965.42
293	117	124	2	214.08
294	118	160	1	2070.69
295	118	227	1	578.23
296	118	165	2	87.49
297	118	68	1	762.99
298	119	133	3	4849.77
299	119	257	2	1295.43
300	119	282	1	2425.15
301	120	17	1	2190.17
302	120	77	3	79.66
303	120	264	1	21.64
304	121	51	1	3296.19
305	121	123	2	60.63
306	121	52	2	923.7
307	121	186	3	2565.65
308	122	47	1	3890.02
309	123	127	2	4223.36
310	123	46	3	2636.92
311	123	240	1	2323.41
312	124	2	2	966.11
313	124	246	1	1498.73
314	124	112	3	4900.94
315	125	91	3	4264.66
316	125	174	3	4487.95
317	126	137	2	2923.1
318	126	253	1	951.68
319	127	78	3	815.71
320	127	71	1	1326.14
321	127	232	3	3341
322	127	69	3	4969.99
323	128	77	3	79.66
324	129	87	1	1159.3
325	130	118	1	1653.35
326	130	224	1	1331.69
327	130	210	3	250.03
328	130	196	2	4031.56
329	131	218	3	893.42
330	132	68	2	762.99
331	132	45	1	3291.46
332	132	27	3	1223.17
333	132	217	2	2395.7
334	133	41	3	2604.51
335	133	108	3	600.5
336	133	10	3	620.57
337	133	118	2	1653.35
338	134	224	2	1331.69
339	134	227	1	578.23
340	134	76	3	4613.91
341	134	25	3	2062.34
342	135	37	3	1864.21
343	135	181	3	749.09
344	135	211	2	4341.33
345	135	201	2	4623.06
346	136	193	1	4213.62
347	137	239	2	944.49
348	137	6	3	2486.1
349	137	75	1	2446.53
350	137	131	1	2342.86
351	138	114	2	2910.44
352	138	155	2	775.75
353	138	255	2	2843.93
354	138	247	3	1184.86
355	139	144	2	1750.96
356	139	194	3	1093.18
357	139	103	2	2918.82
358	140	143	1	3191.91
359	140	166	1	4892.93
360	140	114	3	2910.44
361	140	160	3	2070.69
362	141	242	3	3059.6
363	141	75	3	2446.53
364	142	152	2	1416.85
365	143	64	3	2660.67
366	143	107	1	1221.14
367	144	35	3	4477.11
368	144	236	2	4146.5
369	144	133	2	4849.77
370	145	206	2	2378.11
371	146	278	2	490.65
372	146	277	3	1515.88
373	146	214	2	4910.07
374	147	222	1	3539.2
375	147	147	2	3349.79
376	148	33	3	2850.43
377	148	211	3	4341.33
378	149	168	3	39.25
379	149	139	1	778.6
380	149	61	3	909.56
381	149	148	2	4099.98
382	150	71	1	1326.14
383	151	18	3	4524.74
384	151	187	3	3396.6
385	152	172	3	2563.06
386	153	190	1	639.28
387	153	214	3	4910.07
388	154	147	1	3349.79
389	154	261	1	790.99
390	154	199	3	3626.05
391	154	169	2	712.16
392	155	250	2	810.55
393	155	136	1	2382.64
394	155	3	1	2367.32
395	156	24	3	4690.55
396	156	46	1	2636.92
397	157	31	2	1419.3
398	157	256	1	415.16
399	157	120	2	1195.36
400	158	97	1	2847.91
401	158	79	1	2292.12
402	159	243	3	1559.6
403	159	206	1	2378.11
404	160	272	2	1745.88
405	161	274	1	1474.35
406	161	62	3	2224.13
407	161	80	1	3236.37
408	161	265	2	2047.67
409	162	162	1	1795.78
410	162	6	2	2486.1
411	162	183	3	4624.85
412	163	171	2	1695.63
413	163	44	3	1915.58
414	163	168	1	39.25
415	164	56	3	3316.85
416	165	177	1	2242.63
417	165	173	3	4817.58
418	166	48	1	2145.74
419	166	148	1	4099.98
420	167	257	3	1295.43
421	168	209	3	234.45
422	168	247	2	1184.86
423	168	28	1	181.41
424	168	267	2	2103.51
425	169	237	2	2692.44
426	170	109	1	4505.02
427	170	20	2	1328.6
428	170	151	2	4403.59
429	171	1	3	191.33
430	171	168	1	39.25
431	171	78	1	815.71
432	171	138	3	1274.72
433	172	222	3	3539.2
434	172	119	3	1689.99
435	172	265	3	2047.67
436	173	221	1	3045.81
437	173	285	2	2333.4
438	174	249	3	4366.54
439	174	247	2	1184.86
440	175	94	2	1034.65
441	175	155	2	775.75
442	176	60	1	1815.93
443	176	269	3	3157.69
444	176	254	3	3633.59
445	177	114	1	2910.44
446	177	155	1	775.75
447	178	39	2	3209.83
448	178	143	3	3191.91
449	178	32	1	1240.3
450	178	272	3	1745.88
451	179	87	1	1159.3
452	179	73	2	1107.02
453	179	9	3	66.48
454	180	85	3	1637.43
455	181	37	2	1864.21
456	181	221	1	3045.81
457	181	148	3	4099.98
458	181	142	2	1631.1
459	182	181	1	749.09
460	182	245	3	1068.63
461	183	133	2	4849.77
462	184	267	3	2103.51
463	184	190	3	639.28
464	185	207	1	2636.95
465	185	179	3	3986.65
466	185	203	1	2771.23
467	185	97	1	2847.91
468	186	186	1	2565.65
469	186	249	3	4366.54
470	186	11	2	506.08
471	187	197	3	4694.81
472	188	191	1	942.59
473	188	26	3	3588.62
474	188	166	1	4892.93
475	188	11	1	506.08
476	189	82	3	4318.55
477	189	58	1	121.51
478	189	93	3	1816.18
479	190	184	2	2992.36
480	191	39	3	3209.83
481	191	87	3	1159.3
482	192	31	1	1419.3
483	192	199	3	3626.05
484	192	200	3	2691.81
485	193	280	3	4981.15
486	193	285	3	2333.4
487	194	156	1	3045.31
488	195	122	1	2787.78
489	195	185	1	409.7
490	195	167	1	1076.65
491	196	18	2	4524.74
492	196	100	3	3569.72
493	196	210	3	250.03
494	196	180	2	4230.62
495	197	147	2	3349.79
496	197	278	1	490.65
497	197	59	2	730.65
498	197	153	2	3962.38
499	198	104	2	4433.01
500	198	196	2	4031.56
501	199	194	3	1093.18
502	199	69	1	4969.99
503	199	28	2	181.41
504	200	119	2	1689.99
505	200	147	3	3349.79
506	200	79	1	2292.12
507	200	236	1	4146.5
508	201	221	1	3045.81
509	201	117	3	2915.46
510	202	166	2	4892.93
511	202	283	2	4667.36
512	203	196	1	4031.56
513	204	16	1	102.83
514	205	42	2	3790.97
515	205	200	3	2691.81
516	205	97	2	2847.91
517	205	27	1	1223.17
518	206	21	2	1379.26
519	206	14	1	4363.16
520	207	122	2	2787.78
521	207	236	2	4146.5
522	207	165	1	87.49
523	207	153	3	3962.38
524	208	85	2	1637.43
525	208	89	3	236.47
526	208	228	1	3835.09
527	208	266	3	4890.54
528	209	194	1	1093.18
529	210	89	1	236.47
530	211	214	2	4910.07
531	211	287	2	940.45
532	212	91	1	4264.66
533	213	170	3	2730.72
534	213	192	2	2536.07
535	213	142	2	1631.1
536	214	29	2	2462.95
537	214	18	3	4524.74
538	214	187	1	3396.6
539	214	279	1	226.9
540	215	11	3	506.08
541	216	110	3	1086.99
542	216	65	2	2587.37
543	217	135	2	40.1
544	217	215	1	1607.8
545	217	31	1	1419.3
546	218	286	2	4172.2
547	218	75	2	2446.53
548	219	276	1	4043.27
549	220	90	1	4688.22
550	220	52	2	923.7
551	220	256	2	415.16
552	221	140	2	687.7
553	221	230	3	4283.99
554	222	286	2	4172.2
555	222	74	3	3566.61
556	223	281	2	3478.07
557	223	222	2	3539.2
558	224	248	1	4741.62
559	224	37	3	1864.21
560	224	176	1	72.99
561	225	76	3	4613.91
562	226	23	3	1005.52
563	226	123	1	60.63
564	226	179	3	3986.65
565	226	239	3	944.49
566	227	136	1	2382.64
567	227	5	3	141.82
568	227	238	2	2976.41
569	228	15	3	2025.71
570	229	4	2	4444.26
571	229	18	3	4524.74
572	229	135	3	40.1
573	230	146	1	2941.2
574	231	122	3	2787.78
575	231	154	1	4068.96
576	232	42	2	3790.97
577	233	29	2	2462.95
578	234	196	2	4031.56
579	235	119	2	1689.99
580	235	276	3	4043.27
581	236	188	1	1609.19
582	236	276	2	4043.27
583	236	32	1	1240.3
584	237	152	2	1416.85
585	237	233	1	4106
586	238	190	2	639.28
587	239	11	3	506.08
588	239	159	2	701.89
589	240	213	2	3862.89
590	241	185	1	409.7
591	241	279	3	226.9
592	241	89	2	236.47
593	242	155	1	775.75
594	242	170	2	2730.72
595	242	239	3	944.49
596	242	142	1	1631.1
597	243	66	2	1503.95
598	243	260	3	862.56
599	243	202	2	3909
600	243	68	3	762.99
601	244	220	1	2654.61
602	244	113	2	454.29
603	244	153	2	3962.38
604	245	142	3	1631.1
605	246	39	3	3209.83
606	247	115	2	1288.82
607	248	193	1	4213.62
608	248	150	1	4133.82
609	248	94	1	1034.65
610	248	2	2	966.11
611	249	127	2	4223.36
612	250	44	2	1915.58
613	250	250	1	810.55
614	251	46	2	2636.92
615	251	86	3	436.57
616	251	14	3	4363.16
617	251	85	3	1637.43
618	252	177	2	2242.63
619	252	128	3	2505.19
620	252	116	3	331.25
621	252	178	3	2463.95
622	253	221	3	3045.81
623	253	117	3	2915.46
624	253	44	3	1915.58
625	253	202	2	3909
626	254	82	3	4318.55
627	254	163	3	2710.75
628	254	281	3	3478.07
629	255	280	1	4981.15
630	255	222	1	3539.2
631	255	269	2	3157.69
632	255	89	3	236.47
633	256	203	1	2771.23
634	257	131	3	2342.86
635	258	79	1	2292.12
636	258	154	1	4068.96
637	258	112	1	4900.94
638	258	242	1	3059.6
639	259	96	3	2212.98
640	260	224	1	1331.69
641	260	182	2	2508.73
642	260	14	2	4363.16
643	260	151	1	4403.59
644	261	179	3	3986.65
645	261	38	3	3644.69
646	261	11	1	506.08
647	262	170	3	2730.72
648	262	111	3	3620.9
649	262	159	3	701.89
650	262	263	2	283.98
651	263	90	3	4688.22
652	263	7	3	266.7
653	264	255	3	2843.93
654	264	94	2	1034.65
655	265	99	3	2939.03
656	266	231	3	2475.99
657	266	61	2	909.56
658	267	184	1	2992.36
659	267	288	2	2851.1
660	267	64	1	2660.67
661	268	245	2	1068.63
662	268	231	1	2475.99
663	269	6	1	2486.1
664	270	52	2	923.7
665	270	161	2	1090.52
666	271	60	3	1815.93
667	271	266	1	4890.54
668	271	221	2	3045.81
669	272	132	3	4779.91
670	272	6	3	2486.1
671	272	39	3	3209.83
672	273	163	3	2710.75
673	273	109	1	4505.02
674	273	67	3	1964.81
675	274	144	3	1750.96
676	274	277	3	1515.88
677	274	105	3	3439.98
678	275	93	3	1816.18
679	276	116	1	331.25
680	276	104	2	4433.01
681	277	123	1	60.63
682	277	273	2	4085.21
683	277	228	2	3835.09
684	277	251	2	1805.2
685	278	229	2	98.01
686	279	51	2	3296.19
687	280	54	2	1431.17
688	280	236	2	4146.5
689	281	47	2	3890.02
690	282	106	3	836.74
691	282	100	2	3569.72
692	283	251	2	1805.2
693	283	259	2	2013.76
694	283	40	2	858.05
695	283	63	3	2959.82
696	284	264	3	21.64
697	284	190	3	639.28
698	284	64	2	2660.67
699	285	71	1	1326.14
700	285	269	2	3157.69
701	285	261	1	790.99
702	286	50	3	1046.08
703	286	147	3	3349.79
704	286	179	2	3986.65
705	287	46	2	2636.92
706	287	283	1	4667.36
707	288	200	1	2691.81
708	288	48	1	2145.74
709	288	27	2	1223.17
710	289	189	3	249.23
711	290	81	3	4381.84
712	290	44	3	1915.58
713	290	85	3	1637.43
714	291	252	2	4401.02
715	291	144	1	1750.96
716	292	288	3	2851.1
717	292	173	3	4817.58
718	292	18	1	4524.74
719	293	64	2	2660.67
720	294	163	1	2710.75
721	295	190	3	639.28
722	295	171	1	1695.63
723	296	153	1	3962.38
724	296	96	3	2212.98
725	296	187	3	3396.6
726	296	183	2	4624.85
727	297	122	2	2787.78
728	297	185	2	409.7
729	297	256	2	415.16
730	298	263	3	283.98
731	298	107	2	1221.14
732	299	205	2	3433.63
733	299	117	3	2915.46
734	299	275	2	4006.2
735	300	200	1	2691.81
736	300	244	2	2920.97
737	300	16	1	102.83
738	300	27	3	1223.17
739	301	42	1	3790.97
740	302	287	3	940.45
741	302	50	3	1046.08
742	302	195	1	3424.4
743	303	50	2	1046.08
744	303	86	1	436.57
745	303	37	3	1864.21
746	303	40	3	858.05
747	304	276	3	4043.27
748	305	142	1	1631.1
749	305	263	1	283.98
750	305	255	3	2843.93
751	306	215	1	1607.8
752	307	57	3	2713.28
753	307	80	3	3236.37
754	307	71	2	1326.14
755	308	92	1	412.91
756	309	180	3	4230.62
757	309	252	2	4401.02
758	309	271	3	694.88
759	310	69	1	4969.99
760	311	208	2	2433.91
761	311	257	2	1295.43
762	311	251	1	1805.2
763	311	272	2	1745.88
764	312	73	1	1107.02
765	313	39	2	3209.83
766	313	38	2	3644.69
767	314	63	1	2959.82
768	315	276	2	4043.27
769	315	53	2	4126.49
770	315	101	3	3245.12
771	315	166	1	4892.93
772	316	182	2	2508.73
773	316	194	1	1093.18
774	316	104	3	4433.01
775	317	226	3	756.45
776	317	162	3	1795.78
777	318	161	3	1090.52
778	318	259	2	2013.76
779	319	52	3	923.7
780	319	144	1	1750.96
781	319	8	3	697.97
782	320	282	1	2425.15
783	321	261	1	790.99
784	321	52	3	923.7
785	321	74	1	3566.61
786	321	115	3	1288.82
787	322	181	3	749.09
788	322	243	2	1559.6
789	322	86	1	436.57
790	323	69	2	4969.99
791	323	175	3	2039.09
792	323	104	3	4433.01
793	323	253	3	951.68
794	324	101	2	3245.12
795	324	107	3	1221.14
796	325	43	2	2806.51
797	325	70	2	2042.86
798	325	217	1	2395.7
799	325	227	2	578.23
800	326	63	1	2959.82
801	326	163	3	2710.75
802	327	81	3	4381.84
803	327	37	1	1864.21
804	327	165	1	87.49
805	327	164	1	1658.82
806	328	113	2	454.29
807	328	173	2	4817.58
808	328	52	1	923.7
809	328	65	3	2587.37
810	329	83	1	4417.39
811	329	44	3	1915.58
812	329	134	1	2426.17
813	329	265	2	2047.67
814	330	52	3	923.7
815	330	58	3	121.51
816	331	71	3	1326.14
817	331	164	3	1658.82
818	331	24	1	4690.55
819	332	257	2	1295.43
820	332	150	3	4133.82
821	333	175	1	2039.09
822	334	220	1	2654.61
823	334	132	3	4779.91
824	334	280	2	4981.15
825	334	198	3	364.63
826	335	91	3	4264.66
827	335	120	1	1195.36
828	336	22	2	4690.3
829	337	244	3	2920.97
830	337	80	1	3236.37
831	337	269	1	3157.69
832	338	133	2	4849.77
833	338	57	3	2713.28
834	339	274	1	1474.35
835	339	265	2	2047.67
836	340	14	2	4363.16
837	340	223	3	1505.96
838	341	200	3	2691.81
839	341	286	3	4172.2
840	341	213	3	3862.89
841	341	194	3	1093.18
842	342	104	1	4433.01
843	342	165	1	87.49
844	343	86	3	436.57
845	343	8	1	697.97
846	343	145	3	2385.13
847	344	193	1	4213.62
848	344	167	1	1076.65
849	345	197	3	4694.81
850	346	213	1	3862.89
851	346	69	1	4969.99
852	347	158	2	3535
853	347	140	3	687.7
854	347	50	2	1046.08
855	347	63	1	2959.82
856	348	238	1	2976.41
857	348	283	2	4667.36
858	348	205	2	3433.63
859	348	90	2	4688.22
860	349	203	3	2771.23
861	349	86	2	436.57
862	349	123	1	60.63
863	349	218	2	893.42
864	350	169	3	712.16
865	350	281	2	3478.07
866	350	167	3	1076.65
867	350	145	1	2385.13
868	351	248	1	4741.62
869	351	164	2	1658.82
870	351	56	3	3316.85
871	351	107	1	1221.14
872	352	85	1	1637.43
873	352	57	2	2713.28
874	352	92	3	412.91
875	353	55	1	683.16
876	354	283	2	4667.36
877	354	15	3	2025.71
878	354	218	2	893.42
879	355	31	1	1419.3
880	355	190	2	639.28
881	355	89	2	236.47
882	356	167	2	1076.65
883	356	266	3	4890.54
884	357	83	3	4417.39
885	357	238	2	2976.41
886	357	120	1	1195.36
887	357	124	3	214.08
888	358	28	3	181.41
889	358	178	2	2463.95
890	359	72	2	2882.92
891	359	148	1	4099.98
892	359	186	1	2565.65
893	359	206	1	2378.11
894	360	177	2	2242.63
895	360	132	1	4779.91
896	360	66	3	1503.95
897	361	198	1	364.63
898	361	111	2	3620.9
899	362	239	3	944.49
900	363	173	2	4817.58
901	363	174	1	4487.95
902	363	275	1	4006.2
903	364	282	2	2425.15
904	364	177	2	2242.63
905	364	236	3	4146.5
906	365	255	3	2843.93
907	365	129	2	202.95
908	365	161	3	1090.52
909	365	274	2	1474.35
910	366	158	3	3535
911	366	36	2	1758.9
912	366	145	1	2385.13
913	366	212	3	4821.33
914	367	42	3	3790.97
915	367	48	1	2145.74
916	368	199	3	3626.05
917	368	191	3	942.59
918	369	29	3	2462.95
919	369	148	2	4099.98
920	369	202	2	3909
921	370	187	3	3396.6
922	370	181	3	749.09
923	370	179	3	3986.65
924	371	96	3	2212.98
925	371	7	3	266.7
926	372	81	3	4381.84
927	373	174	3	4487.95
928	373	181	2	749.09
929	373	72	1	2882.92
930	374	271	2	694.88
931	374	18	1	4524.74
932	374	103	1	2918.82
933	374	247	2	1184.86
934	375	132	2	4779.91
935	375	226	1	756.45
936	376	282	2	2425.15
937	376	107	3	1221.14
938	376	226	1	756.45
939	377	4	1	4444.26
940	377	60	2	1815.93
941	377	90	1	4688.22
942	377	73	1	1107.02
943	378	199	2	3626.05
944	379	29	1	2462.95
945	379	209	2	234.45
946	379	64	3	2660.67
947	379	105	3	3439.98
948	380	164	1	1658.82
949	380	21	1	1379.26
950	381	159	1	701.89
951	381	99	1	2939.03
952	381	95	1	1494.05
953	382	217	2	2395.7
954	382	282	1	2425.15
955	383	199	2	3626.05
956	383	124	2	214.08
957	384	78	3	815.71
958	385	245	3	1068.63
959	385	56	3	3316.85
960	385	27	2	1223.17
961	386	2	1	966.11
962	386	66	3	1503.95
963	387	276	3	4043.27
964	387	227	2	578.23
965	387	190	1	639.28
966	388	261	1	790.99
967	388	94	1	1034.65
968	388	80	3	3236.37
969	388	226	3	756.45
970	389	10	3	620.57
971	389	211	3	4341.33
972	390	178	1	2463.95
973	390	15	3	2025.71
974	391	86	2	436.57
975	391	106	2	836.74
976	391	28	3	181.41
977	391	58	2	121.51
978	392	87	2	1159.3
979	392	207	3	2636.95
980	392	87	1	1159.3
981	392	130	2	1198.9
982	393	116	2	331.25
983	393	225	1	1270.52
984	394	29	2	2462.95
985	394	165	2	87.49
986	395	213	2	3862.89
987	395	207	2	2636.95
988	395	275	1	4006.2
989	396	259	1	2013.76
990	396	42	2	3790.97
991	397	197	1	4694.81
992	397	126	2	2497.8
993	397	271	1	694.88
994	398	6	1	2486.1
995	398	25	3	2062.34
996	399	30	3	3703.24
997	399	101	2	3245.12
998	399	241	3	1157.85
999	399	25	1	2062.34
1000	400	205	3	3433.63
1001	400	6	3	2486.1
1002	400	105	1	3439.98
1003	400	181	3	749.09
1004	401	100	2	3569.72
1005	402	240	1	2323.41
1006	403	67	1	1964.81
1007	403	40	1	858.05
1008	404	89	2	236.47
1009	404	100	1	3569.72
1010	404	191	1	942.59
1011	405	172	2	2563.06
1012	405	3	3	2367.32
1013	405	272	3	1745.88
1014	406	209	2	234.45
1015	406	161	2	1090.52
1016	406	211	1	4341.33
1017	407	45	2	3291.46
1018	408	288	1	2851.1
1019	408	160	3	2070.69
1020	409	67	2	1964.81
1021	409	47	1	3890.02
1022	409	68	3	762.99
1023	410	260	3	862.56
1024	410	229	3	98.01
1025	410	175	1	2039.09
1026	410	144	1	1750.96
1027	411	92	3	412.91
1028	411	7	2	266.7
1029	411	221	2	3045.81
1030	412	113	1	454.29
1031	412	205	3	3433.63
1032	412	224	1	1331.69
1033	413	78	3	815.71
1034	413	158	3	3535
1035	414	137	1	2923.1
1036	414	200	3	2691.81
1037	415	133	1	4849.77
1038	415	18	3	4524.74
1039	416	30	2	3703.24
1040	416	274	2	1474.35
1041	416	67	3	1964.81
1042	416	150	3	4133.82
1043	417	138	3	1274.72
1044	418	285	2	2333.4
1045	418	238	3	2976.41
1046	418	44	1	1915.58
1047	419	75	1	2446.53
1048	420	206	2	2378.11
1049	420	19	1	568.33
1050	420	237	3	2692.44
1051	421	179	2	3986.65
1052	422	198	3	364.63
1053	422	86	1	436.57
1054	423	7	1	266.7
1055	424	177	1	2242.63
1056	425	287	1	940.45
1057	425	204	3	1610.65
1058	426	12	3	1101.5
1059	427	166	3	4892.93
1060	427	167	2	1076.65
1061	427	79	3	2292.12
1062	427	278	2	490.65
1063	428	267	2	2103.51
1064	429	248	2	4741.62
1065	429	257	1	1295.43
1066	429	48	2	2145.74
1067	430	105	2	3439.98
1068	430	263	3	283.98
1069	430	183	2	4624.85
1070	430	54	3	1431.17
1071	431	273	3	4085.21
1072	431	233	2	4106
1073	432	287	3	940.45
1074	432	92	3	412.91
1075	433	61	2	909.56
1076	434	260	1	862.56
1077	434	264	2	21.64
1078	434	277	3	1515.88
1079	434	111	2	3620.9
1080	435	136	1	2382.64
1081	435	116	3	331.25
1082	435	236	3	4146.5
1083	435	21	3	1379.26
1084	436	106	2	836.74
1085	436	147	2	3349.79
1086	437	144	1	1750.96
1087	438	269	3	3157.69
1088	439	189	1	249.23
1089	440	177	1	2242.63
1090	441	117	2	2915.46
1091	442	107	2	1221.14
1092	443	195	3	3424.4
1093	444	256	1	415.16
1094	444	277	1	1515.88
1095	444	2	2	966.11
1096	445	255	1	2843.93
1097	446	63	2	2959.82
1098	446	255	3	2843.93
1099	446	283	1	4667.36
1100	447	192	2	2536.07
1101	447	138	3	1274.72
1102	447	211	1	4341.33
1103	447	202	1	3909
1104	448	124	1	214.08
1105	448	148	2	4099.98
1106	448	105	3	3439.98
1107	448	167	1	1076.65
1108	449	174	2	4487.95
1109	449	177	2	2242.63
1110	449	106	1	836.74
1111	449	195	3	3424.4
1112	450	105	1	3439.98
1113	450	152	2	1416.85
1114	451	248	1	4741.62
1115	451	13	2	3965.42
1116	451	164	1	1658.82
1117	452	196	2	4031.56
1118	453	68	1	762.99
1119	453	244	2	2920.97
1120	453	84	1	4234.55
1121	453	131	1	2342.86
1122	454	280	2	4981.15
1123	454	56	2	3316.85
1124	455	89	3	236.47
1125	455	111	1	3620.9
1126	456	284	3	4127.8
1127	456	177	2	2242.63
1128	456	171	1	1695.63
1129	457	118	3	1653.35
1130	458	180	3	4230.62
1131	458	143	2	3191.91
1132	458	5	3	141.82
1133	459	162	3	1795.78
1134	460	84	3	4234.55
1135	461	141	1	1955.22
1136	461	122	1	2787.78
1137	461	108	1	600.5
1138	462	214	1	4910.07
1139	462	197	2	4694.81
1140	462	272	2	1745.88
1141	462	222	2	3539.2
1142	463	86	3	436.57
1143	463	44	2	1915.58
1144	464	201	3	4623.06
1145	464	235	3	3594.23
1146	465	265	2	2047.67
1147	466	128	1	2505.19
1148	466	50	3	1046.08
1149	467	238	1	2976.41
1150	467	165	1	87.49
1151	467	215	2	1607.8
1152	467	283	1	4667.36
1153	468	8	3	697.97
1154	468	67	2	1964.81
1155	468	256	2	415.16
1156	469	81	3	4381.84
1157	470	152	1	1416.85
1158	471	194	3	1093.18
1159	471	286	3	4172.2
1160	472	159	1	701.89
1161	473	272	3	1745.88
1162	474	184	3	2992.36
1163	474	162	3	1795.78
1164	474	139	3	778.6
1165	475	104	2	4433.01
1166	475	62	2	2224.13
1167	475	129	2	202.95
1168	476	217	2	2395.7
1169	476	136	3	2382.64
1170	477	90	2	4688.22
1171	477	60	2	1815.93
1172	477	251	3	1805.2
1173	478	124	2	214.08
1174	479	130	3	1198.9
1175	479	243	3	1559.6
1176	480	64	2	2660.67
1177	480	258	1	688.96
1178	480	63	1	2959.82
1179	480	103	1	2918.82
1180	481	218	3	893.42
1181	481	264	2	21.64
1182	481	53	1	4126.49
1183	481	231	2	2475.99
1184	482	96	2	2212.98
1185	482	117	2	2915.46
1186	482	62	3	2224.13
1187	483	217	2	2395.7
1188	484	201	2	4623.06
1189	485	43	1	2806.51
1190	486	281	3	3478.07
1191	486	229	1	98.01
1192	486	110	2	1086.99
1193	486	212	2	4821.33
1194	487	153	1	3962.38
1195	487	280	3	4981.15
1196	487	147	2	3349.79
1197	488	224	1	1331.69
1198	488	228	1	3835.09
1199	489	248	1	4741.62
1200	489	254	3	3633.59
1201	490	261	2	790.99
1202	490	278	3	490.65
1203	491	277	2	1515.88
1204	491	162	2	1795.78
1205	492	256	3	415.16
1206	492	176	3	72.99
1207	492	53	2	4126.49
1208	493	225	1	1270.52
1209	493	7	1	266.7
1210	493	23	3	1005.52
1211	494	155	1	775.75
1212	494	262	3	4423.65
1213	495	244	1	2920.97
1214	495	176	2	72.99
1215	496	72	2	2882.92
1216	496	24	3	4690.55
1217	497	48	2	2145.74
1218	498	283	3	4667.36
1219	498	218	3	893.42
1220	499	20	3	1328.6
1221	500	232	1	3341
1222	500	145	2	2385.13
1223	501	88	2	4844.03
1224	501	215	1	1607.8
1225	501	111	2	3620.9
1226	502	169	2	712.16
1227	502	91	2	4264.66
1228	502	236	1	4146.5
1229	502	94	1	1034.65
1230	503	109	3	4505.02
1231	503	63	2	2959.82
1232	504	187	3	3396.6
1233	504	61	3	909.56
1234	504	61	1	909.56
1235	505	101	3	3245.12
1236	505	39	1	3209.83
1237	505	77	1	79.66
1238	505	154	1	4068.96
1239	506	188	1	1609.19
1240	506	281	3	3478.07
1241	507	163	1	2710.75
1242	508	14	1	4363.16
1243	508	135	2	40.1
1244	508	61	3	909.56
1245	509	259	1	2013.76
1246	510	121	3	2118.88
1247	511	38	2	3644.69
1248	512	88	1	4844.03
1249	512	133	1	4849.77
1250	512	123	3	60.63
1251	512	62	3	2224.13
1252	513	284	2	4127.8
1253	513	215	1	1607.8
1254	513	190	2	639.28
1255	513	40	2	858.05
1256	514	75	1	2446.53
1257	514	284	1	4127.8
1258	514	251	2	1805.2
1259	514	57	1	2713.28
1260	515	254	2	3633.59
1261	516	99	2	2939.03
1262	516	140	3	687.7
1263	516	247	3	1184.86
1264	517	227	2	578.23
1265	518	59	1	730.65
1266	518	59	2	730.65
1267	519	30	1	3703.24
1268	519	134	3	2426.17
1269	520	22	1	4690.3
1270	521	145	1	2385.13
1271	521	56	2	3316.85
1272	521	80	1	3236.37
1273	522	204	1	1610.65
1274	522	71	3	1326.14
1275	522	144	3	1750.96
1276	522	85	2	1637.43
1277	523	21	2	1379.26
1278	524	270	3	722.62
1279	524	37	3	1864.21
1280	525	259	3	2013.76
1281	525	199	1	3626.05
1282	525	242	2	3059.6
1283	526	50	3	1046.08
1284	526	119	2	1689.99
1285	526	65	1	2587.37
1286	527	285	1	2333.4
1287	527	107	2	1221.14
1288	527	178	1	2463.95
1289	528	91	1	4264.66
1290	529	163	3	2710.75
1291	529	283	2	4667.36
1292	529	149	1	291.03
1293	530	140	1	687.7
1294	530	30	3	3703.24
1295	531	38	2	3644.69
1296	531	183	3	4624.85
1297	532	99	3	2939.03
1298	532	88	3	4844.03
1299	532	78	2	815.71
1300	533	207	2	2636.95
1301	534	84	1	4234.55
1302	535	73	1	1107.02
1303	535	7	2	266.7
1304	536	75	3	2446.53
1305	536	34	3	2318.62
1306	537	169	1	712.16
1307	537	280	2	4981.15
1308	537	268	2	1236.3
1309	538	198	3	364.63
1310	538	95	2	1494.05
1311	539	217	1	2395.7
1312	539	269	1	3157.69
1313	540	110	3	1086.99
1314	541	81	3	4381.84
1315	542	149	3	291.03
1316	542	106	1	836.74
1317	543	38	3	3644.69
1318	544	61	1	909.56
1319	544	196	3	4031.56
1320	544	198	3	364.63
1321	544	13	3	3965.42
1322	545	208	3	2433.91
1323	545	130	2	1198.9
1324	545	25	1	2062.34
1325	546	149	3	291.03
1326	546	253	2	951.68
1327	547	269	1	3157.69
1328	547	245	2	1068.63
1329	547	155	2	775.75
1330	548	1	1	191.33
1331	549	27	3	1223.17
1332	549	80	1	3236.37
1333	550	201	3	4623.06
1334	550	59	3	730.65
1335	551	86	1	436.57
1336	551	72	2	2882.92
1337	551	168	2	39.25
1338	552	155	3	775.75
1339	552	86	3	436.57
1340	552	199	3	3626.05
1341	552	213	3	3862.89
1342	553	9	2	66.48
1343	553	179	3	3986.65
1344	554	104	2	4433.01
1345	554	126	2	2497.8
1346	554	273	3	4085.21
1347	555	61	1	909.56
1348	555	156	3	3045.31
1349	556	37	1	1864.21
1350	556	15	3	2025.71
1351	556	68	2	762.99
1352	557	234	2	932.4
1353	557	171	2	1695.63
1354	557	252	3	4401.02
1355	557	180	1	4230.62
1356	558	80	3	3236.37
1357	559	267	2	2103.51
1358	560	166	2	4892.93
1359	561	210	3	250.03
1360	561	59	3	730.65
1361	561	260	3	862.56
1362	562	94	3	1034.65
1363	562	216	1	3336.09
1364	562	9	2	66.48
1365	562	191	1	942.59
1366	563	146	3	2941.2
1367	563	269	3	3157.69
1368	563	109	1	4505.02
1369	563	146	3	2941.2
1370	564	271	3	694.88
1371	564	24	2	4690.55
1372	565	219	3	2048.68
1373	565	73	1	1107.02
1374	565	76	2	4613.91
1375	565	274	1	1474.35
1376	566	44	1	1915.58
1377	566	49	3	2244.16
1378	566	182	2	2508.73
1379	566	159	1	701.89
1380	567	72	1	2882.92
1381	567	153	1	3962.38
1382	567	169	1	712.16
1383	568	91	2	4264.66
1384	569	166	3	4892.93
1385	570	35	2	4477.11
1386	571	77	1	79.66
1387	571	272	1	1745.88
1388	571	193	1	4213.62
1389	571	49	2	2244.16
1390	572	142	2	1631.1
1391	572	271	1	694.88
1392	572	81	2	4381.84
1393	572	226	1	756.45
1394	573	253	2	951.68
1395	573	62	2	2224.13
1396	573	226	1	756.45
1397	573	47	1	3890.02
1398	574	275	2	4006.2
1399	574	194	1	1093.18
1400	574	141	1	1955.22
1401	574	219	1	2048.68
1402	575	18	3	4524.74
1403	575	140	2	687.7
1404	576	112	3	4900.94
1405	577	59	3	730.65
1406	577	51	2	3296.19
1407	577	127	2	4223.36
1408	578	55	3	683.16
1409	579	39	3	3209.83
1410	580	118	3	1653.35
1411	580	205	3	3433.63
1412	580	186	1	2565.65
1413	581	253	2	951.68
1414	581	237	2	2692.44
1415	581	149	2	291.03
1416	582	59	3	730.65
1417	583	198	1	364.63
1418	583	263	1	283.98
1419	583	223	2	1505.96
1420	584	226	2	756.45
1421	584	86	3	436.57
1422	585	87	1	1159.3
1423	585	7	2	266.7
1424	585	107	1	1221.14
1425	586	143	3	3191.91
1426	586	257	1	1295.43
1427	586	246	2	1498.73
1428	586	255	1	2843.93
1429	587	106	2	836.74
1430	587	131	3	2342.86
1431	587	258	3	688.96
1432	587	120	3	1195.36
1433	588	171	2	1695.63
1434	588	38	3	3644.69
1435	588	100	2	3569.72
1436	588	83	1	4417.39
1437	589	137	3	2923.1
1438	589	15	3	2025.71
1439	589	223	2	1505.96
1440	589	19	3	568.33
1441	590	120	3	1195.36
1442	590	266	1	4890.54
1443	590	19	3	568.33
1444	590	5	3	141.82
1445	591	142	2	1631.1
1446	591	29	2	2462.95
1447	591	41	2	2604.51
1448	592	226	2	756.45
1449	592	241	1	1157.85
1450	593	119	1	1689.99
1451	593	65	2	2587.37
1452	593	209	2	234.45
1453	594	83	2	4417.39
1454	594	243	2	1559.6
1455	594	267	1	2103.51
1456	594	16	1	102.83
1457	595	198	2	364.63
1458	596	39	1	3209.83
1459	596	82	2	4318.55
1460	596	245	2	1068.63
1461	596	181	1	749.09
1462	597	264	2	21.64
1463	597	51	1	3296.19
1464	597	113	1	454.29
1465	598	233	1	4106
1466	598	114	2	2910.44
1467	598	87	3	1159.3
1468	599	239	1	944.49
1469	599	256	2	415.16
1470	600	190	2	639.28
1471	600	20	1	1328.6
1472	600	87	1	1159.3
1473	600	5	2	141.82
1474	601	94	2	1034.65
1475	601	267	3	2103.51
1476	602	251	1	1805.2
1477	602	233	2	4106
1478	602	138	3	1274.72
1479	603	183	3	4624.85
1480	603	173	3	4817.58
1481	603	175	2	2039.09
1482	603	58	3	121.51
1483	604	91	3	4264.66
1484	604	207	1	2636.95
1485	605	258	1	688.96
1486	605	103	3	2918.82
1487	606	149	2	291.03
1488	606	241	1	1157.85
1489	606	58	2	121.51
1490	607	87	1	1159.3
1491	607	166	1	4892.93
1492	608	254	3	3633.59
1493	609	93	3	1816.18
1494	610	176	2	72.99
1495	610	73	1	1107.02
1496	610	129	1	202.95
1497	610	203	2	2771.23
1498	611	20	3	1328.6
1499	611	110	3	1086.99
1500	611	174	3	4487.95
1501	611	281	2	3478.07
1502	612	58	3	121.51
1503	612	159	3	701.89
1504	613	99	2	2939.03
1505	613	241	2	1157.85
1506	613	261	3	790.99
1507	614	262	2	4423.65
1508	615	119	3	1689.99
1509	615	68	3	762.99
1510	615	106	2	836.74
1511	615	17	3	2190.17
1512	616	3	1	2367.32
1513	616	83	3	4417.39
1514	616	44	2	1915.58
1515	617	143	2	3191.91
1516	617	281	3	3478.07
1517	617	171	3	1695.63
1518	617	64	2	2660.67
1519	618	191	3	942.59
1520	618	158	3	3535
1521	619	272	3	1745.88
1522	620	225	3	1270.52
1523	620	28	3	181.41
1524	621	84	1	4234.55
1525	621	248	3	4741.62
1526	622	169	2	712.16
1527	622	32	1	1240.3
1528	623	228	3	3835.09
1529	623	10	1	620.57
1530	623	127	3	4223.36
1531	623	52	1	923.7
1532	624	152	1	1416.85
1533	624	107	2	1221.14
1534	625	256	3	415.16
1535	625	286	2	4172.2
1536	626	134	3	2426.17
1537	627	59	2	730.65
1538	628	70	2	2042.86
1539	628	101	3	3245.12
1540	628	25	1	2062.34
1541	628	5	2	141.82
1542	629	239	3	944.49
1543	629	85	3	1637.43
1544	629	288	3	2851.1
1545	629	235	2	3594.23
1546	630	86	3	436.57
1547	630	28	3	181.41
1548	630	11	1	506.08
1549	630	208	2	2433.91
1550	631	137	2	2923.1
1551	631	186	3	2565.65
1552	631	20	2	1328.6
1553	632	181	1	749.09
1554	632	178	2	2463.95
1555	632	126	1	2497.8
1556	633	73	2	1107.02
1557	633	224	3	1331.69
1558	633	112	2	4900.94
1559	633	103	2	2918.82
1560	634	200	3	2691.81
1561	634	286	1	4172.2
1562	635	219	1	2048.68
1563	635	199	2	3626.05
1564	636	212	2	4821.33
1565	636	56	3	3316.85
1566	637	255	2	2843.93
1567	638	3	3	2367.32
1568	638	35	2	4477.11
1569	638	146	2	2941.2
1570	638	257	2	1295.43
1571	639	252	3	4401.02
1572	640	286	3	4172.2
1573	640	102	1	2745.93
1574	640	132	2	4779.91
1575	641	146	1	2941.2
1576	641	17	1	2190.17
1577	641	17	1	2190.17
1578	642	101	1	3245.12
1579	643	11	3	506.08
1580	644	223	2	1505.96
1581	644	121	3	2118.88
1582	644	30	2	3703.24
1583	645	7	2	266.7
1584	646	149	2	291.03
1585	646	98	3	4615.67
1586	646	52	3	923.7
1587	647	263	2	283.98
1588	647	263	1	283.98
1589	648	278	3	490.65
1590	648	274	1	1474.35
1591	648	126	2	2497.8
1592	649	61	1	909.56
1593	649	85	2	1637.43
1594	649	68	2	762.99
1595	649	82	3	4318.55
1596	650	137	2	2923.1
1597	650	193	1	4213.62
1598	650	57	1	2713.28
1599	650	130	3	1198.9
1600	651	210	1	250.03
1601	651	137	2	2923.1
1602	651	146	1	2941.2
1603	652	31	3	1419.3
1604	652	178	2	2463.95
1605	652	120	1	1195.36
1606	652	127	3	4223.36
1607	653	111	2	3620.9
1608	653	9	3	66.48
1609	653	44	2	1915.58
1610	654	134	1	2426.17
1611	654	5	3	141.82
1612	655	54	1	1431.17
1613	656	207	1	2636.95
1614	656	283	2	4667.36
1615	656	6	2	2486.1
1616	657	237	3	2692.44
1617	657	151	2	4403.59
1618	657	229	1	98.01
1619	657	76	1	4613.91
1620	658	246	2	1498.73
1621	658	154	1	4068.96
1622	658	33	1	2850.43
1623	659	120	3	1195.36
1624	659	205	2	3433.63
1625	660	88	2	4844.03
1626	660	243	1	1559.6
1627	660	16	1	102.83
1628	660	55	1	683.16
1629	661	92	1	412.91
1630	661	25	3	2062.34
1631	661	164	3	1658.82
1632	662	201	1	4623.06
1633	662	185	1	409.7
1634	662	94	2	1034.65
1635	663	91	1	4264.66
1636	663	229	3	98.01
1637	663	191	3	942.59
1638	663	102	2	2745.93
1639	664	213	3	3862.89
1640	664	247	2	1184.86
1641	665	126	3	2497.8
1642	665	113	1	454.29
1643	665	92	2	412.91
1644	666	72	1	2882.92
1645	666	187	2	3396.6
1646	667	79	2	2292.12
1647	667	3	1	2367.32
1648	667	200	2	2691.81
1649	667	220	1	2654.61
1650	668	262	1	4423.65
1651	668	121	2	2118.88
1652	668	273	2	4085.21
1653	669	285	1	2333.4
1654	669	240	3	2323.41
1655	669	178	3	2463.95
1656	670	276	3	4043.27
1657	671	37	1	1864.21
1658	671	98	2	4615.67
1659	672	285	3	2333.4
1660	673	233	3	4106
1661	674	229	2	98.01
1662	674	29	1	2462.95
1663	674	205	1	3433.63
1664	674	109	1	4505.02
1665	675	261	3	790.99
1666	675	165	2	87.49
1667	675	212	1	4821.33
1668	675	11	1	506.08
1669	676	213	3	3862.89
1670	676	35	3	4477.11
1671	676	43	3	2806.51
1672	677	213	2	3862.89
1673	677	52	2	923.7
1674	677	170	2	2730.72
1675	677	187	3	3396.6
1676	678	19	1	568.33
1677	679	7	3	266.7
1678	679	66	3	1503.95
1679	680	86	3	436.57
1680	680	36	1	1758.9
1681	680	161	3	1090.52
1682	681	70	2	2042.86
1683	681	6	3	2486.1
1684	681	128	2	2505.19
1685	681	273	3	4085.21
1686	682	114	1	2910.44
1687	682	32	1	1240.3
1688	683	246	1	1498.73
1689	683	2	1	966.11
1690	683	136	1	2382.64
1691	684	264	2	21.64
1692	685	128	2	2505.19
1693	685	221	3	3045.81
1694	685	87	1	1159.3
1695	686	97	3	2847.91
1696	687	58	2	121.51
1697	687	85	2	1637.43
1698	687	46	3	2636.92
1699	688	144	2	1750.96
1700	688	145	3	2385.13
1701	688	98	3	4615.67
1702	689	33	2	2850.43
1703	689	116	1	331.25
1704	689	27	1	1223.17
1705	690	73	3	1107.02
1706	690	209	1	234.45
1707	691	42	1	3790.97
1708	691	161	2	1090.52
1709	691	230	3	4283.99
1710	691	201	3	4623.06
1711	692	147	2	3349.79
1712	692	219	2	2048.68
1713	692	57	1	2713.28
1714	692	100	3	3569.72
1715	693	162	3	1795.78
1716	694	202	3	3909
1717	694	1	3	191.33
1718	694	147	2	3349.79
1719	695	73	3	1107.02
1720	695	225	2	1270.52
1721	695	238	1	2976.41
1722	696	268	2	1236.3
1723	697	197	2	4694.81
1724	698	56	1	3316.85
1725	698	245	2	1068.63
1726	699	84	3	4234.55
1727	699	131	3	2342.86
1728	699	165	2	87.49
1729	699	94	2	1034.65
1730	700	143	1	3191.91
1731	701	132	2	4779.91
1732	701	71	2	1326.14
1733	701	216	2	3336.09
1734	702	179	2	3986.65
1735	702	77	3	79.66
1736	703	40	2	858.05
1737	703	87	2	1159.3
1738	703	95	3	1494.05
1739	704	14	2	4363.16
1740	705	219	2	2048.68
1741	706	260	1	862.56
1742	707	192	1	2536.07
1743	707	192	2	2536.07
1744	708	221	2	3045.81
1745	708	151	3	4403.59
1746	708	13	3	3965.42
1747	708	221	1	3045.81
1748	709	176	3	72.99
1749	709	223	1	1505.96
1750	710	25	2	2062.34
1751	710	220	2	2654.61
1752	710	159	3	701.89
1753	710	217	1	2395.7
1754	711	26	3	3588.62
1755	711	141	1	1955.22
1756	711	26	1	3588.62
1757	712	17	1	2190.17
1758	712	279	2	226.9
1759	713	236	2	4146.5
1760	713	19	2	568.33
1761	713	105	2	3439.98
1762	713	123	2	60.63
1763	714	117	3	2915.46
1764	714	153	1	3962.38
1765	715	203	1	2771.23
1766	716	77	2	79.66
1767	716	152	2	1416.85
1768	716	199	3	3626.05
1769	716	249	2	4366.54
1770	717	229	1	98.01
1771	718	237	2	2692.44
1772	718	62	2	2224.13
1773	718	217	2	2395.7
1774	718	234	1	932.4
1775	719	186	1	2565.65
1776	719	90	1	4688.22
1777	720	284	1	4127.8
1778	720	193	3	4213.62
1779	720	287	3	940.45
1780	721	81	1	4381.84
1781	721	26	3	3588.62
1782	721	40	2	858.05
1783	721	2	2	966.11
1784	722	106	2	836.74
1785	722	192	1	2536.07
1786	723	152	1	1416.85
1787	723	153	1	3962.38
1788	723	179	2	3986.65
1789	724	269	1	3157.69
1790	725	50	2	1046.08
1791	725	33	1	2850.43
1792	725	111	1	3620.9
1793	725	256	1	415.16
1794	726	230	3	4283.99
1795	726	141	3	1955.22
1796	726	247	3	1184.86
1797	727	191	2	942.59
1798	727	259	2	2013.76
1799	727	83	3	4417.39
1800	728	264	1	21.64
1801	728	40	3	858.05
1802	729	232	1	3341
1803	730	136	3	2382.64
1804	730	229	1	98.01
1805	730	52	1	923.7
1806	730	81	3	4381.84
1807	731	263	3	283.98
1808	731	239	1	944.49
1809	731	267	1	2103.51
1810	731	288	3	2851.1
1811	732	44	1	1915.58
1812	732	29	3	2462.95
1813	733	184	2	2992.36
1814	733	257	2	1295.43
1815	733	262	3	4423.65
1816	734	112	3	4900.94
1817	735	67	2	1964.81
1818	736	36	2	1758.9
1819	736	164	1	1658.82
1820	736	196	2	4031.56
1821	736	108	3	600.5
1822	737	67	2	1964.81
1823	738	245	2	1068.63
1824	738	173	1	4817.58
1825	738	47	3	3890.02
1826	738	118	3	1653.35
1827	739	248	2	4741.62
1828	739	282	2	2425.15
1829	739	94	2	1034.65
1830	740	25	1	2062.34
1831	740	126	2	2497.8
1832	740	197	3	4694.81
1833	741	87	2	1159.3
1834	741	11	1	506.08
1835	742	178	1	2463.95
1836	742	87	1	1159.3
1837	742	92	2	412.91
1838	742	140	1	687.7
1839	743	226	1	756.45
1840	743	128	3	2505.19
1841	743	106	2	836.74
1842	744	271	1	694.88
1843	744	116	3	331.25
1844	745	190	2	639.28
1845	745	131	3	2342.86
1846	745	87	3	1159.3
1847	746	162	2	1795.78
1848	746	127	3	4223.36
1849	747	43	1	2806.51
1850	748	74	1	3566.61
1851	748	25	1	2062.34
1852	749	253	3	951.68
1853	749	1	2	191.33
1854	750	181	3	749.09
1855	750	145	1	2385.13
1856	751	167	2	1076.65
1857	751	117	2	2915.46
1858	752	262	2	4423.65
1859	752	101	1	3245.12
1860	752	145	2	2385.13
1861	753	86	3	436.57
1862	753	22	3	4690.3
1863	754	89	1	236.47
1864	754	75	3	2446.53
1865	754	61	1	909.56
1866	754	85	3	1637.43
1867	755	215	2	1607.8
1868	755	129	3	202.95
1869	756	139	3	778.6
1870	756	66	3	1503.95
1871	756	277	3	1515.88
1872	756	28	2	181.41
1873	757	278	1	490.65
1874	758	279	3	226.9
1875	758	202	1	3909
1876	758	265	2	2047.67
1877	758	100	2	3569.72
1878	759	268	3	1236.3
1879	759	95	2	1494.05
1880	759	250	2	810.55
1881	759	192	3	2536.07
1882	760	73	3	1107.02
1883	760	64	1	2660.67
1884	760	64	3	2660.67
1885	760	81	3	4381.84
1886	761	192	1	2536.07
1887	761	196	1	4031.56
1888	761	178	1	2463.95
1889	762	269	1	3157.69
1890	762	215	1	1607.8
1891	762	26	1	3588.62
1892	762	72	1	2882.92
1893	763	280	2	4981.15
1894	764	177	3	2242.63
1895	764	21	2	1379.26
1896	765	72	2	2882.92
1897	765	19	3	568.33
1898	765	200	2	2691.81
1899	766	38	1	3644.69
1900	766	127	2	4223.36
1901	766	226	1	756.45
1902	766	119	1	1689.99
1903	767	119	1	1689.99
1904	767	229	3	98.01
1905	768	44	1	1915.58
1906	769	219	1	2048.68
1907	769	171	3	1695.63
1908	770	206	3	2378.11
1909	771	183	2	4624.85
1910	771	279	1	226.9
1911	771	40	3	858.05
1912	772	247	2	1184.86
1913	772	244	3	2920.97
1914	772	218	3	893.42
1915	772	206	3	2378.11
1916	773	261	2	790.99
1917	773	281	1	3478.07
1918	773	278	3	490.65
1919	774	212	1	4821.33
1920	774	255	2	2843.93
1921	775	42	2	3790.97
1922	775	217	2	2395.7
1923	775	260	3	862.56
1924	776	91	1	4264.66
1925	776	206	2	2378.11
1926	776	205	2	3433.63
1927	776	17	2	2190.17
1928	777	127	2	4223.36
1929	777	122	2	2787.78
1930	777	242	1	3059.6
1931	777	131	1	2342.86
1932	778	192	1	2536.07
1933	778	205	2	3433.63
1934	778	233	3	4106
1935	779	137	1	2923.1
1936	779	162	1	1795.78
1937	779	187	3	3396.6
1938	779	98	1	4615.67
1939	780	145	1	2385.13
1940	780	67	2	1964.81
1941	780	108	1	600.5
1942	780	74	3	3566.61
1943	781	214	2	4910.07
1944	781	53	3	4126.49
1945	782	44	1	1915.58
1946	783	41	3	2604.51
1947	784	142	3	1631.1
1948	784	57	2	2713.28
1949	785	43	1	2806.51
1950	785	258	1	688.96
1951	785	171	2	1695.63
1952	785	155	3	775.75
1953	786	42	2	3790.97
1954	786	126	1	2497.8
1955	786	109	2	4505.02
1956	786	199	3	3626.05
1957	787	144	2	1750.96
1958	788	141	2	1955.22
1959	788	48	3	2145.74
1960	788	146	2	2941.2
1961	788	64	3	2660.67
1962	789	50	3	1046.08
1963	790	111	1	3620.9
1964	790	193	3	4213.62
1965	791	163	1	2710.75
1966	792	195	1	3424.4
1967	792	92	1	412.91
1968	793	167	2	1076.65
1969	793	193	3	4213.62
1970	793	250	1	810.55
1971	793	209	3	234.45
1972	794	65	3	2587.37
1973	794	106	3	836.74
1974	794	9	2	66.48
1975	794	83	1	4417.39
1976	795	198	3	364.63
1977	796	101	2	3245.12
1978	797	5	2	141.82
1979	797	22	1	4690.3
1980	797	280	3	4981.15
1981	798	266	3	4890.54
1982	799	117	1	2915.46
1983	799	167	2	1076.65
1984	799	156	3	3045.31
1985	799	220	2	2654.61
1986	800	217	2	2395.7
1987	800	276	3	4043.27
1988	800	277	2	1515.88
1989	800	110	1	1086.99
1990	801	248	2	4741.62
1991	801	38	2	3644.69
1992	802	190	3	639.28
1993	802	120	1	1195.36
1994	802	210	2	250.03
1995	802	69	2	4969.99
1996	803	255	1	2843.93
1997	804	241	3	1157.85
1998	804	127	1	4223.36
1999	804	279	2	226.9
2000	805	223	3	1505.96
2001	805	230	1	4283.99
2002	805	61	3	909.56
2003	805	283	3	4667.36
2004	806	224	1	1331.69
2005	806	47	3	3890.02
2006	806	59	1	730.65
2007	807	96	3	2212.98
2008	807	231	3	2475.99
2009	807	269	1	3157.69
2010	808	117	3	2915.46
2011	808	208	1	2433.91
2012	808	72	3	2882.92
2013	809	148	1	4099.98
2014	809	223	2	1505.96
2015	810	47	1	3890.02
2016	810	232	1	3341
2017	810	259	2	2013.76
2018	811	204	3	1610.65
2019	811	170	1	2730.72
2020	811	196	2	4031.56
2021	811	157	1	1068.08
2022	812	197	2	4694.81
2023	812	209	2	234.45
2024	813	164	2	1658.82
2025	813	9	1	66.48
2026	814	83	2	4417.39
2027	814	217	2	2395.7
2028	815	217	3	2395.7
2029	815	91	2	4264.66
2030	815	100	1	3569.72
2031	815	149	2	291.03
2032	816	42	3	3790.97
2033	816	78	2	815.71
2034	817	41	2	2604.51
2035	818	217	2	2395.7
2036	818	242	1	3059.6
2037	818	156	3	3045.31
2038	818	266	1	4890.54
2039	819	76	3	4613.91
2040	819	120	3	1195.36
2041	820	132	1	4779.91
2042	821	57	1	2713.28
2043	821	114	3	2910.44
2044	821	106	3	836.74
2045	821	11	3	506.08
2046	822	52	2	923.7
2047	822	72	1	2882.92
2048	822	115	2	1288.82
2049	822	277	2	1515.88
2050	823	75	1	2446.53
2051	823	190	2	639.28
2052	823	148	3	4099.98
2053	823	101	3	3245.12
2054	824	166	1	4892.93
2055	824	114	1	2910.44
2056	825	16	1	102.83
2057	825	203	1	2771.23
2058	825	20	3	1328.6
2059	825	45	1	3291.46
2060	826	262	2	4423.65
2061	826	31	2	1419.3
2062	827	209	3	234.45
2063	828	286	3	4172.2
2064	829	47	3	3890.02
2065	830	192	3	2536.07
2066	831	5	1	141.82
2067	831	209	1	234.45
2068	832	223	2	1505.96
2069	832	201	1	4623.06
2070	832	8	3	697.97
2071	833	39	2	3209.83
2072	833	234	2	932.4
2073	833	108	3	600.5
2074	834	201	1	4623.06
2075	834	252	3	4401.02
2076	834	88	1	4844.03
2077	835	157	3	1068.08
2078	835	230	1	4283.99
2079	835	142	1	1631.1
2080	835	274	1	1474.35
2081	836	12	1	1101.5
2082	836	59	1	730.65
2083	836	168	1	39.25
2084	836	213	1	3862.89
2085	837	238	3	2976.41
2086	837	177	1	2242.63
2087	837	175	2	2039.09
2088	837	211	1	4341.33
2089	838	259	3	2013.76
2090	838	220	2	2654.61
2091	839	104	1	4433.01
2092	840	169	2	712.16
2093	840	233	1	4106
2094	840	165	2	87.49
2095	841	81	3	4381.84
2096	841	286	3	4172.2
2097	842	93	3	1816.18
2098	842	27	1	1223.17
2099	843	230	2	4283.99
2100	843	111	2	3620.9
2101	843	136	3	2382.64
2102	844	123	1	60.63
2103	844	137	1	2923.1
2104	844	261	3	790.99
2105	845	88	1	4844.03
2106	846	192	1	2536.07
2107	846	197	1	4694.81
2108	847	261	2	790.99
2109	847	195	2	3424.4
2110	847	238	1	2976.41
2111	847	260	2	862.56
2112	848	117	3	2915.46
2113	848	164	3	1658.82
2114	848	232	3	3341
2115	848	265	2	2047.67
2116	849	17	2	2190.17
2117	849	281	2	3478.07
2118	849	207	1	2636.95
2119	849	47	2	3890.02
2120	850	218	1	893.42
2121	850	194	1	1093.18
2122	851	120	2	1195.36
2123	851	63	1	2959.82
2124	851	63	1	2959.82
2125	851	254	3	3633.59
2126	852	131	2	2342.86
2127	852	160	1	2070.69
2128	852	159	3	701.89
2129	852	186	3	2565.65
2130	853	11	1	506.08
2131	853	37	3	1864.21
2132	854	268	3	1236.3
2133	854	134	3	2426.17
2134	854	25	1	2062.34
2135	855	79	3	2292.12
2136	855	1	1	191.33
2137	856	223	1	1505.96
2138	856	186	2	2565.65
2139	856	106	2	836.74
2140	857	186	2	2565.65
2141	857	236	2	4146.5
2142	858	164	2	1658.82
2143	858	209	1	234.45
2144	858	13	2	3965.42
2145	858	157	2	1068.08
2146	859	279	2	226.9
2147	859	116	1	331.25
2148	860	121	2	2118.88
2149	860	212	1	4821.33
2150	860	193	1	4213.62
2151	860	27	2	1223.17
2152	861	246	3	1498.73
2153	862	256	3	415.16
2154	862	214	3	4910.07
2155	862	18	1	4524.74
2156	863	235	2	3594.23
2157	863	282	1	2425.15
2158	863	69	2	4969.99
2159	863	144	1	1750.96
2160	864	122	3	2787.78
2161	864	173	1	4817.58
2162	864	149	3	291.03
2163	864	156	3	3045.31
2164	865	265	1	2047.67
2165	865	206	3	2378.11
2166	865	172	3	2563.06
2167	866	251	3	1805.2
2168	866	50	3	1046.08
2169	867	120	2	1195.36
2170	867	263	2	283.98
2171	867	276	2	4043.27
2172	867	2	3	966.11
2173	868	155	3	775.75
2174	869	22	1	4690.3
2175	869	264	1	21.64
2176	869	162	1	1795.78
2177	870	138	2	1274.72
2178	870	202	3	3909
2179	870	125	2	4769.92
2180	871	207	3	2636.95
2181	872	277	3	1515.88
2182	872	30	2	3703.24
2183	872	272	1	1745.88
2184	873	18	1	4524.74
2185	873	130	2	1198.9
2186	873	138	3	1274.72
2187	873	153	2	3962.38
2188	874	61	1	909.56
2189	874	265	3	2047.67
2190	875	41	3	2604.51
2191	875	32	3	1240.3
2192	876	228	1	3835.09
2193	877	35	2	4477.11
2194	877	9	3	66.48
2195	878	104	2	4433.01
2196	878	239	1	944.49
2197	878	150	3	4133.82
2198	879	32	2	1240.3
2199	879	67	2	1964.81
2200	880	23	3	1005.52
2201	881	161	2	1090.52
2202	882	262	2	4423.65
2203	882	85	3	1637.43
2204	882	220	3	2654.61
2205	882	270	3	722.62
2206	883	261	1	790.99
2207	884	84	3	4234.55
2208	885	156	1	3045.31
2209	886	44	3	1915.58
2210	886	96	2	2212.98
2211	886	216	3	3336.09
2212	887	14	2	4363.16
2213	887	147	2	3349.79
2214	887	235	2	3594.23
2215	888	117	1	2915.46
2216	888	198	3	364.63
2217	888	251	1	1805.2
2218	889	56	3	3316.85
2219	889	104	2	4433.01
2220	889	205	1	3433.63
2221	889	28	2	181.41
2222	890	44	1	1915.58
2223	890	47	2	3890.02
2224	890	155	2	775.75
2225	891	149	1	291.03
2226	891	79	3	2292.12
2227	891	159	2	701.89
2228	892	254	1	3633.59
2229	892	11	2	506.08
2230	892	54	1	1431.17
2231	892	119	2	1689.99
2232	893	253	1	951.68
2233	893	65	2	2587.37
2234	894	48	1	2145.74
2235	895	235	2	3594.23
2236	895	70	1	2042.86
2237	895	58	2	121.51
2238	895	124	3	214.08
2239	896	242	2	3059.6
2240	896	29	2	2462.95
2241	896	35	3	4477.11
2242	896	143	1	3191.91
2243	897	35	1	4477.11
2244	898	28	1	181.41
2245	899	207	2	2636.95
2246	899	83	3	4417.39
2247	899	204	1	1610.65
2248	900	3	1	2367.32
2249	900	38	2	3644.69
2250	900	68	3	762.99
2251	900	186	2	2565.65
2252	901	187	2	3396.6
2253	901	12	1	1101.5
2254	901	246	3	1498.73
2255	902	50	1	1046.08
2256	902	20	1	1328.6
2257	902	214	3	4910.07
2258	902	12	1	1101.5
2259	903	112	3	4900.94
2260	903	180	3	4230.62
2261	903	288	1	2851.1
2262	904	267	1	2103.51
2263	904	280	3	4981.15
2264	904	5	3	141.82
2265	904	171	2	1695.63
2266	905	21	2	1379.26
2267	906	122	1	2787.78
2268	906	131	3	2342.86
2269	906	256	3	415.16
2270	906	88	2	4844.03
2271	907	153	3	3962.38
2272	907	8	3	697.97
2273	907	212	3	4821.33
2274	907	14	2	4363.16
2275	908	39	1	3209.83
2276	909	198	2	364.63
2277	909	250	3	810.55
2278	909	230	2	4283.99
2279	909	27	3	1223.17
2280	910	221	2	3045.81
2281	910	163	1	2710.75
2282	910	264	1	21.64
2283	910	210	2	250.03
2284	911	52	3	923.7
2285	911	69	1	4969.99
2286	911	33	1	2850.43
2287	912	53	1	4126.49
2288	913	287	2	940.45
2289	913	174	1	4487.95
2290	913	160	2	2070.69
2291	914	98	2	4615.67
2292	914	246	2	1498.73
2293	914	21	1	1379.26
2294	914	64	3	2660.67
2295	915	71	2	1326.14
2296	916	141	3	1955.22
2297	916	59	3	730.65
2298	916	1	1	191.33
2299	916	85	2	1637.43
2300	917	168	2	39.25
2301	917	234	3	932.4
2302	917	241	2	1157.85
2303	917	129	2	202.95
2304	918	44	1	1915.58
2305	918	153	2	3962.38
2306	918	167	1	1076.65
2307	919	228	3	3835.09
2308	919	40	3	858.05
2309	919	87	3	1159.3
2310	920	156	1	3045.31
2311	920	276	2	4043.27
2312	920	208	1	2433.91
2313	921	283	2	4667.36
2314	921	283	1	4667.36
2315	921	53	3	4126.49
2316	921	236	1	4146.5
2317	922	111	3	3620.9
2318	922	210	2	250.03
2319	922	213	1	3862.89
2320	922	142	3	1631.1
2321	923	125	3	4769.92
2322	923	156	2	3045.31
2323	923	67	1	1964.81
2324	924	180	1	4230.62
2325	924	52	2	923.7
2326	924	39	2	3209.83
2327	925	151	3	4403.59
2328	925	27	1	1223.17
2329	926	25	3	2062.34
2330	926	86	1	436.57
2331	926	71	2	1326.14
2332	927	26	1	3588.62
2333	927	176	2	72.99
2334	928	243	1	1559.6
2335	928	68	2	762.99
2336	928	254	2	3633.59
2337	928	125	1	4769.92
2338	929	32	3	1240.3
2339	929	152	3	1416.85
2340	929	217	2	2395.7
2341	930	251	2	1805.2
2342	930	198	3	364.63
2343	931	95	2	1494.05
2344	931	31	2	1419.3
2345	931	181	2	749.09
2346	931	113	1	454.29
2347	932	188	3	1609.19
2348	932	167	1	1076.65
2349	933	30	3	3703.24
2350	933	256	2	415.16
2351	933	235	3	3594.23
2352	934	49	1	2244.16
2353	934	17	2	2190.17
2354	934	114	3	2910.44
2355	935	46	3	2636.92
2356	935	252	2	4401.02
2357	935	254	2	3633.59
2358	936	36	1	1758.9
2359	936	67	3	1964.81
2360	936	47	1	3890.02
2361	936	97	2	2847.91
2362	937	58	2	121.51
2363	937	101	1	3245.12
2364	937	251	1	1805.2
2365	937	198	3	364.63
2366	938	44	3	1915.58
2367	938	219	1	2048.68
2368	939	244	3	2920.97
2369	939	83	2	4417.39
2370	939	282	1	2425.15
2371	939	37	3	1864.21
2372	940	33	1	2850.43
2373	941	171	2	1695.63
2374	941	53	3	4126.49
2375	942	91	2	4264.66
2376	942	147	1	3349.79
2377	942	278	3	490.65
2378	942	159	2	701.89
2379	943	11	1	506.08
2380	943	73	2	1107.02
2381	943	116	3	331.25
2382	944	33	3	2850.43
2383	945	283	3	4667.36
2384	945	8	1	697.97
2385	946	53	3	4126.49
2386	946	70	3	2042.86
2387	947	113	3	454.29
2388	948	277	2	1515.88
2389	949	174	1	4487.95
2390	949	208	1	2433.91
2391	949	39	1	3209.83
2392	950	262	3	4423.65
2393	950	137	3	2923.1
2394	950	249	3	4366.54
2395	951	131	2	2342.86
2396	951	126	2	2497.8
2397	951	287	3	940.45
2398	952	61	2	909.56
2399	953	190	3	639.28
2400	953	206	2	2378.11
2401	953	271	3	694.88
2402	953	184	2	2992.36
2403	954	151	2	4403.59
2404	954	62	3	2224.13
2405	954	133	1	4849.77
2406	954	51	1	3296.19
2407	955	107	1	1221.14
2408	956	11	3	506.08
2409	956	94	3	1034.65
2410	957	180	2	4230.62
2411	957	281	2	3478.07
2412	958	117	3	2915.46
2413	959	98	3	4615.67
2414	960	237	1	2692.44
2415	960	247	1	1184.86
2416	960	51	3	3296.19
2417	961	65	1	2587.37
2418	962	232	2	3341
2419	962	212	3	4821.33
2420	962	152	3	1416.85
2421	962	272	3	1745.88
2422	963	95	3	1494.05
2423	963	18	1	4524.74
2424	964	113	3	454.29
2425	964	191	2	942.59
2426	964	64	1	2660.67
2427	964	149	1	291.03
2428	965	34	2	2318.62
2429	965	160	1	2070.69
2430	965	166	2	4892.93
2431	965	69	1	4969.99
2432	966	57	1	2713.28
2433	966	280	2	4981.15
2434	966	227	2	578.23
2435	966	56	3	3316.85
2436	967	286	3	4172.2
2437	967	43	1	2806.51
2438	967	171	2	1695.63
2439	968	196	3	4031.56
2440	969	107	3	1221.14
2441	970	4	1	4444.26
2442	970	24	3	4690.55
2443	970	159	1	701.89
2444	971	10	2	620.57
2445	972	133	3	4849.77
2446	973	63	1	2959.82
2447	973	63	1	2959.82
2448	974	208	2	2433.91
2449	974	284	3	4127.8
2450	975	75	3	2446.53
2451	975	150	1	4133.82
2452	976	242	2	3059.6
2453	976	283	3	4667.36
2454	976	186	2	2565.65
2455	976	216	1	3336.09
2456	977	16	1	102.83
2457	977	190	1	639.28
2458	977	207	3	2636.95
2459	977	124	3	214.08
2460	978	158	2	3535
2461	978	279	3	226.9
2462	978	53	3	4126.49
2463	979	220	3	2654.61
2464	980	105	1	3439.98
2465	980	181	1	749.09
2466	981	63	2	2959.82
2467	982	39	1	3209.83
2468	982	158	2	3535
2469	982	251	1	1805.2
2470	982	69	3	4969.99
2471	983	269	1	3157.69
2472	983	98	1	4615.67
2473	983	198	3	364.63
2474	984	64	3	2660.67
2475	984	56	2	3316.85
2476	985	43	3	2806.51
2477	985	75	3	2446.53
2478	985	163	2	2710.75
2479	985	50	3	1046.08
2480	986	117	1	2915.46
2481	986	172	2	2563.06
2482	986	272	1	1745.88
2483	986	61	2	909.56
2484	987	175	3	2039.09
2485	988	170	3	2730.72
2486	988	95	2	1494.05
2487	988	32	1	1240.3
2488	989	225	1	1270.52
2489	989	213	2	3862.89
2490	989	76	3	4613.91
2491	989	59	2	730.65
2492	990	19	2	568.33
2493	990	71	3	1326.14
2494	991	258	3	688.96
2495	991	64	1	2660.67
2496	991	83	1	4417.39
2497	991	33	3	2850.43
2498	992	11	1	506.08
2499	992	259	2	2013.76
2500	992	73	2	1107.02
2501	992	157	2	1068.08
2502	993	149	3	291.03
2503	993	52	3	923.7
2504	994	92	1	412.91
2505	995	116	2	331.25
2506	995	229	3	98.01
2507	996	115	2	1288.82
2508	996	111	3	3620.9
2509	996	88	2	4844.03
2510	996	282	3	2425.15
2511	997	276	3	4043.27
2512	998	70	1	2042.86
2513	998	283	3	4667.36
2514	998	44	3	1915.58
2515	998	248	1	4741.62
2516	999	5	2	141.82
2517	999	68	1	762.99
2518	1000	124	2	214.08
2519	1001	56	3	3316.85
2520	1001	146	2	2941.2
2521	1001	74	3	3566.61
2522	1002	101	3	3245.12
2523	1002	58	1	121.51
2524	1002	60	2	1815.93
2525	1002	247	1	1184.86
2526	1003	246	2	1498.73
2527	1003	103	1	2918.82
2528	1004	70	3	2042.86
2529	1004	66	1	1503.95
2530	1004	222	1	3539.2
2531	1004	221	2	3045.81
2532	1005	211	1	4341.33
2533	1005	89	3	236.47
2534	1005	53	2	4126.49
2535	1005	114	1	2910.44
2536	1006	136	1	2382.64
2537	1006	106	3	836.74
2538	1006	15	3	2025.71
2539	1006	38	1	3644.69
2540	1007	157	3	1068.08
2541	1007	83	2	4417.39
2542	1007	134	2	2426.17
2543	1007	152	3	1416.85
2544	1008	51	2	3296.19
2545	1009	231	3	2475.99
2546	1009	217	1	2395.7
2547	1010	260	3	862.56
2548	1010	105	1	3439.98
2549	1010	19	2	568.33
2550	1010	139	1	778.6
2551	1011	122	3	2787.78
2552	1011	182	1	2508.73
2553	1011	247	2	1184.86
2554	1011	164	2	1658.82
2555	1012	16	1	102.83
2556	1012	209	1	234.45
2557	1012	111	3	3620.9
2558	1012	177	3	2242.63
2559	1013	186	2	2565.65
2560	1013	214	2	4910.07
2561	1013	136	2	2382.64
2562	1014	49	1	2244.16
2563	1015	93	3	1816.18
2564	1015	79	3	2292.12
2565	1015	128	2	2505.19
2566	1015	151	2	4403.59
2567	1016	16	2	102.83
2568	1017	247	1	1184.86
2569	1017	281	2	3478.07
2570	1017	240	1	2323.41
2571	1018	224	2	1331.69
2572	1018	117	3	2915.46
2573	1019	184	1	2992.36
2574	1019	34	2	2318.62
2575	1019	156	3	3045.31
2576	1020	34	3	2318.62
2577	1021	210	3	250.03
2578	1022	227	2	578.23
2579	1022	233	1	4106
2580	1023	1	3	191.33
2581	1023	117	1	2915.46
2582	1023	140	2	687.7
2583	1023	6	1	2486.1
2584	1024	89	3	236.47
2585	1024	254	1	3633.59
2586	1024	252	3	4401.02
2587	1025	151	3	4403.59
2588	1025	107	1	1221.14
2589	1025	113	3	454.29
2590	1026	124	2	214.08
2591	1026	92	1	412.91
2592	1027	238	1	2976.41
2593	1027	30	2	3703.24
2594	1027	70	3	2042.86
2595	1028	272	1	1745.88
2596	1029	27	3	1223.17
2597	1030	114	1	2910.44
2598	1031	150	3	4133.82
2599	1031	12	2	1101.5
2600	1031	108	3	600.5
2601	1032	245	1	1068.63
2602	1033	14	2	4363.16
2603	1033	283	3	4667.36
2604	1033	38	2	3644.69
2605	1034	247	3	1184.86
2606	1035	59	1	730.65
2607	1035	143	1	3191.91
2608	1036	22	1	4690.3
2609	1037	80	3	3236.37
2610	1037	44	1	1915.58
2611	1037	43	2	2806.51
2612	1038	12	3	1101.5
2613	1038	27	1	1223.17
2614	1038	286	3	4172.2
2615	1038	13	3	3965.42
2616	1039	212	3	4821.33
2617	1040	115	2	1288.82
2618	1040	113	1	454.29
2619	1040	118	3	1653.35
2620	1040	42	3	3790.97
2621	1041	66	3	1503.95
2622	1042	26	3	3588.62
2623	1043	30	2	3703.24
2624	1044	180	2	4230.62
2625	1044	246	3	1498.73
2626	1044	142	3	1631.1
2627	1044	12	3	1101.5
2628	1045	76	2	4613.91
2629	1046	160	3	2070.69
2630	1046	112	1	4900.94
2631	1046	71	1	1326.14
2632	1047	246	2	1498.73
2633	1047	108	3	600.5
2634	1048	229	1	98.01
2635	1048	8	2	697.97
2636	1048	210	2	250.03
2637	1048	41	3	2604.51
2638	1049	224	3	1331.69
2639	1049	274	3	1474.35
2640	1049	233	1	4106
2641	1050	113	2	454.29
2642	1051	130	3	1198.9
2643	1051	224	2	1331.69
2644	1051	23	3	1005.52
2645	1051	287	1	940.45
2646	1052	217	2	2395.7
2647	1052	82	1	4318.55
2648	1053	179	3	3986.65
2649	1053	200	2	2691.81
2650	1053	14	2	4363.16
2651	1054	64	2	2660.67
2652	1054	138	2	1274.72
2653	1054	69	1	4969.99
2654	1054	173	3	4817.58
2655	1055	261	1	790.99
2656	1056	215	2	1607.8
2657	1056	146	1	2941.2
2658	1056	177	1	2242.63
2659	1057	206	1	2378.11
2660	1058	98	3	4615.67
2661	1058	1	1	191.33
2662	1059	7	2	266.7
2663	1059	183	3	4624.85
2664	1059	71	2	1326.14
2665	1059	3	3	2367.32
2666	1060	13	3	3965.42
2667	1061	43	2	2806.51
2668	1061	247	2	1184.86
2669	1061	115	3	1288.82
2670	1062	135	2	40.1
2671	1062	184	1	2992.36
2672	1062	222	2	3539.2
2673	1063	118	2	1653.35
2674	1063	280	2	4981.15
2675	1063	53	3	4126.49
2676	1064	45	3	3291.46
2677	1064	155	1	775.75
2678	1064	45	3	3291.46
2679	1064	230	1	4283.99
2680	1065	45	3	3291.46
2681	1065	276	3	4043.27
2682	1065	256	1	415.16
2683	1065	99	1	2939.03
2684	1066	165	3	87.49
2685	1066	59	1	730.65
2686	1066	210	2	250.03
2687	1066	178	2	2463.95
2688	1067	283	2	4667.36
2689	1067	138	3	1274.72
2690	1067	139	3	778.6
2691	1067	227	2	578.23
2692	1068	56	3	3316.85
2693	1068	47	1	3890.02
2694	1068	141	1	1955.22
2695	1068	47	1	3890.02
2696	1069	29	2	2462.95
2697	1069	260	1	862.56
2698	1070	94	1	1034.65
2699	1071	221	1	3045.81
2700	1072	80	2	3236.37
2701	1072	229	1	98.01
2702	1072	28	2	181.41
2703	1072	242	1	3059.6
2704	1073	228	3	3835.09
2705	1074	78	2	815.71
2706	1074	87	2	1159.3
2707	1075	202	3	3909
2708	1075	256	3	415.16
2709	1076	245	1	1068.63
2710	1076	163	3	2710.75
2711	1077	159	1	701.89
2712	1078	245	1	1068.63
2713	1079	176	2	72.99
2714	1079	5	3	141.82
2715	1080	241	3	1157.85
2716	1080	81	3	4381.84
2717	1081	178	2	2463.95
2718	1081	222	3	3539.2
2719	1082	72	1	2882.92
2720	1082	267	2	2103.51
2721	1083	88	3	4844.03
2722	1084	203	3	2771.23
2723	1084	141	3	1955.22
2724	1085	83	1	4417.39
2725	1085	104	1	4433.01
2726	1085	131	3	2342.86
2727	1085	140	1	687.7
2728	1086	62	2	2224.13
2729	1087	53	3	4126.49
2730	1088	283	1	4667.36
2731	1089	154	1	4068.96
2732	1089	239	3	944.49
2733	1090	8	3	697.97
2734	1090	46	2	2636.92
2735	1091	65	2	2587.37
2736	1092	158	1	3535
2737	1092	170	3	2730.72
2738	1093	213	3	3862.89
2739	1093	98	2	4615.67
2740	1094	157	1	1068.08
2741	1095	188	2	1609.19
2742	1096	35	2	4477.11
2743	1096	98	2	4615.67
2744	1096	156	1	3045.31
2745	1097	3	2	2367.32
2746	1097	82	2	4318.55
2747	1098	48	1	2145.74
2748	1098	141	2	1955.22
2749	1099	164	2	1658.82
2750	1099	124	3	214.08
2751	1099	167	2	1076.65
2752	1099	18	2	4524.74
2753	1100	6	1	2486.1
2754	1101	191	2	942.59
2755	1102	47	2	3890.02
2756	1102	59	3	730.65
2757	1102	159	3	701.89
2758	1102	266	3	4890.54
2759	1103	276	1	4043.27
2760	1103	264	3	21.64
2761	1103	238	3	2976.41
2762	1103	135	3	40.1
2763	1104	16	3	102.83
2764	1104	36	2	1758.9
2765	1104	1	1	191.33
2766	1104	12	2	1101.5
2767	1105	15	2	2025.71
2768	1105	47	3	3890.02
2769	1105	245	1	1068.63
2770	1105	8	2	697.97
2771	1106	273	2	4085.21
2772	1106	114	2	2910.44
2773	1106	110	2	1086.99
2774	1107	103	3	2918.82
2775	1107	54	2	1431.17
2776	1107	260	3	862.56
2777	1108	19	1	568.33
2778	1109	67	2	1964.81
2779	1109	82	2	4318.55
2780	1109	164	3	1658.82
2781	1109	102	1	2745.93
2782	1110	187	2	3396.6
2783	1110	203	1	2771.23
2784	1110	279	3	226.9
2785	1111	201	3	4623.06
2786	1111	254	2	3633.59
2787	1111	150	3	4133.82
2788	1112	246	1	1498.73
2789	1112	7	3	266.7
2790	1112	58	3	121.51
2791	1112	83	3	4417.39
2792	1113	113	2	454.29
2793	1113	146	3	2941.2
2794	1114	238	2	2976.41
2795	1114	62	3	2224.13
2796	1115	39	1	3209.83
2797	1115	261	2	790.99
2798	1115	216	1	3336.09
2799	1115	279	1	226.9
2800	1116	110	3	1086.99
2801	1116	19	1	568.33
2802	1116	286	3	4172.2
2803	1116	203	1	2771.23
2804	1117	133	2	4849.77
2805	1117	156	3	3045.31
2806	1118	257	2	1295.43
2807	1118	255	1	2843.93
2808	1118	140	2	687.7
2809	1118	83	3	4417.39
2810	1119	151	3	4403.59
2811	1119	9	2	66.48
2812	1120	95	2	1494.05
2813	1120	229	1	98.01
2814	1121	210	3	250.03
2815	1121	18	3	4524.74
2816	1121	172	2	2563.06
2817	1121	268	2	1236.3
2818	1122	168	1	39.25
2819	1123	117	2	2915.46
2820	1124	93	1	1816.18
2821	1124	124	2	214.08
2822	1124	186	1	2565.65
2823	1125	70	2	2042.86
2824	1125	14	3	4363.16
2825	1126	168	3	39.25
2826	1127	25	1	2062.34
2827	1127	31	3	1419.3
2828	1128	253	3	951.68
2829	1128	15	2	2025.71
2830	1128	219	2	2048.68
2831	1129	6	3	2486.1
2832	1129	7	1	266.7
2833	1130	167	2	1076.65
2834	1130	257	3	1295.43
2835	1130	119	2	1689.99
2836	1130	177	2	2242.63
2837	1131	115	3	1288.82
2838	1131	111	3	3620.9
2839	1132	228	2	3835.09
2840	1132	70	3	2042.86
2841	1133	59	1	730.65
2842	1133	101	1	3245.12
2843	1134	183	2	4624.85
2844	1134	131	2	2342.86
2845	1135	235	3	3594.23
2846	1135	112	1	4900.94
2847	1135	205	3	3433.63
2848	1135	123	3	60.63
2849	1136	150	3	4133.82
2850	1137	4	1	4444.26
2851	1137	88	2	4844.03
2852	1137	259	2	2013.76
2853	1138	172	2	2563.06
2854	1138	152	3	1416.85
2855	1138	258	2	688.96
2856	1138	278	1	490.65
2857	1139	267	1	2103.51
2858	1140	59	1	730.65
2859	1140	282	3	2425.15
2860	1141	153	2	3962.38
2861	1142	215	1	1607.8
2862	1143	50	1	1046.08
2863	1143	158	1	3535
2864	1143	170	1	2730.72
2865	1144	279	2	226.9
2866	1144	154	3	4068.96
2867	1145	181	1	749.09
2868	1145	271	1	694.88
2869	1145	170	3	2730.72
2870	1145	263	2	283.98
2871	1146	99	2	2939.03
2872	1147	162	3	1795.78
2873	1148	222	2	3539.2
2874	1148	153	3	3962.38
2875	1149	181	1	749.09
2876	1149	225	2	1270.52
2877	1149	211	3	4341.33
2878	1149	219	2	2048.68
2879	1150	60	2	1815.93
2880	1150	209	1	234.45
2881	1150	156	1	3045.31
2882	1150	108	2	600.5
2883	1151	285	2	2333.4
2884	1151	127	1	4223.36
2885	1151	237	1	2692.44
2886	1151	208	2	2433.91
2887	1152	135	2	40.1
2888	1152	63	1	2959.82
2889	1153	82	1	4318.55
2890	1153	76	3	4613.91
2891	1153	63	2	2959.82
2892	1153	56	1	3316.85
2893	1154	30	1	3703.24
2894	1154	243	2	1559.6
2895	1154	45	1	3291.46
2896	1154	170	1	2730.72
2897	1155	91	2	4264.66
2898	1155	206	3	2378.11
2899	1155	173	2	4817.58
2900	1155	219	3	2048.68
2901	1156	189	2	249.23
2902	1156	49	3	2244.16
2903	1157	190	3	639.28
2904	1157	240	1	2323.41
2905	1158	86	3	436.57
2906	1159	244	1	2920.97
2907	1159	72	3	2882.92
2908	1159	133	2	4849.77
2909	1159	105	2	3439.98
2910	1160	182	1	2508.73
2911	1160	122	1	2787.78
2912	1160	200	2	2691.81
2913	1161	194	2	1093.18
2914	1161	4	3	4444.26
2915	1162	11	3	506.08
2916	1162	227	1	578.23
2917	1162	269	1	3157.69
2918	1162	121	1	2118.88
2919	1163	215	3	1607.8
2920	1163	191	2	942.59
2921	1164	225	1	1270.52
2922	1164	170	3	2730.72
2923	1164	57	1	2713.28
2924	1165	102	2	2745.93
2925	1165	265	2	2047.67
2926	1165	239	2	944.49
2927	1165	36	3	1758.9
2928	1166	113	3	454.29
2929	1166	138	3	1274.72
2930	1166	260	2	862.56
2931	1167	137	1	2923.1
2932	1167	258	3	688.96
2933	1167	168	3	39.25
2934	1168	26	1	3588.62
2935	1168	18	2	4524.74
2936	1169	104	1	4433.01
2937	1169	259	2	2013.76
2938	1169	109	2	4505.02
2939	1170	75	2	2446.53
2940	1170	198	3	364.63
2941	1171	95	3	1494.05
2942	1172	241	3	1157.85
2943	1172	269	1	3157.69
2944	1172	107	3	1221.14
2945	1173	91	2	4264.66
2946	1173	120	2	1195.36
2947	1174	288	1	2851.1
2948	1174	3	2	2367.32
2949	1174	263	3	283.98
2950	1174	1	2	191.33
2951	1175	263	3	283.98
2952	1176	197	2	4694.81
2953	1176	210	1	250.03
2954	1177	242	2	3059.6
2955	1177	128	3	2505.19
2956	1177	136	3	2382.64
2957	1177	6	3	2486.1
2958	1178	229	2	98.01
2959	1178	193	3	4213.62
2960	1179	281	1	3478.07
2961	1179	254	2	3633.59
2962	1179	96	1	2212.98
2963	1179	255	2	2843.93
2964	1180	102	1	2745.93
2965	1180	233	3	4106
2966	1180	5	1	141.82
2967	1180	119	1	1689.99
2968	1181	161	2	1090.52
2969	1181	221	3	3045.81
2970	1182	192	2	2536.07
2971	1182	50	3	1046.08
2972	1183	161	3	1090.52
2973	1183	85	1	1637.43
2974	1183	18	2	4524.74
2975	1184	145	2	2385.13
2976	1184	138	1	1274.72
2977	1184	178	1	2463.95
2978	1185	215	2	1607.8
2979	1185	55	3	683.16
2980	1185	221	1	3045.81
2981	1186	279	2	226.9
2982	1187	34	3	2318.62
2983	1187	157	2	1068.08
2984	1187	67	3	1964.81
2985	1188	96	1	2212.98
2986	1188	126	2	2497.8
2987	1189	61	3	909.56
2988	1189	90	2	4688.22
2989	1190	146	2	2941.2
2990	1190	288	3	2851.1
2991	1191	4	2	4444.26
2992	1191	35	3	4477.11
2993	1191	186	1	2565.65
2994	1191	69	3	4969.99
2995	1192	194	1	1093.18
2996	1192	192	1	2536.07
2997	1192	253	2	951.68
2998	1192	255	1	2843.93
2999	1193	117	1	2915.46
3000	1193	257	1	1295.43
3001	1194	4	1	4444.26
3002	1194	131	1	2342.86
3003	1194	149	2	291.03
3004	1195	208	3	2433.91
3005	1195	286	2	4172.2
3006	1195	28	1	181.41
3007	1195	123	3	60.63
3008	1196	182	2	2508.73
3009	1197	152	1	1416.85
3010	1197	139	3	778.6
3011	1198	185	1	409.7
3012	1198	85	1	1637.43
3013	1198	212	2	4821.33
3014	1199	26	2	3588.62
3015	1199	200	3	2691.81
3016	1200	113	1	454.29
3017	1200	123	3	60.63
3018	1200	241	3	1157.85
3019	1200	210	3	250.03
3020	1201	39	1	3209.83
3021	1202	27	1	1223.17
3022	1202	121	1	2118.88
3023	1202	47	1	3890.02
3024	1203	259	1	2013.76
3025	1204	258	1	688.96
3026	1205	230	1	4283.99
3027	1205	16	3	102.83
3028	1205	47	1	3890.02
3029	1205	238	3	2976.41
3030	1206	262	1	4423.65
3031	1207	166	1	4892.93
3032	1207	112	3	4900.94
3033	1207	85	1	1637.43
3034	1207	57	3	2713.28
3035	1208	157	2	1068.08
3036	1208	173	2	4817.58
3037	1209	55	1	683.16
3038	1210	237	3	2692.44
3039	1211	220	3	2654.61
3040	1211	227	2	578.23
3041	1211	268	3	1236.3
3042	1212	273	3	4085.21
3043	1213	71	2	1326.14
3044	1213	191	2	942.59
3045	1213	73	2	1107.02
3046	1214	170	2	2730.72
3047	1214	44	1	1915.58
3048	1215	80	2	3236.37
3049	1216	90	3	4688.22
3050	1216	136	2	2382.64
3051	1216	129	1	202.95
3052	1216	149	1	291.03
3053	1217	101	2	3245.12
3054	1218	272	2	1745.88
3055	1219	218	2	893.42
3056	1219	38	1	3644.69
3057	1219	10	1	620.57
3058	1219	182	1	2508.73
3059	1220	141	1	1955.22
3060	1220	29	1	2462.95
3061	1220	262	2	4423.65
3062	1220	259	2	2013.76
3063	1221	44	2	1915.58
3064	1222	224	2	1331.69
3065	1222	176	1	72.99
3066	1222	64	2	2660.67
3067	1223	192	1	2536.07
3068	1223	63	2	2959.82
3069	1224	154	3	4068.96
3070	1224	202	2	3909
3071	1225	69	3	4969.99
3072	1225	198	2	364.63
3073	1225	139	3	778.6
3074	1225	217	1	2395.7
3075	1226	237	2	2692.44
3076	1226	117	1	2915.46
3077	1226	221	1	3045.81
3078	1227	201	1	4623.06
3079	1227	222	3	3539.2
3080	1227	207	3	2636.95
3081	1227	168	1	39.25
3082	1228	235	2	3594.23
3083	1228	181	2	749.09
3084	1228	261	2	790.99
3085	1229	216	2	3336.09
3086	1230	178	1	2463.95
3087	1231	22	3	4690.3
3088	1232	23	1	1005.52
3089	1233	264	2	21.64
3090	1233	3	3	2367.32
3091	1233	116	2	331.25
3092	1234	76	3	4613.91
3093	1234	253	1	951.68
3094	1234	111	3	3620.9
3095	1235	117	3	2915.46
3096	1235	72	1	2882.92
3097	1236	63	3	2959.82
3098	1236	185	1	409.7
3099	1236	112	3	4900.94
3100	1236	79	3	2292.12
3101	1237	112	1	4900.94
3102	1237	197	2	4694.81
3103	1237	162	2	1795.78
3104	1237	243	3	1559.6
3105	1238	59	2	730.65
3106	1238	149	2	291.03
3107	1239	141	2	1955.22
3108	1239	213	1	3862.89
3109	1240	60	2	1815.93
3110	1240	107	1	1221.14
3111	1241	112	3	4900.94
3112	1241	186	2	2565.65
3113	1242	20	3	1328.6
3114	1242	212	1	4821.33
3115	1242	49	2	2244.16
3116	1243	64	3	2660.67
3117	1243	14	3	4363.16
3118	1243	19	1	568.33
3119	1243	229	1	98.01
3120	1244	6	2	2486.1
3121	1244	133	3	4849.77
3122	1244	114	1	2910.44
3123	1244	5	3	141.82
3124	1245	191	2	942.59
3125	1245	21	1	1379.26
3126	1245	287	1	940.45
3127	1246	2	3	966.11
3128	1247	131	3	2342.86
3129	1247	64	2	2660.67
3130	1247	113	3	454.29
3131	1248	47	2	3890.02
3132	1248	74	2	3566.61
3133	1249	231	2	2475.99
3134	1249	126	2	2497.8
3135	1249	208	1	2433.91
3136	1250	109	1	4505.02
3137	1250	268	3	1236.3
3138	1251	105	1	3439.98
3139	1252	50	2	1046.08
3140	1252	120	1	1195.36
3141	1252	96	2	2212.98
3142	1253	175	1	2039.09
3143	1253	125	2	4769.92
3144	1254	161	3	1090.52
3145	1255	156	1	3045.31
3146	1255	101	2	3245.12
3147	1255	70	3	2042.86
3148	1255	124	1	214.08
3149	1256	276	2	4043.27
3150	1256	238	2	2976.41
3151	1256	27	1	1223.17
3152	1256	125	2	4769.92
3153	1257	172	2	2563.06
3154	1257	174	1	4487.95
3155	1258	47	3	3890.02
3156	1258	255	3	2843.93
3157	1258	175	3	2039.09
3158	1259	151	1	4403.59
3159	1259	116	1	331.25
3160	1260	211	1	4341.33
3161	1260	34	1	2318.62
3162	1260	177	3	2242.63
3163	1260	23	2	1005.52
3164	1261	84	3	4234.55
3165	1262	81	2	4381.84
3166	1262	23	2	1005.52
3167	1262	243	1	1559.6
3168	1262	236	2	4146.5
3169	1263	145	3	2385.13
3170	1264	235	1	3594.23
3171	1265	5	2	141.82
3172	1266	251	1	1805.2
3173	1266	74	2	3566.61
3174	1267	17	1	2190.17
3175	1268	219	2	2048.68
3176	1268	30	1	3703.24
3177	1268	187	2	3396.6
3178	1268	260	1	862.56
3179	1269	77	1	79.66
3180	1269	273	3	4085.21
3181	1270	199	1	3626.05
3182	1270	168	1	39.25
3183	1271	18	3	4524.74
3184	1271	23	2	1005.52
3185	1272	287	2	940.45
3186	1273	128	1	2505.19
3187	1273	6	3	2486.1
3188	1273	185	3	409.7
3189	1273	93	1	1816.18
3190	1274	109	2	4505.02
3191	1274	264	3	21.64
3192	1275	85	1	1637.43
3193	1276	168	2	39.25
3194	1276	99	3	2939.03
3195	1276	140	1	687.7
3196	1276	121	2	2118.88
3197	1277	234	1	932.4
3198	1277	276	3	4043.27
3199	1278	33	2	2850.43
3200	1278	58	1	121.51
3201	1278	227	2	578.23
3202	1279	136	1	2382.64
3203	1279	218	3	893.42
3204	1280	233	1	4106
3205	1280	154	1	4068.96
3206	1280	168	2	39.25
3207	1280	179	3	3986.65
3208	1281	191	1	942.59
3209	1281	198	2	364.63
3210	1282	95	3	1494.05
3211	1282	86	2	436.57
3212	1282	202	2	3909
3213	1283	169	3	712.16
3214	1283	37	3	1864.21
3215	1284	129	1	202.95
3216	1284	250	3	810.55
3217	1284	3	3	2367.32
3218	1284	85	3	1637.43
3219	1285	85	1	1637.43
3220	1285	35	1	4477.11
3221	1286	202	1	3909
3222	1286	201	2	4623.06
3223	1286	267	3	2103.51
3224	1286	136	3	2382.64
3225	1287	84	3	4234.55
3226	1287	32	2	1240.3
3227	1287	230	3	4283.99
3228	1288	214	3	4910.07
3229	1289	25	2	2062.34
3230	1289	238	1	2976.41
3231	1289	78	3	815.71
3232	1289	69	3	4969.99
3233	1290	95	3	1494.05
3234	1290	169	2	712.16
3235	1290	173	1	4817.58
3236	1291	149	2	291.03
3237	1291	275	2	4006.2
3238	1291	97	3	2847.91
3239	1292	230	3	4283.99
3240	1292	271	3	694.88
3241	1292	190	1	639.28
3242	1293	168	3	39.25
3243	1294	213	2	3862.89
3244	1294	256	1	415.16
3245	1295	275	3	4006.2
3246	1295	170	2	2730.72
3247	1295	85	1	1637.43
3248	1295	148	2	4099.98
3249	1296	174	3	4487.95
3250	1296	198	2	364.63
3251	1296	102	3	2745.93
3252	1296	115	1	1288.82
3253	1297	139	2	778.6
3254	1297	56	2	3316.85
3255	1298	170	2	2730.72
3256	1298	74	2	3566.61
3257	1298	161	2	1090.52
3258	1298	128	3	2505.19
3259	1299	154	2	4068.96
3260	1299	212	2	4821.33
3261	1299	242	1	3059.6
3262	1299	90	3	4688.22
3263	1300	15	2	2025.71
3264	1300	20	2	1328.6
3265	1301	33	2	2850.43
3266	1301	188	3	1609.19
3267	1302	5	3	141.82
3268	1302	133	2	4849.77
3269	1303	19	1	568.33
3270	1304	81	2	4381.84
3271	1304	208	2	2433.91
3272	1305	102	2	2745.93
3273	1306	152	3	1416.85
3274	1306	54	2	1431.17
3275	1306	147	2	3349.79
3276	1307	275	1	4006.2
3277	1307	43	3	2806.51
3278	1308	216	1	3336.09
3279	1309	150	1	4133.82
3280	1309	54	2	1431.17
3281	1309	150	2	4133.82
3282	1309	162	1	1795.78
3283	1310	164	1	1658.82
3284	1310	7	3	266.7
3285	1310	195	2	3424.4
3286	1311	40	1	858.05
3287	1312	127	2	4223.36
3288	1312	79	1	2292.12
3289	1312	133	1	4849.77
3290	1312	80	3	3236.37
3291	1313	150	2	4133.82
3292	1313	256	1	415.16
3293	1313	78	3	815.71
3294	1314	271	2	694.88
3295	1315	145	2	2385.13
3296	1315	170	1	2730.72
3297	1315	52	1	923.7
3298	1315	171	3	1695.63
3299	1316	145	3	2385.13
3300	1316	210	3	250.03
3301	1316	142	2	1631.1
3302	1316	266	3	4890.54
3303	1317	239	2	944.49
3304	1317	276	2	4043.27
3305	1317	110	2	1086.99
3306	1317	128	1	2505.19
3307	1318	59	1	730.65
3308	1318	271	1	694.88
3309	1318	232	3	3341
3310	1319	130	3	1198.9
3311	1319	196	2	4031.56
3312	1320	30	3	3703.24
3313	1320	218	3	893.42
3314	1320	284	1	4127.8
3315	1321	73	1	1107.02
3316	1322	211	3	4341.33
3317	1322	236	2	4146.5
3318	1322	64	2	2660.67
3319	1323	182	2	2508.73
3320	1324	14	3	4363.16
3321	1324	53	2	4126.49
3322	1325	79	2	2292.12
3323	1326	156	3	3045.31
3324	1327	70	2	2042.86
3325	1328	132	1	4779.91
3326	1328	81	3	4381.84
3327	1328	227	3	578.23
3328	1328	11	1	506.08
3329	1329	282	2	2425.15
3330	1329	3	3	2367.32
3331	1329	167	3	1076.65
3332	1329	185	2	409.7
3333	1330	271	2	694.88
3334	1330	195	3	3424.4
3335	1331	7	3	266.7
3336	1332	16	2	102.83
3337	1333	18	3	4524.74
3338	1333	65	3	2587.37
3339	1333	258	3	688.96
3340	1333	30	3	3703.24
3341	1334	165	2	87.49
3342	1334	259	1	2013.76
3343	1334	228	3	3835.09
3344	1335	269	1	3157.69
3345	1335	142	1	1631.1
3346	1335	229	3	98.01
3347	1336	238	3	2976.41
3348	1336	106	2	836.74
3349	1336	130	2	1198.9
3350	1336	44	1	1915.58
3351	1337	47	3	3890.02
3352	1338	272	3	1745.88
3353	1338	188	2	1609.19
3354	1339	158	2	3535
3355	1339	94	2	1034.65
3356	1339	6	3	2486.1
3357	1339	260	1	862.56
3358	1340	14	1	4363.16
3359	1341	85	1	1637.43
3360	1342	176	2	72.99
3361	1342	196	1	4031.56
3362	1342	258	2	688.96
3363	1342	80	2	3236.37
3364	1343	67	2	1964.81
3365	1344	14	3	4363.16
3366	1344	174	3	4487.95
3367	1344	230	3	4283.99
3368	1345	173	2	4817.58
3369	1345	131	3	2342.86
3370	1345	237	1	2692.44
3371	1346	90	1	4688.22
3372	1346	127	2	4223.36
3373	1346	96	1	2212.98
3374	1346	67	2	1964.81
3375	1347	241	2	1157.85
3376	1347	249	1	4366.54
3377	1348	59	3	730.65
3378	1348	3	1	2367.32
3379	1348	258	3	688.96
3380	1349	279	2	226.9
3381	1349	139	2	778.6
3382	1349	212	1	4821.33
3383	1349	40	2	858.05
3384	1350	204	2	1610.65
3385	1350	51	3	3296.19
3386	1350	209	3	234.45
3387	1350	31	1	1419.3
3388	1351	117	2	2915.46
3389	1351	212	1	4821.33
3390	1352	228	2	3835.09
3391	1353	230	2	4283.99
3392	1353	209	3	234.45
3393	1353	55	2	683.16
3394	1354	86	3	436.57
3395	1354	173	1	4817.58
3396	1354	215	2	1607.8
3397	1355	236	1	4146.5
3398	1355	63	3	2959.82
3399	1356	225	1	1270.52
3400	1356	117	1	2915.46
3401	1357	27	2	1223.17
3402	1357	211	1	4341.33
3403	1357	173	2	4817.58
3404	1357	211	2	4341.33
3405	1358	27	3	1223.17
3406	1359	246	3	1498.73
3407	1359	191	2	942.59
3408	1359	157	3	1068.08
3409	1359	133	3	4849.77
3410	1360	13	2	3965.42
3411	1360	182	2	2508.73
3412	1360	92	3	412.91
3413	1360	184	3	2992.36
3414	1361	31	2	1419.3
3415	1361	260	3	862.56
3416	1361	237	2	2692.44
3417	1361	100	3	3569.72
3418	1362	230	2	4283.99
3419	1362	258	1	688.96
3420	1362	29	2	2462.95
3421	1362	47	3	3890.02
3422	1363	249	1	4366.54
3423	1363	135	2	40.1
3424	1363	264	2	21.64
3425	1364	51	2	3296.19
3426	1365	188	1	1609.19
3427	1365	154	2	4068.96
3428	1365	76	3	4613.91
3429	1366	223	1	1505.96
3430	1366	209	3	234.45
3431	1366	268	2	1236.3
3432	1367	162	2	1795.78
3433	1368	76	2	4613.91
3434	1369	284	2	4127.8
3435	1369	201	2	4623.06
3436	1369	165	1	87.49
3437	1370	220	3	2654.61
3438	1370	262	1	4423.65
3439	1371	3	1	2367.32
3440	1371	65	2	2587.37
3441	1371	271	1	694.88
3442	1371	210	3	250.03
3443	1372	57	3	2713.28
3444	1373	120	2	1195.36
3445	1373	156	3	3045.31
3446	1373	64	3	2660.67
3447	1374	70	3	2042.86
3448	1374	3	2	2367.32
3449	1374	41	3	2604.51
3450	1374	75	3	2446.53
3451	1375	21	3	1379.26
3452	1376	1	1	191.33
3453	1377	68	3	762.99
3454	1377	287	1	940.45
3455	1377	74	3	3566.61
3456	1377	112	3	4900.94
3457	1378	173	3	4817.58
3458	1378	199	3	3626.05
3459	1379	41	3	2604.51
3460	1379	4	1	4444.26
3461	1380	8	1	697.97
3462	1381	30	1	3703.24
3463	1382	159	1	701.89
3464	1382	89	1	236.47
3465	1383	171	1	1695.63
3466	1384	42	3	3790.97
3467	1384	67	3	1964.81
3468	1385	262	3	4423.65
3469	1385	125	2	4769.92
3470	1385	120	1	1195.36
3471	1386	106	3	836.74
3472	1386	96	1	2212.98
3473	1386	17	3	2190.17
3474	1386	15	3	2025.71
3475	1387	189	2	249.23
3476	1387	153	2	3962.38
3477	1387	141	3	1955.22
3478	1387	274	1	1474.35
3479	1388	212	2	4821.33
3480	1389	269	3	3157.69
3481	1389	186	2	2565.65
3482	1389	170	3	2730.72
3483	1389	57	1	2713.28
3484	1390	112	1	4900.94
3485	1390	74	3	3566.61
3486	1390	55	2	683.16
3487	1390	185	3	409.7
3488	1391	281	1	3478.07
3489	1391	185	1	409.7
3490	1391	249	1	4366.54
3491	1392	140	2	687.7
3492	1392	47	1	3890.02
3493	1392	223	3	1505.96
3494	1392	114	2	2910.44
3495	1393	128	2	2505.19
3496	1393	281	3	3478.07
3497	1394	51	1	3296.19
3498	1395	116	1	331.25
3499	1395	99	2	2939.03
3500	1396	94	2	1034.65
3501	1396	197	3	4694.81
3502	1396	206	1	2378.11
3503	1396	131	1	2342.86
3504	1397	158	2	3535
3505	1397	61	1	909.56
3506	1397	94	3	1034.65
3507	1397	73	2	1107.02
3508	1398	281	2	3478.07
3509	1398	114	1	2910.44
3510	1399	97	2	2847.91
3511	1400	284	3	4127.8
3512	1400	148	2	4099.98
3513	1401	190	1	639.28
3514	1401	160	3	2070.69
3515	1402	189	2	249.23
3516	1402	94	2	1034.65
3517	1403	66	1	1503.95
3518	1404	269	3	3157.69
3519	1405	183	3	4624.85
3520	1405	192	3	2536.07
3521	1406	42	3	3790.97
3522	1406	275	3	4006.2
3523	1406	178	2	2463.95
3524	1406	21	1	1379.26
3525	1407	73	2	1107.02
3526	1407	10	1	620.57
3527	1407	61	3	909.56
3528	1407	256	2	415.16
3529	1408	57	2	2713.28
3530	1409	238	2	2976.41
3531	1409	7	3	266.7
3532	1410	51	3	3296.19
3533	1411	171	2	1695.63
3534	1412	276	1	4043.27
3535	1413	256	3	415.16
3536	1413	156	1	3045.31
3537	1413	7	2	266.7
3538	1414	192	1	2536.07
3539	1414	220	1	2654.61
3540	1415	34	1	2318.62
3541	1415	104	2	4433.01
3542	1415	34	3	2318.62
3543	1415	75	1	2446.53
3544	1416	5	1	141.82
3545	1416	90	3	4688.22
3546	1416	128	3	2505.19
3547	1416	108	1	600.5
3548	1417	113	1	454.29
3549	1417	277	1	1515.88
3550	1417	80	2	3236.37
3551	1418	103	2	2918.82
3552	1419	132	3	4779.91
3553	1419	76	2	4613.91
3554	1419	156	3	3045.31
3555	1420	22	2	4690.3
3556	1420	6	2	2486.1
3557	1420	267	1	2103.51
3558	1420	33	2	2850.43
3559	1421	165	2	87.49
3560	1421	225	3	1270.52
3561	1421	58	2	121.51
3562	1421	168	3	39.25
3563	1422	153	1	3962.38
3564	1423	75	1	2446.53
3565	1424	13	2	3965.42
3566	1425	5	3	141.82
3567	1426	2	3	966.11
3568	1426	67	2	1964.81
3569	1426	194	3	1093.18
3570	1427	163	1	2710.75
3571	1428	263	2	283.98
3572	1428	33	1	2850.43
3573	1428	151	3	4403.59
3574	1429	40	1	858.05
3575	1430	150	3	4133.82
3576	1431	96	2	2212.98
3577	1431	271	3	694.88
3578	1432	260	3	862.56
3579	1432	190	3	639.28
3580	1433	10	2	620.57
3581	1433	78	1	815.71
3582	1434	80	2	3236.37
3583	1435	187	1	3396.6
3584	1435	159	2	701.89
3585	1435	154	1	4068.96
3586	1436	20	1	1328.6
3587	1436	181	2	749.09
3588	1436	7	2	266.7
3589	1436	125	3	4769.92
3590	1437	170	3	2730.72
3591	1437	67	2	1964.81
3592	1438	85	2	1637.43
3593	1438	179	3	3986.65
3594	1438	233	3	4106
3595	1439	58	1	121.51
3596	1439	21	3	1379.26
3597	1440	133	1	4849.77
3598	1441	276	3	4043.27
3599	1442	181	2	749.09
3600	1442	227	2	578.23
3601	1443	226	3	756.45
3602	1443	54	1	1431.17
3603	1443	47	1	3890.02
3604	1444	96	1	2212.98
3605	1444	25	3	2062.34
3606	1444	152	3	1416.85
3607	1444	91	2	4264.66
3608	1445	230	1	4283.99
3609	1445	270	2	722.62
3610	1445	16	3	102.83
3611	1446	252	2	4401.02
3612	1447	266	3	4890.54
3613	1447	84	2	4234.55
3614	1448	165	3	87.49
3615	1448	86	3	436.57
3616	1448	160	1	2070.69
3617	1448	36	2	1758.9
3618	1449	173	3	4817.58
3619	1449	172	1	2563.06
3620	1449	4	2	4444.26
3621	1450	190	2	639.28
3622	1450	152	3	1416.85
3623	1450	280	3	4981.15
3624	1450	207	2	2636.95
3625	1451	157	2	1068.08
3626	1451	93	3	1816.18
3627	1452	58	2	121.51
3628	1452	39	1	3209.83
3629	1453	64	2	2660.67
3630	1453	22	1	4690.3
3631	1454	148	1	4099.98
3632	1454	108	1	600.5
3633	1455	103	2	2918.82
3634	1455	264	3	21.64
3635	1455	216	1	3336.09
3636	1455	10	2	620.57
3637	1456	22	2	4690.3
3638	1456	207	1	2636.95
3639	1456	227	2	578.23
3640	1456	268	2	1236.3
3641	1457	98	3	4615.67
3642	1457	138	2	1274.72
3643	1457	25	2	2062.34
3644	1457	250	3	810.55
3645	1458	144	3	1750.96
3646	1458	20	3	1328.6
3647	1458	254	3	3633.59
3648	1458	250	1	810.55
3649	1459	68	1	762.99
3650	1459	8	1	697.97
3651	1460	219	2	2048.68
3652	1460	120	2	1195.36
3653	1461	271	1	694.88
3654	1461	99	3	2939.03
3655	1462	47	1	3890.02
3656	1462	189	2	249.23
3657	1463	120	3	1195.36
3658	1463	218	1	893.42
3659	1463	149	3	291.03
3660	1464	143	1	3191.91
3661	1465	184	1	2992.36
3662	1465	107	3	1221.14
3663	1465	199	1	3626.05
3664	1465	84	2	4234.55
3665	1466	121	1	2118.88
3666	1466	47	1	3890.02
3667	1467	185	3	409.7
3668	1467	92	2	412.91
3669	1468	54	1	1431.17
3670	1469	286	3	4172.2
3671	1470	43	3	2806.51
3672	1470	27	3	1223.17
3673	1470	82	1	4318.55
3674	1470	214	2	4910.07
3675	1471	56	3	3316.85
3676	1471	27	1	1223.17
3677	1472	279	2	226.9
3678	1472	68	1	762.99
3679	1473	272	2	1745.88
3680	1473	266	1	4890.54
3681	1474	230	3	4283.99
3682	1474	168	3	39.25
3683	1474	255	1	2843.93
3684	1474	43	2	2806.51
3685	1475	157	3	1068.08
3686	1475	61	1	909.56
3687	1475	153	3	3962.38
3688	1476	153	1	3962.38
3689	1476	275	3	4006.2
3690	1476	280	1	4981.15
3691	1476	210	1	250.03
3692	1477	164	3	1658.82
3693	1477	260	2	862.56
3694	1478	272	3	1745.88
3695	1478	168	1	39.25
3696	1478	97	3	2847.91
3697	1479	88	2	4844.03
3698	1479	12	1	1101.5
3699	1479	188	1	1609.19
3700	1479	100	2	3569.72
3701	1480	62	2	2224.13
3702	1480	239	3	944.49
3703	1481	98	1	4615.67
3704	1481	54	2	1431.17
3705	1481	9	1	66.48
3706	1481	227	1	578.23
3707	1482	257	1	1295.43
3708	1482	223	1	1505.96
3709	1482	221	2	3045.81
3710	1483	145	2	2385.13
3711	1484	4	3	4444.26
3712	1484	162	1	1795.78
3713	1484	181	1	749.09
3714	1484	170	2	2730.72
3715	1485	24	1	4690.55
3716	1485	178	3	2463.95
3717	1485	203	1	2771.23
3718	1486	99	3	2939.03
3719	1486	37	2	1864.21
3720	1486	243	2	1559.6
3721	1486	114	3	2910.44
3722	1487	33	2	2850.43
3723	1488	260	3	862.56
3724	1488	72	2	2882.92
3725	1489	82	3	4318.55
3726	1489	13	1	3965.42
3727	1489	286	1	4172.2
3728	1489	247	3	1184.86
3729	1490	73	3	1107.02
3730	1490	179	3	3986.65
3731	1491	133	2	4849.77
3732	1491	73	1	1107.02
3733	1491	281	2	3478.07
3734	1492	74	3	3566.61
3735	1493	284	1	4127.8
3736	1493	265	2	2047.67
3737	1493	112	2	4900.94
3738	1493	266	2	4890.54
3739	1494	36	1	1758.9
3740	1494	262	3	4423.65
3741	1494	70	1	2042.86
3742	1495	252	3	4401.02
3743	1495	281	3	3478.07
3744	1495	249	1	4366.54
3745	1495	130	2	1198.9
3746	1496	149	2	291.03
3747	1497	67	2	1964.81
3748	1498	182	3	2508.73
3749	1498	53	3	4126.49
3750	1498	64	2	2660.67
3751	1499	114	1	2910.44
3752	1500	21	3	1379.26
3753	1501	202	1	3909
3754	1501	66	2	1503.95
3755	1501	217	3	2395.7
3756	1502	19	3	568.33
3757	1502	49	1	2244.16
3758	1502	191	3	942.59
3759	1502	228	3	3835.09
3760	1503	249	2	4366.54
3761	1503	64	1	2660.67
3762	1504	90	2	4688.22
3763	1505	210	3	250.03
3764	1505	62	2	2224.13
3765	1506	1	2	191.33
3766	1507	102	2	2745.93
3767	1507	23	2	1005.52
3768	1507	82	3	4318.55
3769	1508	150	1	4133.82
3770	1508	94	3	1034.65
3771	1508	212	3	4821.33
3772	1509	1	3	191.33
3773	1510	283	1	4667.36
3774	1510	154	2	4068.96
3775	1510	258	2	688.96
3776	1511	225	3	1270.52
3777	1512	179	1	3986.65
3778	1513	279	2	226.9
3779	1513	2	1	966.11
3780	1514	259	2	2013.76
3781	1514	64	3	2660.67
3782	1514	233	2	4106
3783	1514	197	3	4694.81
3784	1515	9	1	66.48
3785	1516	75	2	2446.53
3786	1516	169	1	712.16
3787	1516	1	3	191.33
3788	1516	10	1	620.57
3789	1517	153	3	3962.38
3790	1517	29	1	2462.95
3791	1518	271	1	694.88
3792	1518	57	2	2713.28
3793	1519	49	1	2244.16
3794	1520	259	1	2013.76
3795	1521	142	2	1631.1
3796	1521	59	1	730.65
3797	1521	49	3	2244.16
3798	1522	247	3	1184.86
3799	1523	226	3	756.45
3800	1523	259	2	2013.76
3801	1523	268	2	1236.3
3802	1524	33	2	2850.43
3803	1525	209	2	234.45
3804	1525	160	2	2070.69
3805	1525	5	1	141.82
3806	1525	280	1	4981.15
3807	1526	261	2	790.99
3808	1527	281	3	3478.07
3809	1527	22	3	4690.3
3810	1527	188	1	1609.19
3811	1528	142	2	1631.1
3812	1529	82	3	4318.55
3813	1529	152	2	1416.85
3814	1529	121	2	2118.88
3815	1530	39	2	3209.83
3816	1531	203	3	2771.23
3817	1531	194	2	1093.18
3818	1531	1	2	191.33
3819	1531	239	3	944.49
3820	1532	61	2	909.56
3821	1532	245	2	1068.63
3822	1532	201	3	4623.06
3823	1532	266	1	4890.54
3824	1533	125	1	4769.92
3825	1533	151	1	4403.59
3826	1534	21	3	1379.26
3827	1534	167	3	1076.65
3828	1534	237	1	2692.44
3829	1535	104	3	4433.01
3830	1535	112	3	4900.94
3831	1535	122	2	2787.78
3832	1536	46	3	2636.92
3833	1536	126	3	2497.8
3834	1537	155	2	775.75
3835	1537	146	1	2941.2
3836	1538	241	3	1157.85
3837	1539	171	1	1695.63
3838	1539	33	2	2850.43
3839	1540	212	2	4821.33
3840	1541	268	2	1236.3
3841	1542	196	2	4031.56
3842	1542	260	1	862.56
3843	1542	176	3	72.99
3844	1543	126	1	2497.8
3845	1543	38	2	3644.69
3846	1544	121	2	2118.88
3847	1544	200	2	2691.81
3848	1544	278	2	490.65
3849	1544	206	1	2378.11
3850	1545	285	3	2333.4
3851	1545	262	2	4423.65
3852	1545	80	3	3236.37
3853	1546	33	2	2850.43
3854	1546	24	1	4690.55
3855	1546	197	1	4694.81
3856	1546	183	2	4624.85
3857	1547	40	2	858.05
3858	1548	105	3	3439.98
3859	1548	116	3	331.25
3860	1549	142	1	1631.1
3861	1549	145	2	2385.13
3862	1549	119	1	1689.99
3863	1550	132	1	4779.91
3864	1550	253	1	951.68
3865	1550	175	1	2039.09
3866	1550	285	2	2333.4
3867	1551	198	1	364.63
3868	1551	251	3	1805.2
3869	1551	196	2	4031.56
3870	1552	156	2	3045.31
3871	1552	131	1	2342.86
3872	1553	152	2	1416.85
3873	1553	66	3	1503.95
3874	1553	273	1	4085.21
3875	1554	143	1	3191.91
3876	1555	108	3	600.5
3877	1555	103	1	2918.82
3878	1555	273	2	4085.21
3879	1556	263	2	283.98
3880	1556	162	2	1795.78
3881	1556	200	2	2691.81
3882	1557	110	2	1086.99
3883	1558	282	3	2425.15
3884	1558	163	3	2710.75
3885	1559	72	2	2882.92
3886	1560	134	1	2426.17
3887	1560	20	3	1328.6
3888	1561	244	1	2920.97
3889	1561	14	1	4363.16
3890	1562	26	3	3588.62
3891	1562	278	1	490.65
3892	1563	259	1	2013.76
3893	1563	91	3	4264.66
3894	1563	92	2	412.91
3895	1564	263	1	283.98
3896	1564	245	3	1068.63
3897	1564	71	3	1326.14
3898	1564	181	3	749.09
3899	1565	35	3	4477.11
3900	1565	203	2	2771.23
3901	1565	231	3	2475.99
3902	1565	12	2	1101.5
3903	1566	219	2	2048.68
3904	1567	39	1	3209.83
3905	1567	111	3	3620.9
3906	1567	253	3	951.68
3907	1568	274	3	1474.35
3908	1568	253	2	951.68
3909	1568	288	1	2851.1
3910	1568	274	3	1474.35
3911	1569	74	2	3566.61
3912	1570	103	3	2918.82
3913	1570	175	3	2039.09
3914	1571	188	1	1609.19
3915	1571	83	2	4417.39
3916	1572	275	3	4006.2
3917	1572	9	3	66.48
3918	1572	51	1	3296.19
3919	1573	208	1	2433.91
3920	1573	196	2	4031.56
3921	1573	196	1	4031.56
3922	1574	177	3	2242.63
3923	1575	166	1	4892.93
3924	1575	121	1	2118.88
3925	1576	284	1	4127.8
3926	1576	52	3	923.7
3927	1576	118	1	1653.35
3928	1576	207	2	2636.95
3929	1577	95	2	1494.05
3930	1578	230	3	4283.99
3931	1578	211	2	4341.33
3932	1579	33	3	2850.43
3933	1579	100	1	3569.72
3934	1579	174	3	4487.95
3935	1580	165	3	87.49
3936	1581	60	3	1815.93
3937	1581	268	2	1236.3
3938	1581	218	3	893.42
3939	1582	36	2	1758.9
3940	1582	252	2	4401.02
3941	1582	247	3	1184.86
3942	1583	250	2	810.55
3943	1583	162	1	1795.78
3944	1583	21	2	1379.26
3945	1584	69	1	4969.99
3946	1584	237	3	2692.44
3947	1585	11	2	506.08
3948	1585	143	3	3191.91
3949	1585	42	1	3790.97
3950	1585	96	1	2212.98
3951	1586	220	1	2654.61
3952	1587	169	1	712.16
3953	1587	168	2	39.25
3954	1587	94	2	1034.65
3955	1587	268	2	1236.3
3956	1588	105	3	3439.98
3957	1588	241	3	1157.85
3958	1588	22	3	4690.3
3959	1589	288	2	2851.1
3960	1589	80	2	3236.37
3961	1589	62	3	2224.13
3962	1590	134	1	2426.17
3963	1590	123	1	60.63
3964	1590	179	1	3986.65
3965	1591	202	3	3909
3966	1592	238	3	2976.41
3967	1592	233	1	4106
3968	1592	135	1	40.1
3969	1593	43	2	2806.51
3970	1593	159	3	701.89
3971	1594	168	3	39.25
3972	1595	118	3	1653.35
3973	1596	139	3	778.6
3974	1596	102	3	2745.93
3975	1596	259	3	2013.76
3976	1597	259	2	2013.76
3977	1597	78	3	815.71
3978	1597	92	3	412.91
3979	1597	62	1	2224.13
3980	1598	232	3	3341
3981	1598	199	1	3626.05
3982	1599	240	3	2323.41
3983	1599	210	3	250.03
3984	1600	90	2	4688.22
3985	1600	233	3	4106
3986	1601	284	2	4127.8
3987	1601	272	1	1745.88
3988	1601	89	1	236.47
3989	1601	202	3	3909
3990	1602	196	3	4031.56
3991	1602	253	1	951.68
3992	1602	266	1	4890.54
3993	1602	209	1	234.45
3994	1603	243	3	1559.6
3995	1604	259	3	2013.76
3996	1604	116	2	331.25
3997	1605	234	2	932.4
3998	1605	222	3	3539.2
3999	1605	211	3	4341.33
4000	1606	48	3	2145.74
4001	1607	275	1	4006.2
4002	1607	169	2	712.16
4003	1608	218	1	893.42
4004	1608	273	3	4085.21
4005	1608	122	2	2787.78
4006	1609	164	3	1658.82
4007	1609	219	2	2048.68
4008	1610	224	1	1331.69
4009	1610	67	1	1964.81
4010	1611	142	1	1631.1
4011	1611	208	3	2433.91
4012	1611	107	1	1221.14
4013	1612	62	1	2224.13
4014	1612	257	1	1295.43
4015	1612	256	1	415.16
4016	1612	200	3	2691.81
4017	1613	235	3	3594.23
4018	1613	104	1	4433.01
4019	1613	92	1	412.91
4020	1614	220	1	2654.61
4021	1614	184	2	2992.36
4022	1614	175	3	2039.09
4023	1614	276	1	4043.27
4024	1615	102	2	2745.93
4025	1615	1	3	191.33
4026	1616	220	1	2654.61
4027	1616	55	1	683.16
4028	1617	169	2	712.16
4029	1617	204	1	1610.65
4030	1617	15	3	2025.71
4031	1618	235	2	3594.23
4032	1618	206	1	2378.11
4033	1619	86	1	436.57
4034	1619	17	2	2190.17
4035	1619	72	3	2882.92
4036	1619	40	1	858.05
4037	1620	185	1	409.7
4038	1621	70	1	2042.86
4039	1621	200	3	2691.81
4040	1622	43	3	2806.51
4041	1622	198	2	364.63
4042	1622	88	3	4844.03
4043	1623	261	3	790.99
4044	1623	9	1	66.48
4045	1623	111	2	3620.9
4046	1623	216	2	3336.09
4047	1624	136	1	2382.64
4048	1624	176	3	72.99
4049	1624	103	3	2918.82
4050	1624	122	3	2787.78
4051	1625	127	2	4223.36
4052	1625	137	2	2923.1
4053	1626	167	1	1076.65
4054	1626	8	2	697.97
4055	1627	233	2	4106
4056	1627	142	2	1631.1
4057	1627	273	1	4085.21
4058	1628	152	1	1416.85
4059	1628	250	1	810.55
4060	1628	239	2	944.49
4061	1628	271	3	694.88
4062	1629	220	2	2654.61
4063	1629	43	3	2806.51
4064	1630	207	3	2636.95
4065	1631	24	1	4690.55
4066	1631	12	2	1101.5
4067	1631	241	2	1157.85
4068	1631	48	2	2145.74
4069	1632	265	1	2047.67
4070	1633	73	3	1107.02
4071	1633	283	3	4667.36
4072	1633	241	1	1157.85
4073	1634	25	1	2062.34
4074	1634	121	3	2118.88
4075	1634	33	1	2850.43
4076	1634	113	3	454.29
4077	1635	5	3	141.82
4078	1635	88	1	4844.03
4079	1635	124	1	214.08
4080	1635	11	3	506.08
4081	1636	145	3	2385.13
4082	1636	125	3	4769.92
4083	1636	66	1	1503.95
4084	1637	211	1	4341.33
4085	1637	44	2	1915.58
4086	1637	120	2	1195.36
4087	1638	272	1	1745.88
4088	1638	214	2	4910.07
4089	1639	49	3	2244.16
4090	1639	88	2	4844.03
4091	1640	4	3	4444.26
4092	1640	266	1	4890.54
4093	1640	165	2	87.49
4094	1641	77	2	79.66
4095	1641	84	3	4234.55
4096	1641	218	2	893.42
4097	1642	7	2	266.7
4098	1642	201	3	4623.06
4099	1642	67	3	1964.81
4100	1643	262	2	4423.65
4101	1643	149	2	291.03
4102	1644	50	2	1046.08
4103	1644	211	3	4341.33
4104	1644	268	3	1236.3
4105	1645	31	3	1419.3
4106	1645	178	1	2463.95
4107	1645	110	3	1086.99
4108	1645	29	3	2462.95
4109	1646	55	3	683.16
4110	1647	121	3	2118.88
4111	1647	135	3	40.1
4112	1648	159	2	701.89
4113	1648	204	2	1610.65
4114	1648	34	1	2318.62
4115	1649	261	2	790.99
4116	1649	270	2	722.62
4117	1650	85	1	1637.43
4118	1650	70	3	2042.86
4119	1651	246	3	1498.73
4120	1652	26	1	3588.62
4121	1652	185	1	409.7
4122	1652	254	1	3633.59
4123	1653	106	1	836.74
4124	1654	12	1	1101.5
4125	1655	262	1	4423.65
4126	1655	199	3	3626.05
4127	1655	127	3	4223.36
4128	1655	249	2	4366.54
4129	1656	33	2	2850.43
4130	1656	45	3	3291.46
4131	1657	286	2	4172.2
4132	1657	213	2	3862.89
4133	1658	195	3	3424.4
4134	1659	178	1	2463.95
4135	1659	89	2	236.47
4136	1659	58	2	121.51
4137	1660	205	3	3433.63
4138	1660	201	1	4623.06
4139	1660	272	3	1745.88
4140	1661	184	3	2992.36
4141	1661	2	3	966.11
4142	1662	233	2	4106
4143	1662	229	1	98.01
4144	1662	269	1	3157.69
4145	1662	174	3	4487.95
4146	1663	38	2	3644.69
4147	1664	146	3	2941.2
4148	1664	171	3	1695.63
4149	1664	95	1	1494.05
4150	1665	197	1	4694.81
4151	1665	97	3	2847.91
4152	1665	24	1	4690.55
4153	1666	63	3	2959.82
4154	1666	15	3	2025.71
4155	1667	57	2	2713.28
4156	1667	277	2	1515.88
4157	1667	81	3	4381.84
4158	1668	113	2	454.29
4159	1668	265	3	2047.67
4160	1669	53	2	4126.49
4161	1669	111	1	3620.9
4162	1669	202	2	3909
4163	1670	141	3	1955.22
4164	1671	169	2	712.16
4165	1671	31	2	1419.3
4166	1671	273	3	4085.21
4167	1671	204	3	1610.65
4168	1672	225	2	1270.52
4169	1672	253	1	951.68
4170	1672	284	2	4127.8
4171	1672	275	1	4006.2
4172	1673	87	3	1159.3
4173	1673	112	1	4900.94
4174	1673	272	3	1745.88
4175	1673	209	1	234.45
4176	1674	109	3	4505.02
4177	1675	96	1	2212.98
4178	1675	166	2	4892.93
4179	1676	264	1	21.64
4180	1677	201	2	4623.06
4181	1677	7	1	266.7
4182	1677	63	2	2959.82
4183	1678	83	2	4417.39
4184	1679	211	2	4341.33
4185	1679	77	1	79.66
4186	1680	120	3	1195.36
4187	1680	1	3	191.33
4188	1680	41	2	2604.51
4189	1680	73	2	1107.02
4190	1681	221	3	3045.81
4191	1681	284	3	4127.8
4192	1681	112	3	4900.94
4193	1682	135	2	40.1
4194	1683	34	2	2318.62
4195	1684	266	3	4890.54
4196	1685	244	1	2920.97
4197	1685	231	2	2475.99
4198	1685	6	3	2486.1
4199	1686	136	2	2382.64
4200	1686	164	3	1658.82
4201	1687	58	1	121.51
4202	1687	98	1	4615.67
4203	1687	201	1	4623.06
4204	1687	220	3	2654.61
4205	1688	152	2	1416.85
4206	1688	25	2	2062.34
4207	1688	213	1	3862.89
4208	1688	199	2	3626.05
4209	1689	29	3	2462.95
4210	1689	32	2	1240.3
4211	1689	1	2	191.33
4212	1690	138	2	1274.72
4213	1690	144	2	1750.96
4214	1691	174	2	4487.95
4215	1692	52	1	923.7
4216	1692	137	3	2923.1
4217	1692	15	2	2025.71
4218	1692	231	2	2475.99
4219	1693	182	2	2508.73
4220	1693	210	1	250.03
4221	1693	182	3	2508.73
4222	1694	5	2	141.82
4223	1694	111	3	3620.9
4224	1694	34	2	2318.62
4225	1695	211	1	4341.33
4226	1696	235	2	3594.23
4227	1696	205	3	3433.63
4228	1696	98	2	4615.67
4229	1696	256	1	415.16
4230	1697	27	2	1223.17
4231	1697	154	1	4068.96
4232	1697	224	2	1331.69
4233	1697	236	3	4146.5
4234	1698	188	1	1609.19
4235	1699	162	3	1795.78
4236	1699	135	3	40.1
4237	1699	29	1	2462.95
4238	1700	237	3	2692.44
4239	1700	149	3	291.03
4240	1700	219	2	2048.68
4241	1701	165	2	87.49
4242	1701	85	2	1637.43
4243	1702	210	1	250.03
4244	1702	6	2	2486.1
4245	1703	196	3	4031.56
4246	1703	15	3	2025.71
4247	1703	196	2	4031.56
4248	1703	206	2	2378.11
4249	1704	8	1	697.97
4250	1704	1	2	191.33
4251	1704	263	1	283.98
4252	1705	192	2	2536.07
4253	1705	111	3	3620.9
4254	1705	33	3	2850.43
4255	1705	173	1	4817.58
4256	1706	49	2	2244.16
4257	1706	149	3	291.03
4258	1706	56	2	3316.85
4259	1707	278	2	490.65
4260	1707	141	1	1955.22
4261	1707	151	2	4403.59
4262	1708	75	3	2446.53
4263	1708	6	1	2486.1
4264	1709	254	2	3633.59
4265	1710	124	3	214.08
4266	1711	41	3	2604.51
4267	1712	67	2	1964.81
4268	1712	62	1	2224.13
4269	1712	169	3	712.16
4270	1712	148	1	4099.98
4271	1713	6	1	2486.1
4272	1713	165	3	87.49
4273	1713	271	1	694.88
4274	1713	8	3	697.97
4275	1714	250	1	810.55
4276	1714	76	3	4613.91
4277	1715	191	3	942.59
4278	1715	210	1	250.03
4279	1715	9	1	66.48
4280	1715	120	1	1195.36
4281	1716	78	2	815.71
4282	1716	63	1	2959.82
4283	1717	58	3	121.51
4284	1717	45	3	3291.46
4285	1717	183	1	4624.85
4286	1718	7	1	266.7
4287	1719	287	3	940.45
4288	1720	275	2	4006.2
4289	1720	113	1	454.29
4290	1721	118	2	1653.35
4291	1721	263	1	283.98
4292	1722	263	3	283.98
4293	1723	174	1	4487.95
4294	1723	288	2	2851.1
4295	1723	112	2	4900.94
4296	1724	204	1	1610.65
4297	1725	286	3	4172.2
4298	1725	182	2	2508.73
4299	1725	207	1	2636.95
4300	1725	90	2	4688.22
4301	1726	203	1	2771.23
4302	1726	199	1	3626.05
4303	1726	194	2	1093.18
4304	1727	159	1	701.89
4305	1727	274	1	1474.35
4306	1727	193	2	4213.62
4307	1727	47	2	3890.02
4308	1728	209	2	234.45
4309	1728	215	2	1607.8
4310	1729	207	3	2636.95
4311	1729	279	2	226.9
4312	1729	56	3	3316.85
4313	1729	130	1	1198.9
4314	1730	63	2	2959.82
4315	1730	197	2	4694.81
4316	1731	197	3	4694.81
4317	1731	251	1	1805.2
4318	1732	170	3	2730.72
4319	1732	133	2	4849.77
4320	1732	145	2	2385.13
4321	1732	30	3	3703.24
4322	1733	71	1	1326.14
4323	1733	279	1	226.9
4324	1734	231	1	2475.99
4325	1735	26	2	3588.62
4326	1736	55	1	683.16
4327	1736	273	3	4085.21
4328	1736	96	2	2212.98
4329	1736	51	2	3296.19
4330	1737	26	2	3588.62
4331	1737	248	2	4741.62
4332	1737	31	1	1419.3
4333	1738	286	1	4172.2
4334	1738	8	3	697.97
4335	1738	88	1	4844.03
4336	1738	255	2	2843.93
4337	1739	196	2	4031.56
4338	1740	205	3	3433.63
4339	1740	149	2	291.03
4340	1741	220	1	2654.61
4341	1741	45	1	3291.46
4342	1741	285	2	2333.4
4343	1741	144	2	1750.96
4344	1742	155	3	775.75
4345	1742	256	3	415.16
4346	1742	162	3	1795.78
4347	1743	109	1	4505.02
4348	1743	248	3	4741.62
4349	1743	42	1	3790.97
4350	1743	109	3	4505.02
4351	1744	221	1	3045.81
4352	1745	259	2	2013.76
4353	1745	228	3	3835.09
4354	1746	9	1	66.48
4355	1746	80	2	3236.37
4356	1746	198	3	364.63
4357	1746	74	3	3566.61
4358	1747	177	1	2242.63
4359	1747	42	3	3790.97
4360	1747	154	2	4068.96
4361	1747	196	1	4031.56
4362	1748	195	3	3424.4
4363	1748	272	1	1745.88
4364	1749	135	1	40.1
4365	1750	78	2	815.71
4366	1750	176	3	72.99
4367	1751	214	1	4910.07
4368	1751	233	2	4106
4369	1751	83	3	4417.39
4370	1751	270	1	722.62
4371	1752	186	1	2565.65
4372	1753	12	2	1101.5
4373	1753	83	1	4417.39
4374	1753	50	1	1046.08
4375	1753	16	2	102.83
4376	1754	194	1	1093.18
4377	1754	145	1	2385.13
4378	1754	267	1	2103.51
4379	1754	149	3	291.03
4380	1755	59	2	730.65
4381	1755	232	2	3341
4382	1755	147	3	3349.79
4383	1755	252	2	4401.02
4384	1756	186	2	2565.65
4385	1756	234	3	932.4
4386	1756	1	2	191.33
4387	1757	129	2	202.95
4388	1757	102	2	2745.93
4389	1757	286	3	4172.2
4390	1758	40	1	858.05
4391	1758	20	1	1328.6
4392	1759	43	3	2806.51
4393	1759	147	2	3349.79
4394	1760	226	2	756.45
4395	1761	62	2	2224.13
4396	1761	219	1	2048.68
4397	1761	67	3	1964.81
4398	1761	65	3	2587.37
4399	1762	66	2	1503.95
4400	1763	275	1	4006.2
4401	1763	50	1	1046.08
4402	1763	235	2	3594.23
4403	1764	269	2	3157.69
4404	1765	286	3	4172.2
4405	1766	90	3	4688.22
4406	1766	247	2	1184.86
4407	1767	146	1	2941.2
4408	1767	72	1	2882.92
4409	1767	237	1	2692.44
4410	1768	166	2	4892.93
4411	1768	162	1	1795.78
4412	1769	82	2	4318.55
4413	1769	217	3	2395.7
4414	1770	243	1	1559.6
4415	1770	236	1	4146.5
4416	1771	117	2	2915.46
4417	1771	177	2	2242.63
4418	1771	278	2	490.65
4419	1772	36	3	1758.9
4420	1773	188	1	1609.19
4421	1773	148	1	4099.98
4422	1773	268	2	1236.3
4423	1773	61	3	909.56
4424	1774	119	2	1689.99
4425	1774	5	1	141.82
4426	1775	71	3	1326.14
4427	1775	266	2	4890.54
4428	1775	236	1	4146.5
4429	1775	111	2	3620.9
4430	1776	22	1	4690.3
4431	1776	47	2	3890.02
4432	1776	17	3	2190.17
4433	1777	11	3	506.08
4434	1777	197	3	4694.81
4435	1778	37	1	1864.21
4436	1778	82	2	4318.55
4437	1779	185	3	409.7
4438	1779	251	2	1805.2
4439	1780	26	3	3588.62
4440	1780	60	3	1815.93
4441	1780	198	1	364.63
4442	1780	198	1	364.63
4443	1781	162	3	1795.78
4444	1781	16	3	102.83
4445	1781	197	2	4694.81
4446	1781	145	1	2385.13
4447	1782	23	1	1005.52
4448	1782	114	2	2910.44
4449	1782	192	1	2536.07
4450	1782	270	2	722.62
4451	1783	146	3	2941.2
4452	1783	160	3	2070.69
4453	1783	24	3	4690.55
4454	1784	45	3	3291.46
4455	1784	201	1	4623.06
4456	1785	155	1	775.75
4457	1785	133	1	4849.77
4458	1785	273	3	4085.21
4459	1785	169	1	712.16
4460	1786	209	3	234.45
4461	1786	30	1	3703.24
4462	1787	2	2	966.11
4463	1787	136	3	2382.64
4464	1787	167	3	1076.65
4465	1788	245	3	1068.63
4466	1788	80	3	3236.37
4467	1788	260	3	862.56
4468	1789	208	2	2433.91
4469	1789	249	2	4366.54
4470	1790	132	2	4779.91
4471	1791	205	2	3433.63
4472	1791	240	3	2323.41
4473	1791	159	2	701.89
4474	1792	253	2	951.68
4475	1793	121	2	2118.88
4476	1794	187	3	3396.6
4477	1794	5	1	141.82
4478	1794	131	3	2342.86
4479	1794	44	3	1915.58
4480	1795	113	2	454.29
4481	1796	199	3	3626.05
4482	1796	68	1	762.99
4483	1796	166	3	4892.93
4484	1796	80	3	3236.37
4485	1797	79	2	2292.12
4486	1797	196	3	4031.56
4487	1798	11	1	506.08
4488	1799	242	1	3059.6
4489	1799	240	3	2323.41
4490	1799	179	3	3986.65
4491	1800	153	1	3962.38
4492	1801	204	3	1610.65
4493	1801	197	1	4694.81
4494	1801	242	2	3059.6
4495	1801	125	2	4769.92
4496	1802	31	2	1419.3
4497	1802	98	2	4615.67
4498	1802	63	2	2959.82
4499	1803	10	2	620.57
4500	1803	1	1	191.33
4501	1803	98	2	4615.67
4502	1803	264	3	21.64
4503	1804	270	1	722.62
4504	1804	164	3	1658.82
4505	1805	156	1	3045.31
4506	1806	111	2	3620.9
4507	1806	99	2	2939.03
4508	1807	273	2	4085.21
4509	1808	122	3	2787.78
4510	1808	124	2	214.08
4511	1808	143	2	3191.91
4512	1808	95	1	1494.05
4513	1809	105	1	3439.98
4514	1809	122	3	2787.78
4515	1810	151	1	4403.59
4516	1810	235	2	3594.23
4517	1811	172	1	2563.06
4518	1811	59	3	730.65
4519	1811	62	2	2224.13
4520	1812	79	2	2292.12
4521	1812	171	2	1695.63
4522	1813	25	1	2062.34
4523	1813	21	3	1379.26
4524	1813	164	3	1658.82
4525	1813	45	2	3291.46
4526	1814	215	2	1607.8
4527	1815	42	3	3790.97
4528	1815	198	2	364.63
4529	1815	268	1	1236.3
4530	1815	274	3	1474.35
4531	1816	277	3	1515.88
4532	1816	118	2	1653.35
4533	1816	232	2	3341
4534	1817	84	2	4234.55
4535	1817	150	2	4133.82
4536	1818	108	3	600.5
4537	1818	267	3	2103.51
4538	1818	91	1	4264.66
4539	1819	241	3	1157.85
4540	1819	76	3	4613.91
4541	1820	110	1	1086.99
4542	1820	70	2	2042.86
4543	1820	277	1	1515.88
4544	1821	124	3	214.08
4545	1821	187	1	3396.6
4546	1821	117	1	2915.46
4547	1821	156	1	3045.31
4548	1822	3	1	2367.32
4549	1823	110	2	1086.99
4550	1823	241	2	1157.85
4551	1823	197	2	4694.81
4552	1824	64	1	2660.67
4553	1824	277	1	1515.88
4554	1824	228	3	3835.09
4555	1824	177	2	2242.63
4556	1825	83	3	4417.39
4557	1825	267	3	2103.51
4558	1826	40	2	858.05
4559	1826	23	2	1005.52
4560	1826	12	3	1101.5
4561	1826	225	1	1270.52
4562	1827	202	3	3909
4563	1827	287	1	940.45
4564	1828	205	3	3433.63
4565	1828	224	2	1331.69
4566	1828	196	2	4031.56
4567	1828	145	3	2385.13
4568	1829	251	3	1805.2
4569	1829	38	3	3644.69
4570	1830	28	2	181.41
4571	1830	172	1	2563.06
4572	1830	47	3	3890.02
4573	1830	138	2	1274.72
4574	1831	236	1	4146.5
4575	1831	29	3	2462.95
4576	1832	136	1	2382.64
4577	1832	81	1	4381.84
4578	1833	61	3	909.56
4579	1833	267	3	2103.51
4580	1833	53	1	4126.49
4581	1833	43	3	2806.51
4582	1834	164	1	1658.82
4583	1834	151	2	4403.59
4584	1834	11	1	506.08
4585	1834	35	2	4477.11
4586	1835	128	3	2505.19
4587	1836	45	3	3291.46
4588	1836	265	3	2047.67
4589	1836	254	3	3633.59
4590	1837	212	3	4821.33
4591	1837	62	3	2224.13
4592	1837	30	1	3703.24
4593	1837	93	2	1816.18
4594	1838	25	3	2062.34
4595	1838	73	2	1107.02
4596	1839	229	2	98.01
4597	1840	269	2	3157.69
4598	1840	70	1	2042.86
4599	1840	19	3	568.33
4600	1841	24	3	4690.55
4601	1841	259	3	2013.76
4602	1841	19	2	568.33
4603	1842	137	3	2923.1
4604	1843	46	1	2636.92
4605	1843	281	2	3478.07
4606	1843	184	2	2992.36
4607	1843	111	1	3620.9
4608	1844	193	3	4213.62
4609	1844	43	3	2806.51
4610	1844	252	3	4401.02
4611	1845	147	3	3349.79
4612	1846	213	3	3862.89
4613	1847	137	1	2923.1
4614	1847	33	2	2850.43
4615	1847	136	1	2382.64
4616	1847	201	2	4623.06
4617	1848	115	3	1288.82
4618	1848	6	1	2486.1
4619	1848	248	3	4741.62
4620	1848	273	1	4085.21
4621	1849	47	2	3890.02
4622	1849	55	2	683.16
4623	1850	12	2	1101.5
4624	1850	272	1	1745.88
4625	1851	249	1	4366.54
4626	1851	85	1	1637.43
4627	1851	30	3	3703.24
4628	1852	244	1	2920.97
4629	1852	172	2	2563.06
4630	1852	114	2	2910.44
4631	1852	145	3	2385.13
4632	1853	216	2	3336.09
4633	1853	228	2	3835.09
4634	1853	146	3	2941.2
4635	1853	106	2	836.74
4636	1854	223	3	1505.96
4637	1855	165	3	87.49
4638	1856	134	2	2426.17
4639	1857	256	3	415.16
4640	1857	277	3	1515.88
4641	1858	107	3	1221.14
4642	1858	179	2	3986.65
4643	1859	209	2	234.45
4644	1859	92	3	412.91
4645	1859	23	3	1005.52
4646	1860	105	1	3439.98
4647	1861	93	2	1816.18
4648	1861	43	1	2806.51
4649	1861	7	2	266.7
4650	1862	99	1	2939.03
4651	1863	99	3	2939.03
4652	1863	239	3	944.49
4653	1863	203	2	2771.23
4654	1864	37	1	1864.21
4655	1865	104	3	4433.01
4656	1866	162	1	1795.78
4657	1867	281	3	3478.07
4658	1868	279	1	226.9
4659	1868	158	1	3535
4660	1868	157	2	1068.08
4661	1869	99	3	2939.03
4662	1869	29	3	2462.95
4663	1869	127	1	4223.36
4664	1869	237	3	2692.44
4665	1870	265	1	2047.67
4666	1870	124	1	214.08
4667	1870	23	3	1005.52
4668	1870	180	3	4230.62
4669	1871	52	1	923.7
4670	1872	18	2	4524.74
4671	1872	272	2	1745.88
4672	1873	112	3	4900.94
4673	1874	275	3	4006.2
4674	1874	96	2	2212.98
4675	1875	276	2	4043.27
4676	1876	74	1	3566.61
4677	1877	228	1	3835.09
4678	1878	150	3	4133.82
4679	1878	32	2	1240.3
4680	1879	219	3	2048.68
4681	1879	90	1	4688.22
4682	1879	270	3	722.62
4683	1879	252	1	4401.02
4684	1880	98	1	4615.67
4685	1880	282	3	2425.15
4686	1880	35	1	4477.11
4687	1881	210	2	250.03
4688	1881	185	2	409.7
4689	1881	228	3	3835.09
4690	1882	187	3	3396.6
4691	1882	286	3	4172.2
4692	1883	11	1	506.08
4693	1884	229	2	98.01
4694	1884	90	3	4688.22
4695	1884	209	1	234.45
4696	1885	131	2	2342.86
4697	1885	285	1	2333.4
4698	1885	62	2	2224.13
4699	1885	80	3	3236.37
4700	1886	144	1	1750.96
4701	1886	186	2	2565.65
4702	1886	223	3	1505.96
4703	1887	147	3	3349.79
4704	1887	117	2	2915.46
4705	1887	208	3	2433.91
4706	1887	104	1	4433.01
4707	1888	49	1	2244.16
4708	1888	288	3	2851.1
4709	1888	30	1	3703.24
4710	1889	130	1	1198.9
4711	1889	173	3	4817.58
4712	1889	277	3	1515.88
4713	1890	76	3	4613.91
4714	1890	24	3	4690.55
4715	1890	195	3	3424.4
4716	1891	69	3	4969.99
4717	1892	211	2	4341.33
4718	1892	1	3	191.33
4719	1892	123	1	60.63
4720	1892	213	1	3862.89
4721	1893	127	2	4223.36
4722	1893	157	2	1068.08
4723	1893	18	1	4524.74
4724	1893	20	2	1328.6
4725	1894	110	2	1086.99
4726	1894	253	1	951.68
4727	1895	205	3	3433.63
4728	1895	244	1	2920.97
4729	1895	169	2	712.16
4730	1895	147	1	3349.79
4731	1896	164	2	1658.82
4732	1897	180	3	4230.62
4733	1897	98	1	4615.67
4734	1898	127	2	4223.36
4735	1898	267	3	2103.51
4736	1898	213	3	3862.89
4737	1899	84	2	4234.55
4738	1899	53	1	4126.49
4739	1899	49	3	2244.16
4740	1899	40	3	858.05
4741	1900	162	3	1795.78
4742	1900	107	1	1221.14
4743	1901	32	3	1240.3
4744	1902	243	2	1559.6
4745	1902	124	1	214.08
4746	1902	278	2	490.65
4747	1903	7	3	266.7
4748	1903	235	1	3594.23
4749	1903	105	2	3439.98
4750	1903	54	2	1431.17
4751	1904	8	2	697.97
4752	1904	83	1	4417.39
4753	1905	235	1	3594.23
4754	1905	88	2	4844.03
4755	1905	65	1	2587.37
4756	1905	143	3	3191.91
4757	1906	26	1	3588.62
4758	1907	60	3	1815.93
4759	1907	96	2	2212.98
4760	1908	256	1	415.16
4761	1908	204	2	1610.65
4762	1909	39	2	3209.83
4763	1910	194	3	1093.18
4764	1911	166	1	4892.93
4765	1912	27	2	1223.17
4766	1912	56	1	3316.85
4767	1912	154	3	4068.96
4768	1913	90	3	4688.22
4769	1913	168	2	39.25
4770	1914	11	1	506.08
4771	1914	132	2	4779.91
4772	1914	75	2	2446.53
4773	1915	205	3	3433.63
4774	1916	84	2	4234.55
4775	1916	163	3	2710.75
4776	1916	89	2	236.47
4777	1917	260	2	862.56
4778	1917	211	2	4341.33
4779	1917	247	1	1184.86
4780	1918	26	1	3588.62
4781	1918	243	2	1559.6
4782	1918	198	3	364.63
4783	1919	153	3	3962.38
4784	1919	61	3	909.56
4785	1919	235	1	3594.23
4786	1920	68	1	762.99
4787	1920	33	2	2850.43
4788	1920	48	2	2145.74
4789	1921	107	1	1221.14
4790	1921	6	3	2486.1
4791	1921	193	1	4213.62
4792	1922	213	1	3862.89
4793	1922	83	3	4417.39
4794	1922	257	1	1295.43
4795	1922	113	2	454.29
4796	1923	38	3	3644.69
4797	1923	171	1	1695.63
4798	1923	218	1	893.42
4799	1924	90	2	4688.22
4800	1924	19	1	568.33
4801	1924	282	2	2425.15
4802	1924	153	3	3962.38
4803	1925	93	1	1816.18
4804	1925	25	1	2062.34
4805	1925	18	1	4524.74
4806	1926	128	1	2505.19
4807	1926	131	3	2342.86
4808	1926	173	2	4817.58
4809	1927	82	2	4318.55
4810	1927	96	1	2212.98
4811	1927	182	2	2508.73
4812	1927	128	1	2505.19
4813	1928	172	3	2563.06
4814	1928	119	1	1689.99
4815	1928	189	2	249.23
4816	1929	228	1	3835.09
4817	1929	34	3	2318.62
4818	1929	12	1	1101.5
4819	1930	133	3	4849.77
4820	1930	239	2	944.49
4821	1930	109	1	4505.02
4822	1930	122	3	2787.78
4823	1931	105	3	3439.98
4824	1931	231	1	2475.99
4825	1932	222	2	3539.2
4826	1932	169	1	712.16
4827	1932	183	2	4624.85
4828	1933	277	1	1515.88
4829	1934	215	2	1607.8
4830	1934	188	3	1609.19
4831	1935	237	3	2692.44
4832	1935	8	2	697.97
4833	1935	115	1	1288.82
4834	1936	164	2	1658.82
4835	1936	148	2	4099.98
4836	1936	146	1	2941.2
4837	1936	2	2	966.11
4838	1937	288	3	2851.1
4839	1937	166	2	4892.93
4840	1937	287	1	940.45
4841	1938	280	3	4981.15
4842	1938	165	1	87.49
4843	1939	91	2	4264.66
4844	1939	27	3	1223.17
4845	1939	184	2	2992.36
4846	1939	5	3	141.82
4847	1940	67	3	1964.81
4848	1941	31	3	1419.3
4849	1942	123	3	60.63
4850	1942	202	2	3909
4851	1942	140	2	687.7
4852	1943	229	3	98.01
4853	1943	59	2	730.65
4854	1943	225	1	1270.52
4855	1943	25	3	2062.34
4856	1944	180	3	4230.62
4857	1944	219	2	2048.68
4858	1945	190	2	639.28
4859	1946	266	2	4890.54
4860	1946	46	1	2636.92
4861	1947	127	1	4223.36
4862	1947	65	2	2587.37
4863	1947	66	3	1503.95
4864	1947	215	2	1607.8
4865	1948	53	1	4126.49
4866	1948	69	1	4969.99
4867	1948	239	3	944.49
4868	1949	229	3	98.01
4869	1950	98	3	4615.67
4870	1950	30	3	3703.24
4871	1950	131	2	2342.86
4872	1950	182	2	2508.73
4873	1951	69	3	4969.99
4874	1951	29	2	2462.95
4875	1951	265	2	2047.67
4876	1951	227	2	578.23
4877	1952	41	2	2604.51
4878	1952	39	3	3209.83
4879	1953	253	3	951.68
4880	1953	181	1	749.09
4881	1953	71	3	1326.14
4882	1953	259	3	2013.76
4883	1954	39	3	3209.83
4884	1955	274	3	1474.35
4885	1955	194	1	1093.18
4886	1955	62	1	2224.13
4887	1956	190	2	639.28
4888	1956	30	3	3703.24
4889	1957	30	2	3703.24
4890	1957	118	2	1653.35
4891	1957	111	3	3620.9
4892	1958	112	3	4900.94
4893	1958	11	1	506.08
4894	1959	168	1	39.25
4895	1959	30	2	3703.24
4896	1959	206	2	2378.11
4897	1960	200	2	2691.81
4898	1961	201	1	4623.06
4899	1962	267	1	2103.51
4900	1962	119	1	1689.99
4901	1962	150	2	4133.82
4902	1962	152	3	1416.85
4903	1963	37	3	1864.21
4904	1964	124	1	214.08
4905	1964	216	1	3336.09
4906	1964	84	1	4234.55
4907	1965	71	2	1326.14
4908	1965	250	3	810.55
4909	1965	149	3	291.03
4910	1966	96	1	2212.98
4911	1966	188	2	1609.19
4912	1967	180	2	4230.62
4913	1967	160	3	2070.69
4914	1967	125	3	4769.92
4915	1967	250	1	810.55
4916	1968	56	1	3316.85
4917	1969	143	3	3191.91
4918	1969	278	1	490.65
4919	1970	54	1	1431.17
4920	1970	252	1	4401.02
4921	1970	268	3	1236.3
4922	1970	10	2	620.57
4923	1971	163	1	2710.75
4924	1971	183	1	4624.85
4925	1971	219	3	2048.68
4926	1972	104	3	4433.01
4927	1972	280	1	4981.15
4928	1972	208	3	2433.91
4929	1972	208	2	2433.91
4930	1973	247	3	1184.86
4931	1973	45	3	3291.46
4932	1973	34	3	2318.62
4933	1973	40	2	858.05
4934	1974	198	1	364.63
4935	1974	16	3	102.83
4936	1975	185	1	409.7
4937	1975	169	2	712.16
4938	1976	146	1	2941.2
4939	1977	119	3	1689.99
4940	1978	67	1	1964.81
4941	1978	250	1	810.55
4942	1978	48	2	2145.74
4943	1978	224	3	1331.69
4944	1979	229	3	98.01
4945	1979	272	1	1745.88
4946	1980	115	3	1288.82
4947	1980	92	3	412.91
4948	1980	286	1	4172.2
4949	1980	187	2	3396.6
4950	1981	217	3	2395.7
4951	1981	137	2	2923.1
4952	1981	50	1	1046.08
4953	1982	85	3	1637.43
4954	1982	188	3	1609.19
4955	1983	72	2	2882.92
4956	1984	16	3	102.83
4957	1984	141	3	1955.22
4958	1984	200	2	2691.81
4959	1984	35	1	4477.11
4960	1985	175	2	2039.09
4961	1986	160	2	2070.69
4962	1986	108	3	600.5
4963	1986	78	2	815.71
4964	1987	186	1	2565.65
4965	1987	209	3	234.45
4966	1987	51	3	3296.19
4967	1987	222	2	3539.2
4968	1988	198	1	364.63
4969	1988	218	3	893.42
4970	1988	213	2	3862.89
4971	1988	148	2	4099.98
4972	1989	107	1	1221.14
4973	1990	85	3	1637.43
4974	1991	288	2	2851.1
4975	1991	161	1	1090.52
4976	1991	20	1	1328.6
4977	1992	207	2	2636.95
4978	1992	45	1	3291.46
4979	1992	158	1	3535
4980	1992	183	1	4624.85
4981	1993	282	3	2425.15
4982	1993	193	3	4213.62
4983	1993	10	3	620.57
4984	1993	257	2	1295.43
4985	1994	66	3	1503.95
4986	1994	172	3	2563.06
4987	1995	193	1	4213.62
4988	1995	46	3	2636.92
4989	1996	128	1	2505.19
4990	1996	198	2	364.63
4991	1996	50	1	1046.08
4992	1996	208	1	2433.91
4993	1997	90	2	4688.22
4994	1997	221	3	3045.81
4995	1997	144	1	1750.96
4996	1997	151	1	4403.59
4997	1998	45	2	3291.46
4998	1998	68	1	762.99
4999	1998	101	2	3245.12
5000	1999	16	3	102.83
5001	1999	36	2	1758.9
5002	1999	78	3	815.71
5003	1999	173	2	4817.58
5004	2000	196	2	4031.56
5005	2000	191	1	942.59
5006	2000	209	1	234.45
5007	2001	276	3	4043.27
5008	2001	164	1	1658.82
5009	2001	273	3	4085.21
5010	2001	273	3	4085.21
5011	2002	285	1	2333.4
5012	2002	21	3	1379.26
5013	2003	142	3	1631.1
5014	2003	113	1	454.29
5015	2003	276	1	4043.27
5016	2004	247	1	1184.86
5017	2004	18	2	4524.74
5018	2004	151	1	4403.59
5019	2004	205	2	3433.63
5020	2005	178	1	2463.95
5021	2005	77	2	79.66
5022	2005	274	2	1474.35
5023	2005	209	3	234.45
5024	2006	204	3	1610.65
5025	2006	185	1	409.7
5026	2006	57	3	2713.28
5027	2007	146	2	2941.2
5028	2007	65	1	2587.37
5029	2007	123	2	60.63
5030	2007	227	2	578.23
5031	2008	238	2	2976.41
5032	2008	112	1	4900.94
5033	2008	192	3	2536.07
5034	2008	266	2	4890.54
5035	2009	252	1	4401.02
5036	2009	278	3	490.65
5037	2009	150	3	4133.82
5038	2009	20	1	1328.6
5039	2010	95	3	1494.05
5040	2011	234	1	932.4
5041	2011	181	1	749.09
5042	2011	71	3	1326.14
5043	2011	113	3	454.29
5044	2012	109	2	4505.02
5045	2013	77	1	79.66
5046	2014	205	1	3433.63
5047	2014	121	1	2118.88
5048	2014	53	2	4126.49
5049	2015	164	3	1658.82
5050	2015	283	3	4667.36
5051	2016	82	2	4318.55
5052	2016	45	3	3291.46
5053	2016	267	3	2103.51
5054	2016	157	2	1068.08
5055	2017	96	2	2212.98
5056	2018	77	3	79.66
5057	2019	245	2	1068.63
5058	2020	111	3	3620.9
5059	2020	234	1	932.4
5060	2020	279	1	226.9
5061	2021	285	3	2333.4
5062	2021	264	3	21.64
5063	2022	196	1	4031.56
5064	2022	214	2	4910.07
5065	2022	65	1	2587.37
5066	2022	47	1	3890.02
5067	2023	58	1	121.51
5068	2024	115	3	1288.82
5069	2025	30	1	3703.24
5070	2025	133	3	4849.77
5071	2025	20	3	1328.6
5072	2026	21	1	1379.26
5073	2027	73	3	1107.02
5074	2027	40	2	858.05
5075	2028	264	3	21.64
5076	2029	94	3	1034.65
5077	2030	198	2	364.63
5078	2030	225	2	1270.52
5079	2030	220	2	2654.61
5080	2030	169	1	712.16
5081	2031	266	2	4890.54
5082	2031	52	1	923.7
5083	2031	57	3	2713.28
5084	2031	95	1	1494.05
5085	2032	71	1	1326.14
5086	2032	82	1	4318.55
5087	2033	153	3	3962.38
5088	2033	262	3	4423.65
5089	2033	155	2	775.75
5090	2033	276	3	4043.27
5091	2034	166	1	4892.93
5092	2034	276	2	4043.27
5093	2035	119	3	1689.99
5094	2035	122	3	2787.78
5095	2035	260	3	862.56
5096	2035	119	3	1689.99
5097	2036	133	3	4849.77
5098	2036	84	2	4234.55
5099	2036	139	2	778.6
5100	2036	97	3	2847.91
5101	2037	152	3	1416.85
5102	2038	138	2	1274.72
5103	2038	220	2	2654.61
5104	2038	273	2	4085.21
5105	2039	26	3	3588.62
5106	2040	65	2	2587.37
5107	2040	239	2	944.49
5108	2041	238	3	2976.41
5109	2041	154	1	4068.96
5110	2042	28	2	181.41
5111	2042	83	3	4417.39
5112	2042	79	1	2292.12
5113	2042	140	2	687.7
5114	2043	130	3	1198.9
5115	2044	131	3	2342.86
5116	2044	138	1	1274.72
5117	2044	260	3	862.56
5118	2044	69	3	4969.99
5119	2045	274	1	1474.35
5120	2045	145	2	2385.13
5121	2045	56	3	3316.85
5122	2046	97	2	2847.91
5123	2046	28	2	181.41
5124	2046	124	2	214.08
5125	2047	199	3	3626.05
5126	2047	138	2	1274.72
5127	2048	252	1	4401.02
5128	2048	79	1	2292.12
5129	2049	76	1	4613.91
5130	2049	59	1	730.65
5131	2050	228	1	3835.09
5132	2050	220	2	2654.61
5133	2051	170	3	2730.72
5134	2051	196	2	4031.56
5135	2051	18	1	4524.74
5136	2052	283	2	4667.36
5137	2052	243	1	1559.6
5138	2052	125	3	4769.92
5139	2052	243	2	1559.6
5140	2053	282	2	2425.15
5141	2053	20	1	1328.6
5142	2054	251	1	1805.2
5143	2054	278	3	490.65
5144	2054	142	3	1631.1
5145	2055	212	2	4821.33
5146	2055	82	1	4318.55
5147	2056	279	1	226.9
5148	2056	19	3	568.33
5149	2056	91	2	4264.66
5150	2057	205	2	3433.63
5151	2057	14	1	4363.16
5152	2058	16	3	102.83
5153	2058	66	3	1503.95
5154	2058	140	2	687.7
5155	2059	190	3	639.28
5156	2060	172	2	2563.06
5157	2060	97	2	2847.91
5158	2061	200	3	2691.81
5159	2061	65	2	2587.37
5160	2061	49	3	2244.16
5161	2062	283	3	4667.36
5162	2062	245	1	1068.63
5163	2062	204	2	1610.65
5164	2063	33	3	2850.43
5165	2063	26	3	3588.62
5166	2063	172	3	2563.06
5167	2063	31	2	1419.3
5168	2064	171	3	1695.63
5169	2064	59	2	730.65
5170	2064	89	1	236.47
5171	2064	42	1	3790.97
5172	2065	249	2	4366.54
5173	2066	141	1	1955.22
5174	2066	187	1	3396.6
5175	2066	124	2	214.08
5176	2067	166	3	4892.93
5177	2067	212	1	4821.33
5178	2067	264	3	21.64
5179	2068	38	1	3644.69
5180	2068	267	1	2103.51
5181	2069	143	1	3191.91
5182	2069	70	1	2042.86
5183	2069	242	3	3059.6
5184	2069	23	1	1005.52
5185	2070	65	1	2587.37
5186	2070	60	3	1815.93
5187	2070	172	2	2563.06
5188	2071	101	1	3245.12
5189	2072	156	2	3045.31
5190	2072	89	1	236.47
5191	2072	140	1	687.7
5192	2072	227	1	578.23
5193	2073	157	3	1068.08
5194	2073	95	2	1494.05
5195	2074	232	1	3341
5196	2074	19	3	568.33
5197	2075	171	2	1695.63
5198	2076	95	2	1494.05
5199	2077	27	3	1223.17
5200	2077	130	1	1198.9
5201	2077	28	1	181.41
5202	2078	158	3	3535
5203	2079	129	2	202.95
5204	2079	251	1	1805.2
5205	2079	198	3	364.63
5206	2079	273	1	4085.21
5207	2080	227	1	578.23
5208	2080	110	3	1086.99
5209	2081	107	1	1221.14
5210	2081	162	2	1795.78
5211	2082	22	3	4690.3
5212	2082	219	2	2048.68
5213	2083	164	1	1658.82
5214	2083	142	1	1631.1
5215	2083	51	1	3296.19
5216	2083	222	2	3539.2
5217	2084	37	1	1864.21
5218	2084	93	3	1816.18
5219	2084	56	2	3316.85
5220	2084	200	3	2691.81
5221	2085	205	1	3433.63
5222	2085	274	1	1474.35
5223	2085	186	2	2565.65
5224	2085	21	3	1379.26
5225	2086	256	1	415.16
5226	2086	45	2	3291.46
5227	2087	237	1	2692.44
5228	2088	190	2	639.28
5229	2088	204	2	1610.65
5230	2088	131	1	2342.86
5231	2088	200	1	2691.81
5232	2089	208	3	2433.91
5233	2089	168	2	39.25
5234	2089	216	1	3336.09
5235	2089	182	3	2508.73
5236	2090	251	3	1805.2
5237	2090	275	2	4006.2
5238	2090	235	1	3594.23
5239	2091	30	2	3703.24
5240	2091	132	1	4779.91
5241	2091	199	3	3626.05
5242	2091	229	2	98.01
5243	2092	23	3	1005.52
5244	2092	109	1	4505.02
5245	2093	204	3	1610.65
5246	2094	213	1	3862.89
5247	2094	213	2	3862.89
5248	2094	70	2	2042.86
5249	2094	134	2	2426.17
5250	2095	215	1	1607.8
5251	2095	43	2	2806.51
5252	2095	198	2	364.63
5253	2096	33	3	2850.43
5254	2096	132	1	4779.91
5255	2096	260	2	862.56
5256	2096	166	2	4892.93
5257	2097	238	2	2976.41
5258	2097	111	2	3620.9
5259	2097	252	2	4401.02
5260	2097	51	2	3296.19
5261	2098	267	3	2103.51
5262	2098	71	3	1326.14
5263	2098	271	3	694.88
5264	2098	256	3	415.16
5265	2099	70	1	2042.86
5266	2099	165	2	87.49
5267	2099	100	3	3569.72
5268	2099	63	1	2959.82
5269	2100	109	1	4505.02
5270	2100	234	2	932.4
5271	2100	46	2	2636.92
5272	2100	108	2	600.5
5273	2101	43	2	2806.51
5274	2101	101	1	3245.12
5275	2101	44	2	1915.58
5276	2101	58	1	121.51
5277	2102	65	3	2587.37
5278	2102	239	2	944.49
5279	2102	213	3	3862.89
5280	2102	200	2	2691.81
5281	2103	125	1	4769.92
5282	2103	78	3	815.71
5283	2103	111	3	3620.9
5284	2104	138	3	1274.72
5285	2104	6	1	2486.1
5286	2104	8	3	697.97
5287	2105	81	2	4381.84
5288	2106	77	1	79.66
5289	2106	12	1	1101.5
5290	2106	112	1	4900.94
5291	2107	134	1	2426.17
5292	2107	67	1	1964.81
5293	2107	188	2	1609.19
5294	2107	250	2	810.55
5295	2108	62	1	2224.13
5296	2108	192	1	2536.07
5297	2108	31	2	1419.3
5298	2108	156	3	3045.31
5299	2109	111	1	3620.9
5300	2110	193	2	4213.62
5301	2111	88	1	4844.03
5302	2111	256	1	415.16
5303	2111	127	1	4223.36
5304	2111	121	1	2118.88
5305	2112	249	1	4366.54
5306	2112	179	1	3986.65
5307	2112	190	3	639.28
5308	2113	105	2	3439.98
5309	2113	19	2	568.33
5310	2114	208	2	2433.91
5311	2114	76	1	4613.91
5312	2115	168	1	39.25
5313	2115	21	3	1379.26
5314	2116	253	1	951.68
5315	2116	75	3	2446.53
5316	2117	250	3	810.55
5317	2118	188	3	1609.19
5318	2119	249	1	4366.54
5319	2120	280	2	4981.15
5320	2120	262	2	4423.65
5321	2120	280	1	4981.15
5322	2120	125	3	4769.92
5323	2121	102	1	2745.93
5324	2121	250	2	810.55
5325	2121	157	2	1068.08
5326	2122	224	2	1331.69
5327	2122	264	2	21.64
5328	2122	230	1	4283.99
5329	2122	8	1	697.97
5330	2123	257	1	1295.43
5331	2123	28	1	181.41
5332	2124	195	1	3424.4
5333	2124	32	3	1240.3
5334	2125	65	3	2587.37
5335	2125	159	1	701.89
5336	2126	44	3	1915.58
5337	2126	21	2	1379.26
5338	2126	276	1	4043.27
5339	2126	256	1	415.16
5340	2127	258	1	688.96
5341	2128	41	3	2604.51
5342	2129	252	3	4401.02
5343	2130	278	2	490.65
5344	2131	93	2	1816.18
5345	2131	22	3	4690.3
5346	2131	192	2	2536.07
5347	2132	194	3	1093.18
5348	2133	103	2	2918.82
5349	2133	83	3	4417.39
5350	2133	108	1	600.5
5351	2134	210	2	250.03
5352	2134	162	1	1795.78
5353	2134	62	1	2224.13
5354	2134	139	2	778.6
5355	2135	170	3	2730.72
5356	2135	275	2	4006.2
5357	2135	228	1	3835.09
5358	2136	11	3	506.08
5359	2136	201	1	4623.06
5360	2136	174	1	4487.95
5361	2136	269	1	3157.69
5362	2137	51	3	3296.19
5363	2137	131	3	2342.86
5364	2138	44	3	1915.58
5365	2139	112	3	4900.94
5366	2139	167	3	1076.65
5367	2140	279	3	226.9
5368	2140	20	2	1328.6
5369	2140	111	1	3620.9
5370	2140	217	1	2395.7
5371	2141	176	2	72.99
5372	2141	258	3	688.96
5373	2142	77	2	79.66
5374	2142	89	2	236.47
5375	2142	33	3	2850.43
5376	2142	15	1	2025.71
5377	2143	93	3	1816.18
5378	2143	187	3	3396.6
5379	2143	72	1	2882.92
5380	2143	62	2	2224.13
5381	2144	89	1	236.47
5382	2144	141	3	1955.22
5383	2144	99	1	2939.03
5384	2145	173	2	4817.58
5385	2145	140	1	687.7
5386	2145	180	2	4230.62
5387	2145	41	2	2604.51
5388	2146	7	1	266.7
5389	2147	215	2	1607.8
5390	2147	120	1	1195.36
5391	2147	251	2	1805.2
5392	2148	83	2	4417.39
5393	2148	86	3	436.57
5394	2148	79	1	2292.12
5395	2149	205	1	3433.63
5396	2149	150	1	4133.82
5397	2149	100	1	3569.72
5398	2150	37	2	1864.21
5399	2150	202	2	3909
5400	2150	242	3	3059.6
5401	2151	69	1	4969.99
5402	2151	190	2	639.28
5403	2151	9	1	66.48
5404	2152	95	2	1494.05
5405	2152	175	2	2039.09
5406	2153	29	2	2462.95
5407	2153	202	3	3909
5408	2154	68	3	762.99
5409	2154	190	2	639.28
5410	2155	127	1	4223.36
5411	2156	33	3	2850.43
5412	2156	30	2	3703.24
5413	2157	136	2	2382.64
5414	2157	69	3	4969.99
5415	2158	170	3	2730.72
5416	2159	29	2	2462.95
5417	2159	155	3	775.75
5418	2160	93	2	1816.18
5419	2160	21	3	1379.26
5420	2160	255	3	2843.93
5421	2161	275	1	4006.2
5422	2161	232	3	3341
5423	2162	181	2	749.09
5424	2163	107	2	1221.14
5425	2164	103	3	2918.82
5426	2164	12	2	1101.5
5427	2164	79	3	2292.12
5428	2164	233	2	4106
5429	2165	247	3	1184.86
5430	2165	148	2	4099.98
5431	2165	276	3	4043.27
5432	2166	81	1	4381.84
5433	2167	189	2	249.23
5434	2167	61	3	909.56
5435	2167	239	2	944.49
5436	2167	25	2	2062.34
5437	2168	113	2	454.29
5438	2169	181	2	749.09
5439	2169	174	3	4487.95
5440	2169	288	1	2851.1
5441	2169	226	1	756.45
5442	2170	261	1	790.99
5443	2170	219	2	2048.68
5444	2171	137	2	2923.1
5445	2172	77	3	79.66
5446	2173	63	3	2959.82
5447	2173	40	1	858.05
5448	2173	203	3	2771.23
5449	2174	39	2	3209.83
5450	2174	244	3	2920.97
5451	2174	35	3	4477.11
5452	2175	183	3	4624.85
5453	2176	149	2	291.03
5454	2176	51	2	3296.19
5455	2176	225	2	1270.52
5456	2176	30	2	3703.24
5457	2177	111	2	3620.9
5458	2177	11	3	506.08
5459	2178	13	2	3965.42
5460	2178	201	2	4623.06
5461	2179	57	3	2713.28
5462	2179	1	3	191.33
5463	2179	287	3	940.45
5464	2179	19	3	568.33
5465	2180	276	2	4043.27
5466	2180	34	2	2318.62
5467	2181	172	3	2563.06
5468	2182	68	3	762.99
5469	2182	288	3	2851.1
5470	2182	163	3	2710.75
5471	2182	97	2	2847.91
5472	2183	33	1	2850.43
5473	2184	24	3	4690.55
5474	2184	108	3	600.5
5475	2185	73	1	1107.02
5476	2185	83	2	4417.39
5477	2185	218	1	893.42
5478	2185	24	1	4690.55
5479	2186	169	1	712.16
5480	2187	43	2	2806.51
5481	2188	123	2	60.63
5482	2189	249	1	4366.54
5483	2189	76	2	4613.91
5484	2190	157	2	1068.08
5485	2190	219	1	2048.68
5486	2190	196	1	4031.56
5487	2190	124	1	214.08
5488	2191	220	1	2654.61
5489	2191	287	1	940.45
5490	2191	157	2	1068.08
5491	2192	162	1	1795.78
5492	2192	157	3	1068.08
5493	2192	118	2	1653.35
5494	2193	224	2	1331.69
5495	2193	186	3	2565.65
5496	2193	26	1	3588.62
5497	2194	154	3	4068.96
5498	2194	202	1	3909
5499	2194	103	1	2918.82
5500	2195	192	3	2536.07
5501	2196	87	2	1159.3
5502	2196	26	3	3588.62
5503	2196	113	3	454.29
5504	2196	80	3	3236.37
5505	2197	225	3	1270.52
5506	2197	150	2	4133.82
5507	2198	262	3	4423.65
5508	2198	243	3	1559.6
5509	2198	274	3	1474.35
5510	2198	92	3	412.91
5511	2199	149	2	291.03
5512	2199	196	1	4031.56
5513	2200	227	2	578.23
5514	2200	150	2	4133.82
5515	2201	4	2	4444.26
5516	2201	239	1	944.49
5517	2202	76	2	4613.91
5518	2202	92	1	412.91
5519	2202	3	1	2367.32
5520	2203	163	3	2710.75
5521	2203	280	2	4981.15
5522	2203	6	1	2486.1
5523	2204	214	2	4910.07
5524	2204	172	2	2563.06
5525	2205	180	2	4230.62
5526	2205	156	1	3045.31
5527	2206	106	3	836.74
5528	2206	261	2	790.99
5529	2207	167	3	1076.65
5530	2207	98	2	4615.67
5531	2208	255	2	2843.93
5532	2209	82	3	4318.55
5533	2210	200	2	2691.81
5534	2210	176	2	72.99
5535	2211	182	2	2508.73
5536	2212	26	3	3588.62
5537	2212	234	3	932.4
5538	2212	15	1	2025.71
5539	2212	235	3	3594.23
5540	2213	237	2	2692.44
5541	2213	136	2	2382.64
5542	2214	55	3	683.16
5543	2215	282	2	2425.15
5544	2215	154	1	4068.96
5545	2215	29	1	2462.95
5546	2215	267	2	2103.51
5547	2216	135	1	40.1
5548	2216	191	3	942.59
5549	2217	168	2	39.25
5550	2217	270	2	722.62
5551	2218	268	1	1236.3
5552	2218	198	2	364.63
5553	2219	63	1	2959.82
5554	2219	179	3	3986.65
5555	2220	47	3	3890.02
5556	2220	86	3	436.57
5557	2220	60	2	1815.93
5558	2220	177	1	2242.63
5559	2221	79	1	2292.12
5560	2221	146	3	2941.2
5561	2222	217	2	2395.7
5562	2222	55	2	683.16
5563	2223	162	2	1795.78
5564	2224	272	1	1745.88
5565	2224	149	2	291.03
5566	2224	217	2	2395.7
5567	2224	48	3	2145.74
5568	2225	174	2	4487.95
5569	2225	135	2	40.1
5570	2226	258	2	688.96
5571	2227	107	3	1221.14
5572	2227	60	3	1815.93
5573	2227	57	1	2713.28
5574	2228	158	3	3535
5575	2228	17	3	2190.17
5576	2229	21	2	1379.26
5577	2229	128	1	2505.19
5578	2229	273	1	4085.21
5579	2230	65	2	2587.37
5580	2230	142	3	1631.1
5581	2230	227	2	578.23
5582	2230	133	1	4849.77
5583	2231	228	2	3835.09
5584	2231	156	2	3045.31
5585	2231	269	2	3157.69
5586	2231	179	2	3986.65
5587	2232	154	1	4068.96
5588	2233	8	2	697.97
5589	2233	156	3	3045.31
5590	2233	144	2	1750.96
5591	2233	37	1	1864.21
5592	2234	122	1	2787.78
5593	2234	162	1	1795.78
5594	2234	148	1	4099.98
5595	2234	2	2	966.11
5596	2235	244	1	2920.97
5597	2236	157	1	1068.08
5598	2237	47	2	3890.02
5599	2237	209	3	234.45
5600	2237	40	2	858.05
5601	2238	214	1	4910.07
5602	2238	96	1	2212.98
5603	2238	185	1	409.7
5604	2238	224	2	1331.69
5605	2239	130	2	1198.9
5606	2239	104	2	4433.01
5607	2239	106	1	836.74
5608	2240	1	3	191.33
5609	2241	172	1	2563.06
5610	2242	16	2	102.83
5611	2242	269	2	3157.69
5612	2242	239	1	944.49
5613	2242	230	2	4283.99
5614	2243	32	1	1240.3
5615	2243	26	2	3588.62
5616	2244	190	3	639.28
5617	2244	164	3	1658.82
5618	2245	144	2	1750.96
5619	2245	279	3	226.9
5620	2246	120	3	1195.36
5621	2246	177	1	2242.63
5622	2246	140	2	687.7
5623	2247	139	1	778.6
5624	2247	231	1	2475.99
5625	2248	9	1	66.48
5626	2248	171	2	1695.63
5627	2249	45	3	3291.46
5628	2249	227	3	578.23
5629	2249	208	2	2433.91
5630	2250	97	1	2847.91
5631	2250	232	1	3341
5632	2251	65	2	2587.37
5633	2251	50	1	1046.08
5634	2251	85	2	1637.43
5635	2251	114	1	2910.44
5636	2252	95	1	1494.05
5637	2252	140	1	687.7
5638	2252	95	2	1494.05
5639	2253	73	3	1107.02
5640	2253	281	3	3478.07
5641	2253	136	2	2382.64
5642	2254	99	2	2939.03
5643	2254	176	2	72.99
5644	2255	165	1	87.49
5645	2255	45	2	3291.46
5646	2255	43	1	2806.51
5647	2256	168	1	39.25
5648	2256	246	2	1498.73
5649	2257	211	2	4341.33
5650	2257	270	2	722.62
5651	2258	253	3	951.68
5652	2259	187	3	3396.6
5653	2260	77	1	79.66
5654	2260	85	1	1637.43
5655	2261	7	3	266.7
5656	2261	160	1	2070.69
5657	2262	192	2	2536.07
5658	2262	278	1	490.65
5659	2263	264	2	21.64
5660	2263	12	3	1101.5
5661	2264	168	3	39.25
5662	2264	87	1	1159.3
5663	2264	191	1	942.59
5664	2264	127	1	4223.36
5665	2265	203	3	2771.23
5666	2266	187	2	3396.6
5667	2266	235	2	3594.23
5668	2266	229	2	98.01
5669	2267	247	2	1184.86
5670	2267	163	2	2710.75
5671	2268	259	3	2013.76
5672	2268	41	1	2604.51
5673	2269	180	1	4230.62
5674	2269	207	2	2636.95
5675	2269	248	3	4741.62
5676	2270	284	3	4127.8
5677	2270	17	1	2190.17
5678	2271	110	2	1086.99
5679	2271	98	2	4615.67
5680	2271	287	1	940.45
5681	2271	28	2	181.41
5682	2272	271	3	694.88
5683	2272	284	2	4127.8
5684	2272	48	2	2145.74
5685	2273	99	3	2939.03
5686	2273	238	3	2976.41
5687	2273	73	3	1107.02
5688	2273	235	1	3594.23
5689	2274	250	2	810.55
5690	2274	172	2	2563.06
5691	2274	89	3	236.47
5692	2275	2	1	966.11
5693	2276	43	2	2806.51
5694	2277	117	3	2915.46
5695	2277	158	1	3535
5696	2277	165	2	87.49
5697	2278	1	3	191.33
5698	2278	138	1	1274.72
5699	2278	224	2	1331.69
5700	2279	28	3	181.41
5701	2279	171	3	1695.63
5702	2280	262	3	4423.65
5703	2280	125	2	4769.92
5704	2281	120	3	1195.36
5705	2281	104	2	4433.01
5706	2281	250	1	810.55
5707	2281	7	2	266.7
5708	2282	45	3	3291.46
5709	2282	122	2	2787.78
5710	2282	26	1	3588.62
5711	2282	6	2	2486.1
5712	2283	177	2	2242.63
5713	2284	109	3	4505.02
5714	2285	230	2	4283.99
5715	2285	167	2	1076.65
5716	2285	230	3	4283.99
5717	2286	37	1	1864.21
5718	2287	139	1	778.6
5719	2288	59	3	730.65
5720	2289	187	2	3396.6
5721	2289	147	2	3349.79
5722	2290	16	2	102.83
5723	2291	163	3	2710.75
5724	2291	56	1	3316.85
5725	2291	210	3	250.03
5726	2292	8	1	697.97
5727	2293	274	1	1474.35
5728	2293	228	3	3835.09
5729	2293	211	1	4341.33
5730	2293	116	1	331.25
5731	2294	19	3	568.33
5732	2294	215	1	1607.8
5733	2294	76	2	4613.91
5734	2294	2	3	966.11
5735	2295	288	1	2851.1
5736	2296	128	3	2505.19
5737	2296	149	2	291.03
5738	2297	251	1	1805.2
5739	2297	185	1	409.7
5740	2297	132	2	4779.91
5741	2297	247	3	1184.86
5742	2298	248	1	4741.62
5743	2298	187	2	3396.6
5744	2299	120	1	1195.36
5745	2299	237	3	2692.44
5746	2300	12	2	1101.5
5747	2301	167	3	1076.65
5748	2302	225	2	1270.52
5749	2302	95	3	1494.05
5750	2303	134	1	2426.17
5751	2303	132	3	4779.91
5752	2303	179	2	3986.65
5753	2304	211	2	4341.33
5754	2305	12	3	1101.5
5755	2305	86	2	436.57
5756	2305	200	2	2691.81
5757	2306	73	3	1107.02
5758	2306	195	3	3424.4
5759	2306	137	2	2923.1
5760	2307	207	1	2636.95
5761	2307	98	3	4615.67
5762	2307	113	2	454.29
5763	2307	120	3	1195.36
5764	2308	64	1	2660.67
5765	2309	46	2	2636.92
5766	2310	270	1	722.62
5767	2310	127	3	4223.36
5768	2311	219	2	2048.68
5769	2311	58	1	121.51
5770	2311	89	2	236.47
5771	2311	75	1	2446.53
5772	2312	156	3	3045.31
5773	2312	151	3	4403.59
5774	2312	284	1	4127.8
5775	2313	112	3	4900.94
5776	2313	39	3	3209.83
5777	2314	272	3	1745.88
5778	2314	263	3	283.98
5779	2314	224	2	1331.69
5780	2315	184	1	2992.36
5781	2315	18	3	4524.74
5782	2315	192	2	2536.07
5783	2316	237	2	2692.44
5784	2316	219	3	2048.68
5785	2317	184	3	2992.36
5786	2317	243	1	1559.6
5787	2317	20	3	1328.6
5788	2317	62	2	2224.13
5789	2318	216	3	3336.09
5790	2318	149	2	291.03
5791	2318	39	2	3209.83
5792	2318	11	2	506.08
5793	2319	185	1	409.7
5794	2319	172	1	2563.06
5795	2320	266	1	4890.54
5796	2321	77	1	79.66
5797	2321	231	2	2475.99
5798	2321	32	2	1240.3
5799	2321	164	2	1658.82
5800	2322	8	3	697.97
5801	2323	259	2	2013.76
5802	2324	125	2	4769.92
5803	2324	250	2	810.55
5804	2325	124	3	214.08
5805	2325	156	3	3045.31
5806	2325	26	3	3588.62
5807	2325	82	2	4318.55
5808	2326	167	1	1076.65
5809	2327	190	3	639.28
5810	2327	219	2	2048.68
5811	2327	224	2	1331.69
5812	2328	175	2	2039.09
5813	2328	228	2	3835.09
5814	2328	244	2	2920.97
5815	2329	180	1	4230.62
5816	2329	37	2	1864.21
5817	2329	143	1	3191.91
5818	2329	169	2	712.16
5819	2330	219	2	2048.68
5820	2331	262	3	4423.65
5821	2331	204	2	1610.65
5822	2331	225	2	1270.52
5823	2331	33	1	2850.43
5824	2332	133	2	4849.77
5825	2332	282	1	2425.15
5826	2332	65	1	2587.37
5827	2333	138	3	1274.72
5828	2334	8	1	697.97
5829	2335	100	2	3569.72
5830	2335	88	3	4844.03
5831	2335	174	1	4487.95
5832	2335	12	1	1101.5
5833	2336	95	1	1494.05
5834	2336	277	1	1515.88
5835	2336	106	1	836.74
5836	2337	124	3	214.08
5837	2337	85	2	1637.43
5838	2338	162	1	1795.78
5839	2338	13	2	3965.42
5840	2339	247	1	1184.86
5841	2340	66	3	1503.95
5842	2340	25	2	2062.34
5843	2340	195	1	3424.4
5844	2340	237	2	2692.44
5845	2341	285	2	2333.4
5846	2341	21	3	1379.26
5847	2342	121	1	2118.88
5848	2342	39	3	3209.83
5849	2343	55	3	683.16
5850	2343	106	1	836.74
5851	2343	11	3	506.08
5852	2343	239	1	944.49
5853	2344	187	1	3396.6
5854	2345	93	1	1816.18
5855	2345	187	2	3396.6
5856	2345	2	3	966.11
5857	2345	86	2	436.57
5858	2346	70	1	2042.86
5859	2346	169	3	712.16
5860	2346	58	1	121.51
5861	2347	209	3	234.45
5862	2347	185	3	409.7
5863	2347	247	1	1184.86
5864	2347	48	2	2145.74
5865	2348	264	1	21.64
5866	2348	189	1	249.23
5867	2348	266	3	4890.54
5868	2348	196	1	4031.56
5869	2349	171	2	1695.63
5870	2349	19	1	568.33
5871	2349	143	3	3191.91
5872	2349	181	2	749.09
5873	2350	140	1	687.7
5874	2351	37	3	1864.21
5875	2351	41	2	2604.51
5876	2352	99	3	2939.03
5877	2352	10	1	620.57
5878	2352	95	1	1494.05
5879	2353	77	3	79.66
5880	2353	29	3	2462.95
5881	2353	243	2	1559.6
5882	2353	174	1	4487.95
5883	2354	275	1	4006.2
5884	2354	161	3	1090.52
5885	2355	257	3	1295.43
5886	2355	258	3	688.96
5887	2355	174	3	4487.95
5888	2355	240	3	2323.41
5889	2356	85	2	1637.43
5890	2356	87	3	1159.3
5891	2356	284	2	4127.8
5892	2357	124	2	214.08
5893	2357	164	1	1658.82
5894	2357	142	3	1631.1
5895	2357	38	3	3644.69
5896	2358	278	1	490.65
5897	2359	212	3	4821.33
5898	2360	183	1	4624.85
5899	2360	55	2	683.16
5900	2360	224	2	1331.69
5901	2360	12	2	1101.5
5902	2361	117	2	2915.46
5903	2361	67	3	1964.81
5904	2362	32	2	1240.3
5905	2363	29	3	2462.95
5906	2363	224	2	1331.69
5907	2363	30	1	3703.24
5908	2363	204	1	1610.65
5909	2364	142	2	1631.1
5910	2364	286	3	4172.2
5911	2364	264	2	21.64
5912	2365	40	1	858.05
5913	2365	154	1	4068.96
5914	2365	74	2	3566.61
5915	2365	169	2	712.16
5916	2366	33	3	2850.43
5917	2367	162	3	1795.78
5918	2368	67	2	1964.81
5919	2369	163	1	2710.75
5920	2370	160	2	2070.69
5921	2371	153	2	3962.38
5922	2371	268	3	1236.3
5923	2371	92	2	412.91
5924	2372	233	2	4106
5925	2372	190	2	639.28
5926	2372	276	1	4043.27
5927	2373	174	1	4487.95
5928	2373	85	2	1637.43
5929	2373	171	3	1695.63
5930	2373	203	1	2771.23
5931	2374	164	2	1658.82
5932	2375	116	3	331.25
5933	2376	140	2	687.7
5934	2376	233	1	4106
5935	2377	158	1	3535
5936	2378	209	2	234.45
5937	2378	198	1	364.63
5938	2378	278	2	490.65
5939	2379	19	3	568.33
5940	2380	222	2	3539.2
5941	2380	75	1	2446.53
5942	2380	201	3	4623.06
5943	2381	187	1	3396.6
5944	2381	32	1	1240.3
5945	2381	252	3	4401.02
5946	2381	213	3	3862.89
5947	2382	10	1	620.57
5948	2383	156	3	3045.31
5949	2384	129	1	202.95
5950	2384	28	2	181.41
5951	2384	223	2	1505.96
5952	2385	53	2	4126.49
5953	2385	172	1	2563.06
5954	2385	209	2	234.45
5955	2385	225	3	1270.52
5956	2386	143	1	3191.91
5957	2386	284	2	4127.8
5958	2386	182	1	2508.73
5959	2386	204	3	1610.65
5960	2387	185	3	409.7
5961	2387	54	1	1431.17
5962	2388	201	3	4623.06
5963	2388	227	2	578.23
5964	2388	249	1	4366.54
5965	2389	51	3	3296.19
5966	2389	180	3	4230.62
5967	2389	51	1	3296.19
5968	2390	155	1	775.75
5969	2390	55	1	683.16
5970	2390	12	1	1101.5
5971	2391	236	2	4146.5
5972	2391	4	2	4444.26
5973	2392	95	2	1494.05
5974	2392	89	3	236.47
5975	2392	220	2	2654.61
5976	2392	93	1	1816.18
5977	2393	164	1	1658.82
5978	2393	91	3	4264.66
5979	2393	195	1	3424.4
5980	2394	263	1	283.98
5981	2394	66	2	1503.95
5982	2395	272	3	1745.88
5983	2395	184	2	2992.36
5984	2395	99	1	2939.03
5985	2396	181	1	749.09
5986	2396	41	2	2604.51
5987	2396	69	2	4969.99
5988	2397	154	1	4068.96
5989	2397	40	3	858.05
5990	2397	81	3	4381.84
5991	2398	134	2	2426.17
5992	2398	198	3	364.63
5993	2399	286	3	4172.2
5994	2399	156	1	3045.31
5995	2400	177	3	2242.63
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, buyer_id, total_price, status, created_at) FROM stdin;
1	101	7883.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2	101	20516.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
3	101	1596.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
4	101	3669.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
5	101	39204.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
6	101	19191.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
7	101	2342.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
8	101	2425.15	TESLIM_EDILDI	2025-05-10 03:51:14.792211
9	101	18940.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
10	101	4027.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
11	101	28190.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
12	102	18799.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
13	102	14692.03	TESLIM_EDILDI	2025-05-10 03:51:14.792211
14	102	14847.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
15	102	5086.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
16	102	10046.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
17	102	7435.81	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
18	102	10656.27	HAZIRLANIYOR	2025-05-10 03:51:14.792211
19	102	16017.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
20	102	19797.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
21	102	4237.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
22	102	9575.73	HAZIRLANIYOR	2025-05-10 03:51:14.792211
23	102	17322.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
24	102	8119.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
25	102	1241.14	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
26	102	709.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
27	103	9671.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
28	103	1917.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
29	103	25975.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
30	103	15356.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
31	103	10816.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
32	103	5675.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
33	103	24425.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
34	103	9317.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
35	103	1084.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
36	103	9687.25	TESLIM_EDILDI	2025-05-10 03:51:14.792211
37	103	14112.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
38	103	14654.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
39	103	17991.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
40	103	15136.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
41	103	10724.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
42	104	11760.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
43	104	17647.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
44	104	5475.6	TESLIM_EDILDI	2025-05-10 03:51:14.792211
45	104	20438.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
46	104	25410.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
47	104	13530.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
48	104	19104.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
49	105	37606.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
50	105	6570.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
51	105	12994.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
52	105	730.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
53	105	11153.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
54	105	9559.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
55	106	9513.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
56	106	2462.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
57	106	17751.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
58	106	4678.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
59	106	9741.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
60	106	15114.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
61	107	8553.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
62	107	1522.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
63	107	11637.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
64	107	5074.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
65	107	12563.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
66	107	10765.86	TESLIM_EDILDI	2025-05-10 03:51:14.792211
67	107	17802.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
68	107	12670.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
69	107	20919.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
70	107	5461.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
71	107	10161.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
72	107	19049.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
73	108	5290.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
74	108	13711.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
75	108	981.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
76	108	16495.71	TESLIM_EDILDI	2025-05-10 03:51:14.792211
77	108	12726.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
78	109	4126.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
79	109	11305.29	HAZIRLANIYOR	2025-05-10 03:51:14.792211
80	109	17244.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
81	109	3965.42	TESLIM_EDILDI	2025-05-10 03:51:14.792211
82	110	18966.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
83	110	12845.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
84	111	9323.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
85	111	15973.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
86	111	3844.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
87	112	9699.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
88	112	24205.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
89	112	4646.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
90	112	2992.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
91	112	14763.66	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
92	112	4936.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
93	112	2047.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
94	112	26855.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
95	112	13521.75	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
96	112	8888.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
97	112	10642.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
98	112	4779.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
99	113	14522.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
100	113	8139.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
101	113	28524.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
102	113	1278.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
103	113	12706.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
104	113	8043.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
105	113	18324.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
106	113	3703.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
107	113	27610.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
108	113	22191.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
109	113	9962.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
110	113	21516.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
111	113	10026.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
112	113	17125.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
113	114	6951.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
114	114	17962.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
115	114	17345.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
116	114	18861.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
117	114	12207.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
118	114	3586.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
119	114	19565.32	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
120	114	2450.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
121	114	12961.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
122	114	3890.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
123	115	18680.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
124	115	18133.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
125	115	26257.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
126	115	6797.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
127	115	28706.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
128	116	238.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
129	116	1159.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
130	116	11798.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
131	116	2680.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
132	116	13278.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
133	116	14783.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
134	116	23270.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
135	116	25768.68	HAZIRLANIYOR	2025-05-10 03:51:14.792211
136	116	4213.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
137	116	14136.67	TESLIM_EDILDI	2025-05-10 03:51:14.792211
138	116	16614.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
139	116	12619.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
140	116	23028.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
141	117	16518.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
142	117	2833.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
143	117	9203.15	TESLIM_EDILDI	2025-05-10 03:51:14.792211
144	117	31423.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
145	117	4756.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
146	117	15349.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
147	117	10238.78	TESLIM_EDILDI	2025-05-10 03:51:14.792211
148	117	21575.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
149	117	11824.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
150	117	1326.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
151	117	23764.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
152	117	7689.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
153	118	15369.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
154	118	16443.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
155	118	6371.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
156	118	16708.57	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
157	118	5644.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
158	118	5140.03	HAZIRLANIYOR	2025-05-10 03:51:14.792211
159	118	7056.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
160	118	3491.76	TESLIM_EDILDI	2025-05-10 03:51:14.792211
161	118	15478.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
162	118	20642.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
163	118	9177.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
164	118	9950.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
165	118	16695.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
166	118	6245.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
167	118	3886.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
168	119	7461.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
169	119	5384.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
170	119	15969.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
171	120	5253.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
172	120	21830.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
173	120	7712.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
174	120	15469.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
175	120	3620.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
176	120	22189.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
177	120	3686.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
178	120	22473.33	TESLIM_EDILDI	2025-05-10 03:51:14.792211
179	120	3572.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
180	120	4912.29	HAZIRLANIYOR	2025-05-10 03:51:14.792211
181	120	22336.37	TESLIM_EDILDI	2025-05-10 03:51:14.792211
182	120	3954.98	TESLIM_EDILDI	2025-05-10 03:51:14.792211
183	121	9699.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
184	121	8228.37	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
185	121	20216.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
186	121	16677.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
187	121	14084.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
188	121	17107.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
189	121	18525.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
190	121	5984.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
191	121	13107.39	HAZIRLANIYOR	2025-05-10 03:51:14.792211
192	121	20372.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
193	121	21943.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
194	121	3045.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
195	121	4274.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
196	122	28969.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
197	122	16576.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
198	122	16929.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
199	122	8612.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
200	122	19867.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
201	122	11792.19	HAZIRLANIYOR	2025-05-10 03:51:14.792211
202	122	19120.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
203	123	4031.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
204	123	102.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
205	123	22576.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
206	123	7121.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
207	123	25843.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
208	123	22490.98	TESLIM_EDILDI	2025-05-10 03:51:14.792211
209	123	1093.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
210	123	236.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
211	123	11701.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
212	123	4264.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
213	123	16526.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
214	123	22123.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
215	123	1518.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
216	124	8435.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
217	124	3107.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
218	124	13237.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
219	125	4043.27	TESLIM_EDILDI	2025-05-10 03:51:14.792211
220	125	7365.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
221	125	14227.37	TESLIM_EDILDI	2025-05-10 03:51:14.792211
222	125	19044.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
223	125	14034.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
224	125	10407.24	TESLIM_EDILDI	2025-05-10 03:51:14.792211
225	126	13841.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
226	126	17870.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
227	126	8760.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
228	126	6077.13	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
229	126	22583.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
230	126	2941.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
231	126	12432.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
232	126	7581.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
233	126	4925.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
234	126	8063.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
235	127	15509.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
236	127	10936.03	HAZIRLANIYOR	2025-05-10 03:51:14.792211
237	127	6939.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
238	127	1278.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
239	127	2922.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
240	127	7725.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
241	127	1563.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
242	127	10701.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
243	128	15702.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
244	128	11487.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
245	128	4893.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
246	128	9629.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
247	128	2577.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
248	128	11314.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
249	128	8446.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
250	128	4641.71	TESLIM_EDILDI	2025-05-10 03:51:14.792211
251	128	24585.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
252	128	20386.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
253	129	31448.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
254	129	31522.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
255	129	15545.14	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
256	129	2771.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
257	129	7028.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
258	129	14321.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
259	129	6638.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
260	129	19479.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
261	129	23400.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
262	129	21728.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
263	129	14864.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
264	129	10601.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
265	129	8817.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
266	129	9247.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
267	130	11355.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
268	130	4613.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
269	130	2486.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
270	130	4028.44	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
271	130	16429.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
272	130	31427.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
273	130	18531.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
274	130	20120.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
275	130	5448.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
276	130	9197.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
277	130	19511.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
278	130	196.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
279	130	6592.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
280	130	11155.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
281	130	7780.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
282	131	9649.66	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
283	131	18233.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
284	131	7304.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
285	131	8432.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
286	131	21160.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
287	131	9941.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
288	131	7283.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
289	131	747.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
290	131	23804.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
291	131	10553	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
292	131	27530.78	TESLIM_EDILDI	2025-05-10 03:51:14.792211
293	131	5321.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
294	132	2710.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
295	132	3613.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
296	132	30040.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
297	132	7225.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
298	132	3294.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
299	132	23626.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
300	132	12306.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
301	132	3790.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
302	132	9383.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
303	133	10695.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
304	133	12129.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
305	133	10446.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
306	133	1607.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
307	133	20501.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
308	133	412.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
309	133	23578.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
310	133	4969.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
311	133	12755.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
312	133	1107.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
313	133	13709.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
314	133	2959.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
315	134	30967.81	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
316	134	19409.67	TESLIM_EDILDI	2025-05-10 03:51:14.792211
317	134	7656.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
318	134	7299.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
319	135	6615.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
320	135	2425.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
321	135	10995.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
322	135	5803.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
323	135	32211.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
324	135	10153.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
325	135	13250.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
326	135	11092.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
327	135	16756.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
328	135	19229.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
329	136	16685.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
330	136	3135.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
331	136	13645.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
332	136	14992.32	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
333	136	2039.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
334	136	28050.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
335	136	13989.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
336	136	9380.6	TESLIM_EDILDI	2025-05-10 03:51:14.792211
337	136	15156.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
338	136	17839.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
339	136	5569.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
340	137	13244.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
341	137	35460.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
342	137	4520.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
343	137	9163.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
344	137	5290.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
345	137	14084.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
346	137	8832.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
347	137	14185.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
348	137	28554.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
349	137	11034.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
350	137	14707.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
351	137	19230.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
352	138	8302.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
353	138	683.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
354	138	17198.69	TESLIM_EDILDI	2025-05-10 03:51:14.792211
355	138	3170.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
356	138	16824.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
357	138	21042.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
358	139	5472.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
359	139	14809.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
360	139	13777.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
361	139	7606.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
362	139	2833.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
363	139	18129.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
364	139	21775.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
365	139	15157.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
366	139	30971.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
367	139	13518.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
368	139	13705.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
369	140	23406.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
370	140	24397.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
371	140	7439.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
372	140	13145.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
373	140	17844.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
374	140	11203.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
375	140	10316.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
376	140	9270.17	TESLIM_EDILDI	2025-05-10 03:51:14.792211
377	140	13871.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
378	140	7252.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
379	140	21233.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
380	141	3038.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
381	141	5134.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
382	141	7216.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
383	141	7680.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
384	141	2447.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
385	141	15602.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
386	141	5477.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
387	141	13925.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
388	141	13804.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
389	142	14885.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
390	142	8541.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
391	142	3333.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
392	142	13786.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
393	142	1933.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
394	142	5100.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
395	142	17005.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
396	142	9595.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
397	142	10385.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
398	142	8673.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
399	143	23135.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
400	143	23446.44	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
401	143	7139.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
402	143	2323.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
403	143	2822.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
404	143	4985.25	TESLIM_EDILDI	2025-05-10 03:51:14.792211
405	143	17465.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
406	143	6991.27	TESLIM_EDILDI	2025-05-10 03:51:14.792211
407	143	6582.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
408	143	9063.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
409	143	10108.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
410	143	6671.76	TESLIM_EDILDI	2025-05-10 03:51:14.792211
411	144	7863.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
412	144	12086.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
413	144	13052.13	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
414	144	10998.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
415	144	18423.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
416	144	28651.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
417	144	3824.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
418	144	15511.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
419	145	2446.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
420	145	13401.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
421	145	7973.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
422	145	1530.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
423	145	266.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
424	145	2242.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
425	145	5772.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
426	145	3304.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
427	145	24689.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
428	145	4207.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
429	145	15070.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
430	145	21275.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
431	145	20467.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
432	145	4060.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
433	146	1819.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
434	146	12695.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
435	146	19953.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
436	146	8373.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
437	146	1750.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
438	146	9473.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
439	146	249.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
440	146	2242.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
441	146	5830.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
442	146	2442.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
443	146	10273.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
444	146	3863.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
445	146	2843.93	TESLIM_EDILDI	2025-05-10 03:51:14.792211
446	147	19118.79	TESLIM_EDILDI	2025-05-10 03:51:14.792211
447	147	17146.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
448	147	19810.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
449	148	24571.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
450	148	6273.68	HAZIRLANIYOR	2025-05-10 03:51:14.792211
451	149	14331.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
452	149	8063.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
453	149	13182.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
454	149	16596	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
455	149	4330.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
456	149	18564.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
457	149	4960.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
458	149	19501.14	TESLIM_EDILDI	2025-05-10 03:51:14.792211
459	149	5387.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
460	149	12703.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
461	149	5343.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
462	149	24869.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
463	149	5140.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
464	150	24651.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
465	150	4095.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
466	150	5643.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
467	150	10946.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
468	150	6853.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
469	150	13145.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
470	150	1416.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
471	150	15796.14	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
472	150	701.89	TESLIM_EDILDI	2025-05-10 03:51:14.792211
473	150	5237.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
474	150	16700.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
475	150	13720.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
476	151	11939.32	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
477	151	18423.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
478	151	428.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
479	152	8275.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
480	152	11888.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
481	152	11802.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
482	152	16929.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
483	152	4791.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
484	152	9246.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
485	152	2806.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
486	152	22348.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
487	152	25605.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
488	152	5166.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
489	152	15642.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
490	152	3053.93	TESLIM_EDILDI	2025-05-10 03:51:14.792211
491	152	6623.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
492	152	9717.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
493	152	4553.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
494	153	14046.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
495	153	3066.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
496	153	19837.49	HAZIRLANIYOR	2025-05-10 03:51:14.792211
497	153	4291.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
498	153	16682.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
499	153	3985.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
500	153	8111.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
501	153	18537.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
502	153	15134.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
503	153	19434.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
504	153	13828.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
505	153	17093.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
506	153	12043.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
507	154	2710.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
508	154	7172.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
509	154	2013.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
510	154	6356.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
511	154	7289.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
512	154	16548.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
513	154	12858.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
514	154	12898.01	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
515	154	7267.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
516	155	11495.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
517	155	1156.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
518	155	2191.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
519	155	10981.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
520	155	4690.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
521	156	12255.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
522	156	14116.81	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
523	156	2758.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
524	156	7760.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
525	156	15786.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
526	156	9105.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
527	157	7239.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
528	157	4264.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
529	157	17758	HAZIRLANIYOR	2025-05-10 03:51:14.792211
530	157	11797.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
531	157	21163.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
532	157	24980.6	TESLIM_EDILDI	2025-05-10 03:51:14.792211
533	158	5273.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
534	158	4234.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
535	158	1640.42	HAZIRLANIYOR	2025-05-10 03:51:14.792211
536	158	14295.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
537	159	13147.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
538	159	4081.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
539	159	5553.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
540	160	3260.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
541	160	13145.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
542	160	1709.83	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
543	161	10934.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
544	161	25994.39	HAZIRLANIYOR	2025-05-10 03:51:14.792211
545	161	11761.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
546	161	2776.45	TESLIM_EDILDI	2025-05-10 03:51:14.792211
547	161	6846.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
548	161	191.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
549	161	6905.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
550	161	16061.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
551	161	6280.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
552	162	26103.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
553	162	12092.91	TESLIM_EDILDI	2025-05-10 03:51:14.792211
554	162	26117.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
555	162	10045.49	HAZIRLANIYOR	2025-05-10 03:51:14.792211
556	162	9467.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
557	162	22689.74	TESLIM_EDILDI	2025-05-10 03:51:14.792211
558	162	9709.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
559	162	4207.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
560	162	9785.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
561	162	5529.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
562	162	7515.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
563	162	31625.29	HAZIRLANIYOR	2025-05-10 03:51:14.792211
564	162	11465.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
565	162	17955.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
566	162	14367.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
567	163	7557.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
568	163	8529.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
569	163	14678.79	TESLIM_EDILDI	2025-05-10 03:51:14.792211
570	163	8954.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
571	163	10527.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
572	163	13477.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
573	163	10998.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
574	163	13109.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
575	163	14949.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
576	163	14702.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
577	163	17231.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
578	163	2049.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
579	164	9629.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
580	164	17826.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
581	164	7870.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
582	164	2191.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
583	164	3660.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
584	164	2822.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
585	164	2913.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
586	164	16712.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
587	164	14355.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
588	165	25882.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
589	165	19563.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
590	165	10607.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
591	165	13397.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
592	165	2670.75	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
593	165	7333.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
594	165	14160.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
595	165	729.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
596	165	14733.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
597	165	3793.76	TESLIM_EDILDI	2025-05-10 03:51:14.792211
598	165	13404.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
599	165	1774.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
600	165	4050.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
601	165	8379.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
602	166	13841.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
603	166	32770	TESLIM_EDILDI	2025-05-10 03:51:14.792211
604	166	15430.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
605	166	9445.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
606	166	1982.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
607	166	6052.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
608	166	10900.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
609	166	5448.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
610	166	6998.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
611	166	27666.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
612	166	2470.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
613	166	10566.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
614	166	8847.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
615	166	15602.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
616	167	19450.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
617	167	27226.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
618	167	13432.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
619	167	5237.64	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
620	167	4355.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
621	167	18459.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
622	167	2664.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
623	167	25719.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
624	168	3859.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
625	168	9589.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
626	169	7278.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
627	169	1461.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
628	169	16167.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
629	169	23487.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
630	169	7227.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
631	169	16200.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
632	169	8174.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
633	169	21848.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
634	170	12247.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
635	170	9300.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
636	170	19593.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
637	170	5687.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
638	171	24529.44	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
639	171	13203.06	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
640	171	24822.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
641	171	7321.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
642	171	3245.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
643	171	1518.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
644	171	16775.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
645	171	533.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
646	171	17200.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
647	171	851.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
648	172	7941.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
649	172	18666.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
650	173	16369.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
651	173	9037.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
652	173	23051.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
653	173	11272.4	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
654	173	2851.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
655	173	1431.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
656	173	16943.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
657	173	21596.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
658	173	9916.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
659	173	10453.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
660	174	12033.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
661	174	11576.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
662	174	7102.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
663	174	12878.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
664	174	13958.39	HAZIRLANIYOR	2025-05-10 03:51:14.792211
665	174	8773.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
666	174	9676.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
667	174	14989.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
668	174	16831.83	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
669	174	16695.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
670	175	12129.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
671	175	11095.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
672	175	7000.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
673	175	12318	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
674	176	10597.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
675	176	7875.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
676	176	33439.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
677	176	25224.42	HAZIRLANIYOR	2025-05-10 03:51:14.792211
678	176	568.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
679	176	5311.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
680	176	6340.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
681	176	28810.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
682	177	4150.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
683	177	4847.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
684	177	43.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
685	177	15307.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
686	177	8543.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
687	177	11428.64	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
688	177	24504.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
689	177	7255.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
690	177	3555.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
691	178	32693.16	TESLIM_EDILDI	2025-05-10 03:51:14.792211
692	178	24219.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
693	178	5387.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
694	178	19000.57	TESLIM_EDILDI	2025-05-10 03:51:14.792211
695	178	8838.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
696	178	2472.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
697	178	9389.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
698	178	5454.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
699	178	21976.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
700	178	3191.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
701	178	18884.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
702	179	8212.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
703	179	8516.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
704	179	8726.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
705	179	4097.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
706	179	862.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
707	179	7608.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
708	179	34244.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
709	179	1724.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
710	179	13935.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
711	180	16309.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
712	180	2643.97	HAZIRLANIYOR	2025-05-10 03:51:14.792211
713	181	16430.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
714	181	12708.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
715	181	2771.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
716	181	22604.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
717	182	98.01	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
718	182	15556.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
719	182	7253.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
720	182	19590.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
721	182	18796.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
722	182	4209.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
723	183	13352.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
724	183	3157.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
725	183	8978.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
726	183	22272.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
727	183	19164.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
728	183	2595.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
729	183	3341	HAZIRLANIYOR	2025-05-10 03:51:14.792211
730	183	21315.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
731	183	12453.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
732	183	9304.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
733	183	21846.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
734	184	14702.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
735	184	3929.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
736	184	15041.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
737	184	3929.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
738	185	23584.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
739	185	16402.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
740	185	21142.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
741	185	2824.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
742	185	5136.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
743	185	9945.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
744	185	1688.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
745	185	11785.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
746	185	16261.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
747	185	2806.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
748	185	5628.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
749	185	3237.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
750	185	4632.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
751	185	7984.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
752	186	16862.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
753	186	15380.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
754	186	13397.91	TESLIM_EDILDI	2025-05-10 03:51:14.792211
755	186	3824.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
756	186	11758.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
757	186	490.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
758	186	15824.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
759	186	15926.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
760	186	27109.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
761	186	9031.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
762	186	11237.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
763	186	9962.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
764	186	9486.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
765	187	12854.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
766	187	14537.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
767	187	1984.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
768	187	1915.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
769	187	7135.57	TESLIM_EDILDI	2025-05-10 03:51:14.792211
770	187	7134.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
771	187	12050.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
772	187	20947.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
773	188	6532	TESLIM_EDILDI	2025-05-10 03:51:14.792211
774	188	10509.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
775	188	14961.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
776	188	20268.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
777	189	19424.74	TESLIM_EDILDI	2025-05-10 03:51:14.792211
778	189	21721.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
779	189	19524.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
780	189	17615.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
781	189	22199.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
782	189	1915.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
783	189	7813.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
784	190	10319.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
785	190	9213.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
786	190	29967.93	TESLIM_EDILDI	2025-05-10 03:51:14.792211
787	190	3501.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
788	190	24212.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
789	190	3138.24	TESLIM_EDILDI	2025-05-10 03:51:14.792211
790	190	16261.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
791	190	2710.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
792	190	3837.31	TESLIM_EDILDI	2025-05-10 03:51:14.792211
793	190	16308.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
794	190	14822.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
795	190	1093.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
796	190	6490.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
797	190	19917.39	HAZIRLANIYOR	2025-05-10 03:51:14.792211
798	191	14671.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
799	191	19513.91	TESLIM_EDILDI	2025-05-10 03:51:14.792211
800	191	21039.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
801	191	16772.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
802	191	13553.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
803	191	2843.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
804	192	8150.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
805	192	25532.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
806	192	13732.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
807	192	17224.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
808	192	19829.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
809	192	7111.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
810	192	11258.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
811	193	16693.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
812	193	9858.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
813	194	3384.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
814	194	13626.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
815	194	19868.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
816	194	13004.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
817	194	5209.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
818	194	21877.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
819	194	17427.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
820	194	4779.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
821	194	15473.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
822	194	10339.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
823	194	25760.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
824	195	7803.37	TESLIM_EDILDI	2025-05-10 03:51:14.792211
825	195	10151.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
826	195	11685.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
827	195	703.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
828	195	12516.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
829	195	11670.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
830	195	7608.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
831	195	376.27	HAZIRLANIYOR	2025-05-10 03:51:14.792211
832	195	9728.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
833	195	10085.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
834	196	22670.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
835	196	10593.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
836	196	5734.29	HAZIRLANIYOR	2025-05-10 03:51:14.792211
837	196	19591.37	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
838	196	11350.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
839	196	4433.01	TESLIM_EDILDI	2025-05-10 03:51:14.792211
840	196	5705.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
841	196	25662.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
842	196	6671.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
843	196	22957.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
844	196	5356.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
845	196	4844.03	HAZIRLANIYOR	2025-05-10 03:51:14.792211
846	197	7230.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
847	197	13132.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
848	197	27841.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
849	197	21753.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
850	198	1986.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
851	198	19211.13	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
852	198	16559.03	TESLIM_EDILDI	2025-05-10 03:51:14.792211
853	198	6098.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
854	199	13049.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
855	199	7067.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
856	199	8310.74	TESLIM_EDILDI	2025-05-10 03:51:14.792211
857	199	13424.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
858	199	13619.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
859	199	785.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
860	200	15719.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
861	200	4496.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
862	200	20500.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
863	200	21304.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
864	200	23189.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
865	200	16871.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
866	200	8553.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
867	200	13943.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
868	200	2327.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
869	200	6507.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
870	200	23816.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
871	200	7910.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
872	201	13700	TESLIM_EDILDI	2025-05-10 03:51:14.792211
873	201	18671.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
874	201	7052.57	HAZIRLANIYOR	2025-05-10 03:51:14.792211
875	201	11534.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
876	201	3835.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
877	201	9153.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
878	201	22211.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
879	201	6410.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
880	202	3016.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
881	202	2181.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
882	202	23891.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
883	202	790.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
884	202	12703.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
885	203	3045.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
886	203	20180.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
887	203	22614.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
888	204	5814.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
889	204	22613.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
890	204	11247.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
891	204	8571.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
892	204	9456.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
893	204	6126.42	TESLIM_EDILDI	2025-05-10 03:51:14.792211
894	204	2145.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
895	204	10116.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
896	205	27668.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
897	205	4477.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
898	205	181.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
899	205	20136.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
900	205	17076.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
901	205	12390.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
902	205	18206.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
903	206	30245.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
904	206	20863.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
905	206	2758.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
906	206	20749.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
907	206	37171.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
908	206	3209.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
909	206	15398.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
910	206	9324.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
911	206	10591.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
912	206	4126.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
913	207	10510.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
914	207	21590.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
915	207	2652.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
916	208	11523.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
917	208	5597.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
918	209	10916.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
919	209	17557.32	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
920	209	13565.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
921	209	30528.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
922	209	20118.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
923	209	22365.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
924	209	12497.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
925	209	14433.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
926	209	9275.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
927	209	3734.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
928	209	15122.68	HAZIRLANIYOR	2025-05-10 03:51:14.792211
929	209	12762.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
930	210	4704.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
931	210	7779.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
932	210	5904.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
933	210	22722.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
934	210	15355.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
935	210	23979.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
936	210	17239.17	TESLIM_EDILDI	2025-05-10 03:51:14.792211
937	210	6387.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
938	210	7795.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
939	210	25615.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
940	210	2850.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
941	210	15770.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
942	210	14754.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
943	210	3713.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
944	211	8551.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
945	211	14700.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
946	211	18508.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
947	211	1362.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
948	211	3031.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
949	211	10131.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
950	212	35139.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
951	212	12502.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
952	212	1819.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
953	212	14743.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
954	212	23625.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
955	212	1221.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
956	212	4622.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
957	212	15417.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
958	212	8746.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
959	212	13847.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
960	212	13765.87	HAZIRLANIYOR	2025-05-10 03:51:14.792211
961	212	2587.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
962	212	30634.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
963	213	9006.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
964	213	6199.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
965	213	21463.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
966	213	23782.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
967	213	18714.37	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
968	213	12094.68	HAZIRLANIYOR	2025-05-10 03:51:14.792211
969	213	3663.42	HAZIRLANIYOR	2025-05-10 03:51:14.792211
970	213	19217.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
971	213	1241.14	TESLIM_EDILDI	2025-05-10 03:51:14.792211
972	213	14549.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
973	213	5919.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
974	213	17251.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
975	213	11473.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
976	214	28588.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
977	214	9295.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
978	214	20130.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
979	215	7963.83	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
980	215	4189.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
981	215	5919.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
982	215	26995	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
983	215	8867.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
984	215	14615.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
985	216	24318.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
986	216	11606.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
987	216	6117.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
988	216	12420.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
989	217	24299.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
990	217	5115.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
991	217	17696.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
992	217	8883.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
993	217	3644.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
994	217	412.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
995	217	956.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
996	218	30403.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
997	218	12129.81	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
998	218	26533.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
999	218	1046.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1000	218	428.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1001	218	26532.78	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1002	218	14673.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1003	218	5916.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1004	218	17263.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1005	218	16214.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1006	218	14614.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1007	218	21141.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1008	219	6592.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1009	219	9823.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1010	219	7942.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1011	220	16559.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1012	220	17927.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1013	220	19716.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1014	220	2244.16	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1015	220	26142.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1016	220	205.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1017	220	10464.41	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1018	220	11409.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1019	221	16765.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1020	221	6955.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1021	221	750.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1022	221	5262.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1023	221	7350.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1024	221	17546.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1025	221	15794.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1026	221	841.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1027	221	16511.47	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1028	221	1745.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1029	221	3669.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1030	221	2910.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1031	222	16405.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1032	222	1068.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1033	222	30017.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1034	222	3554.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1035	222	3922.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1036	222	4690.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1037	222	17237.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1038	222	28940.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1039	222	14463.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1040	223	19364.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1041	223	4511.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1042	223	10765.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1043	223	7406.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1044	223	21155.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1045	223	9227.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1046	223	12439.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1047	223	4798.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1048	223	9807.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1049	223	12524.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1050	223	908.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1051	223	10217.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1052	224	9109.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1053	224	26069.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1054	224	27293.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1055	224	790.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1056	224	8399.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1057	224	2378.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1058	224	14038.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1059	225	24162.19	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1060	225	11896.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1061	225	11849.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1062	225	10150.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1063	225	25648.47	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1064	225	24808.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1065	225	25358.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1066	225	6421.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1067	225	16651.14	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1068	225	19685.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1069	225	5788.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1070	225	1034.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1071	225	3045.81	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1072	225	9993.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1073	226	11505.27	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1074	226	3950.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1075	226	12972.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1076	226	9200.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1077	227	701.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1078	227	1068.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1079	227	571.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1080	227	16619.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1081	227	15545.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1082	227	7089.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1083	227	14532.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1084	227	14179.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1085	227	16566.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1086	227	4448.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1087	227	12379.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1088	227	4667.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1089	227	6902.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1090	228	7367.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1091	228	5174.74	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1092	228	11727.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1093	228	20820.01	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1094	228	1068.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1095	228	3218.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1096	228	21230.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1097	228	13371.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1098	228	6056.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1099	229	15162.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1100	229	2486.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1101	229	1885.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1102	229	26749.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1103	229	13157.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1104	229	6220.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1105	229	18186.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1106	229	16165.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1107	229	14206.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1108	229	568.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1109	229	20289.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1110	229	10245.13	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1111	230	33537.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1112	230	15915.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1113	230	9732.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1114	230	12625.21	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1115	230	8354.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1116	231	19117.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1117	231	18835.47	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1118	231	20062.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1119	231	13343.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1120	231	3086.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1121	231	21923.03	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1122	231	39.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1123	231	5830.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1124	231	4809.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1125	232	17175.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1126	232	117.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1127	232	6320.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1128	232	11003.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1129	232	7725	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1130	233	13904.83	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1131	233	14729.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1132	233	13798.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1133	233	3975.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1134	234	13935.42	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1135	234	26166.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1136	234	12401.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1137	234	18159.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1138	234	11245.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1139	234	2103.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1140	388	8006.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1141	388	7924.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1142	388	1607.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1143	388	7311.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1144	388	12660.68	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1145	388	10204.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1146	388	5878.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1147	388	5387.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1148	388	18965.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1149	235	20411.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1150	235	8112.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1151	235	16450.42	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1152	235	3040.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1153	235	27396.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1154	236	12844.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1155	236	31444.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1156	236	7230.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1157	236	4241.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1158	236	1309.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1159	236	28149.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1160	236	10680.13	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1161	236	15519.14	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1162	236	7373.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1163	236	6708.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1164	236	12175.96	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1165	237	16752.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1166	237	6912.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1167	237	5107.73	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1168	237	12638.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1169	237	17470.57	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1170	237	5986.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1171	237	4482.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1172	237	10294.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1173	237	10920.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1174	237	8820.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1175	237	851.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1176	237	9639.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1177	237	28240.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1178	238	12836.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1179	238	18646.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1180	238	16895.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1181	238	11318.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1182	238	8210.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1183	238	13958.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1184	238	8508.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1185	238	8310.89	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1186	238	453.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1187	238	14986.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1188	238	7208.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1189	238	12105.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1190	238	14435.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1191	239	39795.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1192	239	8376.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1193	239	4210.89	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1194	239	7369.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1195	239	16009.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1196	239	5017.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1197	239	3752.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1198	239	11689.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1199	239	15252.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1200	239	4859.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1201	239	3209.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1202	240	7232.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1203	240	2013.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1204	240	688.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1205	240	17411.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1206	240	4423.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1207	240	29373.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1208	240	11771.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1209	240	683.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1210	240	8077.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1211	240	12829.19	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1212	240	12255.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1213	240	6751.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1214	240	7377.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1215	240	6472.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1216	241	19323.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1217	241	6490.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1218	241	3491.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1219	241	8560.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1220	241	17292.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1221	241	3831.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1222	242	8057.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1223	242	8455.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1224	242	20024.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1225	242	20370.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1226	243	11346.15	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1227	243	23190.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1228	243	10268.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1229	243	6672.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1230	243	2463.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1231	243	14070.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1232	243	1005.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1233	244	7807.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1234	244	25656.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1235	244	11629.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1236	244	30868.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1237	245	22560.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1238	245	2043.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1239	245	7773.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1240	245	4853	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1241	245	19834.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1242	245	13295.45	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1243	245	21737.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1244	245	22857.41	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1245	245	4204.89	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1246	245	2898.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1247	245	13712.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1248	245	14913.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1249	245	12381.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1250	245	8213.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1251	246	3439.98	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1252	246	7713.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1253	246	11578.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1254	246	3271.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1255	246	15878.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1256	246	24802.37	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1257	246	9614.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1258	246	26319.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1259	246	4734.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1260	246	15398.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1261	246	12703.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1262	246	20627.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1263	246	7155.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1264	246	3594.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1265	247	283.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1266	247	8938.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1267	247	2190.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1268	247	15456.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1269	247	12335.29	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1270	247	3665.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1271	247	15585.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1272	247	1880.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1273	247	13008.77	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1274	247	9074.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1275	247	1637.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1276	247	13821.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1277	247	13062.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1278	248	6978.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1279	248	5062.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1280	248	20213.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1281	248	1671.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1282	248	13173.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1283	248	7729.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1284	248	14648.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1285	248	6114.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1286	248	26613.57	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1287	248	28036.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1288	248	14730.21	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1289	248	24458.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1290	248	10724.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1291	248	17138.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1292	249	15575.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1293	249	117.75	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1294	249	8140.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1295	249	27317.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1296	249	23719.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1297	249	8190.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1298	249	22291.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1299	249	34904.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1300	249	6708.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1301	249	10528.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1302	249	10125	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1303	249	568.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1304	249	13631.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1305	249	5491.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1306	250	13812.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1307	250	12425.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1308	250	3336.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1309	250	17059.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1310	250	9307.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1311	251	858.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1312	251	25297.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1313	251	11129.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1314	251	1389.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1315	252	13511.57	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1316	252	25839.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1317	252	14654.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1318	252	11448.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1319	252	11659.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1320	252	17917.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1321	253	1107.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1322	253	26638.33	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1323	253	5017.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1324	253	21342.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1325	253	4584.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1326	253	9135.93	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1327	253	4085.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1328	253	20166.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1329	253	16001.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1330	253	11662.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1331	253	800.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1332	253	205.66	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1333	254	34512.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1334	254	13694.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1335	254	5082.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1336	254	14916.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1337	254	11670.06	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1338	254	8456.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1339	254	17460.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1340	254	4363.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1341	254	1637.43	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1342	254	12028.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1343	254	3929.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1344	254	39405.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1345	254	19356.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1346	255	19277.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1347	255	6682.24	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1348	255	6626.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1349	255	8548.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1350	256	15232.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1351	256	10652.25	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1352	256	7670.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1353	257	10637.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1354	257	9342.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1355	257	13025.96	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1356	257	4185.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1357	257	25105.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1358	257	3669.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1359	257	24134.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1360	257	23164.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1361	257	21520.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1362	257	25852.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1363	257	4490.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1364	257	6592.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1365	257	23588.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1366	258	4681.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1367	258	3591.56	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1368	258	9227.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1369	258	17589.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1370	258	12387.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1371	258	8987.03	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1372	258	8139.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1373	258	19508.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1374	258	26016.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1375	258	4137.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1376	258	191.33	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1377	258	28632.07	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1378	259	25330.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1379	259	12257.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1380	259	697.97	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1381	259	3703.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1382	259	938.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1383	259	1695.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1384	259	17267.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1385	259	24006.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1386	259	17370.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1387	259	15763.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1388	260	9642.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1389	260	25509.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1390	260	18196.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1391	261	8254.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1392	261	15604.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1393	261	15444.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1394	261	3296.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1395	261	6209.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1396	261	20874.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1397	261	13297.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1398	262	9866.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1399	262	5695.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1400	262	20583.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1401	262	6851.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1402	262	2567.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1403	262	1503.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1404	263	9473.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1405	263	21482.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1406	264	29698.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1407	264	6393.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1408	264	5426.56	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1409	264	6752.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1410	264	9888.57	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1411	265	3391.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1412	265	4043.27	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1413	265	4824.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1414	265	5190.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1415	265	20587.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1416	265	22322.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1417	265	8442.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1418	266	5837.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1419	266	32703.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1420	266	22157.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1421	266	4347.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1422	266	3962.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1423	266	2446.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1424	266	7930.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1425	266	425.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1426	266	10107.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1427	267	2710.75	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1428	267	16629.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1429	267	858.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1430	267	12401.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1431	267	6510.6	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1432	267	4505.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1433	267	2056.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1434	267	6472.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1435	268	8869.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1436	268	17669.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1437	268	12121.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1438	269	27552.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1439	269	4259.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1440	269	4849.77	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1441	269	12129.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1442	269	2654.64	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1443	269	7590.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1444	269	21179.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1445	269	6037.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1446	270	8802.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1447	270	23140.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1448	270	7160.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1449	270	25904.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1450	270	25746.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1451	270	7584.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1452	271	3452.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1453	271	10011.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1454	272	4700.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1455	272	10479.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1456	272	15646.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1457	272	22952.78	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1458	272	20950	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1459	272	1460.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1460	272	6488.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1461	272	9511.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1462	272	4388.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1463	272	5352.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1464	272	3191.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1465	272	18750.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1466	272	6008.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1467	272	2054.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1468	273	1431.17	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1469	273	12516.6	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1470	273	26227.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1471	274	11173.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1472	274	1216.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1473	275	8382.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1474	275	21426.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1475	275	16000.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1476	276	21212.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1477	276	6701.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1478	276	13820.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1479	276	19538.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1480	277	7281.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1481	277	8122.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1482	277	8893.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1483	277	4770.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1484	277	21339.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1485	277	14853.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1486	277	24396.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1487	277	5700.86	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1488	277	8353.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1489	277	24647.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1490	277	15281.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1491	278	17762.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1492	278	10699.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1493	278	27806.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1494	278	17072.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1495	278	30401.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1496	278	582.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1497	278	3929.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1498	279	25227	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1499	279	2910.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1500	279	4137.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1501	279	14104	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1502	279	18282.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1503	279	11393.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1504	279	9376.44	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1505	279	5198.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1506	279	382.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1507	279	20458.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1508	279	21701.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1509	279	573.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1510	279	14183.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1511	280	3811.56	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1512	280	3986.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1513	281	1419.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1514	281	34305.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1515	281	66.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1516	281	6799.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1517	281	14350.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1518	281	6121.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1519	281	2244.16	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1520	281	2013.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1521	281	10725.33	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1522	281	3554.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1523	281	8769.47	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1524	281	5700.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1525	282	9733.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1526	282	1581.98	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1527	282	26114.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1528	282	3262.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1529	282	20027.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1530	282	6419.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1531	282	13716.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1532	282	22716.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1533	282	9173.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1534	283	10060.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1535	283	33577.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1536	283	15404.16	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1537	283	4492.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1538	283	3473.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1539	283	7396.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1540	283	9642.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1541	284	2472.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1542	284	9144.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1543	284	9787.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1544	284	12980.79	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1545	284	25556.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1546	284	24335.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1547	284	1716.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1548	284	11313.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1549	284	8091.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1550	284	12437.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1551	285	13843.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1552	285	8433.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1553	285	11430.76	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1554	285	3191.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1555	285	12890.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1556	285	9543.14	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1557	286	2173.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1558	286	15407.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1559	286	5765.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1560	287	6411.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1561	287	7284.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1562	287	11256.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1563	288	15633.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1564	288	9715.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1565	288	28604.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1566	288	4097.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1567	288	16927.57	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1568	288	13600.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1569	288	7133.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1570	288	14873.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1571	288	10443.97	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1572	288	15514.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1573	288	14528.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1574	288	6727.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1575	289	7011.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1576	289	13826.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1577	289	2988.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1578	289	21534.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1579	289	25584.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1580	289	262.47	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1581	290	10600.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1582	290	15874.42	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1583	290	6175.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1584	290	13047.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1585	290	16591.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1586	290	2654.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1587	290	5332.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1588	291	27864.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1589	291	18847.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1590	291	6473.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1591	291	11727	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1592	291	13075.33	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1593	291	7718.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1594	291	117.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1595	291	4960.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1596	291	16614.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1597	292	9937.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1598	292	13649.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1599	292	7720.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1600	292	21694.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1601	292	21964.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1602	292	18171.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1603	293	4678.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1604	293	6703.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1605	293	25506.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1606	293	6437.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1607	293	5430.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1608	293	18724.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1609	293	9073.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1610	293	3296.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1611	294	10153.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1612	294	12010.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1613	294	15628.61	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1614	295	18799.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1615	295	6065.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1616	295	3337.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1617	295	9112.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1618	295	9566.57	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1619	295	14323.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1620	295	409.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1621	295	10118.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1622	295	23680.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1623	296	16353.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1624	296	19721.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1625	296	14292.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1626	296	2472.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1627	296	15559.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1628	297	6201.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1629	297	13728.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1630	297	7910.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1631	297	13500.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1632	297	2047.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1633	297	18480.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1634	297	12632.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1635	297	7001.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1636	297	22969.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1637	297	10563.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1638	297	11566.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1639	297	16420.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1640	298	18398.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1641	298	14649.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1642	298	20297.01	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1643	299	9429.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1644	299	18825.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1645	299	17371.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1646	299	2049.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1647	299	6476.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1648	299	6943.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1649	299	3027.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1650	299	7766.01	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1651	299	4496.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1652	299	7631.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1653	300	836.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1654	300	1101.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1655	300	36704.96	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1656	300	15575.24	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1657	300	16070.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1658	300	10273.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1659	300	3179.91	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1660	300	20161.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1661	300	11875.41	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1662	300	24931.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1663	300	7289.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1664	300	15404.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1665	300	17929.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1666	300	14956.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1667	300	21603.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1668	301	7051.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1669	301	19691.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1670	301	5865.66	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1671	302	21350.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1672	302	15754.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1673	302	13850.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1674	302	13515.06	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1675	302	11998.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1676	302	21.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1677	302	15432.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1678	302	8834.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1679	302	8762.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1680	302	11583.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1681	302	36223.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1682	302	80.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1683	302	4637.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1684	302	14671.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1685	303	15331.25	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1686	303	9741.74	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1687	303	17324.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1688	303	18073.37	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1689	303	10252.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1690	303	6051.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1691	303	8975.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1692	303	18696.4	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1693	303	12793.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1694	303	15783.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1695	303	4341.33	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1696	303	27135.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1697	303	21618.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1698	304	1609.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1699	304	7970.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1700	304	13047.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1701	304	3449.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1702	304	5222.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1703	304	30991.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1704	304	1364.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1705	304	29303.71	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1706	304	11995.11	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1707	304	11743.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1708	304	9825.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1709	304	7267.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1710	305	642.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1711	305	7813.53	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1712	305	12390.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1713	305	5537.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1714	305	14652.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1715	305	4339.64	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1716	306	4591.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1717	306	14863.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1718	306	266.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1719	306	2821.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1720	306	8466.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1721	306	3590.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1722	306	851.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1723	306	19992.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1724	306	1610.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1725	306	29547.45	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1726	306	8583.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1727	306	18383.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1728	306	3684.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1729	307	19514.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1730	307	15309.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1731	307	15889.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1732	307	33771.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1733	307	1553.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1734	307	2475.99	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1735	307	7177.24	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1736	307	23957.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1737	307	18079.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1738	307	16798	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1739	307	8063.12	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1740	307	10882.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1741	307	14114.79	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1742	308	8960.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1743	308	36035.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1744	308	3045.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1745	308	15532.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1746	308	18332.94	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1747	308	25785.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1748	308	12019.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1749	308	40.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1750	308	1850.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1751	308	27096.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1752	308	2565.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1753	308	7872.13	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1754	309	6454.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1755	309	26994.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1756	309	8311.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1757	309	18414.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1758	309	2186.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1759	309	15119.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1760	309	1512.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1761	309	20153.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1762	309	3007.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1763	309	12240.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1764	309	6315.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1765	309	12516.6	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1766	309	16434.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1767	310	8516.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1768	310	11581.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1769	310	15824.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1770	310	5706.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1771	310	11297.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1772	311	5276.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1773	311	10910.45	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1774	311	3521.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1775	311	25147.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1776	311	19040.85	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1777	311	15602.67	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1778	311	10501.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1779	311	4839.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1780	311	16942.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1781	311	17470.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1782	312	10807.71	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1783	312	29107.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1784	312	14497.44	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1785	312	18593.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1786	312	4406.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1787	312	12310.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1788	312	15502.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1789	312	13600.9	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1790	312	9559.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1791	313	15241.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1792	313	1903.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1793	313	4237.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1794	313	23106.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1795	313	908.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1796	313	36029.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1797	314	16678.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1798	314	506.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1799	314	21989.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1800	314	3962.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1801	314	25185.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1802	314	17989.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1803	315	10728.73	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1804	315	5699.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1805	315	3045.31	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1806	315	13119.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1807	316	8170.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1808	316	16669.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1809	317	11803.32	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1810	317	11592.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1811	317	9203.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1812	317	7975.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1813	317	17759.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1814	317	3215.6	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1815	317	17761.52	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1816	317	14536.34	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1817	317	16736.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1818	318	12376.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1819	318	17315.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1820	318	6688.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1821	318	9999.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1822	318	2367.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1823	319	13879.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1824	319	20167.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1825	319	19562.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1826	319	8302.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1827	319	12667.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1828	319	28182.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1829	319	16349.67	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1830	319	17145.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1831	319	11535.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1832	319	6764.48	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1833	319	21585.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1834	319	19926.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1835	319	7515.57	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1836	319	26918.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1837	320	28471.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1838	320	8401.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1839	321	196.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1840	321	10063.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1841	321	21249.59	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1842	321	8769.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1843	321	19198.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1844	321	34263.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1845	321	10049.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1846	321	11588.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1847	321	20252.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1848	321	24662.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1849	322	9146.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1850	322	3948.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1851	322	17113.69	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1852	322	21023.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1853	322	24839.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1854	322	4517.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1855	322	262.47	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1856	323	4852.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1857	323	5793.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1858	323	11636.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1859	323	4724.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1860	323	3439.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1861	323	6972.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1862	323	2939.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1863	323	17193.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1864	323	1864.21	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1865	323	13299.03	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1866	323	1795.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1867	324	10434.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1868	324	5898.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1869	324	28506.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1870	324	17970.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1871	324	923.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1872	324	12541.24	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1873	324	14702.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1874	325	16444.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1875	325	8086.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1876	325	3566.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1877	325	3835.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1878	325	14882.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1879	325	17403.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1880	325	16368.23	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1881	325	12824.73	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1882	325	22706.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1883	325	506.08	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1884	325	14495.13	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1885	326	21176.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1886	326	11400.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1887	326	27615.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1888	326	14500.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1889	326	20199.28	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1890	326	38186.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1891	327	14909.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1892	327	13180.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1893	327	17764.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1894	327	3125.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1895	327	17995.97	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1896	327	3317.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1897	327	17307.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1898	327	26345.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1899	327	21902.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1900	327	6608.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1901	327	3720.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1902	328	4314.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1903	328	14136.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1904	328	5813.33	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1905	328	25445.39	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1906	328	3588.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1907	328	9873.75	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1908	328	3636.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1909	328	6419.66	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1910	328	3279.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1911	328	4892.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1912	328	17970.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1913	328	14143.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1914	328	14958.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1915	328	10300.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1916	328	17074.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1917	329	11592.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1918	329	7801.71	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1919	329	18210.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1920	330	10755.33	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1921	330	12893.06	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1922	330	19319.07	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1923	330	13523.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1924	330	26682.21	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1925	330	8403.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1926	330	19168.93	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1927	330	18372.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1928	331	9877.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1929	331	11892.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1930	331	29306.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1931	331	12795.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1932	331	17040.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1933	332	1515.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1934	332	8043.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1935	332	10762.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1936	332	16391.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1937	332	19279.61	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1938	332	15030.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1939	332	18609.01	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1940	332	5894.43	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1941	332	4257.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1942	332	9375.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1943	332	9212.87	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1944	332	16789.22	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1945	332	1278.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1946	332	12418	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1947	332	17125.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1948	333	11929.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1949	333	294.03	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1950	333	34659.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1951	333	25087.67	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1952	334	14838.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1953	334	13623.83	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1954	335	9629.49	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1955	335	7740.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1956	335	12388.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1957	336	21575.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1958	336	15208.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1959	336	12201.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1960	336	5383.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1961	336	4623.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1962	336	16311.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1963	336	5592.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1964	336	7784.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1965	337	5957.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1966	337	5431.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1967	337	29793.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1968	337	3316.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1969	337	10066.38	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1970	337	10782.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1971	338	13481.64	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1972	338	30449.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1973	339	22100.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1974	339	673.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1975	339	1834.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1976	340	2941.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1977	340	5069.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1978	341	11061.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1979	341	2039.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1980	341	16070.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1981	341	14079.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1982	341	9739.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1983	341	5765.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1984	341	16034.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1985	342	4078.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1986	342	7574.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1987	342	20235.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1988	342	18970.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1989	343	1221.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1990	343	4912.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1991	343	8121.32	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1992	343	16725.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1993	343	24368.88	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1994	344	12201.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
1995	344	12124.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
1996	344	6714.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1997	344	24668.42	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1998	344	13836.15	TESLIM_EDILDI	2025-05-10 03:51:14.792211
1999	345	15908.58	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2000	345	9240.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2001	345	38299.89	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2002	345	6471.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2003	345	9390.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2004	346	21505.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2005	346	6275.32	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2006	346	13381.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2007	346	9747.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2008	346	28243.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2009	346	19603.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2010	346	4482.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2011	346	7022.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2012	346	9010.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2013	346	79.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2014	346	13805.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2015	346	18978.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2016	346	26958.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2017	346	4425.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2018	346	238.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2019	347	2137.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2020	347	12022	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2021	347	7065.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2022	347	20329.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2023	347	121.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2024	347	3866.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2025	347	22238.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2026	347	1379.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2027	347	5037.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2028	347	64.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2029	347	3103.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2030	347	9291.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2031	348	20338.67	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2032	348	5644.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2033	348	38839.4	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2034	348	12979.47	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2035	348	21090.96	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2036	348	33119.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2037	348	4250.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2038	348	16029.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2039	349	10765.86	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2040	349	7063.72	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2041	350	12998.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2042	350	17282.51	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2043	350	3596.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2044	350	25800.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2045	350	16195.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2046	351	6486.8	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2047	351	13427.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2048	351	6693.14	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2049	351	5344.56	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2050	351	9144.31	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2051	351	20780.02	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2052	351	28323.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2053	351	6178.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2054	351	8170.45	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2055	351	13961.21	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2056	351	10461.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2057	351	11230.42	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2058	352	6195.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2059	352	1917.84	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2060	352	10821.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2061	352	19982.65	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2062	352	18292.01	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2063	352	29844.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2064	352	10575.63	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2065	352	8733.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2066	352	5779.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2067	352	19565.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2068	352	5748.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2069	352	15419.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2070	352	13161.28	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2071	353	3245.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2072	353	7593.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2073	353	6192.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2074	353	5045.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2075	353	3391.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2076	353	2988.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2077	353	5049.82	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2078	353	10605	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2079	353	7390.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2080	353	3839.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2081	353	4812.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2082	353	18168.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2083	353	13664.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2084	353	22021.88	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2085	353	14177.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2086	354	6998.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2087	354	2692.44	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2088	354	9534.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2089	354	18242.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2090	354	17022.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2091	354	23260.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2092	354	7521.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2093	354	4831.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2094	354	20526.73	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2095	354	7950.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2096	354	24842.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2097	354	28589.04	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2098	354	13619.07	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2099	355	15886.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2100	355	12844.66	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2101	355	12810.81	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2102	355	26623.38	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2103	355	18079.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2104	356	8404.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2105	356	8763.68	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2106	356	6082.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2107	356	9230.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2108	356	16734.73	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2109	356	3620.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2110	356	8427.24	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2111	356	11601.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2112	356	10271.03	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2113	357	8016.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2114	357	9481.73	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2115	357	4177.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2116	357	8291.27	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2117	357	2431.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2118	357	4827.57	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2119	357	4366.54	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2120	357	38100.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2121	357	6503.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2122	357	7688.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2123	358	1476.84	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2124	358	7145.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2125	358	8464	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2126	358	12963.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2127	358	688.96	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2128	358	7813.53	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2129	358	13203.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2130	358	981.3	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2131	358	22775.4	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2132	358	3279.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2133	358	19690.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2134	358	6077.17	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2135	359	20039.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2136	359	13786.94	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2137	359	16917.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2138	359	5746.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2139	359	17932.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2140	360	9354.5	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2141	360	2212.86	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2142	360	11209.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2143	360	22969.52	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2144	360	9041.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2145	360	23993.12	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2146	360	266.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2147	360	8021.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2148	360	12436.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2149	360	11137.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2150	360	20725.22	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2151	360	6315.03	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2152	360	7066.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2153	360	16652.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2154	360	3567.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2155	361	4223.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2156	361	15957.77	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2157	361	19675.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2158	361	8192.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2159	362	7253.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2160	362	16301.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2161	362	14029.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2162	363	1498.18	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2163	363	2442.28	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2164	364	26047.82	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2165	364	23884.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2166	364	4381.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2167	364	9240.8	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2168	365	908.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2169	365	18569.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2170	365	4888.35	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2171	365	5846.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2172	365	238.98	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2173	365	18051.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2174	365	28613.9	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2175	365	13874.55	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2176	365	17121.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2177	365	8760.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2178	365	17176.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2179	366	13240.17	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2180	366	12723.78	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2181	366	7689.18	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2182	366	24670.34	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2183	367	2850.43	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2184	367	15873.15	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2185	367	15525.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2186	367	712.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2187	367	5613.02	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2188	367	121.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2189	367	13594.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2190	367	8430.48	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2191	367	5731.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2192	367	8306.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2193	367	13948.95	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2194	367	19034.7	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2195	367	7608.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2196	367	24156.44	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2197	367	12079.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2198	368	23611.53	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2199	368	4613.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2200	368	9424.1	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2201	368	9833.01	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2202	368	12008.05	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2203	369	20580.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2204	369	14946.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2205	369	11506.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2206	369	4092.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2207	369	12461.29	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2208	369	5687.86	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2209	369	12955.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2210	369	5529.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2211	369	5017.46	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2212	369	26371.46	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2213	369	10150.16	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2214	369	2049.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2215	370	15589.23	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2216	370	2867.87	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2217	370	1523.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2218	370	1965.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2219	370	14919.77	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2220	370	18854.26	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2221	370	11115.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2222	371	6157.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2223	371	3591.56	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2224	371	13556.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2225	371	9056.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2226	371	1377.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2227	372	11824.49	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2228	372	17175.51	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2229	372	9348.92	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2230	373	16074.27	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2231	373	28049.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2232	373	4068.96	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2233	374	15898	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2234	374	10615.76	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2235	374	2920.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2236	375	1068.08	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2237	375	10199.49	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2238	375	10196.13	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2239	375	12100.56	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2240	375	573.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2241	375	2563.06	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2242	375	16033.51	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2243	375	8417.54	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2244	375	6894.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2245	375	4182.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2246	375	7204.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2247	375	3254.59	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2248	375	3457.74	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2249	375	16476.89	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2250	376	6188.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2251	376	12406.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2252	376	5169.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2253	376	18520.55	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2254	376	6024.04	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2255	376	9476.92	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2256	376	3036.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2257	376	10127.9	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2258	376	2855.04	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2259	376	10189.8	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2260	376	1717.09	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2261	377	2870.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2262	377	5562.79	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2263	377	3347.78	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2264	377	6443	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2265	377	8313.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2266	377	14177.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2267	377	7791.22	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2268	377	8645.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2269	377	23729.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2270	378	14573.57	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2271	378	12708.59	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2272	378	14631.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2273	378	24661.61	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2274	378	7456.63	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2275	378	966.11	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2276	378	5613.02	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2277	378	12456.36	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2278	378	4512.09	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2279	378	5631.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2280	379	22810.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2281	379	13796.05	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2282	379	24010.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2283	379	4485.26	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2284	379	13515.06	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2285	379	23573.25	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2286	379	1864.21	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2287	379	778.6	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2288	379	2191.95	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2289	379	13492.78	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2290	379	205.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2291	379	12199.19	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2292	379	697.97	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2293	380	17652.2	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2294	380	15438.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2295	380	2851.1	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2296	380	8097.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2297	380	15329.3	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2298	380	11534.82	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2299	380	9272.68	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2300	380	2203	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2301	380	3229.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2302	380	7023.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2303	380	24739.2	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2304	381	8682.66	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2305	381	9561.26	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2306	381	19440.46	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2307	381	20978.62	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2308	381	2660.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2309	381	5273.84	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2310	381	13392.7	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2311	381	7138.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2312	381	26474.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2313	381	24332.31	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2314	382	8752.96	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2315	382	21638.72	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2316	382	11530.92	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2317	382	18970.74	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2318	382	18022.15	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2319	383	2972.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2320	383	4890.54	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2321	383	10829.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2322	383	2093.91	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2323	383	4027.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2324	383	11160.94	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2325	383	29181.13	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2326	383	1076.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2327	383	8678.58	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2328	383	17590.3	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2329	383	12575.27	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2330	383	4097.36	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2331	383	21883.72	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2332	383	14712.06	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2333	384	3824.16	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2334	384	697.97	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2335	384	27260.98	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2336	384	3846.67	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2337	384	3917.1	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2338	384	9726.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2339	384	1184.86	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2340	384	17445.81	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2341	384	8804.58	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2342	384	11748.37	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2343	384	5348.95	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2344	384	3396.6	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2345	384	12380.85	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2346	384	4300.85	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2347	385	7408.79	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2348	385	18974.05	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2349	385	15033.5	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2350	385	687.7	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2351	385	10801.65	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2352	385	10931.71	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2353	385	15234.98	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2354	385	7277.76	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2355	385	26387.25	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2356	385	15008.36	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2357	385	17914.35	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2358	385	490.65	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2359	385	14463.99	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2360	385	10857.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2361	385	11725.35	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2362	386	2480.6	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2363	386	15366.12	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2364	386	15822.08	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2365	386	13484.55	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2366	386	8551.29	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2367	386	5387.34	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2368	386	3929.62	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2369	386	2710.75	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2370	386	4141.38	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2371	386	12459.48	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2372	386	13533.83	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2373	386	15620.93	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2374	387	3317.64	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2375	387	993.75	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2376	387	5481.4	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2377	387	3535	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2378	387	1814.83	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2379	387	1704.99	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2380	387	23394.11	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2381	387	29428.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2382	387	620.57	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2383	387	9135.93	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2384	387	3577.69	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2385	387	15096.5	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2386	389	18788.19	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2387	389	2660.27	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2388	389	19392.18	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2389	389	25876.62	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2390	389	2560.41	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2391	389	17181.52	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2392	389	10822.91	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2393	389	17877.2	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2394	390	3291.88	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2395	390	14161.39	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2396	390	15898.09	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2397	390	19788.63	KARGOYA_VERILDI	2025-05-10 03:51:14.792211
2398	390	5946.23	HAZIRLANIYOR	2025-05-10 03:51:14.792211
2399	390	15561.91	TESLIM_EDILDI	2025-05-10 03:51:14.792211
2400	390	6727.89	HAZIRLANIYOR	2025-05-10 03:51:14.792211
\.


--
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_reviews (id, product_id, user_id, rating, comment, created_at) FROM stdin;
1	1	350	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2	1	108	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
3	1	170	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
4	1	259	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
5	1	270	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
6	1	205	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
7	1	200	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
8	1	236	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
9	1	174	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
10	1	351	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
11	1	137	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
12	1	312	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
13	1	309	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
14	1	170	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
15	1	198	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
16	2	243	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
17	2	147	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
18	2	211	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
19	2	334	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
20	2	267	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
21	2	122	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
22	2	230	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
23	2	287	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
24	2	182	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
25	2	317	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
26	2	383	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
27	2	313	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
28	2	167	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
29	2	178	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
30	2	244	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
31	3	214	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
32	3	368	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
33	3	123	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
34	3	360	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
35	3	114	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
36	3	151	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
37	3	143	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
38	3	125	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
39	3	110	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
40	3	360	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
41	3	294	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
42	3	127	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
43	3	364	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
44	3	327	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
45	3	304	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
46	3	315	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
47	4	361	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
48	4	226	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
49	4	181	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
50	4	345	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
51	4	376	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
52	4	318	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
53	4	300	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
54	4	305	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
55	4	329	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
56	4	298	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
57	4	138	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
58	5	272	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
59	5	184	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
60	5	309	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
61	5	295	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
62	5	303	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
63	6	267	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
64	6	136	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
65	6	224	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
66	6	213	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
67	6	267	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
68	6	133	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
69	6	355	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
70	6	208	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
71	6	218	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
72	6	116	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
73	6	373	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
74	6	240	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
75	6	254	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
76	6	183	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
77	6	309	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
78	6	192	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
79	7	170	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
80	7	161	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
81	7	340	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
82	7	106	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
83	7	142	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
84	7	349	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
85	8	380	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
86	8	248	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
87	8	316	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
88	8	211	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
89	8	167	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
90	8	153	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
91	8	220	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
92	8	162	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
93	9	131	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
94	9	309	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
95	9	317	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
96	9	151	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
97	9	349	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
98	9	387	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
99	9	300	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
100	9	253	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
101	9	333	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
102	9	350	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
103	9	121	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
104	9	167	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
105	10	323	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
106	10	283	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
107	10	277	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
108	10	361	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
109	10	157	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
110	11	315	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
111	11	129	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
112	12	328	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
113	12	304	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
114	12	151	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
115	12	223	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
116	12	330	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
117	12	384	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
118	12	369	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
119	12	146	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
120	12	305	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
121	12	245	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
122	12	148	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
123	12	375	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
124	12	265	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
125	12	306	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
126	12	120	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
127	12	176	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
128	13	307	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
129	13	155	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
130	13	297	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
131	13	237	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
132	14	286	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
133	14	222	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
134	14	326	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
135	15	373	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
136	15	323	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
137	16	102	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
138	16	165	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
139	16	324	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
140	16	163	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
141	16	284	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
142	16	254	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
143	16	224	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
144	16	248	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
145	16	213	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
146	17	101	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
147	17	253	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
148	17	158	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
149	17	104	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
150	17	338	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
151	17	142	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
152	17	150	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
153	17	128	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
154	17	340	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
155	17	220	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
156	17	341	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
157	17	169	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
158	17	343	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
159	17	202	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
160	17	124	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
161	17	204	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
162	17	115	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
163	17	158	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
164	17	130	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
165	17	219	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
166	18	106	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
167	18	260	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
168	18	164	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
169	18	318	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
170	18	177	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
171	18	380	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
172	18	346	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
173	18	119	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
174	18	259	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
175	18	193	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
176	18	343	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
177	18	149	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
178	19	262	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
179	19	370	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
180	19	337	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
181	19	131	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
182	20	292	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
183	20	162	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
184	20	389	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
185	20	214	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
186	21	214	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
187	21	217	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
188	21	103	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
189	21	345	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
190	21	152	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
191	21	147	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
192	21	335	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
193	21	262	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
194	21	213	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
195	21	271	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
196	22	184	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
197	22	336	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
198	22	300	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
199	22	214	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
200	22	179	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
201	22	150	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
202	22	287	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
203	22	176	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
204	22	281	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
205	22	341	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
206	22	366	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
207	22	133	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
208	22	211	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
209	22	146	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
210	22	338	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
211	22	127	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
212	23	266	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
213	23	298	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
214	23	324	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
215	23	309	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
216	23	279	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
217	23	208	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
218	23	225	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
219	23	278	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
220	23	335	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
221	23	240	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
222	23	308	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
223	23	384	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
224	23	367	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
225	23	278	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
226	23	146	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
227	23	104	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
228	24	123	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
229	24	226	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
230	24	315	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
231	24	175	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
232	24	324	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
233	24	309	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
234	24	164	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
235	25	232	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
236	25	141	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
237	25	309	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
238	25	108	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
239	26	208	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
240	26	185	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
241	26	292	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
242	26	371	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
243	26	346	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
244	26	135	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
245	27	171	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
246	27	186	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
247	27	269	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
248	27	262	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
249	27	130	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
250	27	371	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
251	27	357	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
252	27	325	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
253	27	181	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
254	27	367	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
255	28	104	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
256	28	177	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
257	28	265	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
258	28	214	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
259	28	184	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
260	28	109	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
261	28	133	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
262	28	339	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
263	28	318	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
264	28	154	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
265	29	244	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
266	29	129	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
267	29	203	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
268	29	376	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
269	29	384	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
270	29	110	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
271	29	258	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
272	29	180	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
273	29	123	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
274	29	123	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
275	29	302	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
276	29	316	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
277	29	124	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
278	29	289	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
279	29	349	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
280	29	193	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
281	29	147	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
282	30	204	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
283	30	347	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
284	30	310	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
285	30	220	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
286	30	234	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
287	30	104	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
288	30	372	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
289	30	186	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
290	30	243	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
291	30	139	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
292	30	389	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
293	30	264	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
294	30	160	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
295	30	144	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
296	30	202	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
297	31	101	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
298	31	205	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
299	31	146	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
300	31	184	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
301	31	142	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
302	31	103	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
303	31	329	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
304	31	219	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
305	31	354	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
306	31	158	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
307	31	332	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
308	31	371	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
309	31	298	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
310	31	275	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
311	31	109	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
312	31	181	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
313	31	253	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
314	31	332	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
315	32	127	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
316	32	240	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
317	32	127	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
318	32	266	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
319	32	131	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
320	32	389	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
321	32	168	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
322	32	370	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
323	32	125	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
324	32	224	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
325	32	129	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
326	32	257	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
327	32	216	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
328	32	147	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
329	32	374	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
330	32	378	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
331	32	135	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
332	32	308	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
333	32	316	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
334	32	369	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
335	33	131	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
336	33	280	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
337	33	292	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
338	33	225	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
339	33	371	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
340	33	122	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
341	33	264	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
342	33	386	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
343	33	389	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
344	33	211	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
345	33	107	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
346	33	170	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
347	33	115	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
348	33	183	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
349	33	112	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
350	33	242	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
351	33	110	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
352	34	153	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
353	34	103	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
354	34	291	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
355	34	303	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
356	34	375	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
357	35	389	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
358	35	103	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
359	35	243	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
360	35	140	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
361	35	337	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
362	35	239	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
363	35	378	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
364	35	171	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
365	35	287	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
366	35	221	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
367	35	118	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
368	35	276	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
369	35	284	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
370	35	198	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
371	35	296	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
372	36	318	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
373	36	103	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
374	37	135	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
375	37	308	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
376	37	203	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
377	37	344	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
378	37	198	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
379	37	160	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
380	37	123	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
381	37	164	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
382	37	342	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
383	37	324	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
384	37	120	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
385	37	294	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
386	37	221	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
387	37	368	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
388	37	201	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
389	37	305	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
390	37	188	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
391	37	274	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
392	38	326	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
393	38	329	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
394	38	178	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
395	38	251	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
396	38	288	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
397	38	215	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
398	38	370	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
399	38	213	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
400	38	150	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
401	38	153	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
402	39	331	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
403	39	259	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
404	39	346	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
405	39	312	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
406	39	239	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
407	39	321	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
408	39	131	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
409	39	254	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
410	39	337	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
411	39	213	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
412	39	317	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
413	40	148	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
414	40	104	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
415	40	369	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
416	40	288	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
417	40	174	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
418	40	281	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
419	40	293	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
420	40	377	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
421	40	193	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
422	40	269	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
423	40	262	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
424	40	256	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
425	40	193	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
426	40	281	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
427	40	334	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
428	40	364	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
429	40	138	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
430	40	194	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
431	40	224	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
432	40	279	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
433	41	198	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
434	41	210	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
435	41	271	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
436	41	272	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
437	41	208	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
438	41	167	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
439	41	298	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
440	42	309	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
441	42	132	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
442	42	291	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
443	42	201	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
444	42	243	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
445	42	120	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
446	42	235	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
447	42	188	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
448	42	105	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
449	42	351	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
450	42	319	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
451	42	381	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
452	42	166	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
453	42	384	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
454	42	373	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
455	43	238	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
456	43	315	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
457	43	352	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
458	43	274	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
459	43	275	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
460	43	333	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
461	43	344	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
462	43	302	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
463	44	147	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
464	44	226	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
465	44	350	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
466	44	218	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
467	44	245	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
468	44	324	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
469	44	365	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
470	44	376	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
471	44	205	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
472	44	291	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
473	45	285	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
474	45	288	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
475	45	250	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
476	45	135	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
477	45	325	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
478	45	348	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
479	45	146	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
480	45	376	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
481	46	241	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
482	46	330	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
483	46	143	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
484	46	188	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
485	46	163	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
486	46	214	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
487	46	110	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
488	46	172	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
489	46	189	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
490	46	200	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
491	46	217	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
492	46	312	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
493	46	267	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
494	46	382	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
495	46	318	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
496	46	256	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
497	46	335	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
498	47	238	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
499	47	179	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
500	47	297	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
501	47	115	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
502	47	155	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
503	47	380	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
504	47	168	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
505	47	267	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
506	47	250	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
507	47	161	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
508	47	203	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
509	47	329	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
510	47	116	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
511	47	254	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
512	47	301	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
513	47	140	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
514	48	166	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
515	48	187	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
516	48	288	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
517	48	318	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
518	48	284	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
519	48	193	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
520	241	330	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
521	241	380	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
522	241	363	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
523	241	160	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
524	241	330	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
525	241	176	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
526	241	285	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
527	241	322	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
528	241	197	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
529	241	128	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
530	241	138	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
531	241	285	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
532	241	166	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
533	241	353	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
534	241	281	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
535	241	117	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
536	241	123	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
537	241	369	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
538	241	214	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
539	49	169	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
540	49	105	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
541	49	385	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
542	49	156	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
543	49	105	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
544	49	113	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
545	49	346	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
546	49	280	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
547	49	260	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
548	50	221	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
549	50	200	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
550	50	301	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
551	50	286	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
552	51	264	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
553	51	337	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
554	51	246	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
555	51	207	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
556	51	265	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
557	51	141	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
558	51	168	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
559	51	352	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
560	51	275	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
561	51	314	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
562	52	353	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
563	52	206	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
564	52	282	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
565	52	267	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
566	52	207	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
567	52	115	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
568	52	360	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
569	52	290	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
570	52	146	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
571	52	138	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
572	52	304	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
573	52	248	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
574	52	103	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
575	52	257	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
576	52	162	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
577	52	343	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
578	52	164	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
579	52	146	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
580	52	329	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
581	52	277	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
582	53	114	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
583	53	133	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
584	53	225	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
585	53	187	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
586	53	369	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
587	53	223	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
588	53	101	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
589	53	293	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
590	53	295	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
591	53	263	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
592	54	184	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
593	54	319	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
594	54	239	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
595	54	257	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
596	54	372	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
597	54	196	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
598	54	386	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
599	54	302	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
600	54	278	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
601	54	147	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
602	54	102	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
603	54	305	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
604	54	180	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
605	54	133	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
606	54	179	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
607	55	322	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
608	55	132	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
609	55	365	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
610	56	130	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
611	56	308	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
612	56	336	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
613	56	367	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
614	56	361	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
615	56	199	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
616	56	328	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
617	56	115	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
618	56	281	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
619	56	109	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
620	56	367	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
621	56	266	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
622	56	263	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
623	56	138	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
624	56	281	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
625	56	248	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
626	57	274	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
627	57	167	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
628	57	252	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
629	57	212	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
630	57	209	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
631	57	379	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
632	57	312	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
633	58	372	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
634	58	137	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
635	58	289	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
636	58	196	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
637	58	257	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
638	58	217	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
639	58	173	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
640	58	160	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
641	58	369	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
642	58	248	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
643	58	262	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
644	58	208	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
645	58	156	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
646	58	298	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
647	58	112	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
648	58	113	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
649	58	191	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
650	58	265	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
651	59	321	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
652	59	283	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
653	59	174	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
654	59	252	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
655	59	191	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
656	59	264	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
657	59	142	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
658	59	206	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
659	59	302	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
660	59	347	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
661	59	209	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
662	59	163	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
663	59	206	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
664	59	212	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
665	59	167	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
666	59	323	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
667	59	316	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
668	59	236	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
669	59	314	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
670	59	364	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
671	60	239	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
672	60	386	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
673	60	296	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
674	60	157	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
675	60	387	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
676	60	370	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
677	60	348	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
678	60	361	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
679	60	123	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
680	60	177	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
681	60	132	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
682	60	125	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
683	60	152	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
684	61	385	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
685	61	134	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
686	61	238	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
687	61	168	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
688	61	139	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
689	61	382	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
690	61	387	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
691	61	324	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
692	61	205	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
693	61	265	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
694	61	240	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
695	61	371	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
696	61	261	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
697	61	220	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
698	61	163	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
699	61	267	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
700	61	320	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
701	61	264	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
702	61	149	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
703	61	363	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
704	62	371	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
705	62	362	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
706	62	366	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
707	62	195	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
708	62	173	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
709	62	365	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
710	62	337	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
711	62	206	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
712	62	146	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
713	62	220	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
714	62	321	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
715	62	352	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
716	62	342	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
717	62	164	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
718	62	123	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
719	62	137	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
720	62	244	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
721	62	152	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
722	62	116	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
723	62	186	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
724	63	246	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
725	63	123	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
726	63	367	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
727	63	322	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
728	63	213	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
729	63	259	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
730	63	136	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
731	63	149	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
732	63	117	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
733	63	175	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
734	63	212	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
735	63	332	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
736	63	249	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
737	63	280	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
738	63	347	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
739	64	384	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
740	64	214	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
741	64	280	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
742	64	131	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
743	64	295	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
744	64	247	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
745	64	369	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
746	64	378	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
747	65	235	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
748	65	229	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
749	65	139	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
750	65	259	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
751	65	380	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
752	65	305	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
753	65	208	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
754	65	132	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
755	65	181	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
756	65	197	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
757	65	277	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
758	66	106	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
759	66	237	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
760	66	315	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
761	66	178	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
762	67	180	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
763	67	306	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
764	67	176	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
765	67	120	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
766	67	275	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
767	67	389	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
768	67	365	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
769	67	165	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
770	67	127	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
771	67	382	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
772	67	123	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
773	67	255	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
774	67	338	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
775	67	161	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
776	67	239	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
777	67	195	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
778	67	222	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
779	67	208	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
780	67	267	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
781	68	129	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
782	68	238	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
783	68	112	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
784	68	341	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
785	68	334	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
786	69	265	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
787	69	143	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
788	69	209	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
789	69	249	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
790	70	122	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
791	70	224	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
792	70	313	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
793	70	204	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
794	70	102	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
795	71	153	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
796	71	130	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
797	72	331	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
798	72	179	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
799	72	138	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
800	72	313	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
801	73	295	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
802	73	314	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
803	73	201	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
804	73	308	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
805	73	299	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
806	73	280	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
807	73	116	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
808	73	167	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
809	73	133	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
810	73	361	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
811	73	310	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
812	73	146	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
813	73	313	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
814	73	267	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
815	73	105	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
816	73	214	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
817	73	229	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
818	73	342	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
819	74	161	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
820	74	372	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
821	74	198	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
822	74	333	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
823	74	301	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
824	74	235	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
825	74	311	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
826	74	302	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
827	74	380	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
828	74	334	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
829	74	336	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
830	74	260	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
831	75	278	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
832	75	171	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
833	75	259	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
834	75	280	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
835	75	287	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
836	75	231	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
837	75	282	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
838	75	152	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
839	75	323	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
840	75	234	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
841	76	278	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
842	76	231	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
843	76	332	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
844	76	235	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
845	76	303	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
846	76	326	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
847	76	183	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
848	76	362	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
849	76	278	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
850	76	339	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
851	76	108	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
852	76	180	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
853	76	111	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
854	76	238	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
855	76	206	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
856	76	147	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
857	76	144	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
858	76	233	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
859	77	145	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
860	77	343	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
861	77	338	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
862	77	223	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
863	77	299	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
864	78	251	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
865	78	181	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
866	78	173	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
867	78	312	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
868	78	222	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
869	78	196	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
870	78	231	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
871	78	280	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
872	78	262	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
873	78	368	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
874	78	128	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
875	78	141	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
876	78	291	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
877	78	172	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
878	78	138	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
879	78	266	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
880	79	348	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
881	79	269	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
882	79	381	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
883	79	113	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
884	79	319	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
885	79	356	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
886	79	107	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
887	79	138	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
888	79	153	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
889	79	208	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
890	79	210	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
891	79	318	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
892	79	101	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
893	79	275	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
894	79	161	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
895	79	215	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
896	79	260	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
897	80	325	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
898	80	219	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
899	80	172	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
900	81	305	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
901	81	319	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
902	81	302	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
903	81	115	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
904	81	293	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
905	81	352	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
906	82	188	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
907	82	196	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
908	82	270	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
909	82	203	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
910	82	368	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
911	82	128	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
912	82	298	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
913	82	217	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
914	83	218	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
915	83	248	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
916	83	201	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
917	83	233	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
918	83	326	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
919	83	300	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
920	83	162	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
921	83	239	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
922	83	294	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
923	83	362	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
924	83	152	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
925	83	353	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
926	83	318	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
927	83	234	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
928	83	389	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
929	83	231	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
930	83	201	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
931	84	387	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
932	84	313	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
933	84	364	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
934	84	234	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
935	84	105	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
936	84	382	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
937	84	311	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
938	85	126	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
939	85	296	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
940	85	374	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
941	85	256	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
942	85	128	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
943	85	170	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
944	85	322	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
945	86	201	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
946	86	330	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
947	86	372	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
948	86	268	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
949	86	135	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
950	86	346	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
951	86	160	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
952	86	359	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
953	86	378	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
954	87	224	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
955	87	319	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
956	87	339	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
957	87	187	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
958	87	155	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
959	87	209	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
960	87	214	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
961	87	333	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
962	87	280	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
963	88	296	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
964	88	347	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
965	88	338	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
966	88	152	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
967	88	110	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
968	88	380	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
969	88	252	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
970	88	275	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
971	88	121	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
972	88	240	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
973	88	114	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
974	88	377	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
975	88	336	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
976	88	305	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
977	88	384	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
978	88	120	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
979	89	195	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
980	89	323	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
981	89	274	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
982	89	154	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
983	89	135	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
984	89	118	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
985	90	111	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
986	90	349	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
987	90	347	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
988	90	120	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
989	90	311	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
990	90	161	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
991	90	333	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
992	90	280	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
993	90	169	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
994	90	157	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
995	90	332	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
996	90	171	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
997	90	265	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
998	90	286	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
999	90	276	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1000	90	257	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1001	90	134	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1002	91	126	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1003	91	210	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1004	92	301	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1005	92	371	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1006	92	259	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1007	92	242	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1008	92	359	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1009	92	121	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1010	92	168	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1011	92	379	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1012	92	378	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1013	92	384	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1014	92	305	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1015	93	138	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1016	93	203	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1017	93	215	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1018	93	193	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1019	93	181	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1020	93	359	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1021	93	228	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1022	93	341	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1023	93	105	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1024	93	230	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1025	93	300	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1026	93	202	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1027	93	161	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1028	93	156	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1029	93	351	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1030	93	153	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1031	93	199	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1032	93	305	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1033	93	339	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1034	93	164	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1035	94	154	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1036	94	280	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1037	94	349	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1038	94	295	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1039	94	255	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1040	94	372	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1041	94	293	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1042	94	125	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1043	94	234	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1044	94	271	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1045	94	159	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1046	94	113	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1047	95	143	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1048	95	121	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1049	95	169	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1050	95	311	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1051	95	384	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1052	95	320	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1053	95	153	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1054	96	263	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1055	96	319	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1056	96	359	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1057	96	292	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1058	96	103	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1059	96	239	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1060	96	160	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1061	96	253	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1062	96	325	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1063	96	157	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1064	96	149	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1065	96	306	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1066	96	223	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1067	96	264	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1068	96	188	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1069	97	337	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1070	97	313	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1071	97	133	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1072	97	349	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1073	97	131	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1074	97	203	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1075	97	147	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1076	97	328	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1077	97	126	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1078	97	353	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1079	97	270	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1080	98	201	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1081	98	197	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1082	98	108	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1083	98	325	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1084	98	258	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1085	98	311	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1086	98	343	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1087	99	356	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1088	99	336	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1089	99	196	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1090	99	256	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1091	99	102	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1092	99	363	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1093	99	360	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1094	99	190	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1095	100	276	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1096	100	371	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1097	100	329	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1098	101	310	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1099	101	138	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1100	101	285	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1101	101	338	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1102	101	249	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1103	101	140	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1104	101	161	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1105	101	196	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1106	101	110	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1107	101	274	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1108	101	317	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1109	102	111	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1110	102	259	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1111	103	192	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1112	103	303	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1113	103	178	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1114	103	327	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1115	103	165	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1116	103	287	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1117	103	210	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1118	103	295	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1119	103	347	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1120	103	206	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1121	103	107	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1122	104	298	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1123	104	103	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1124	104	166	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1125	104	352	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1126	104	105	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1127	104	283	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1128	104	312	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1129	104	159	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1130	104	349	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1131	104	160	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1132	104	323	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1133	104	334	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1134	104	336	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1135	104	299	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1136	105	326	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1137	105	336	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1138	105	208	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1139	105	300	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1140	105	339	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1141	105	312	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1142	105	173	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1143	105	205	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1144	105	175	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1145	105	146	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1146	105	206	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1147	105	382	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1148	105	284	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1149	105	314	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1150	105	202	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1151	105	253	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1152	105	274	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1153	106	207	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1154	106	115	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1155	106	298	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1156	106	128	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1157	107	218	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1158	107	299	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1159	107	386	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1160	107	166	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1161	107	129	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1162	107	111	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1163	108	311	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1164	108	178	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1165	108	380	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1166	108	138	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1167	108	370	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1168	108	119	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1169	108	333	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1170	108	147	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1171	108	140	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1172	108	251	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1173	108	186	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1174	108	205	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1175	109	316	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1176	109	339	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1177	109	345	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1178	109	222	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1179	109	275	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1180	109	114	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1181	109	203	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1182	109	316	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1183	109	239	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1184	109	276	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1185	109	172	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1186	109	288	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1187	109	294	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1188	109	295	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1189	109	305	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1190	109	238	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1191	109	305	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1192	110	119	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1193	110	287	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1194	110	161	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1195	110	364	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1196	110	207	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1197	110	157	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1198	110	266	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1199	110	150	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1200	110	102	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1201	111	151	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1202	111	269	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1203	111	219	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1204	111	347	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1205	111	252	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1206	111	389	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1207	111	304	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1208	111	178	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1209	111	180	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1210	111	386	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1211	112	106	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1212	112	170	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1213	112	277	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1214	112	259	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1215	112	126	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1216	112	322	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1217	112	102	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1218	112	176	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1219	112	377	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1220	112	373	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1221	112	248	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1222	112	155	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1223	112	173	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1224	113	284	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1225	113	174	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1226	113	116	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1227	113	132	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1228	113	163	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1229	113	225	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1230	113	272	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1231	113	298	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1232	113	106	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1233	113	189	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1234	113	211	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1235	113	132	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1236	113	123	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1237	113	208	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1238	113	388	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1239	113	305	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1240	113	389	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1241	114	170	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1242	114	119	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1243	114	110	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1244	114	124	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1245	114	337	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1246	114	262	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1247	114	307	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1248	114	305	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1249	114	160	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1250	114	198	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1251	114	377	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1252	114	216	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1253	115	197	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1254	115	114	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1255	115	361	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1256	115	122	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1257	115	137	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1258	115	248	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1259	116	383	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1260	116	272	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1261	116	107	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1262	116	127	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1263	116	376	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1264	116	272	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1265	116	125	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1266	116	117	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1267	116	324	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1268	116	143	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1269	116	337	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1270	116	152	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1271	116	105	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1272	116	329	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1273	116	285	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1274	116	388	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1275	117	298	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1276	117	179	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1277	117	120	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1278	117	158	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1279	117	340	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1280	117	287	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1281	118	221	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1282	118	215	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1283	118	225	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1284	118	129	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1285	118	376	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1286	118	207	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1287	118	387	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1288	118	347	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1289	118	389	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1290	118	257	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1291	118	279	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1292	118	150	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1293	118	216	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1294	118	367	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1295	118	323	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1296	118	150	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1297	118	210	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1298	118	153	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1299	118	251	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1300	119	122	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1301	119	150	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1302	119	316	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1303	119	191	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1304	119	118	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1305	119	206	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1306	119	145	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1307	119	258	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1308	119	166	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1309	119	258	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1310	119	370	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1311	119	341	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1312	119	185	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1313	120	335	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1314	120	233	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1315	120	175	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1316	120	165	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1317	120	176	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1318	120	113	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1319	120	362	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1320	120	243	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1321	120	337	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1322	120	304	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1323	120	147	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1324	120	331	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1325	120	390	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1326	121	197	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1327	121	205	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1328	121	263	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1329	121	108	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1330	121	235	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1331	121	377	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1332	121	390	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1333	121	276	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1334	121	172	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1335	121	257	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1336	121	375	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1337	121	351	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1338	121	334	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1339	122	126	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1340	122	244	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1341	122	331	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1342	123	315	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1343	123	331	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1344	123	103	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1345	123	250	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1346	123	138	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1347	123	132	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1348	123	237	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1349	123	185	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1350	123	282	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1351	123	160	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1352	123	291	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1353	123	355	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1354	123	208	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1355	123	191	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1356	123	278	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1357	123	151	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1358	124	288	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1359	124	347	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1360	124	307	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1361	124	184	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1362	124	101	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1363	124	294	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1364	124	334	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1365	124	145	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1366	124	245	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1367	124	229	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1368	124	330	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1369	124	154	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1370	124	319	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1371	124	355	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1372	124	337	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1373	125	294	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1374	125	292	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1375	125	359	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1376	125	283	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1377	125	257	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1378	125	255	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1379	125	113	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1380	125	204	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1381	125	348	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1382	125	291	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1383	125	279	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1384	125	357	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1385	125	288	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1386	125	216	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1387	125	143	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1388	125	301	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1389	125	356	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1390	125	104	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1391	125	245	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1392	126	148	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1393	126	373	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1394	126	314	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1395	126	364	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1396	126	104	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1397	126	255	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1398	127	113	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1399	127	217	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1400	127	227	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1401	127	163	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1402	127	349	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1403	127	189	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1404	127	206	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1405	127	348	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1406	127	351	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1407	127	198	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1408	127	145	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1409	127	255	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1410	127	116	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1411	127	133	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1412	127	251	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1413	128	194	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1414	128	247	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1415	128	103	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1416	128	274	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1417	128	376	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1418	128	189	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1419	128	316	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1420	128	355	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1421	128	310	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1422	128	249	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1423	128	337	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1424	128	309	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1425	128	282	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1426	128	213	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1427	128	371	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1428	128	314	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1429	128	153	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1430	128	135	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1431	128	371	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1432	128	288	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1433	129	336	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1434	129	210	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1435	129	296	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1436	129	217	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1437	129	278	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1438	129	152	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1439	129	224	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1440	129	232	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1441	129	275	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1442	129	143	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1443	129	286	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1444	130	207	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1445	130	112	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1446	130	379	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1447	130	304	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1448	130	345	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1449	130	338	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1450	130	385	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1451	130	335	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1452	130	249	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1453	130	368	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1454	130	121	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1455	130	370	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1456	130	378	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1457	131	167	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1458	131	354	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1459	131	274	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1460	131	275	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1461	131	209	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1462	131	277	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1463	131	379	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1464	131	335	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1465	131	383	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1466	131	335	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1467	132	152	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1468	132	385	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1469	132	193	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1470	132	221	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1471	132	300	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1472	132	222	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1473	132	134	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1474	132	126	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1475	132	325	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1476	132	243	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1477	132	289	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1478	132	310	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1479	133	285	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1480	133	157	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1481	133	273	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1482	133	263	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1483	133	170	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1484	133	104	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1485	133	200	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1486	133	251	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1487	133	318	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1488	133	390	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1489	133	226	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1490	133	339	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1491	133	205	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1492	133	197	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1493	133	187	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1494	133	317	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1495	133	355	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1496	134	146	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1497	134	145	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1498	134	173	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1499	134	154	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1500	134	272	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1501	134	150	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1502	134	353	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1503	135	189	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1504	135	150	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1505	135	253	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1506	135	128	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1507	135	283	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1508	136	322	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1509	136	150	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1510	136	240	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1511	136	239	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1512	136	222	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1513	136	199	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1514	136	278	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1515	136	315	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1516	136	112	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1517	136	155	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1518	136	147	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1519	136	199	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1520	137	300	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1521	137	119	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1522	137	340	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1523	137	182	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1524	137	250	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1525	137	291	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1526	137	218	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1527	138	142	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1528	138	271	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1529	138	321	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1530	138	119	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1531	138	233	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1532	138	354	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1533	138	182	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1534	138	116	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1535	139	240	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1536	139	352	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1537	139	288	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1538	139	250	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1539	140	144	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1540	140	249	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1541	140	337	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1542	140	184	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1543	140	143	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1544	140	131	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1545	140	364	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1546	140	339	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1547	140	262	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1548	140	383	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1549	140	341	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1550	140	201	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1551	140	104	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1552	141	340	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1553	141	278	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1554	141	341	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1555	141	304	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1556	141	107	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1557	142	263	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1558	142	369	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1559	142	165	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1560	142	297	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1561	142	262	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1562	142	307	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1563	143	142	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1564	143	382	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1565	143	342	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1566	143	367	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1567	143	298	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1568	143	108	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1569	143	239	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1570	143	296	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1571	143	205	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1572	143	164	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1573	143	147	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1574	143	324	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1575	143	271	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1576	143	249	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1577	143	172	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1578	143	336	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1579	143	364	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1580	143	316	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1581	144	139	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1582	144	215	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1583	144	295	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1584	145	276	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1585	145	187	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1586	145	237	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1587	145	358	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1588	145	368	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1589	145	300	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1590	145	162	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1591	145	203	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1592	145	297	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1593	145	385	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1594	145	152	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1595	145	159	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1596	145	226	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1597	145	233	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1598	145	362	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1599	146	249	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1600	146	259	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1601	146	348	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1602	147	382	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1603	147	186	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1604	147	374	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1605	147	383	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1606	147	389	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1607	148	232	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1608	148	132	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1609	148	184	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1610	148	190	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1611	148	133	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1612	148	284	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1613	148	386	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1614	148	197	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1615	148	150	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1616	148	287	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1617	149	277	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1618	149	244	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1619	149	364	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1620	149	121	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1621	149	298	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1622	149	277	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1623	149	104	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1624	149	293	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1625	149	386	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1626	149	275	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1627	150	156	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1628	150	319	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1629	151	208	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1630	151	309	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1631	151	324	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1632	151	136	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1633	151	286	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1634	151	229	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1635	151	291	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1636	151	317	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1637	151	143	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1638	151	208	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1639	151	324	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1640	151	308	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1641	151	246	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1642	152	145	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1643	152	308	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1644	152	126	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1645	152	325	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1646	152	202	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1647	152	299	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1648	152	364	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1649	152	293	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1650	152	270	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1651	152	173	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1652	152	282	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1653	152	357	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1654	152	268	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1655	152	254	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1656	152	389	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1657	152	360	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1658	152	317	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1659	152	274	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1660	153	262	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1661	153	151	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1662	153	133	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1663	153	370	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1664	153	243	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1665	153	216	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1666	153	283	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1667	153	317	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1668	153	178	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1669	153	268	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1670	153	228	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1671	154	386	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1672	154	309	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1673	154	308	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1674	154	303	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1675	154	375	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1676	154	208	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1677	154	183	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1678	154	366	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1679	154	310	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1680	154	285	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1681	154	292	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1682	154	162	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1683	155	267	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1684	155	101	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1685	155	204	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1686	155	362	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1687	155	169	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1688	155	234	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1689	155	316	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1690	155	138	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1691	155	351	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1692	155	365	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1693	155	281	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1694	155	134	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1695	155	157	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1696	155	140	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1697	155	115	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1698	156	112	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1699	156	136	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1700	156	163	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1701	156	333	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1702	156	137	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1703	156	169	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1704	157	105	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1705	157	362	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1706	157	252	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1707	157	368	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1708	157	138	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1709	157	389	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1710	157	203	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1711	157	107	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1712	157	267	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1713	158	201	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1714	158	198	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1715	158	286	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1716	158	301	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1717	158	278	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1718	158	294	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1719	158	196	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1720	158	356	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1721	158	189	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1722	158	116	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1723	158	195	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1724	158	346	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1725	158	383	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1726	158	135	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1727	158	118	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1728	158	207	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1729	159	115	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1730	159	164	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1731	159	157	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1732	159	285	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1733	159	146	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1734	159	217	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1735	159	327	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1736	159	384	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1737	159	390	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1738	159	263	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1739	159	319	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1740	159	179	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1741	159	170	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1742	159	115	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1743	159	266	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1744	159	127	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1745	159	118	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1746	159	266	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1747	159	356	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1748	159	166	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1749	160	308	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1750	160	340	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1751	160	228	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1752	160	280	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1753	160	295	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1754	160	182	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1755	160	272	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1756	160	329	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1757	160	274	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1758	161	239	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1759	161	364	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1760	161	152	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1761	161	127	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1762	161	172	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1763	161	339	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1764	161	306	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1765	161	359	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1766	161	185	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1767	162	272	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1768	162	157	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1769	162	182	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1770	162	234	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1771	162	306	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1772	162	172	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1773	162	259	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1774	162	111	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1775	162	281	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1776	162	191	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1777	162	112	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1778	162	185	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1779	162	108	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1780	163	255	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1781	163	267	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1782	163	306	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1783	163	209	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1784	163	236	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1785	163	222	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1786	163	232	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1787	164	200	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1788	164	211	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1789	164	290	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1790	164	124	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1791	164	120	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1792	164	226	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1793	164	267	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1794	164	119	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1795	164	361	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1796	164	128	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1797	164	168	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1798	164	148	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1799	164	127	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1800	164	370	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1801	164	293	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1802	164	150	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1803	164	233	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1804	164	262	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1805	165	289	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1806	165	359	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1807	165	225	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1808	165	111	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1809	165	275	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1810	165	259	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1811	165	104	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1812	165	286	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1813	165	108	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1814	165	217	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1815	165	320	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1816	165	229	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1817	165	303	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1818	166	204	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1819	166	359	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1820	166	146	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1821	166	374	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1822	166	206	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1823	166	319	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1824	166	127	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1825	166	373	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1826	167	312	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1827	167	229	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1828	167	345	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1829	167	249	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1830	167	257	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1831	167	254	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1832	167	208	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1833	168	234	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1834	168	262	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1835	168	234	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1836	168	356	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1837	168	206	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1838	168	151	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1839	168	342	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1840	168	317	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1841	168	179	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1842	168	292	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1843	168	101	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1844	168	317	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1845	168	253	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1846	168	253	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1847	168	362	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1848	168	384	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1849	168	160	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1850	168	117	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1851	168	177	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1852	169	227	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1853	169	169	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1854	169	236	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1855	169	203	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1856	169	373	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1857	169	353	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1858	169	252	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1859	170	195	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1860	170	352	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1861	170	362	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1862	170	204	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1863	170	317	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1864	170	128	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1865	171	201	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1866	171	210	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1867	171	179	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1868	171	186	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1869	172	113	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1870	172	206	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1871	172	126	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1872	172	115	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1873	172	263	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1874	172	330	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1875	172	233	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1876	172	216	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1877	172	350	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1878	172	226	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1879	172	336	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1880	172	133	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1881	172	313	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1882	172	184	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1883	172	317	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1884	172	362	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1885	172	306	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1886	173	365	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1887	173	139	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1888	173	246	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1889	173	238	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1890	173	145	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1891	174	271	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1892	174	351	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1893	175	188	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1894	175	388	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1895	175	350	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1896	175	386	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1897	175	352	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1898	175	104	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1899	175	207	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1900	176	384	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1901	176	208	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1902	176	368	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1903	176	366	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1904	176	121	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1905	176	242	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1906	176	269	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1907	176	150	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1908	176	193	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1909	176	276	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
1910	176	142	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1911	176	281	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1912	176	104	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
1913	176	351	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1914	176	211	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1915	176	213	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
1916	176	118	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1917	176	163	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1918	176	128	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
1919	176	127	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1920	177	102	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1921	177	195	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1922	177	142	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1923	177	170	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1924	177	326	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1925	178	209	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1926	178	149	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1927	178	333	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1928	178	316	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1929	178	294	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1930	178	255	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1931	178	382	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1932	178	340	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
1933	178	177	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1934	178	264	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1935	178	223	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1936	178	190	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1937	178	112	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
1938	178	164	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1939	178	273	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1940	179	324	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1941	179	178	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1942	179	179	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1943	179	373	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1944	179	389	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1945	179	139	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1946	179	265	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1947	179	262	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1948	179	312	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1949	179	265	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1950	179	102	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1951	179	384	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1952	179	351	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1953	179	152	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1954	179	122	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1955	179	189	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1956	179	105	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1957	179	286	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1958	179	308	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1959	180	329	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1960	180	318	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1961	180	376	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1962	180	351	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1963	180	368	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
1964	180	345	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1965	180	136	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
1966	180	317	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1967	180	144	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1968	180	157	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
1969	180	135	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1970	180	327	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1971	180	208	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1972	180	366	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1973	180	214	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
1974	180	123	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
1975	180	144	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1976	180	264	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1977	180	197	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
1978	181	345	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
1979	181	102	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1980	181	160	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1981	181	105	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1982	181	381	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
1983	181	112	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
1984	181	282	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
1985	181	304	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1986	181	106	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
1987	181	274	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1988	181	271	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
1989	181	101	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
1990	181	352	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
1991	182	178	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1992	182	144	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1993	182	248	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
1994	182	359	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
1995	182	189	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
1996	183	142	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
1997	183	130	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1998	183	354	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
1999	183	190	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2000	183	134	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2001	183	143	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2002	183	148	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2003	183	266	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2004	183	138	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2005	183	389	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2006	183	353	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2007	183	148	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2008	183	275	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2009	183	144	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2010	183	144	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2011	183	306	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2012	183	381	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2013	183	282	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2014	183	194	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2015	183	311	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2016	184	255	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2017	184	294	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2018	184	264	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2019	184	119	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2020	184	257	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2021	184	251	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2022	184	189	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2023	184	328	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2024	184	197	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2025	184	234	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2026	184	390	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2027	184	111	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2028	184	370	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2029	184	212	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2030	184	119	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2031	184	124	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2032	185	286	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2033	185	345	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2034	186	287	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2035	186	344	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2036	186	135	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2037	186	283	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2038	186	267	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2039	186	363	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2040	186	148	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2041	186	167	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2042	186	103	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2043	186	115	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2044	186	105	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2045	186	264	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2046	186	388	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2047	186	275	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2048	186	383	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2049	186	385	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2050	187	311	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2051	187	377	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2052	187	141	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2053	187	311	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2054	187	291	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2055	187	143	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2056	187	358	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2057	187	332	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2058	187	168	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2059	187	383	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2060	187	296	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2061	187	343	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2062	187	386	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2063	187	376	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2064	187	334	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2065	187	346	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2066	187	192	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2067	187	359	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2068	187	339	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2069	188	368	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2070	188	165	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2071	188	337	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2072	188	354	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2073	188	367	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2074	188	326	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2075	188	110	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2076	188	388	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2077	188	291	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2078	189	135	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2079	189	169	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2080	189	364	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2081	189	212	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2082	189	347	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2083	190	141	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2084	190	117	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2085	190	176	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2086	190	267	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2087	190	311	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2088	190	366	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2089	190	337	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2090	191	387	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2091	191	195	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2092	191	291	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2093	191	319	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2094	191	390	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2095	191	155	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2096	191	341	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2097	191	333	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2098	191	223	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2099	191	322	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2100	191	179	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2101	191	179	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2102	191	147	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2103	192	238	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2104	192	267	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2105	192	302	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2106	192	227	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2107	192	315	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2108	192	267	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2109	192	184	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2110	192	138	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2111	192	286	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2112	192	139	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2113	193	386	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2114	193	210	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2115	193	187	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2116	193	101	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2117	193	295	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2118	193	201	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2119	193	333	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2120	193	178	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2121	193	160	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2122	193	252	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2123	193	318	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2124	193	199	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2125	193	273	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2126	193	129	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2127	194	209	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2128	194	353	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2129	194	308	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2130	194	353	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2131	194	143	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2132	194	145	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2133	194	261	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2134	194	258	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2135	194	133	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2136	194	196	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2137	194	273	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2138	194	204	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2139	194	147	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2140	194	341	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2141	194	189	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2142	195	309	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2143	195	101	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2144	195	144	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2145	195	237	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2146	195	336	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2147	195	359	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2148	195	273	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2149	195	189	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2150	195	188	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2151	195	140	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2152	195	333	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2153	195	184	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2154	195	219	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2155	195	137	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2156	195	387	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2157	195	155	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2158	195	146	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2159	195	307	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2160	196	166	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2161	196	211	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2162	196	151	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2163	196	342	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2164	196	286	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2165	196	150	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2166	196	156	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2167	196	246	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2168	196	306	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2169	196	143	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2170	196	197	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2171	197	304	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2172	197	259	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2173	197	174	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2174	197	260	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2175	197	167	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2176	197	365	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2177	197	236	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2178	197	131	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2179	197	331	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2180	197	277	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2181	198	379	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2182	198	316	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2183	198	365	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2184	198	139	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2185	198	157	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2186	198	249	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2187	198	386	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2188	198	211	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2189	198	338	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2190	198	349	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2191	198	371	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2192	199	303	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2193	199	249	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2194	200	254	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2195	200	268	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2196	201	359	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2197	201	225	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2198	202	127	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2199	202	203	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2200	202	290	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2201	202	276	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2202	202	362	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2203	202	157	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2204	202	229	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2205	202	154	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2206	202	154	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2207	202	109	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2208	202	187	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2209	202	293	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2210	202	123	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2211	202	277	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2212	202	180	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2213	203	202	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2214	203	192	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2215	203	367	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2216	203	198	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2217	203	186	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2218	203	305	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2219	203	277	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2220	203	333	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2221	203	276	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2222	203	129	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2223	203	254	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2224	203	197	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2225	203	364	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2226	204	360	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2227	204	353	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2228	204	154	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2229	204	190	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2230	204	254	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2231	204	285	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2232	204	307	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2233	205	318	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2234	205	346	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2235	205	124	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2236	205	138	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2237	205	372	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2238	205	300	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2239	205	290	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2240	205	241	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2241	205	285	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2242	205	381	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2243	205	311	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2244	206	333	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2245	206	332	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2246	206	277	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2247	206	221	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2248	206	353	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2249	206	281	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2250	206	142	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2251	206	298	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2252	206	224	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2253	206	236	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2254	206	341	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2255	206	377	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2256	206	348	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2257	206	345	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2258	206	185	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2259	207	212	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2260	207	223	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2261	208	200	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2262	208	348	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2263	208	188	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2264	208	260	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2265	209	116	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2266	209	357	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2267	209	271	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2268	209	116	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2269	209	385	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2270	209	292	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2271	209	193	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2272	209	247	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2273	209	135	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2274	209	183	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2275	209	316	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2276	209	256	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2277	209	304	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2278	209	307	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2279	209	220	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2280	209	201	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2281	209	206	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2282	210	139	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2283	210	319	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2284	210	191	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2285	210	377	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2286	210	330	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2287	210	381	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2288	210	136	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2289	210	239	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2290	211	273	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2291	211	262	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2292	211	168	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2293	211	251	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2294	211	379	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2295	211	194	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2296	211	359	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2297	211	366	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2298	211	148	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2299	211	252	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2300	211	362	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2301	211	293	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2302	211	135	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2303	211	361	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2304	211	221	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2305	211	256	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2306	211	314	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2307	211	349	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2308	211	193	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2309	211	336	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2310	212	316	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2311	212	235	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2312	212	384	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2313	212	182	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2314	212	317	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2315	212	147	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2316	212	211	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2317	212	108	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2318	212	331	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2319	212	229	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2320	212	342	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2321	212	329	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2322	212	389	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2323	212	305	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2324	212	154	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2325	212	153	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2326	212	346	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2327	213	355	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2328	213	274	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2329	213	190	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2330	213	347	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2331	213	122	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2332	213	115	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2333	213	235	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2334	213	168	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2335	213	354	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2336	213	225	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2337	213	167	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2338	213	275	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2339	213	328	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2340	213	124	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2341	213	325	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2342	213	239	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2343	213	123	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2344	213	226	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2345	214	186	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2346	214	103	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2347	214	374	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2348	214	351	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2349	214	140	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2350	214	165	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2351	214	386	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2352	214	386	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2353	214	254	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2354	214	154	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2355	214	230	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2356	214	293	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2357	214	217	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2358	214	137	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2359	214	254	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2360	215	188	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2361	215	382	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2362	215	294	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2363	215	261	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2364	215	147	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2365	215	126	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2366	215	159	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2367	215	241	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2368	215	331	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2369	215	313	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2370	215	288	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2371	215	295	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2372	215	334	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2373	215	390	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2374	216	384	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2375	216	351	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2376	217	344	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2377	217	321	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2378	217	253	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2379	217	334	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2380	217	252	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2381	217	280	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2382	218	175	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2383	218	146	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2384	218	198	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2385	218	158	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2386	218	199	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2387	218	280	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2388	218	199	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2389	218	219	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2390	218	212	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2391	218	110	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2392	218	223	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2393	218	167	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2394	218	244	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2395	218	373	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2396	218	223	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2397	218	112	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2398	218	249	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2399	218	274	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2400	219	164	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2401	219	122	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2402	219	208	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2403	219	350	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2404	219	131	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2405	219	363	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2406	219	215	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2407	219	207	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2408	219	206	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2409	219	224	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2410	219	103	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2411	219	193	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2412	219	367	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2413	219	234	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2414	219	266	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2415	220	276	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2416	220	128	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2417	220	347	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2418	220	367	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2419	220	167	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2420	220	314	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2421	220	127	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2422	221	355	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2423	221	131	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2424	221	286	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2425	221	283	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2426	221	194	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2427	221	208	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2428	221	336	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2429	222	336	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2430	222	103	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2431	222	268	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2432	222	255	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2433	222	385	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2434	222	387	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2435	223	384	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2436	223	374	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2437	223	254	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2438	223	220	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2439	223	102	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2440	223	323	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2441	223	364	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2442	223	107	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2443	223	179	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2444	223	295	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2445	223	341	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2446	223	387	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2447	224	152	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2448	224	154	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2449	224	178	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2450	224	380	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2451	224	331	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2452	224	288	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2453	224	295	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2454	224	121	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2455	224	191	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2456	224	350	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2457	224	127	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2458	224	157	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2459	224	266	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2460	224	300	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2461	224	292	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2462	224	234	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2463	224	333	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2464	224	303	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2465	224	343	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2466	225	379	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2467	225	275	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2468	225	205	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2469	225	207	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2470	225	279	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2471	225	231	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2472	225	301	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2473	225	257	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2474	225	270	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2475	226	140	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2476	226	129	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2477	226	267	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2478	226	320	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2479	226	123	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2480	226	210	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2481	226	374	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2482	227	111	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2483	227	162	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2484	227	222	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2485	227	378	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2486	227	342	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2487	227	129	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2488	227	231	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2489	227	310	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2490	227	331	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2491	227	148	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2492	227	297	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2493	227	128	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2494	227	142	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2495	227	321	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2496	228	298	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2497	228	131	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2498	228	215	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2499	228	336	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2500	228	105	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2501	228	336	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2502	228	372	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2503	228	256	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2504	229	244	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2505	229	133	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2506	230	320	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2507	230	138	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2508	230	381	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2509	230	187	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2510	230	177	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2511	230	361	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2512	230	325	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2513	230	160	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2514	230	105	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2515	230	136	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2516	230	218	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2517	230	232	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2518	230	349	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2519	230	357	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2520	230	261	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2521	230	127	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2522	231	343	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2523	231	242	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2524	231	306	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2525	231	328	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2526	231	192	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2527	231	300	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2528	231	319	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2529	231	326	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2530	231	132	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2531	231	188	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2532	231	197	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2533	231	189	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2534	232	388	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2535	232	179	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2536	233	150	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2537	233	174	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2538	233	174	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2539	233	380	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2540	233	138	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2541	233	149	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2542	233	306	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2543	233	186	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2544	233	173	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2545	234	159	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2546	234	162	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2547	234	150	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2548	234	183	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2549	234	224	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2550	234	122	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2551	234	136	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2552	234	159	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2553	235	323	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2554	235	137	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2555	235	176	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2556	235	173	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2557	235	271	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2558	235	142	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2559	235	278	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2560	235	388	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2561	235	271	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2562	235	339	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2563	235	145	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2564	235	259	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2565	236	324	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2566	236	191	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2567	237	361	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2568	237	200	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2569	237	190	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2570	237	322	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2571	237	321	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2572	237	171	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2573	238	101	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2574	238	305	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2575	238	309	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2576	238	336	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2577	238	127	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2578	238	240	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2579	238	354	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2580	238	341	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2581	238	328	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2582	238	296	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2583	239	170	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2584	239	128	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2585	239	380	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2586	239	187	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2587	239	267	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2588	240	340	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2589	240	198	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2590	240	195	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2591	240	110	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2592	240	191	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2593	240	261	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2594	240	370	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2595	240	238	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2596	240	143	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2597	240	155	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2598	240	372	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2599	240	163	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2600	240	330	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2601	240	296	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2602	240	177	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2603	240	299	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2604	240	136	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2605	240	333	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2606	240	124	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2607	242	272	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2608	242	214	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2609	242	242	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2610	242	121	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2611	242	385	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2612	242	135	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2613	242	260	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2614	242	317	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2615	242	195	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2616	242	364	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2617	242	272	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2618	242	315	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2619	242	157	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2620	242	327	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2621	242	361	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2622	242	122	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2623	243	353	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2624	243	218	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2625	243	318	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2626	243	387	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2627	243	136	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2628	243	251	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2629	243	303	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2630	243	353	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2631	244	163	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2632	244	322	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2633	244	360	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2634	244	167	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2635	244	389	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2636	244	260	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2637	244	272	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2638	244	254	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2639	244	369	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2640	244	161	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2641	244	320	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2642	244	347	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2643	244	275	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2644	244	331	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2645	244	304	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2646	244	179	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2647	244	236	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2648	245	363	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2649	245	159	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2650	245	112	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2651	245	374	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2652	246	390	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2653	246	234	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2654	246	363	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2655	246	140	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2656	246	296	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2657	247	129	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2658	247	147	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2659	247	378	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2660	247	228	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2661	247	119	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2662	247	160	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2663	247	264	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2664	247	178	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2665	247	223	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2666	248	285	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2667	248	300	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2668	248	285	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2669	248	199	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2670	248	311	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2671	248	260	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2672	248	244	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2673	248	224	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2674	248	356	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2675	248	199	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2676	248	278	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2677	248	136	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2678	248	271	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2679	248	350	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2680	248	185	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2681	248	150	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2682	248	134	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2683	248	361	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2684	249	294	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2685	249	128	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2686	249	125	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2687	249	131	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2688	249	361	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2689	249	326	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2690	250	192	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2691	250	334	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2692	250	374	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2693	250	116	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2694	250	150	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2695	250	324	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2696	250	107	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2697	250	323	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2698	250	221	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2699	250	123	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2700	250	163	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2701	250	372	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2702	250	242	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2703	250	378	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2704	250	291	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2705	251	262	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2706	251	365	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2707	251	348	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2708	251	280	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2709	251	337	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2710	251	364	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2711	251	130	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2712	251	186	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2713	251	313	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2714	251	288	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2715	251	297	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2716	252	161	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2717	252	196	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2718	252	123	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2719	252	160	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2720	252	230	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2721	252	241	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2722	252	220	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2723	252	316	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2724	252	130	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2725	252	152	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2726	252	142	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2727	252	161	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2728	252	192	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2729	252	127	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2730	253	323	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2731	253	203	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2732	253	245	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2733	253	310	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2734	253	205	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2735	253	255	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2736	253	207	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2737	253	291	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2738	253	223	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2739	253	201	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2740	253	287	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2741	253	196	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2742	253	379	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2743	253	291	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2744	254	209	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2745	254	361	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2746	254	182	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2747	254	101	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2748	254	237	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2749	254	281	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2750	255	300	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2751	255	142	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2752	255	349	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2753	255	288	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2754	255	358	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2755	255	189	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2756	255	370	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2757	256	230	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2758	256	176	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2759	256	112	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2760	256	206	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2761	256	163	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2762	256	136	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2763	256	141	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2764	256	218	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2765	256	288	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2766	256	381	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2767	256	202	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2768	256	121	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2769	256	198	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2770	256	120	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2771	256	375	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2772	256	311	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2773	256	334	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2774	257	165	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2775	257	272	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2776	257	380	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2777	257	236	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2778	257	307	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2779	257	346	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2780	257	327	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2781	257	202	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2782	257	300	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2783	257	299	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2784	257	142	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2785	257	149	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2786	257	312	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2787	257	376	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2788	257	321	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2789	257	286	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2790	257	319	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2791	257	226	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2792	258	196	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2793	258	348	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2794	258	200	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2795	258	263	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2796	258	121	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2797	258	109	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2798	258	306	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2799	258	347	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2800	258	170	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2801	258	135	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2802	258	232	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2803	258	110	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2804	258	385	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2805	259	162	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2806	259	257	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2807	259	367	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2808	260	196	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2809	260	177	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2810	261	242	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2811	261	241	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2812	261	318	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2813	261	297	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2814	261	249	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2815	261	293	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2816	261	230	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2817	261	164	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2818	261	138	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2819	261	141	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2820	261	312	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2821	261	167	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2822	261	330	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2823	261	170	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2824	261	203	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2825	262	245	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2826	262	220	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2827	262	200	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2828	262	296	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2829	262	308	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2830	262	155	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2831	262	153	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2832	262	371	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2833	262	244	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2834	262	157	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2835	263	129	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2836	263	377	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2837	263	152	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2838	263	153	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2839	263	267	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2840	263	334	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2841	263	187	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2842	263	338	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2843	263	275	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2844	263	357	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2845	263	160	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2846	263	224	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2847	263	284	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2848	263	301	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2849	263	373	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2850	263	161	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2851	264	352	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2852	264	380	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2853	264	379	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2854	264	140	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2855	264	111	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2856	265	245	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2857	265	287	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2858	265	148	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2859	265	162	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2860	265	246	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2861	266	225	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2862	266	165	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2863	266	238	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2864	266	161	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2865	266	358	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2866	266	232	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2867	266	306	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2868	266	179	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2869	266	245	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2870	266	264	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2871	266	133	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2872	266	130	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2873	266	250	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2874	266	347	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2875	266	249	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2876	266	322	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2877	266	263	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2878	267	337	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2879	267	245	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2880	267	290	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2881	267	107	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2882	267	376	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2883	267	349	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2884	267	305	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2885	267	145	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2886	267	207	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2887	267	304	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2888	267	330	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2889	267	258	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2890	267	247	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2891	267	305	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2892	268	140	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2893	268	348	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2894	268	115	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2895	268	167	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2896	268	105	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2897	268	200	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2898	268	264	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
2899	268	259	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2900	268	122	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2901	268	138	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2902	268	390	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2903	268	333	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2904	268	256	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2905	268	266	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2906	268	257	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2907	268	299	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2908	268	241	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2909	269	201	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2910	269	374	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2911	269	376	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
2912	269	217	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2913	269	193	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2914	269	291	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2915	269	218	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2916	269	369	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2917	269	201	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2918	269	314	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2919	269	331	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2920	270	146	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2921	270	129	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2922	270	282	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2923	271	161	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2924	271	308	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2925	271	350	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2926	271	219	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
2927	272	174	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2928	272	200	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2929	272	368	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2930	272	355	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2931	272	316	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2932	272	364	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2933	272	218	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2934	272	329	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2935	272	190	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2936	272	136	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2937	272	311	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2938	272	183	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2939	272	206	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2940	272	266	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2941	272	160	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2942	272	163	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2943	272	386	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2944	272	152	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2945	272	304	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2946	273	132	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
2947	273	193	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2948	274	250	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2949	274	214	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2950	274	254	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2951	274	258	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2952	274	260	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
2953	274	349	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
2954	274	129	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2955	274	125	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2956	274	228	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2957	274	315	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
2958	275	337	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2959	275	232	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2960	275	165	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
2961	275	181	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2962	275	302	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2963	275	349	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2964	275	322	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2965	275	125	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2966	275	263	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2967	275	385	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2968	275	194	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
2969	275	130	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2970	275	335	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2971	275	384	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
2972	275	174	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
2973	275	322	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2974	275	273	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2975	275	193	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
2976	276	295	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
2977	276	117	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2978	276	108	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
2979	276	155	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2980	276	326	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2981	276	239	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2982	276	272	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2983	276	333	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
2984	276	301	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2985	276	137	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
2986	276	279	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
2987	276	235	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
2988	276	276	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2989	276	223	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
2990	276	257	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2991	276	163	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2992	276	252	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2993	276	371	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
2994	277	335	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
2995	277	222	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
2996	277	133	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
2997	277	252	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
2998	277	259	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
2999	277	320	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
3000	277	268	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3001	277	238	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3002	277	116	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3003	277	319	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3004	277	306	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3005	277	198	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
3006	277	155	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
3007	277	285	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3008	277	212	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3009	278	122	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3010	278	234	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
3011	278	217	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3012	279	331	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3013	279	304	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3014	279	101	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3015	279	301	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3016	279	232	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
3017	279	299	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3018	279	212	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3019	279	371	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
3020	279	212	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3021	279	164	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
3022	279	339	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
3023	279	260	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3024	279	205	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3025	279	321	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3026	279	340	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3027	280	133	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3028	280	234	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3029	280	333	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3030	280	160	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3031	280	362	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3032	280	227	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
3033	280	245	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3034	280	228	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3035	280	205	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3036	280	334	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3037	280	327	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
3038	280	289	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
3039	280	113	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3040	280	220	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
3041	280	146	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3042	281	372	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3043	281	186	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3044	281	127	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3045	281	386	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3046	281	129	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
3047	281	247	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
3048	281	380	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
3049	281	240	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3050	281	207	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
3051	281	235	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3052	281	110	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
3053	281	261	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3054	281	284	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3055	282	242	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3056	282	216	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
3057	282	134	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3058	282	243	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
3059	282	230	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3060	283	384	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
3061	283	363	2	Kötü değil ama iyi de değil.	2025-05-10 03:51:12.881192
3062	283	147	1	Tam bir hayal kırıklığı!	2025-05-10 03:51:12.881192
3063	283	223	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3064	283	322	1	Kesinlikle almayın.	2025-05-10 03:51:12.881192
3065	284	276	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3066	284	344	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3067	284	202	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3068	284	273	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3069	284	294	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3070	284	307	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3071	284	218	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3072	284	383	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
3073	284	247	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3074	284	220	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
3075	284	202	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3076	284	319	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
3077	284	137	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
3078	284	218	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3079	284	188	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
3080	284	128	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
3081	284	336	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3082	284	197	4	İyi bir alışverişti, tavsiye ederim.	2025-05-10 03:51:12.881192
3083	284	292	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3084	285	228	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3085	285	193	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
3086	285	353	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3087	285	198	2	Göründüğü gibi değil.	2025-05-10 03:51:12.881192
3088	285	356	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3089	285	137	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
3090	285	169	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3091	285	107	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
3092	286	286	3	Ortalama kalite, fiyatına göre normal.	2025-05-10 03:51:12.881192
3093	286	119	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3094	286	297	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3095	286	315	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3096	286	309	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
3097	286	187	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3098	286	327	1	Kötü kalite ve kötü hizmet.	2025-05-10 03:51:12.881192
3099	286	312	5	Mükemmel ürün, kesinlikle tavsiye ederim!	2025-05-10 03:51:12.881192
3100	286	238	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3101	286	331	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3102	286	307	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3103	286	323	3	Ürün beklentimi tam karşılamadı.	2025-05-10 03:51:12.881192
3104	286	179	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3105	286	218	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
3106	286	149	2	Fiyatına değmez.	2025-05-10 03:51:12.881192
3107	286	344	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
3108	286	272	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
3109	286	280	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3110	286	226	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
3111	286	147	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3112	287	373	3	Görseldeki gibi ama kullanışlı değil.	2025-05-10 03:51:12.881192
3113	287	227	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3114	287	279	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3115	287	202	3	Kargo süresi uzundu ama ürün sağlam.	2025-05-10 03:51:12.881192
3116	287	305	2	Kalite düşük, tekrar almam.	2025-05-10 03:51:12.881192
3117	287	170	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
3118	287	330	3	Ne iyi ne kötü, idare eder.	2025-05-10 03:51:12.881192
3119	287	381	4	Fiyatına göre oldukça iyi.	2025-05-10 03:51:12.881192
3120	287	242	5	Beklentilerimin çok üzerinde, harika!	2025-05-10 03:51:12.881192
3121	287	111	1	İade ettim, hiç memnun kalmadım.	2025-05-10 03:51:12.881192
3122	287	308	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3123	287	269	5	Kalite ve performans süper!	2025-05-10 03:51:12.881192
3124	287	226	4	Ürün güzel ama küçük eksikleri var.	2025-05-10 03:51:12.881192
3125	288	156	5	Ürün gerçekten harika, tekrar alacağım.	2025-05-10 03:51:12.881192
3126	288	217	4	Kaliteli ama biraz geç geldi.	2025-05-10 03:51:12.881192
3127	288	126	4	Genel olarak memnun kaldım.	2025-05-10 03:51:12.881192
3128	288	106	2	Beklentimi karşılamadı.	2025-05-10 03:51:12.881192
3129	288	369	1	Ürün bozuk geldi, tavsiye etmiyorum.	2025-05-10 03:51:12.881192
3130	288	140	5	Hızlı kargo ve kaliteli ürün. Teşekkürler.	2025-05-10 03:51:12.881192
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, seller_id, name, price, stock, category, image_url, description) FROM stdin;
202	69	Şampuan	3909	74	Kozmetik	https://ideacdn.net/idea/nk/94/myassets/products/171/gliss-schwarzkopf-serum-deep-repair-onarici-sampuan-protein-kompleksi-hint-inciri-500-ml2.jpg?revision=1730548170	Gliss Schwarzkopf Serum Deep Repair Onarıcı Şampuan - Protein Kompleksi Hint İnciri 500 ml
261	92	Şampuan	790.99	9	Kozmetik	https://nebilcdn.blob.core.windows.net/gimatlinux/0012135_head-and-shoulders-sampuan-350-ml-sac-dok-karsiti-kadin-kafein-etki_510.jpg	Head and Shoulders Şampuan 350 ml Saç Dökülme Karşıtı Kadın Kafein Etki
239	83	Şampuan	944.49	30	Kozmetik	https://tr.phyto.com/cdn/shop/files/PHYTOCYANEINVIGORATINGSHAMPOO.webp?v=1726084515	PhytoCyane Kadınlar için Dolgunlaştırıcı ve Canlandırıcı Şampuan 250 ml
235	82	Şampuan	3594.23	50	Kozmetik	https://www.prozinc.com.tr/files/urunlerimiz/kepege_karsi_etkili_gunluk_kullanim/women_sampuan/women_sampuan_1.jpg	ProZinc Women Şampuan
234	81	Şampuan	932.4	58	Kozmetik	https://www.dermokozmetika.com.tr/ipek-men-formula-kepek-karsiti-sampuan-tum-sac-tipleri-icin-derinlemesine-temizlik-480ml-58360-36-B.jpg	İpek Men Formula Kepek Karşıtı Şampuan - Tüm Saç Tipleri için Derinlemesine Temizlik 480ml
207	71	Tencere	2636.95	22	Ev_Yasam	https://www.gizerler.com/assets/product-images/109000/tefal-clipso-precision-6lt-duduklu-tencere-1510001273_75517.jpg	Tefal Clipso Precision 6 Lt Düdüklü Tencere
3	6	Akıllı Saat	2367.32	62	Elektronik	https://statics.vestel.com.tr/productimages/20292605_r1_1000_1000.jpg	Akıllı Saat ürünü, şık tasarımı ve dayanıklı yapısıyla dikkat çeker.
5	7	Fondöten	141.82	39	Kozmetik	https://afb801.a-cdn.akinoncloud.com/products/2023/08/01/6662/345737ee-5fd1-44f2-975a-51ba18ea5681_size960x1440_cropCenter.jpg	Fondöten ürünü, şık tasarımı ve dayanıklı yapısıyla dikkat çeker.
6	7	Ruj	2486.1	84	Kozmetik	https://shop.goldenrose.com.tr/golden-rose-lipstick-103-soft-creamy-ruj-parlak-ruj-golden-rose-lipstick-26583-13-B.jpg	Ruj sayesinde hayatınızı kolaylaştırın, şimdi sipariş verin.
11	9	Fondöten	506.08	32	Kozmetik	https://www.yeppuda.com//images/prod/2332.jpg	Fondöten sayesinde hayatınızı kolaylaştırın, şimdi sipariş verin.
12	9	Şampuan	1101.5	45	Kozmetik	https://images.hc.com.tr/image/600/600/c/hc-sampuan-normal-ve-kuru-saclar-icin-246.jpg	Şampuan ürünü, şık tasarımı ve dayanıklı yapısıyla dikkat çeker.
13	10	Çanta	3965.42	98	Moda	https://img-network.mncdn.com/mnresize/491/-/productimages/8683798709335_1.jpg	Çanta sayesinde hayatınızı kolaylaştırın, şimdi sipariş verin.
15	10	Ayakkabı	2025.71	70	Moda	https://cdn.olurbutik.com/img/1200/85/yuksek-taban-gunluk-kadin-spor-ayakkabi-1a598-1b013.webp	Bu Ayakkabı, konfor ve kaliteyi bir arada sunar.
16	10	Tişört	102.83	95	Moda	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRETIFg32u-pQP67IJEIFaWIdTrwu9Po2k7yA&s	Tişört, en son teknolojiyle üretilmiştir ve günlük kullanım için idealdir.
17	10	Pantolon	2190.17	76	Moda	https://cdn.pazarium.com.tr/ip-detayli-beli-lastikli-dar-paca-siyah-pantolon-pantolon-sumeyye-tekstil-390959-66-B.jpg	Bu Pantolon, konfor ve kaliteyi bir arada sunar.
18	11	Kulaklık	4524.74	88	Elektronik	https://static.ticimax.cloud/55525/uploads/urunresimleri/buyuk/eef397ec-5e8f-4c0d-8314-cde564af9ceb-f4b-41.jpg	Yüksek müşteri memnuniyetine sahip Kulaklık, stoklarla sınırlıdır.
24	13	Koşu Bandı	4690.55	59	Spor	https://cdn.dsmcdn.com/ty1600/prod/QC/20241112/10/23a6e632-eec0-3aa0-932f-68986949c236/1_org_zoom.jpg	Proforce Optimum Koşu Bandı 
25	13	Dambıl	2062.34	40	Spor	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF7kwuYdpEsgmhHN8zlna7Fl33bgCgJ6h4dA&s	Dambıl Decathlon
26	13	Spor Ayakkabı	3588.62	74	Spor	https://st-vans.mncdn.com/mnresize/1500/1500/Content/media/ProductImg/original/638574215145732379.jpg	Yüksek müşteri memnuniyetine sahip Spor Ayakkabı.
27	13	Bisiklet	1223.17	63	Spor	https://gokidy.com/public/uploads/gallery/1724680267_33a4d8f35a1baad93bf4.png	GoKiddy bisiklet, dağ tırmanışları için idealdir.
28	13	Yoga Matı	181.41	12	Spor	https://m.media-amazon.com/images/I/617h1LByNML.jpg	Yoga Minderi
29	14	Kulaklık	2462.95	71	Elektronik	https://cdn.dsmcdn.com/ty962/product/media/images/20230706/10/391603629/975789770/1/1_org_zoom.jpg	Fibaks P9
30	14	Laptop	3703.24	98	Elektronik	https://m.media-amazon.com/images/I/817xnvwK0PL.jpg	HP Laptop 15
31	15	Tencere	1419.3	22	Ev_Yasam	https://brillantstore.com.tr/image/catalog/185a.jpg	Brillant Petra
42	17	Perde	3790.97	97	Ev_Yasam	https://www.birlik1952.com/wp-content/uploads/2022/12/birlik1952-muslin-perde-curtain-boho-bohem-dekorasyon-maison-decoration-linen-fabric-curtains-crinkle-fabric-antrasit-anthracitte-grey-gri-3-1200x1174.jpg	Pamuklu Bohem Perde
43	18	Fondöten	2806.51	91	Kozmetik	https://shop.goldenrose.com.tr/golden-rose-fluid-foundation-21-porcelain-kapatici-etkili-fondoten-yogun-kapatici-fondoten-golden-rose-fluid-foundation-25710-86-B.jpg	Golden Rose Fondöten
44	19	Araç Kamerası	1915.58	71	Otomotiv	https://n11scdn.akamaized.net/a1/320_480/06/06/05/29/IMG-3622610894637751439.jpg	GPS Araç içi kamera
4	7	Nemlendirici	4444.26	26	Kozmetik	https://m.clinique.com.tr/media/export/cms/products/1200x1500/cl_sku_V7Y801_1200x1500_0.png	Clinique moisture surge nemlendirici krem
54	21	Parfüm	1431.17	38	Kozmetik	https://www.sevil.com.tr/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/m/a/mag-15174001000_11.jpeg	Versace Eros
55	22	Sandalye	683.16	12	Ev_Yasam	https://mymassa.com.tr/cdn/shop/files/GRI-Photoroom_8d7370b7-29a5-485f-868e-ebb63d3e3e35.jpg?v=1723712881	Gri minderli ahşap sandalye
56	22	Masa	3316.85	83	Ev_Yasam	https://www.divanev.com.tr/site/uploads/_18743.jpg	Açılır Yemek Masası
62	25	Ayakkabı	2224.13	10	Moda	https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,e_sharpen/global/395016/04/fnd/TUR/w/1000/h/1000/fmt/png	Puma Caven Unisex Ayakkabı
57	22	Tencere	2713.28	50	Ev_Yasam	https://www.jumbo.com.tr/cdn/shop/files/52751942-c1d5-4077-9a33-c64298f45d99_ef33576a-858c-42a4-bf19-f717e7145107.jpg	Jumbo Flame 8 parça tencere seti
58	22	Perde	121.51	83	Ev_Yasam	https://productimages.hepsiburada.net/s/777/375-375/110000688143263.jpg	Gri Keten Tül Perde
59	22	Yastık	730.65	59	Ev_Yasam	https://productimages.hepsiburada.net/s/21/375-375/9933467582514.jpg	Ortopedik Visco Yastık
60	23	Spor Ayakkabı	1815.93	93	Spor	https://www.jump.com.tr/jump-29891-siyah-kadin-sneaker-gunluk-spor-ayakkabi-sneaker-jump-240006-55-B.jpg	Jump Kadın Spor Ayakkabı
61	24	Koşu Bandı	909.56	12	Spor	https://cdn.evkur.com.tr/c/Product/thumbs/hattrick1_fz45lq_500.jpg	Hattrick Rase Koşu Bandı
63	25	Pantolon	2959.82	73	Moda	https://www.bisse.com/erkek-4-cep-kumas-spor-pantolon-d55-25984-22-B.jpg	4 cepli kumaş pantolon
64	25	Çanta	2660.67	22	Moda	https://cdn.dsmcdn.com/ty1594/prod/QC/20241029/10/63630d15-2df0-3519-85ad-6b718db3cb45/1_org_zoom.jpg	Estute kadın çantası
65	25	Tişört	2587.37	14	Moda	https://static.ticimax.cloud/5334/uploads/urunresimleri/buyuk/siyah-desenli-oversize-erkek-tisort-2541e6.jpg	Siyah Desenli Oversize tişört
66	25	Elbise	1503.95	60	Moda	https://cdn.swist.com.tr/bordo-zico-drapeli-madonna-yaka-yirtmacli-kadin-midi-elbise-midi-elbiseler-swist-37702-42-B.jpg	Bordo Zico Drapeli Madonna Yaka Yırtmaçlı
68	26	Bisiklet	762.99	5	Spor	https://www.bikeandoutdoor.com/alba-fold-x-kd218-128-2-hd-katlanir-elektrikli-bisiklet-1-elektrikli-katlanir-bisiklet-alba-foldx-65449-20-B.jpg	Alba Fold X Katlanabilir Bisiklet
67	26	Koşu Bandı	1964.81	95	Spor	https://cdn.myikas.com/images/02737eed-4039-419d-86e4-fda3c69d70ec/039754c4-dddb-4cb7-9e32-35a4466e8fbf/3840/rebuwo-rz-20-plus-katlanir-kosu-bandi-2.webp	Repuwo RZ Koşu Bandı
69	26	Spor Ayakkabı	4969.99	9	Spor	https://www.gizerler.com/assets/gibitel/productimage/IH7759/adidas-runfalcon-5-kadin-spor-ayakkabi-102263.jpeg	Adidas RunFalcon Kadın Koşu Ayakkabısı
70	26	Dambıl	2042.86	12	Spor	https://www.marbosport.eu/hpeciai/57c2c28f21b0e5169c5a62bfe33fc77b/pol_pl_29721-29721_1.jpg	Vinvly Upform 2.5 Kg Dumbell
71	26	Yoga Matı	1326.14	33	Spor	https://i2.wp.com/whosaidacademy.com/wp-content/uploads/2022/11/10mm1.jpg?fit=800%2C800&ssl=1	Delta Foam Pilates Minderi
72	27	Telefon	2882.92	55	Elektronik	https://cdn.evkur.com.tr/c/Product/thumbs/tr-a60-6-128gb-purple-1_f3r7xi_500.jpg	Trident A60 6GB Ram 128GB Hafıza
73	27	Akıllı Saat	1107.02	69	Elektronik	https://cdn.akakce.com/z/samsung/samsung-galaxy-watch-7-44mm-yesil.jpg	Samsung Galaxy Watch 7
75	28	Araç Kamerası	2446.53	54	Otomotiv	https://www.garmin.com.tr/images/thumbs/0009485_garmin-dash-cam-x310-140-derecelik-gorus-alanina-ve-dahili-clarity-polarizore-sahip-4k-dokunmatik-ek.jpeg	Garmin Araç Kamerası
74	28	Bagaj Düzenleyici	3566.61	13	Otomotiv	https://suscaroto.com/wp-content/uploads/2024/07/arac-bagaj-duzenleyici-deri-canta-organizer-deri-araba-cantasi-oto-ici-esya-aksesuarlari-duzenleme-otomobil-aksesuar-malzeme-kirmizi-dikisli-kapitone-png.png	Deri Bagaj Dzüenleyici
76	28	Lastik	4613.91	58	Otomotiv	https://miaotolastik.com/wp-content/uploads/2024/07/snowmaster2-1.webp	Petlas MileStone Araç Lastiği
77	28	Navigasyon	79.66	19	Otomotiv	https://elcobil.com/wp-content/uploads/cf-lg-1.jpg	Garmin Drive Assistanı
78	29	Akıllı Saat	815.71	45	Elektronik	https://f-a101-l.mncdn.com/mnresize/480/480/livephotos/8/26040865SIYAH/26040865SIYAH_239.jpg	Xiaomi Redmi Watch 3 Akıllı Saat
79	29	Telefon	2292.12	14	Elektronik	https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_87300495/fee_786_587_png	İphone 13 128 GB
80	30	Pantolon	3236.37	9	Moda	https://static.modamixtr.com/image/cache/catalog/products/33439-960x1280.jpg	Slim fit gri erkek pantolon
81	30	Elbise	4381.84	69	Moda	https://fns.modanisa.com/r/pro2/2023/05/04/z--8719382-1.jpg	Etfelya Kına Abiye
82	30	Tişört	4318.55	27	Moda	https://cdn.myikas.com/images/44b1a388-3ac6-4eae-9296-2561ff23bb0c/d3f60a07-16e7-49d7-a1fa-0de4894ab0b7/image_3840.webp	Mavi Polo Yaka Erkek Tişört
83	30	Ayakkabı	4417.39	58	Moda	https://www.serenze.com/i/l/001/0013920_siyah-triko-erkek-spor-ayakkabi.jpeg	Bu Ayakkabı, konfor ve kaliteyi bir arada sunar. Siyah Triko Ayakkabı
84	31	Sandalye	4234.55	28	Ev_Yasam	https://www.mobilyamevime.com/images/urunler/inci-ahsap-ayakli-sandalye-inegol-mobilyasi%20(1)60051.webp	İnci Ahşap ayaklı sandalye
85	31	Tencere	1637.43	86	Ev_Yasam	https://cdn.evkur.com.tr/c/Product/thumbs/emsan-bright-7-parca-granit-kaplama-tencere-seti-2_xa24gx_500.jpg	7 Parça granit tencere seti
86	31	Yastık	436.57	22	Ev_Yasam	https://platincdn.com/1626/pictures/IYODVIYTTN1012202294627_COTTON.jpg	Bu Yastık, konfor ve kaliteyi bir arada sunar. Doğal pamuktan yapılmıştır.
87	32	Dambıl	1159.3	41	Spor	https://shop.lifefitness.com/cdn/shop/products/RoundUrethaneDumbbell1000x1000_1200x1200.jpg?v=1746093614	Hammer 35 Kg dumbell
241	83	Nemlendirici	1157.85	8	Kozmetik	https://www.recete.com/mustela-cok-hassas-ciltler-icin-nemlendirici-yuz-kremi-40ml-bebek-nemlendiricileri-mustela-3042-30-B.jpg	Mustela Çok Hassas Ciltler İçin Nemlendirici Yüz Kremi 40ml
96	33	Kulaklık	2212.98	40	Elektronik	https://www.incehesap.com/resim/urun/202202/6211a3d64190c3.13471425_hfqojpnlkimeg_500.webp	Logitech G733
93	33	Akıllı Saat	1816.18	92	Elektronik	https://akilliasistan.com/image/cache/catalog/urunler/akilli-saatler/diger/t500/smart-watch-t500-akilli-saat-2-1200x1200.webp?randomId=1706921096	Smart Watch T500
94	33	Tablet	1034.65	43	Elektronik	https://productimages.hepsiburada.net/s/367/375-375/110000383420616.jpg	Lenevo Tab M10 4 GB Ram 64 GB Hafıza
95	33	Laptop	1494.05	92	Elektronik	https://img-monsternotebook.mncdn.com/UPLOAD/_html_assets/semruk-s7-v9-detail/semruk-laptop-1-1.png	Semruk S7 V9.1.1: Intel i7-13700HX, RTX 4060, 32GB DDR5 RAM, 1TB Gen4 SSD, 17" QHD+ 240Hz ekran, RGB klavye, 3kg ağırlıkla yüksek performanslı oyun laptopu.
97	34	Yoga Matı	2847.91	65	Spor	https://www.cdnaws.com/i/spormedikal2/ZW3D2Lqi2qQZW3D2QvGYHPsSdwLZW3D2/images/urunler/621730a2e13ad-25289-1.jpg	Zero Gym Yeşil Yoga Matı
98	34	Koşu Bandı	4615.67	17	Spor	https://kiralabunu.fra1.cdn.digitaloceanspaces.com/products/2023/08/23/conversions/6513-1-zoom.png	Xiaomi Koşu Bandı
103	35	Tencere	2918.82	14	Ev_Yasam	https://www.korkmazstore.com.tr/korkmaz-lena-seramik-tencere-24x125-a3882-seramik-tencere-13772-96-B.jpg	Korkmaz Store Tencere
104	35	Masa	4433.01	73	Ev_Yasam	https://www.seray.com/wp-content/uploads/2023/02/WhatsApp-Image-2023-08-05-at-09.59.34-1.jpeg	Decean Mermer Masa
105	35	Perde	3439.98	49	Ev_Yasam	https://ranperde.com/wp-content/uploads/2022/10/Duz-keten-fon-perde-Vizon-Rengi-Gri-4.jpg	Düz Keten Gri Fon Perde
107	36	Lastik	1221.14	99	Otomotiv	https://www.bridgestone.com.tr/Dosyalar/Lastik-Gorselleri-2025/weather-control.webp	Lastik, en son teknolojiyle üretilmiştir ve mevsimlik kullanım için idealdir.
108	36	Bagaj Düzenleyici	600.5	100	Otomotiv	https://cdn-img.pttavm.com/pimages/592/604/534/64dcd716c6d7b.jpg?v=201910111530	Çift Bölmeli Bagaj Düzenleyici
109	37	Ayakkabı	4505.02	33	Moda	https://floimages.mncdn.com/media/catalog/product/23-10/12/201032697-1-1697091099.jpg	Kadın Siyah Leopar Yürüyüş Ayakkabısı
110	37	Elbise	1086.99	70	Moda	https://www.twenhil.com.tr/slim-fit-erkek-yelekli-takim-elbise-1563-erkek-takim-elbise-twenhil-15379-15-B.jpg	Slim Fit Erkek Takım Elbise
111	37	Pantolon	3620.9	56	Moda	https://witcdn.ramsey.com.tr/indigo-duz-regular-fit-denim-100-pamuk-pantolon-10148769-250-jean-pantolon-ramsey-8559173-16-K.jpg	Açık Mavi Erkek Kot Pantolon
112	37	Tişört	4900.94	54	Moda	https://pasage.com/cdn/shop/products/Free-Born-Oversize-Kadin-Tisort-P_S_GE-67.jpg?v=1714653724	FreeBorn Siyah Oversize Tişört
113	38	Nemlendirici	454.29	27	Kozmetik	https://m.media-amazon.com/images/I/51cQVn+CDpL._AC_UF1000,1000_QL80_.jpg	The Purest Solutions
114	39	Lastik	2910.44	6	Otomotiv	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToZsSeGZGKqDYLCK5UYGPePH8GxEBmpgi4Dg&s	Petlas 165/65
115	40	Spor Ayakkabı	1288.82	5	Spor	https://www.mnpc.store/UserFiles/Fotograflar/org/382904-mnpc-erkek-cocuk-spor-ayakkabi-siyah-renk-9634-20s-c4-b0yah-201.jpg	Çocuk Spor Ayakkabı
116	40	Dambıl	331.25	75	Spor	https://aad216.a-cdn.akinoncloud.com/products/2023/10/27/446092/c84eef43-d75b-4b0b-b0b8-0335b91e6e0b_size1000x1000_cropCenter.jpg	Vinvly 1 kg dambıl
117	40	Koşu Bandı	2915.46	89	Spor	https://runtechstore.com/wp-content/uploads/2022/01/1-2.jpg	Mini Run Plus Koşu Bandı
118	40	Yoga Matı	1653.35	53	Spor	https://aad216.a-cdn.akinoncloud.com/products/2024/04/17/1198379/4c164175-a0bf-4757-ad32-45340c1b3ce3_size1000x1000_cropCenter.jpg	Energetics Pembe Yoga Matı
119	40	Bisiklet	1689.99	48	Spor	https://productimages.hepsiburada.net/s/93/375-375/110000036060971.jpg	Daafu Sxc200
120	41	Elbise	1195.36	87	Moda	https://www.iconasline.com/kraliyet-mavi-korsajli-pelerin-detayli-islemeli-cicekli-prenses-abiye-elbise-32-uzun-elbiseler-omur-inn-9859-27-B.jpg	Kraliyet Mavi Korsajlı Pelerin Detaylı İşlemeli Çiçekli Prenses Abiye Elbise
121	41	Tişört	2118.88	65	Moda	https://witcdn.tommylife.com.tr/p-fistik-yesil-polo-yaka-basic-kisa-kollu-kadin-crop-top-t-shirt-97208-crop-top-tommylife-t12by-97208-160003-30-O.jpg	Fıstık Yeşil Polo Yaka Basic Kısa Kollu Kadın Crop Top T-Shirt
126	44	Nemlendirici	2497.8	55	Kozmetik	https://cdn.akakce.com/nivea/nivea-soft-200-ml-nemlendirici-bakim-kremi-z.jpg	Nivea Soft Nemlendirici Krem
127	44	Ruj	4223.36	10	Kozmetik	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNZzBAV8uBQbkSNRaGBtNhv37VtwA90h3eIA&s	Golden Rose Velvet
128	44	Fondöten	2505.19	15	Kozmetik	https://www.watsons.com.tr/medias/sys_master/prd-images/h94/h8b/11588079255582/prd-front-1398131_365x385/prd-front-1398131-365x385.jpg	Note New Era
129	45	Pantolon	202.95	76	Moda	https://www.civilim.com/Uploads/categoryimg/erkekcocuk/ust/erkek-cocuk-pantolon-158.png	Açık kahverengi çocuk pantolunu
130	45	Tişört	1198.9	60	Moda	https://cdn2.sorsware.com/suvari/ContentImages/Product/23y/TS1014000288-YH2/o-yaka-regular-kalip-duz-tisort_ts1014000288-yh2_yesil-haki-2-yesil_1_enbuyuk.webp	Süvari O Yaka Regular Düz Tişört
131	45	Ayakkabı	2342.86	31	Moda	https://static.ticimax.cloud/51093/uploads/urunresimleri/buyuk/pembe-topugu-kelebekli-kiz-cocuk-ayakk-a51c-8.jpg	Pembe Topuğu Kelebekli Kız Çocuk Ayakkabı
106	36	Navigasyon	836.74	48	Otomotiv	https://www.navitech.com.tr/admin/PICS/products/big_crop_4_85656.jpg	AX-1012R Ford Focus\nNavigasyon ve Multimedya Araç Bilgisayarı
132	46	Akıllı Saat	4779.91	7	Elektronik	https://m.media-amazon.com/images/I/61NgVKtuHfL._AC_SX569_.jpg	Luqeeg Çocuklar Akıllı Sesli Saat, IP67 Su Geçirmez Akıllı Saat Telefon 3-12 Yaş Çocuklar için Spor Akıllı Saat, Görüntülü Arama, GPS konumu, Sorguyu takip et, Çalar Saat, El feneri
134	46	Telefon	2426.17	62	Elektronik	https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_120121342/fee_786_587_png	İphone 15 128 GB
141	50	Sandalye	1955.22	98	Ev_Yasam	https://img.sandalyedeposu.com/images/webp/M_500_a7a86a8e9707a5351ac40f6f404729c9.webp	Focus Natural Ahşap Ayaklı Sandalye (Pembe Kumaş)
136	46	Tablet	2382.64	21	Elektronik	https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_145289098?x=536&y=402&format=jpg&quality=80&sp=yes&strip=yes&trim&ex=536&ey=402&align=center&resizesource&unsharp=1.5x1+0.7+0.02&cox=0&coy=0&cdx=536&cdy=402	SAMSUNG Galaxy Tab S10 Ultra 12/512GB Tam Dokunmatik Tablet Gri
142	51	Pantolon	1631.1	42	Moda	https://hacmalzemesi.com/images/detailed/7/hardal-sari-kargo-model-lastikli-pantalon-03.jpg	Hardal Sarı Erkek Pantolon
144	51	Ayakkabı	1750.96	92	Moda	https://static.ticimax.cloud/40735/uploads/urunresimleri/buyuk/isikli-kaymaz-taban-kiz-cocuk-ayakkabi-1fe-3c.jpg	Işıklı Kaymaz Taban Kız Çocuk Ayakkabısı
145	51	Tişört	2385.13	92	Moda	https://ktnimg2.mncdn.com/products/2024/02/03/2866442/fb3bad79-f2c3-4445-a2c9-8188bc37e587_size870x1142.jpg	Erkek Çocuk Tişört Kuru Kafa Baskılı Kısa Kollu Bisiklet Yaka Pamuklu
146	51	Elbise	2941.2	84	Moda	https://static.ticimax.cloud/2248/uploads/urunresimleri/buyuk/retrobird-tasarim-ashley-kruvaze-elbis-ac2-e9.jpeg	Retrobird Ashley Kruvaze Siyah Kadın Elbise
147	52	Navigasyon	3349.79	55	Otomotiv	https://www.dhresource.com/webp/m/0x0/f2/albu/g21/M01/88/34/rBVaqmFpX4CAJgvfAAFsqw_Gha8812.jpg	Otomatik Araba 7 inç GPS Gezgin Güneşlik Kalkanı 8GB 256MB Kamyon SAT NAV FM Bluetooth Avin Navigasyon
148	52	Araç Kamerası	4099.98	63	Otomotiv	https://www.segaturk.com/wp-content/uploads/2018/09/arac-kamerasi-MK-116-1.jpg	MK-116 Araç Kamerası
165	58	Pantolon	87.49	33	Moda	https://cdn.dsmcdn.com/ty1318/product/media/images/prod/QC/20240517/15/8ed07b4b-0910-3f78-85be-ceb3c1e29f5b/1_org_zoom.jpg	Kadın Hiking Cargo Hızlı Kuruma Hafif Esnek Cepli Kargo Pantolon
166	59	Fondöten	4892.93	100	Kozmetik	https://www.makyajtrendi.com/Content/ProductImage/Original/637262862531651271-607845060468_1.jpg?bgcolor=white	NARS SHEER GLOW FOUNDATION
167	59	Parfüm	1076.65	43	Kozmetik	https://media.sephora.eu/content/dam/digital/pim/published/D/DIOR/564565/242603-media_swatch.jpg?scaleWidth=585&scaleHeight=585&scaleMode=fit	Miss Dior - Eau de Parfum
168	59	Ruj	39.25	84	Kozmetik	https://img.joomcdn.net/fecab3c44613396344b6432812fb83a1a88a6347_original.jpeg	Siyah Yeşil Mor Ruj Noel Cadılar Bayramı Dudak Makyaj Tonu Nemlendirici Su Geçirmez Mat Ruj Su Geçirmez Dudak Pigmenti
169	59	Nemlendirici	712.16	69	Kozmetik	https://www.dermokozmetika.com.tr/garnier-aha-bha-komur-3u-1-arada-matlastirici-gunluk-nemlendirici-krem-50ml-56736-35-B.jpg	Garnier AHA BHA Kömür 3'ü 1 Arada Matlaştırıcı Günlük Nemlendirici Krem 50ml
170	59	Şampuan	2730.72	78	Kozmetik	https://cdn.dsmcdn.com/ty337/product/media/images/20220219/16/53616555/392123646/1/1_org_zoom.jpg	Elseve Şampuan 6 Mucizevi Yağ Normal Ve Kuru Saç 450 ml
171	60	Şampuan	1695.63	66	Kozmetik	https://static.ticimax.cloud/48857/uploads/urunresimleri/buyuk/1141585-6dd05b.jpg	Clear Men Kepeğe Karşı Etkili Şampuan Yoğun Arındırıcı Kömür İle 350 ml
172	60	Parfüm	2563.06	30	Kozmetik	https://witcdn.lufian.com/westward-erkek-parfum-standart-lufian-379679-73-B.jpg	Westward Erkek Parfüm Standart
173	60	Ruj	4817.58	28	Kozmetik	https://sdcdn.io/mac/tr/mac_sku_SMXF28_1x1_0.png?width=1440&height=1440	Lustreglass Sheer-Shine Ruj\nHafif bir yapıya sahip, ahududu çekirdeği ve organik zeytinyağı içeren ruj, uzun süre kalıcı parlak bir bitiş ile şeffaf ve ışıltılı renkler sunar.
174	60	Nemlendirici	4487.95	99	Kozmetik	https://cdn.myikas.com/images/22eebb3d-a810-4ce4-b3e5-3c57326ae2c6/e71b0df6-9e35-4fef-89d3-d16f315d9f7d/image_1080.jpg	THE CEEL\nBariyer Koruyucu Yoğun Onarıcı ve Nemlendirici Cica Krem 50 ml
175	61	Nemlendirici	2039.09	13	Kozmetik	https://www.dermokozmetika.com.tr/bioxcin-acnium-sebum-dengeleyici-nemlendirici-krem-50ml-63257-33-B.jpg	Bioxcin Acnium Sebum Dengeleyici Nemlendirici Krem 50ml
195	67	Şampuan	3424.4	22	Kozmetik	https://cdn.dsmcdn.com/ty738/product/media/images/20230220/11/284952411/862488431/1/1_org_zoom.jpg	Clear Women Şampuan Yumuşak Parlak 350 Ml
203	70	Telefon	2771.23	38	Elektronik	https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/600/600/productimage/125079196/125079196_0_MC/80607028.jpg	Xiaomi Redmi Note 12 8GB/128GB 6.67'' Mavi Akıllı Telefon
216	73	Tencere	3336.09	9	Ev_Yasam	https://witcdn.aryildiz.com/aryildiz-touch-cook-duduklu-tencere-6-litre-duduklu-tencere-aryildiz-0-44642-11-B.jpg	Aryıldız Touch & Cook Düdüklü Tencere 6 Litre
219	75	Tencere	2048.68	60	Ev_Yasam	https://cdn.akakce.com/nehir/nehir-silver-klasik-8-lt-z.jpg	Nehir Silver Klasik 8 Lt Düdüklü Tencere
209	72	Tişört	234.45	72	Moda	https://static.ticimax.cloud/55914/uploads/urunresimleri/buyuk/erkek-basic-polo-yaka-tisort-regular-f-a3ef6-..jpg	Basic Regular Fit Erkek Lacivert Polo Yaka Tişört
213	73	Yastık	3862.89	11	Ev_Yasam	https://www.yastikminder.com/images/thumbs/0000433_yastikminder-koton-sari-dekoratif-yastik-kilifi_600.jpeg	Yastıkminder Koton Sarı Dekoratif Yastık
206	71	Yastık	2378.11	68	Ev_Yasam	https://37e69e.a-cdn.akinoncloud.com/products/2024/07/04/12325/4efc192a-0fdd-4001-9135-d1360e27717c.jpg	Palmier Dekoratif Yastık
196	68	Yoga Matı	4031.56	46	Spor	https://www.yogazero.com/cdn/shop/products/cork-dream-catcher-1.jpg?v=1676640536	SEEKA YOGA – CORK SERIES – DREAMCATCHER YOGA VE PİLATES MATI- %100 Pamuk Taşıma Çantası Hediyeli
199	68	Koşu Bandı	3626.05	58	Spor	https://www.sporvebiz.com/wp-content/uploads/2021/05/b-spirit-fitness-ct800-televizyonlu-kosu-bandi-spor-salonu-tipi-kosu-bandi-600x600.jpg	SPIRIT FITNESS CT 800 TELEVİZYONLU PROFESYONEL KOŞU BANDI
178	61	Parfüm	2463.95	32	Kozmetik	https://cdn.beymen.com/mnresize/505/704/productimages/0709001254_IMG_01_3348901486385.jpg	Sauvage Dior 100 ml Erkek Parfüm
180	62	Dambıl	4230.62	33	Spor	https://ideacdn.net/idea/ic/56/myassets/products/594/whatsapp-image-2022-11-30-at-20-07-25.jpeg?revision=1704811664	Leyaton 1 Kg Dambıl Seti Ağırlık Seti 1 Kg 2 Adet Mor
181	62	Bisiklet	749.09	14	Spor	https://www.gizerler.com/assets/product-images/150000/carraro-force-970c-29-480h-gumus-mavi-acik-mavi-dag-bisiklet_93444.jpg	Carraro Force 970 C 29 Jant 480h Dağ Bisiklet Gümüş-Mavi-Açık Mavi
182	63	Çanta	2508.73	16	Moda	https://cdn.emnora.com/product/cache/1200x1800_cok-cepli-canta-kirmizi-omuz-cantasi-emnora-18229-32-B.webp?3244	Emnora Çok Cepli Çanta Kırmızı
183	63	Elbise	4624.85	97	Moda	https://www.bisse.com/ptk-23101-dokuma-mono-yaka-cift-yirtmac-6-dr-kls-takim-laci-29464-24-B.jpg	Bisse Comfort Fit Mono Yaka Drop 6 Lacivert Erkek Takım Elbise
188	65	Akıllı Saat	1609.19	83	Elektronik	https://carmenta.com.tr/wp-content/uploads/2024/09/carmenta-watch-8-pro-pembe-kadin-akilli-saat.png	Carmenta Note 8 Pro Pembe Kadın Akıllı Saat
189	65	Laptop	249.23	20	Elektronik	https://www.evshop.com.tr/image/cache/catalog/21311452_6-1024x1024.jpg	HUAWEI MATEBOOK D15 8 GB RAM 256 GB SSD LAPTOP INTEL CORE I3 1115G4
190	66	Nemlendirici	639.28	64	Kozmetik	https://www.lynskincare.com/wp-content/uploads/2020/09/lyn-yaslanma-karsiti-gunduz-kremi.jpg	Lyn Yoğun Nemlendirici Krem
191	66	Fondöten	942.59	75	Kozmetik	https://img.gratis.com/mnpadding/800/800/ffffff/productimages/10203493/10203493_01/8822309093426_1730806698382.jpg?v=418146951047901	LYKD Glow Perfector 4'ü 1 Arada Fondöten Light
192	67	Ruj	2536.07	100	Kozmetik	https://cdn03.ciceksepeti.com/cicek/kcm42033331-1/XL/golden-rose-mat-kirmizi-kalem-ruj-no-09-kcm42033331-1-7864174f990444d781e7d287945e05c2.jpg	Golden Rose Mat Kırmızı Kalem Ruj No: 09
193	67	Nemlendirici	4213.62	87	Kozmetik	https://images.deliveryhero.io/image/product-information-management/672a0c609e92c1b8f2730501.jpg?height=480	Arko Nem Değerli Yağlar Zeytinyağlı Nemlendirici Krem 250 ml
204	70	Akıllı Saat	1610.65	85	Elektronik	https://market.miuiturkiye.net/image/cache/catalog/mibro-watch-t1/mibro-watch-t1-product-5-418x418.jpg	Mibro Watch T1 Akıllı Saat
211	72	Ayakkabı	4341.33	11	Moda	https://floimages.mncdn.com/media/catalog/product/24-01/22/101496061_f2-1705909772.JPG	Kinetix VAGOR 4FX Beyaz Erkek Çocuk Spor Ayakkabı
210	72	Çanta	250.03	14	Moda	https://static.ticimax.cloud/59166/uploads/urunresimleri/valmenti-origame-erkek-grisiyah-hakiki-dd9-8d.jpg	Valmenti Origame Erkek Gri\\Siyah Hakiki Deri El Çantası
208	72	Elbise	2433.91	48	Moda	https://floimages.mncdn.com/media/catalog/product/24-05/06/201201834-2-1714982551.jpg	Erkek Beyaz Poliviskon Trend Kruvaze Slim Fit Sivri Yaka Takım Elbise
200	69	Fondöten	2691.81	58	Kozmetik	https://i8.amplience.net/i/Cosnova/5299982	DOĞAL MAT KÖPÜK FONDÖTEN. Doğal, mat bir görünüm için orta düzeyde kapatıcılık sunan mus fondöteni
205	70	Kulaklık	3433.63	66	Elektronik	https://cdn.evkur.com.tr/c/Product/thumbs/huawei-freeclip-bluetooth-kulaklik-1_n7kck0_1920.jpg	Huawei Freeclip Bluetooth Kulaklık Siyah
212	73	Masa	4821.33	79	Ev_Yasam	https://kumbahce.com.tr/wp-content/uploads/2023/04/kumbahce-amor-aluminyum-masa-takimi-dis-mekan-mobilyasi.png	Amor 6 Kişilik Açılır-Kapanır Masa Takımı ( Antrasit )
201	69	Nemlendirici	4623.06	71	Kozmetik	https://www.gosiv.com.tr/idea/jw/76/myassets/products/005/1080-kutu2-nem.jpg?revision=1713354399	Bariyer Onarıcı Yoğun Nemlendirici Krem 50 ML
194	67	Parfüm	1093.18	65	Kozmetik	https://cdn.beymen.com/mnresize/505/704/productimages/3fpaxrow.5my_IMG_01_888066000079.jpg	Tom Ford Black Orchid EDP 100 ml Unisex Parfüm
218	75	Perde	893.42	17	Ev_Yasam	https://www.peraper.com/image/cache/catalog/Tul-Stor%20Perde/modern-ciftli-tul-stor-perde-30187-136-1200x1600.jpg	Modern Çiftli Tül Stor Perde
215	73	Sandalye	1607.8	60	Ev_Yasam	https://m.media-amazon.com/images/I/61h5atfBKdL.jpg	Depolife Çocuk Koltuğu Prenses Desenli Çocuk Çalışma Sandalyesi
217	74	Spor Ayakkabı	2395.7	37	Spor	https://akn-desa.a-cdn.akinoncloud.com/products/2023/02/25/187003/d87975a6-86c4-419c-ba41-d514f9f9549a_size1500x1500_quality100_cropCenter.jpg	Kadın Pembe Spor Ayakkabı
228	79	Şampuan	3835.09	92	Kozmetik	https://cdn.myikas.com/images/5ceaa165-c63e-4237-a7e8-eeab2eef7495/c1aba613-628e-48db-b45f-39ad6d07b774/3840/women-shampoo-1lt.webp	Shampelo Kadın Saç Şampuanı 1 LT
243	84	Tencere	1559.6	83	Ev_Yasam	https://www.lines.com.tr/lines-helvane-metal-kulplu-derin-tencere-celik-tencere-lines-helvane-33-40-O.jpg	Lines Gastro Metal Kulplu Paslanmaz Derin Çelik Tencere
257	91	Tişört	1295.43	59	Moda	https://cdn.gencallar.com.tr/Uploads/Product/thumbs/11220741_40000_2_w552.jpg	MAVİ Erkek Polo Yaka T-Shirt
251	88	Yastık	1805.2	6	Ev_Yasam	https://cf6ad7.a-cdn.akinoncloud.com/products/2025/01/11/120805/3c0f7500-10f0-46ca-9f2b-a6c1afb9af02_size1000x1000_cropTop.jpg	Evidea Soft Love Figürlü Yastık - Pembe
263	93	Yastık	283.98	77	Ev_Yasam	https://www.maviperde.com/media/catalog/product/cache/3647cb318dc1e08839199750286dbb2d/t/o/toz_pembe_yast_k_014.png	Toz Pembe Yastık
220	76	Yoga Matı	2654.61	30	Spor	https://aad216.a-cdn.akinoncloud.com/products/2025/02/11/3160443/24c5e7cc-fc19-4ccb-92bb-3abf259d6f70_size1000x1000_cropCenter.jpg	Energetics Unisex Siyah Yoga Matı
247	85	Yoga Matı	1184.86	57	Spor	https://cdn.akakce.com/z/avessa/avessa-10-mm-yoga-mat-pilates-minderi-yesil.jpg	Avessa 10 mm Yeşil Yoga Matı
246	85	Dambıl	1498.73	22	Spor	https://fitnessshop.com.tr/wp-content/uploads/2020/05/voit-1kg-440x440.jpg	Voit Dipping Dumbell (Dambıl)
233	80	Akıllı Saat	4106	67	Elektronik	https://img.pzrmcdn.com/mnresize/716/716/asset/e0ce5368-2da6-4ed2-9051-f00e5337d1f46973626300257/images/imikisf1xiaomiecosystemcompanysesligrmeakllsaatgenpagarantili-2.jpg	IMIKI SF1 Xiaomi Ecosystem Company Sesli Görüşme Akıllı Saat
254	90	Araç Kamerası	3633.59	89	Otomotiv	https://www.teknostore.com/image/cache/data/resimler/viofo-a119-v3-gps-li-akilli-arac-kamerasi-611-682x682.jpg	Viofo A119 V3 GPS'li Akıllı Araç Kamerası
250	87	Bagaj Düzenleyici	810.55	43	Otomotiv	https://amarist.net/wp-content/uploads/2023/11/655542622e8e612f7a21b55a72b8bf34476d6b574a2f47d41afa4.jpg	Arnee 3 Adet Oto Bagaj Çantası Araba Bagaj Çantası Araç Bagaj Organizer Bagaj Düzenleyici
222	76	Dambıl	3539.2	70	Spor	https://static.ticimax.cloud/14897/uploads/urunresimleri/buyuk/ecgspor-2-5-kg-dambil-seti-2-5-kg-x-2--ac-370.jpg	Ecgspor 2.5 KG Dambıl Seti 2.5 KG x 2 Toplam 5 KG Ağırlık Seti Kırmızı
227	79	Fondöten	578.23	59	Kozmetik	https://static.ticimax.cloud/49308/uploads/urunresimleri/buyuk/fresh-nude-fondoten-d8-b78.jpg	Fresh Nude Fondöten
237	83	Fondöten	2692.44	59	Kozmetik	https://media.sephora.eu/content/dam/digital/pim/published/M/MAKE%20UP%20FOR%20EVER/713417/342359-media_swatch.jpg?scaleWidth=undefined&scaleHeight=undefined&scaleMode=undefined	MAKE UP FOR EVER. HD Skin Hydra Glow - Fondöten
221	76	Koşu Bandı	3045.81	40	Spor	https://image01.idefix.com/resize/500/0/product/581457/dynamic-floyd-pembe-kosu-bandi-66c746c0485a0.jpg	Dynamic Floyd Pembe Koşu Bandı
232	80	Kulaklık	3341	77	Elektronik	https://img.pzrmcdn.com/mnresize/716/716/asset/0705618500057/images/kulakstbluetoothkulaklkairmaxp9mikrofonlukablosuzkulaklk-1.jpg	Kulak Üstü Bluetooth Kulaklık Air Max P9 Mikrofonlu Kablosuz Kulaklık
224	77	Laptop	1331.69	80	Elektronik	https://resim.epey.com/988864/b_lenovo-legion-pro-7-leg82wq00awtx56-1.jpg	Lenovo Legion Pro 7 LEG82WQ00AWTX56 Notebook
253	90	Lastik	951.68	11	Otomotiv	https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/300/300/productimage/790852845/790852845_0_MC/e341771b9cd54a3095bccb05581c27a0.jpg	Snoways Kış Lastiği
244	84	Masa	2920.97	88	Ev_Yasam	https://image-ikea.mncdn.com/urunler/2000_2000/PE932463.jpg	ASKHOLMEN katlanabilir masa, koyu kahve, 110x70x71 cm
256	90	Navigasyon	415.16	17	Otomotiv	https://www.incehesap.com/resim/urun/201207/oem-navigasyon-8506_500.webp	RAMAR 4.3 6027B GPS NAVIGASYON CİHAZI
226	78	Navigasyon	756.45	52	Otomotiv	https://elcobil.com/wp-content/uploads/garmin-drive-51-lmt-s-2.jpg	Garmin Drive 51 LMT-S Navigasyon Cihazı
259	92	Nemlendirici	2013.76	59	Kozmetik	https://kozmetik.avon.com.tr/assets/tr-tr/images/product/prod_1204049_1_613x613.jpg	Nutra Effects Soothe Nemlendirici Krem 50 ml SPF20
229	79	Nemlendirici	98.01	74	Kozmetik	https://www.polentenatural.com/cdn/shop/files/SQUALANE_62555204-9fb5-42dd-976b-2402b86f0bd0.jpg?v=1744909990	HYDRA MOIST CREAM - Hyalüronik Asit & Skualen İçeren Nemlendirici Krem (50 ml)
260	92	Parfüm	862.56	74	Kozmetik	https://parfumania.com.tr/wp-content/uploads/2024/06/Tom-Ford-Tobacco-Vanille-100-ml-Edp-Erkek-Parfumu-888066004503.jpg	Tom Ford Tobacco Vanille 100 ml Edp Erkek Parfümü
242	84	Perde	3059.6	50	Ev_Yasam	https://productimages.hepsiburada.net/s/59/960-1280/110000000566217.jpg	Çift Kanat Etnik Afrika Desenli Modern Dijital Baskılı Fon Perde
264	93	Perde	21.64	33	Ev_Yasam	https://cdn.dsmcdn.com/mnresize/1200/1800/ty1263/product/media/images/prod/SPM/PIM/20240418/18/3bb4363d-88ef-30a4-8206-753118c891b4/1_org_zoom.jpg	Homefesto Modern Fon Perde Petek Kadife Dokulu Bej Perde Pilesiz Ekstraforlu Güneşlik 140 x 260 cm
230	79	Ruj	4283.99	25	Kozmetik	https://sdcdn.io/mac/tr/mac_sku_SRH918_1x1_0.png	LOCKED KISS INK 24HR LİKİT MAT RUJ
262	92	Ruj	4423.65	84	Kozmetik	https://www.dermokozmetika.com.tr/loreal-paris-color-riche-nude-saten-bitisli-ruj-no-520-nude-defiant-58339-36-B.jpg	Loreal Paris Color Riche Nude - Saten Bitişli Ruj No: 520 Nude Defiant
238	83	Ruj	2976.41	46	Kozmetik	https://media.sephora.eu/content/dam/digital/pim/published/S/SEPHORA%20COLLECTION/614310/330243-media_swatch.jpg	Sephora Cream Lip Stain – Bulaşmayan Kadife Bitişli Ruj - Mat Likit Ruj
245	84	Sandalye	1068.63	41	Ev_Yasam	https://cdn03.ciceksepeti.com/cicek/kcm29809547-1/L/ofis-cocuk-odasi-calisma-koltugu-doner-ayakli-mor-kcm29809547-1-1dd69cd1eabf405a847db60f375ee455.jpg	Krom Metal Ayaklı Ofis Çocuk Odası Çalışma Sandalyesi (Ayarlanılabilir) Mor
272	96	Akıllı Saat	1745.88	87	Elektronik	https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/600/600/productimage/780167434/780167434_0_MC/18534c51ed294f33ac0397ee4dc4a719.png	S92 Premium LT Watch Akıllı Saat
266	94	Akıllı Saat	4890.54	82	Elektronik	https://enteknoloji.com.tr/cdn/shop/files/watch-ultra-hello-3-akilli-saat-3.png?v=1724523935	Watch Ultra Hello 3 Plus Akıllı Saat
282	99	Akıllı Saat	2425.15	62	Elektronik	https://cms.vodafone.com.tr/static/img/content/24-11/19/mipo-s24-akilli-saat-gumus1.png	Mipo S24 Akıllı Saat
270	95	Araç Kamerası	722.62	26	Otomotiv	https://www.ayestore.com.tr/image/cache/catalog/a129produo/a129-pro-duo-2-550x550.jpg	Viofo A129 Pro Duo 4K Gps'li Ön Arka Araç Kamerası
275	97	Bisiklet	4006.2	28	Spor	https://www.gizerler.com/assets/product-images/150000/carraro-force-970c-29-480h-gumus-mavi-acik-mavi-dag-bisiklet_93444.jpg	Carraro Force 970 C 29 Jant 480h Dağ Bisiklet Gümüş-Mavi-Açık Mavi
288	100	Bisiklet	2851.1	45	Spor	https://www.bisan.com.tr/cdn/shop/files/E-Folding_F2_Bisan_Elektrikli_Bisiklet_20_Jant_1x7_Vites_yesil.jpg?v=1719004714&width=1800	E-Folding F2 Bisan Elektrikli Bisiklet 1x7 Vites
281	98	Çanta	3478.07	65	Moda	https://witcdn.tergan.com.tr/siyah-deri-erkek-sirt-cantasi-s1sr00021443-a41-siyah-erkek-sirt-cantasi-tergan-2024-yaz-71747-35-B.jpg	Siyah Deri Sırt Çantası
274	97	Dambıl	1474.35	85	Spor	https://cdn.akakce.com/voit/voit-db107-2-kg-dipping-z.jpg	Voit 2 Kg Dambıl
285	100	Dambıl	2333.4	73	Spor	https://img.vivense.com/720x480/images/e96b6d39c5a4469f879fed8916c9ab9d.jpg	ECGSPOR İKİ ADET 8 KG VİNYL DAMBIL SETİ
280	98	Elbise	4981.15	11	Moda	https://static.ticimax.cloud/52816/uploads/urunresimleri/buyuk/erkek-oversize-rahat-kalip-kruvaze-tak-b207-6.jpg	Erkek Oversize Rahat Kalıp Kruvaze Takım Elbise Siyah
284	100	Koşu Bandı	4127.8	69	Spor	https://cdn.cimri.io/image/1200x1200/altis-sd-5000-kosu-bandi_170846098.jpg	Altis SD 5000 Koşu Bandı
278	97	Koşu Bandı	490.65	89	Spor	https://img.pzrmcdn.com/asset/8682798443591/images/yuix24proplus14kmhz120kgtamakatlanabilirakllyryvekouband25hpbeyaz-1.jpg	Yui X24 PRO PLUS 14 Km Hız-120 Kg Taşıma-Katlanabilir Akıllı Yürüyüş Ve Koşu Bandı
283	99	Kulaklık	4667.36	27	Elektronik	https://ideacdn.net/idea/em/59/myassets/products/647/soultech-bh050s-magicpro-bluetooth-kulaklik-1075.png?revision=1727763383	Soultech BH050S MagicPro Bluetooth Kulaklık ANC+ENC+Şeffaf Mod
267	94	Kulaklık	2103.51	28	Elektronik	https://f-a101-l.mncdn.com/mnresize/480/480/livephotos/8/25005143SIYAH/25005143SIYAH_893.jpg	JBL Free II Kulak İçi Bluetooth Kulaklık Siyah
268	94	Laptop	1236.3	83	Elektronik	https://resim.epey.com/927640/b_asus-rog-strix-g18-g814jz-n6002w-1.jpg	Asus ROG Strix G18 G814JZR-N609232 Notebook
273	96	Laptop	4085.21	69	Elektronik	https://resim.epey.com/910958/b_dell-precision-m7680-xctop7680emea-vp2a6-741035590455-1.jpg	Dell Precision M7680 XCTOP7680EMEA_VP2A11
269	95	Navigasyon	3157.69	80	Otomotiv	https://piranha.com.tr/static/media/product_media/194/gallery/Sigma_400.png	Sigma Piranha 4.3 inç Navigasyon
276	97	Spor Ayakkabı	4043.27	6	Spor	https://www.cdnaws.com/i/missmittocom/ZW3D2Lqi2qQZW3D2QvGYHPsSdwLZW3D2/urunler/65ecbb0189ee0-65ecbb018ede5.jpg	Kadın Kahve Sneaker Bağcıklı Bej Kalın Tabanlı Rahat ve Şık Spor Ayakkabı
287	100	Spor Ayakkabı	940.45	61	Spor	https://www.civilim.com/productimages/466682/big/4062451497644.jpg	Puma Anzarun Lite AC PS Erkek Çocuk Spor Ayakkabı 28-35 Numara Siyah
271	96	Tablet	694.88	36	Elektronik	https://resim.epey.com/884199/m_samsung-galaxy-tab-s9-plus-20.jpg	Samsung Galaxy Tab S9+ Wi-Fi Tablet (256 GB)
265	94	Telefon	2047.67	100	Elektronik	https://www.gizerler.com/assets/product-images/146000/xiaomi-redmi-note-13-pro-8-gb256-gb-mor-telefon_85662.jpg	Xiaomi Redmi Note 13 Pro 8 GB/256 GB Mor Telefon
279	98	Tişört	226.9	46	Moda	https://littlegusto.com.tr/cdn/shop/files/Organik_Pamuk_Bebek_Tisort_Beyaz_-_Little_Gusto_-_-2168619.jpg?v=1722848889	Organik Pamuk Bebek Tişört Beyaz
277	97	Yoga Matı	1515.88	91	Spor	https://www.cosfer.com.tr/imgurun/8681949604195.jpg	Cosfer 6,5 mm Pilates ve Yoga Minderi Siyah
286	100	Yoga Matı	4172.2	81	Spor	https://akn-spx.a-cdn.akinoncdn.com/products/2021/11/10/992885/786ea539-94b7-4093-b902-3e410159de8a.jpg	NIKE MOVE YOGA MAT 4 MM BLACK/ANTHRACITE OSFM
1	6	Kulaklık	191.33	46	Elektronik	https://statics.vestel.com.tr/productimages/20275109_r1_1000_1000.jpg	Yüksek müşteri memnuniyetine sahip Kulaklık, stoklarla sınırlıdır.
2	6	Laptop	966.11	58	Elektronik	https://cdn.cimri.io/image/1200x1200/https://cdn.cimri.io/image/200x200/lenovo-v15-g4-amn-82yu0123tx-ryzen-5-7520u-16gb-ram-512gb-ssd-freedos-15-6-inc-laptop-notebook_875128464.jpg	Laptop, en son teknolojiyle üretilmiştir ve günlük kullanım için idealdir.
7	7	Parfüm	266.7	59	Kozmetik	https://img-lancome.mncdn.com/mnpadding/700/700/FFFFFF/media/catalog/product/5/b/5bb68a0b1e6d8c4d49a924cc3d9ba46d900199d282e6216531199c7340f9fe80.jpeg	Yüksek müşteri memnuniyetine sahip Parfüm, stoklarla sınırlıdır.
8	7	Şampuan	697.97	93	Kozmetik	https://cdn.dsmcdn.com/ty337/product/media/images/20220219/16/53616555/392123646/1/1_org_zoom.jpg	Bu Şampuan, konfor ve kaliteyi bir arada sunar.
9	8	Nemlendirici	66.48	49	Kozmetik	https://cdn.rossmann.com.tr/mnpadding/700/700/FFFFFF/media/catalog/product/0/6/06d1e96049520f90a0cde0b296b7af41cf73d7c4f2d2657db08ccdc31f16af29.jpeg	Nemlendirici ürünü, şık tasarımı ve dayanıklı yapısıyla dikkat çeker.
10	8	Şampuan	620.57	27	Kozmetik	https://www.recete.com/ogx-biotin-collagen-dolgunlastirici-sampuan-385ml-sac-sampuanlari-organix-3948-39-B.jpg	Bu Şampuan, konfor ve kaliteyi bir arada sunar.
14	10	Elbise	4363.16	59	Moda	https://www.modaebva.com/belden-oturtmali-toka-detayli-tesettur-elbise-3139-kiremit-elbise-17878-33-B.jpg	Yüksek müşteri memnuniyetine sahip Elbise, stoklarla sınırlıdır.
19	12	Masa	568.33	7	Ev_Yasam	https://img.vivense.com/1920x1280/images/0b9ea4b7515543efba091709b283344c.jpg	Masa sade görünümü ile dikkat çekiyor.
20	12	Yastık	1328.6	54	Ev_Yasam	https://koctas-img.mncdn.com/mnpadding/300/300/ffffff/productimages/5000702374/5000702374_1_MC/9048764678194_1710230707422.jpg	Boyun Destekli Yastık
21	12	Tencere	1379.26	27	Ev_Yasam	https://images.guralporselen.com/gural-celik-gural-porselen-ametis-22-cm-granit-derin-tencere-antrasit-tek-parca-granit-urunler-2676-56-B.jpg	Ametis Tencere
22	12	Sandalye	4690.3	93	Ev_Yasam	https://witcdn.medusahome.com.tr/cardiff-ahsap-sandalye-02-sandalye-modelleri-139812-22-B.jpg	Cardiff Ahşap Sandalye
23	12	Perde	1005.52	52	Ev_Yasam	https://cdn1.jysk.com/getimage/wd3.medium/241208	Perde Totak
32	15	Perde	1240.3	76	Ev_Yasam	https://www.farbateks.com.tr/image/cache/A.%C3%96%20FON%20pERDE/bej-kusgozu-rut%C4%B1k-tul-blacout-750x1010_0.jpg	Yüksek müşteri memnuniyetine sahip Perde
33	15	Masa	2850.43	89	Ev_Yasam	https://upload.wikimedia.org/wikipedia/commons/7/7b/Table_pliante.jpg	Bu Masa, konfor ve kaliteyi bir arada sunar.
34	15	Yastık	2318.62	34	Ev_Yasam	https://moln.com.tr/cdn/shop/files/moln-beauty-air-collagen-visco-yastik-550724.jpg?v=1741615308&width=1100	Bu Yastık, konfor ve kaliteyi bir arada sunar.
35	15	Sandalye	4477.11	67	Ev_Yasam	https://ce1999.a-cdn.akinoncloud.com/products/2024/01/28/458495/31750c95-2f61-4e5d-958a-5c64326ce9f7_size650x650_cropCenter.jpg	Yüksek müşteri memnuniyetine sahip Sandalye, stoklarla sınırlıdır.
36	16	Çanta	1758.9	34	Moda	https://static.ticimax.cloud/13728/uploads/urunresimleri/buyuk/mio-gusto-siyah-renk-katlanabilir-kadi-fb-4c1.jpg	Mio Gusto
37	16	Pantolon	1864.21	33	Moda	https://cdn.sorsware.com/oxxo/ContentImages/Product/23y/23YOX-PELJOGBAG/yuksek-bel-jogger-pantolon--tencel-_antik-soft-bronze-green-haki_1_detay.jpg	Haki Yüksek Bel Jogger
38	17	Masa	3644.69	40	Ev_Yasam	https://www.itals.com.tr/idea/dr/99/myassets/products/560/best-oval.jpg?revision=1746195744	6 kişilik takım
39	17	Sandalye	3209.83	43	Ev_Yasam	https://m.media-amazon.com/images/I/716sVrBRM6L._AC_UF1000,1000_QL80_.jpg	360 dönen ofis sandalyesi
40	17	Yastık	858.05	29	Ev_Yasam	https://www.othellobedding.com/othello-promed-bas-ve-boyun-destek-yastigi-60x40-12-cm-medikal-yastik-4836-43-B.jpg	Othello Medical
41	17	Tencere	2604.51	98	Ev_Yasam	https://static.ticimax.cloud/55091/Uploads/UrunResimleri/buyuk/tefal-titanyum-1x-easy-cookclean-derin-c5-494.jpg	Tefal Titanyum
45	19	Bagaj Düzenleyici	3291.46	13	Otomotiv	https://m.media-amazon.com/images/I/716QqtyMINL._AC_UF1000,1000_QL80_.jpg	HAGS Bagaj Düzenleyici
46	19	Lastik	2636.92	16	Otomotiv	https://productimages.hepsiburada.net/s/777/300-443/110000952082064.jpg	Continental mevsimlik araç lastiği
47	19	Navigasyon	3890.02	74	Otomotiv	https://m.media-amazon.com/images/I/71k1XPGNzJL._AC_UF1000,1000_QL80_.jpg	GPS Navigasyon ürünü, şık tasarımı ile dikkat çeker.
48	20	Yoga Matı	2145.74	43	Spor	https://floimages.mncdn.com/media/catalog/product/22-04/27/200118324_d1.jpg	Delta Yoga Matı
49	20	Spor Ayakkabı	2244.16	43	Spor	https://www.enderspor.com/UserFiles/ProductImages/0/ml408wn/orj/new-balance-408-lifestyle-erkek-gunluk-spor-ayakkabi-102332.jpg	New Balance ML408WN
50	20	Dambıl	1046.08	75	Spor	https://www.xtr.gr/images/detailed/30/03-003-700-X-Fit-Adjustable-Dumbbell.jpg	Kilo ayarlanabilir dumbell
51	21	Fondöten	3296.19	72	Kozmetik	https://cdn.dsmcdn.com/ty1534/product/media/images/prod/QC/20240910/11/918b80f3-015d-37d8-bb61-079fc41c9fcb/1_org_zoom.jpg	Maybelline New York Fondöten
52	21	Ruj	923.7	22	Kozmetik	https://afb801.a-cdn.akinoncloud.com/products/2023/05/08/6044/84f177bf-e7ca-4a65-815e-fa8ea8161917_size960x1440_cropCenter.jpg	Kiss me more Flormar
53	21	Nemlendirici	4126.49	58	Kozmetik	https://sch.sachane.com/images/detailed/62/cerave-nemlendirici-krem-50-ml.jpg	CeraVe nemlendirici krem
143	51	Çanta	3191.91	71	Moda	https://cache.manuka.com.tr/product/cache/1200x1800_-25919-50-B.jpg?5031	LIZZO MANUKA Kadın Çantası
155	53	Çanta	775.75	9	Moda	https://witcdn.imannoor.com/noor-siyah-kanvas-canta-canta-imannoor-11549-46-K.jpg	Noor Siyah Kanvas Çanta
164	58	Çanta	1658.82	70	Moda	https://st-calvinkleinecom.mncdn.com/mnresize/1800/1800/Content/media/ProductImg/original/k60k6122330gr-kadin-minimal-monogram-canta-638549338293537555.jpeg	Calvin Klein Kadın Çanta
88	32	Koşu Bandı	4844.03	25	Spor	https://www.sporvebiz.com/wp-content/uploads/2021/05/b-voit-active-plus-kosu-bandi.jpg	Voit Active Plus
89	32	Bisiklet	236.47	10	Spor	https://ideacdn.net/idea/ii/30/myassets/products/889/dsc04682.JPG?revision=1697143329	Ducati Corse Bisiklet
90	32	Yoga Matı	4688.22	28	Spor	https://cdn.dsmcdn.com/mnresize/400/-/ty1534/product/media/images/prod/QC/20240910/09/4ebb3503-7ad9-3157-9c1b-8972bac3a505/1_org.jpg	Ravel taşıma askılı yoga minderi
91	32	Spor Ayakkabı	4264.66	20	Spor	https://cdn.akakce.com/x/adidas/adidas-terrex-tracefinder-2-ji0958-erkek-kosu-ayakkabisi.jpg	Adidas Terrex Erkek ayakkabı
92	33	Telefon	412.91	43	Elektronik	https://f-a101-l.mncdn.com/mnresize/480/480/livephotos/8/26034236ALTIN/26034236ALTIN_433.jpg	Hiking A41 128 GB Hafıza 4 GB Ram
99	34	Bisiklet	2939.03	59	Spor	https://www.pilsanstore.com.tr/idea/cy/49/myassets/products/755/07-132-smart-bisiklet-on-kirmizi.jpg?revision=1705673157	Smart Üç Tekerli Çocuk Bisikleti
100	34	Spor Ayakkabı	3569.72	73	Spor	https://aad216.a-cdn.akinoncloud.com/products/2023/06/15/11738/8d634ee4-b950-4664-9d80-c992e8e9eddc_size1000x1000_cropCenter.jpg	Adidas Grand Erkek Beyaz Günlük
101	35	Sandalye	3245.12	67	Ev_Yasam	https://www.dugunsamdan.com/image/cache/cache/1-1000/355/main/1063-tiffany-sandalye-beyaz-0-1-450x450.jpg	Tiffany beyaz sandalye
102	35	Yastık	2745.93	11	Ev_Yasam	https://www.realhomes.com.tr/wp-content/uploads/2022/07/Silindir-Dolu-2025-Gorsel.jpg	Siyah Beyaz Çizgili Silindir Yastık
122	42	Tencere	2787.78	94	Ev_Yasam	https://witcdn.aryildiz.com/aryildiz-colombus-crystal-kisa-tencere-24-cm-tek-tencere-aryildiz-46144-19-K.jpg	Ar-Yıldız beyaz tencere
123	42	Yastık	60.63	27	Ev_Yasam	https://image-ikea.mncdn.com/urunler/2000_2000/PE682721.jpg	Gri Yastık
124	42	Masa	214.08	22	Ev_Yasam	https://d28po1cu83ayb1.cloudfront.net/121-thickbox_default/dikdortgen-masa.jpg	Yeşil Masa
125	43	Akıllı Saat	4769.92	11	Elektronik	https://ideacdn.net/idea/em/59/myassets/products/705/soultech-soulfit-sw002s-akilli-saat-1-83-tft-ekran-ip68-siyah-1221.png?revision=1709216759	Soultech Soulfit SW002S Akıllı Saat
133	46	Laptop	4849.77	88	Elektronik	https://image.coolblue.nl/max/500x500/products/2057163	Microsoft Surface Laptop Copilot+ PC 13.8 Snapdragon X Elite/16GB/512GB Graphite
135	46	Kulaklık	40.1	18	Elektronik	https://ideacdn.net/idea/el/11/myassets/products/869/jbl-tune-520bt-multi-connect-bluetooth-kulaklik-mor-8985.jpeg?revision=1744201322	Jbl Tune 520BT Multi Connect Bluetooth Kulaklık,Mor
137	47	Tencere	2923.1	48	Ev_Yasam	https://www.tacev.com/image/cache/catalog/image/cache/catalog/TENCERELER/tt-1508_dekube-1200x1200.webp	Taç Titan Granit Nostalji 5 Parça Tencere Seti
138	48	Navigasyon	1274.72	25	Otomotiv	https://m.media-amazon.com/images/I/71dVwD4nSJL._AC_UF1000,1000_QL80_.jpg	Vobor Mini GPS Tracker, Mini Taşınabilir GPS Takipçisi, Araba, Motosiklet, Çocuk, Kedi ve Köpekler için Gerçek Zamanlı Taşınabilir GPS Takipçisi
139	48	Araç Kamerası	778.6	12	Otomotiv	https://www.elcobilmarket.com/idea/bj/37/myassets/products/231/gps-sensorlu-arac-ici-cift-yonlu-kamera-125-66-b.jpg?revision=1741689987	GO-3000 Pro Çift Yönlü Taşınabilir Araç içi Kamera
140	49	Tablet	687.7	95	Elektronik	https://cdn.vatanbilgisayar.com/Upload/PRODUCT/samsung/thumb/141967-1_large.jpg	Samsung Galaxy Tab A9+ 64Gb 4GB-11'' Android Tablet SM-X210NZAATUR Graphite
149	52	Lastik	291.03	51	Otomotiv	https://medias89k-ete3a4c6hxdufvhh.a03.azurefd.net/sys-master-hybris-image-prod/h02/h90/8797066854430	LASSA Otomobil Lastiği
150	52	Bagaj Düzenleyici	4133.82	48	Otomotiv	https://www.yiltas.com/idea/et/40/myassets/products/029/179456.jpg?revision=1710917553	AutoMix Bagaj Düzenleyici
151	53	Ayakkabı	4403.59	94	Moda	https://cdn.aldoshoes.com.tr/mnresize/800/800/media/catalog/product/b/a/barbiestessy-652-002-020___1.jpg	Barbie Kadın Topuklu Ayakkabı
152	53	Pantolon	1416.85	24	Moda	https://cdn.aksesuarix.com/UserFiles/Fotograflar/94406-ters-dikis-parasut-kargo-cep-erkek-pantolon-uk1294syby-uk1294syby-uk1294syby-02.jpg	Ters Dikiş Paraşüt Kargo Cep Erkek Pantolon UK1294SYBY
153	53	Tişört	3962.38	25	Moda	https://witcdn.tommylife.com.tr/p-seker-pembe-minimal-yazi-baskili-o-yaka-rahat-form-kisa-kollu-kiz-cocuk-t-shirt-75110-tisort-tommylife-t13kg-75110-196606-37-O.jpg	Şeker Pembe Minimal Yazı Baskılı O Yaka Rahat Form Kısa Kollu Kız Çocuk T-Shirt
154	53	Elbise	4068.96	34	Moda	https://cdn.kip.com.tr/saks-slim-fit-kelebek-yaka-dokuma-smokin-takim-elbise-10120863-240-smokin-takim-elbise-kip-6864266-40-B.jpg	Saks Slim Fit Kelebek Yaka Dokuma Smokin Takım Elbise
156	54	Araç Kamerası	3045.31	56	Otomotiv	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWYyU0rCa_vdajkhB2fLLVNo_trH6Hzp4IgQ&s	JY-027 IP ARAÇ KAMERASI
157	55	Masa	1068.08	8	Ev_Yasam	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbTETC5wzeg9mfbeuNRrocIkB3xKkgniU7kA&s	Demir Camlı Masa
158	56	Bagaj Düzenleyici	3535	85	Otomotiv	https://img.joomcdn.net/d7908248f20a89569475973fdf634cb0a1519177_1024_1024.jpeg	Krem Deri Bagaj Düzenleyici
159	57	Tencere	701.89	66	Ev_Yasam	https://static.ticimax.cloud/31174/uploads/urunresimleri/buyuk/emsan-cocinero-10-parca-celik-tencere--7fdbac.jpg	EMSAN COCINERO 10 PARÇA ÇELİK TENCERE SETİ
160	57	Yastık	2070.69	19	Ev_Yasam	https://www.yastikdunyasi.com.tr/images/thumbs/0004251_koton-lila-mor-duz-dekoratif-yastik-kilifi.jpeg	Mor Yastık
161	57	Sandalye	1090.52	31	Ev_Yasam	https://static.ticimax.cloud/34211/uploads/urunresimleri/buyuk/milena-natural-ahsap-sandalye-2-adet--7-ecc9.jpg	2 adet ahşap sandalye
162	57	Masa	1795.78	66	Ev_Yasam	https://www.novussishop.com/cdn/shop/files/Adsiztasarim_20.jpg?v=1684160206	Novussi Wood Masa 90x150 Noktalı Camlı Masa
163	57	Perde	2710.75	15	Ev_Yasam	https://ideacdn.net/idea/fm/43/myassets/products/103/cizgili-celik-tul-01.jpg?revision=1716479010	Beyaz Tül Perde
176	61	Ruj	72.99	73	Kozmetik	https://s.alicdn.com/@sc04/kf/Ha50c712d2da140caa079df82812effb5v.jpg_720x720q50.jpg	YANQINA dudaklar güzellik makyaj nemlendirici besleyici mavi gül sıcaklık rengi değişen ruj
177	61	Fondöten	2242.63	57	Kozmetik	https://afb801.a-cdn.akinoncloud.com/products/2023/07/17/6647/d107ee7f-c2f8-485a-87a4-7fa3d216e4cb_size960x1440_cropCenter.jpg	Skin Lifting Sıkılaştırıcı Bakım Yapan Kremsi Dokulu SPF 30
258	91	Çanta	688.96	57	Moda	https://st-tommy.mncdn.com/mnpadding/800/1068/FFFFFF/Content/media/ProductImg/original/am0am09507bds-essential-pu-laptop-cantasi-637848553543073975.jpg	Tommy Hilfiger erkek essential pu laptop çantası
179	62	Yoga Matı	3986.65	46	Spor	https://f-a101-l.mncdn.com/mnresize/480/480/livephotos/8/26027141SARI/26027141SARI_377.jpg	Sarı Yoga Matı
197	68	Dambıl	4694.81	28	Spor	https://www.e-finspor.com/protech-vinyl-15-kg-pembe-dipping-dambil-ta1301-dambillar-ve-agirlik-setleri-protech-130-86-B.jpg	Protech Vinyl 1.5 Kg Pembe Dipping Dambıl TA1301
248	86	Dambıl	4741.62	74	Spor	https://www.cdnaws.com/i/sadeceondacom/ZW3D2Lqi2qQQvGYHnFzROLPsSdwHVUkzYQ1Dr/images/urunler/639c663a69c43-5724.png	Dambıl 2 adx 1,5Kg Fıtness Pilates Ağırlığı
184	64	Parfüm	2992.36	27	Kozmetik	https://witcdn.kaganparfumeri.com/chanel-bleu-de-chanel-erkek-parfum-edp-150-ml-edp-parfum-chanel-50893-28-B.jpg	Chanel Bleu De Chanel Erkek Parfüm Edp 150 Ml
185	65	Kulaklık	409.7	6	Elektronik	https://st-troy.mncdn.com/mnresize/775/775/Content/media/ProductImg/original/muw33eea-beats-solo-4-kulak-ustu-kablosuz-kulaklik-bulut-pembesi-638525949871585651.jpeg	Beats Solo 4 - Kulak Üstü Kablosuz Kulaklık - Bulut Pembesi
186	65	Telefon	2565.65	48	Elektronik	https://www.beko.com.tr/media/resize/9230511600_LO1_20220820_000503.png/2000Wx2000H/image.webp	Samsung Galaxy Z Flip4 128GB Mor
187	65	Tablet	3396.6	77	Elektronik	https://cdn.cimri.io/image/1200x1200/apple-ipad-7-32gb-mw762tu-a-10-2-inc-wi-fi-tablet-pc-altin_190733580.jpg	Apple iPad 7 32GB MW762TU-A 10.2 inç Wi-Fi Tablet Pc Altın
255	90	Bagaj Düzenleyici	2843.93	65	Otomotiv	https://bsgcaraccessories.com/bsg-arac-bagaj-duzenleyici-bagaj-duzenleyici-bsg-121-29-B.jpg	BSG ARAÇ BAGAJ DÜZENLEYİCİ
223	76	Bisiklet	1505.96	35	Spor	https://iet-cdn-003.akinsofteticaret.net/azizmotor.net/Resim/Minik/1500x1500_thumb_st03572.jpg	ARORA LONDRA ELEKTRİKLİ BİSİKLET SİYAH
225	77	Kulaklık	1270.52	85	Elektronik	https://carmenta.com.tr/wp-content/uploads/2024/05/Carmenta-K55-Bluetooth-Kulaklik-Mavi.webp	Carmenta Gamer Bluetooth Kulaklık K55
252	89	Lastik	4401.02	96	Otomotiv	https://cdn.akakce.com/petlas/petlas-snow-master-w651-195-55-r15-85h-z.jpg	Petlas Snowmaster W651 195/55 R15 85H Kış Lastiği
249	87	Lastik	4366.54	47	Otomotiv	https://www.tiryakilerlastik.com/idea/dr/23/myassets/products/097/lassa-snoways-3.jpg?revision=1731076128	Lassa 155/70R13 75T Snoways 3 (Kış) (2024)
231	79	Parfüm	2475.99	20	Kozmetik	https://media.sephora.eu/content/dam/digital/pim/published/T/TOM%20FORD/220615/61759-media_swatch.jpg	TOM FORD Neroli Portofino - Eau de Parfum
240	83	Parfüm	2323.41	8	Kozmetik	https://media.sephora.eu/content/dam/digital/pim/published/H/HUGO%20BOSS/620819/280456-media_swatch.jpg	HUGO BOSS Bottled Parfum
214	73	Perde	4910.07	71	Ev_Yasam	https://f-a101-l.mncdn.com/mnresize/480/480/livephotos/8/26005309DEFAULT/26005309DEFAULT_952.jpg	Beyaz Güneşlik Perde
236	82	Ruj	4146.5	16	Kozmetik	https://m.media-amazon.com/images/I/51wQ-nQgfGL._AC_UF1000,1000_QL80_.jpg	Pastel Profashion Matte Lipstick Mat Ruj Dark 570
198	68	Spor Ayakkabı	364.63	13	Spor	https://minio.yalispor.com.tr/yalispor/images/lumberjack-4m-mera-4fx-kadin-spor-ayakkabi-acik-mavi-1.jpg	Lumberjack 4M Mera 4Fx Kadın Açık Mavi Spor Ayakkabı
\.


--
-- Data for Name: seller_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seller_details (id, user_id, business_name, business_address, tax_number) FROM stdin;
1	6	Yıldırım Akçay Şti.	97456 Ülker Flat Suite 340, Bahittinburgh, NV 05595	9969560558
2	7	Bilir San.	92614 Çetin Brook, West Dilşatstad, SC 17910	1606475100
3	8	Sepaş Enerji Sakarya Elektrik	15754 Dağistan Lights, Demirelville, TN 68743	5243039096
4	9	Aytemiz Akaryakıt Dağıtım	977 Durdu Prairie Suite 963, Saygınmouth, CT 17047	2707805755
5	10	Coca-Cola İçecek	9112 Akar Lodge, Gülkadınbury, FL 25170	4732519713
6	11	Migros	33037 Yankı Flat, East Aclan, MO 92454	2337564538
7	12	Kısakürek Ltd.	1183 Şafak Mountain, Zehranurfurt, ND 64365	3653522514
8	13	Öcalan Tic.	525 Akçay Street Apt. 899, Port Şerman, VA 13355	0148062302
9	14	Selçuk Ecza	286 İklim Drive Apt. 960, New Bilgen, WY 89677	7170013734
10	15	Türk Yılmaz San.	Unit 5469 Box 5656, DPO AP 85808	7736572472
11	16	Yılmaz Akgündüz Ltd.	6040 Ülker Haven, West Aytunafurt, GU 32887	0949700972
12	17	Gül Duran Tic.	56589 Soylu Loop, North Henife, PR 81361	4192938629
13	18	Tevetoğlu Tic.	49956 Yılmaz Prairie Apt. 023, Bilirville, WI 78126	8252736058
14	19	Yılmaz Ergül Şti.	6632 Hayrioğlu Springs, Şendoğanview, NM 65336	5624281088
15	20	Akdeniz Yaman A.Ş.	13243 Eraslan Corners, Yamanfort, OH 05433	3059344555
16	21	Demirel Tic.	68309 Deha Ramp, Lâleborough, PW 95292	6971090399
17	22	Sezgin Tic.	77225 Hayrioğlu Key Apt. 610, Atiyyemouth, VI 25645	3375252001
18	23	Dumanlı Şti.	74694 Bilge Causeway Suite 847, Port Alpsü, NV 20100	6966560514
19	24	Selçuk Ecza	74786 Akdeniz Trafficway Apt. 229, Akçayborough, MH 79226	8401448565
20	25	Fırat Eraslan A.Ş.	Unit 5935 Box 4335, DPO AA 95622	4633152748
21	26	Akça Ltd.	007 Akgündüz Union, Benolview, CT 86277	7178727101
22	27	Philsa Philip Morris Sabancı Sigara	82650 Ertaş Pines Apt. 809, Port Enginizland, HI 19248	3147080552
23	28	Ergül Ltd.	68417 Seven Springs Suite 578, Sanavbershire, NC 33255	1512021713
24	29	Tarhan Ltd.	81344 Zekayi Lakes Apt. 205, New Sancak, AR 25664	6083067469
25	30	LC Waikiki Mağazacılık	09439 Özbilek Points Apt. 350, Karadenizfurt, FM 57920	7356977609
26	31	Ertaş Ltd.	625 Yıldırım Center, Ünübolmouth, UT 54326	9818305480
27	32	Çorlu A.Ş.	43036 Sezen Pass, West Hakikat, WV 07475	3359491308
28	33	Durmuş Ertaş Tic.	Unit 3613 Box 1416, DPO AA 40436	9578530351
29	34	Sezer Ltd.	60551 Tayyibe Prairie Suite 519, Serdaville, AL 24003	7244075300
30	35	Ertaş Ltd.	2271 Resulcan Roads Apt. 255, Ögestad, LA 90119	6319533599
31	36	Ertaş San.	61423 Cercis Curve Suite 911, Mehrigülfort, MH 98020	0757979355
32	37	Sezer İhsanoğlu Ltd.	365 Duran Plaza Suite 831, North Törelmouth, FL 68804	1972899068
33	38	Eraslan A.Ş.	132 Gönen Place Suite 515, East Ömürstad, AL 74091	3997385071
34	39	Otokoç	0203 İnönü Gardens, East Tevsland, MN 90632	7349717120
35	40	Fırat Eraslan Tic.	71699 İlkim Turnpike Apt. 127, Port Şöhret, PR 73947	5611027170
36	41	LC Waikiki Mağazacılık	840 Durdu Street, East Kocabaş, IN 62635	0040422196
37	42	Durmuş Zorlu Ltd.	888 Demir Shoals Apt. 787, Adasalville, WY 32616	7064719648
38	43	Akgündüz San.	00303 Tanbay Mission, Durduton, SD 96511	6588422314
39	44	Türk Traktör	9360 Zorlu Ranch Apt. 903, Övünside, DC 98150	2254428335
40	45	Unilever	584 Zorlu Lane, Merzukchester, WV 24356	9528425376
41	46	Demirel San.	35439 Alabezek Shore, Aferport, WI 55516	4044173344
42	47	Öcalan Çamurcuoğlu Ltd.	6605 Zemzem Plain Suite 381, Lake N˜zamett˜nshire, NH 90285	7370377407
43	48	Seven A.Ş.	814 Aksu Terrace Apt. 372, Port Altuğborough, ID 27446	1543232624
44	49	Akgündüz A.Ş.	381 Huzuri Avenue, Çavuldurland, WA 35660	4973077519
45	50	Türk Traktör	64209 Ülker Shore Apt. 259, North Şehamet, MN 73472	5040074826
46	51	CarrefourSA	711 Akdeniz Mountains Suite 294, Şafakton, CA 66624	3779811560
47	52	Seven Karadeniz Ltd.	9396 Metinkaya Dam, Port Deryanur, MO 94502	5984960399
48	53	TAV Havalimanları	PSC 3261, Box 0322, APO AP 60802	1688589332
49	54	Demir İhsanoğlu Şti.	598 Sağıt Run, Şamamouth, IA 64185	3853972702
50	55	Çetin Kısakürek Şti.	USCGC Akgündüz, FPO AP 53662	9982472321
51	56	Ertaş San.	Unit 6170 Box 6655, DPO AE 23414	6517842883
52	57	Şener Mansız Tic.	44242 Bilge Valley Suite 500, Dolunside, NC 87363	8513924618
53	58	Durdu Kısakürek A.Ş.	6202 Gözem Lodge, Ülkerbury, IL 76057	3711833578
54	59	İçtaş İnşaat	13829 Alemdar Ville, Akayburgh, NY 32785	9851787485
55	60	Manço A.Ş.	90170 Süvari Street, Port Mansuralistad, AS 71279	7863630662
56	61	Yüksel San.	PSC 8515, Box 0394, APO AE 91486	0415990118
57	62	Bilir Arsoy Ltd.	3403 Ergül Alley, Abdulsemetbury, FM 03740	6255140708
58	63	Migros	30788 Özger Row, Özkentborough, IL 58012	4962177774
59	64	Aslan Sezer Tic.	5382 Demirel Springs, Güçlüton, RI 85258	0199358502
60	65	İnönü Ülker Şti.	4478 Duracan Isle Suite 046, Lake Fehmiye, NY 53430	3023659751
61	66	Çamurcuoğlu Manço San.	910 Günkurt Causeway Suite 414, North Sonadhaven, PA 62792	3949152379
62	67	Shell&Turcas Petrol	48287 Sakarya Mews Suite 363, West Nebiha, NE 17026	7833526432
63	68	TAV Havalimanları	7825 Aksu Squares, Velitdinfurt, WY 42494	3879385714
64	69	Borusan Otomotiv	772 Müferrih Stravenue, Lake Zilfafort, LA 23573	8552606177
65	70	Şama A.Ş.	7023 Zubeyde Inlet, İnönühaven, DC 76041	4424759434
66	71	Yıldırım Ltd.	03578 Durdu Garden, Sezerside, MD 87782	4440920670
67	72	Fırat San.	199 İvecen Plaza Suite 137, West Odkanlıshire, NV 36528	1289526282
68	73	Durdu Tic.	Unit 6844 Box 1830, DPO AA 63193	7100438383
69	74	Tarhan Yıldırım Şti.	04188 Manço Center Apt. 434, New Özkentberg, AZ 41156	4677557450
70	75	Alemdar San.	1744 Güçlü Cape Suite 546, North Özdil, DC 53519	2840829112
71	76	Sakarya Şti.	65133 Asalet Knolls Suite 031, Erözview, TX 57058	0298799337
72	77	Aksu Tevetoğlu Ltd.	508 Aslan Green, Yamanmouth, SD 54275	9297234222
73	78	Seven Şama San.	398 Akça Centers, Mutluhanhaven, WY 12188	7363571824
74	79	TP Petrol Dağıtım	80926 Pekkan Island Suite 746, East Sahir, ND 90096	1758703501
75	80	Arslan A.Ş.	5075 Nezengül Fords Apt. 472, Port İmge, MN 66054	1554436784
76	81	Durmuş Şti.	PSC 7945, Box 0572, APO AE 58948	7402613258
77	82	Şensoy Güçlü A.Ş.	886 Tuğçe Knoll Suite 602, Tarhanton, OH 08409	2652128244
78	83	Çetin Çorlu A.Ş.	8648 Şensoy Knoll, Lake Mesude, WI 84260	5769800814
79	84	Hançer Zengin Ltd.	11951 Çokan Trafficway Apt. 008, North Gürcüyebury, NC 26239	4818148152
80	85	Durdu Ltd.	08526 Bilir Forks Apt. 022, Lake Boynak, MP 73811	1592314268
81	86	Hayrioğlu Hançer A.Ş.	7066 Dorukhan Harbors Apt. 140, Atiyyebury, UT 32893	7185416929
82	87	Şener San.	39835 Arsoy Points, Ülküdeşbury, MN 54379	1671131573
83	88	Limak Yatırım	3412 Kısakürek Garden Apt. 033, South Muhyettin, OH 34550	9197087976
84	89	Bilge İnönü Ltd.	4529 Dumanlı Ways, New Şahnurayberg, TX 62833	2218300325
85	90	Mapa İnşaat	USCGC Duran, FPO AE 05136	6955835525
86	91	Gülen A.Ş.	6731 Yorulmaz Falls, Çorlumouth, ID 40302	8766595530
87	92	İnönü A.Ş.	986 Hançer Key, New Büreyretown, IN 75851	9129040846
88	93	Arsoy Ltd.	0966 Şensoy Pass Apt. 486, Soyluside, IN 73092	2205086426
89	94	Duran A.Ş.	2263 Nuretdin Drive Apt. 974, North Sargın, NY 49379	0685646416
90	95	Zengin A.Ş.	USNV Akça, FPO AP 36357	5228988796
91	96	CarrefourSA	902 Halidun Valley Apt. 636, Bakimouth, WY 90243	4144327268
92	97	Hayrioğlu Şama A.Ş.	PSC 7449, Box 6695, APO AP 42508	6183394481
93	98	Sezgin San.	3530 Sadittin Cliffs Suite 278, South İnsafland, GU 12985	7471239619
94	99	Akar Tic.	65787 Çevregül Trail, Arsoyport, NC 05430	1283351203
95	100	Bilge Kısakürek Şti.	06119 Çetin Expressway Apt. 509, East Aral, CA 07195	7999363347
\.


--
-- Data for Name: shipping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping (id, order_id, tracking_number, carrier, estimated_delivery, status) FROM stdin;
1	1	TR16088862	PTT	2025-05-12	TESLIM_EDILDI
2	2	TR08260924	Aras	2025-05-16	YOLDA
3	3	TR05446525	Yurtiçi	2025-05-15	YOLDA
4	4	TR18259906	Sürat	2025-05-20	YOLDA
5	5	TR06600541	Yurtiçi	2025-05-17	YOLDA
6	6	TR69825843	Sürat	2025-05-16	TESLIM_EDILDI
7	7	TR56653272	Aras	2025-05-18	TESLIM_EDILDI
8	8	TR24887481	PTT	2025-05-15	TESLIM_EDILDI
9	9	TR54347158	MNG	2025-05-19	TESLIM_EDILDI
10	10	TR65372201	Sürat	2025-05-17	TESLIM_EDILDI
11	11	TR89516213	Yurtiçi	2025-05-16	YOLDA
12	12	TR70724944	MNG	2025-05-12	TESLIM_EDILDI
13	13	TR02076474	Yurtiçi	2025-05-20	YOLDA
14	14	TR10430120	Aras	2025-05-19	YOLDA
15	15	TR14056498	Sürat	2025-05-12	TESLIM_EDILDI
16	16	TR85132470	MNG	2025-05-14	TESLIM_EDILDI
17	17	TR57413780	PTT	2025-05-18	TESLIM_EDILDI
18	18	TR71866306	Sürat	2025-05-15	YOLDA
19	19	TR89138915	Sürat	2025-05-14	TESLIM_EDILDI
20	20	TR76412818	Yurtiçi	2025-05-19	TESLIM_EDILDI
21	21	TR86089357	Aras	2025-05-19	TESLIM_EDILDI
22	22	TR80564976	Yurtiçi	2025-05-15	TESLIM_EDILDI
23	23	TR70814490	PTT	2025-05-19	YOLDA
24	24	TR15263471	Aras	2025-05-15	TESLIM_EDILDI
25	25	TR60504326	Sürat	2025-05-17	YOLDA
26	26	TR24620876	PTT	2025-05-15	TESLIM_EDILDI
27	27	TR96678403	Sürat	2025-05-16	YOLDA
28	28	TR87713880	Aras	2025-05-14	TESLIM_EDILDI
29	29	TR02783158	MNG	2025-05-20	TESLIM_EDILDI
30	30	TR62015793	Yurtiçi	2025-05-18	YOLDA
31	31	TR01308471	Aras	2025-05-19	TESLIM_EDILDI
32	32	TR87656511	MNG	2025-05-14	TESLIM_EDILDI
33	33	TR97410078	MNG	2025-05-13	TESLIM_EDILDI
34	34	TR44713395	Aras	2025-05-20	YOLDA
35	35	TR77354103	Yurtiçi	2025-05-19	TESLIM_EDILDI
36	36	TR53682239	MNG	2025-05-16	TESLIM_EDILDI
37	37	TR77210591	PTT	2025-05-17	YOLDA
38	38	TR49108481	Sürat	2025-05-17	YOLDA
39	39	TR32401446	Sürat	2025-05-20	YOLDA
40	40	TR77749077	PTT	2025-05-15	TESLIM_EDILDI
41	41	TR06010064	PTT	2025-05-20	TESLIM_EDILDI
42	42	TR26640967	Aras	2025-05-16	YOLDA
43	43	TR38908487	Aras	2025-05-19	YOLDA
44	44	TR96041085	PTT	2025-05-20	YOLDA
45	45	TR41795065	Sürat	2025-05-14	TESLIM_EDILDI
46	46	TR21747089	Aras	2025-05-14	YOLDA
47	47	TR29868517	PTT	2025-05-14	YOLDA
48	48	TR87924004	Aras	2025-05-20	TESLIM_EDILDI
49	49	TR09343810	Aras	2025-05-17	YOLDA
50	50	TR34335329	PTT	2025-05-20	TESLIM_EDILDI
51	51	TR43931449	Yurtiçi	2025-05-14	TESLIM_EDILDI
52	52	TR33994054	Aras	2025-05-20	TESLIM_EDILDI
53	53	TR76267040	PTT	2025-05-14	TESLIM_EDILDI
54	54	TR85861682	MNG	2025-05-13	TESLIM_EDILDI
55	55	TR43460908	Aras	2025-05-14	YOLDA
56	56	TR05136745	Aras	2025-05-16	YOLDA
57	57	TR92363506	Yurtiçi	2025-05-17	TESLIM_EDILDI
58	58	TR57799041	Sürat	2025-05-13	TESLIM_EDILDI
59	59	TR36657629	MNG	2025-05-17	YOLDA
60	60	TR24308768	Yurtiçi	2025-05-19	TESLIM_EDILDI
61	61	TR19824410	Sürat	2025-05-20	TESLIM_EDILDI
62	62	TR12651499	MNG	2025-05-19	TESLIM_EDILDI
63	63	TR45057222	Yurtiçi	2025-05-13	TESLIM_EDILDI
64	64	TR98084312	MNG	2025-05-20	YOLDA
65	65	TR32846709	Yurtiçi	2025-05-19	YOLDA
66	66	TR36982894	MNG	2025-05-19	YOLDA
67	67	TR35961434	Aras	2025-05-12	YOLDA
68	68	TR38260493	PTT	2025-05-14	YOLDA
69	69	TR09904079	Yurtiçi	2025-05-12	TESLIM_EDILDI
70	70	TR81469582	Sürat	2025-05-17	YOLDA
71	71	TR01844336	Sürat	2025-05-15	TESLIM_EDILDI
72	72	TR87524108	Aras	2025-05-15	TESLIM_EDILDI
73	73	TR73908555	Sürat	2025-05-19	YOLDA
74	74	TR01947839	MNG	2025-05-16	TESLIM_EDILDI
75	75	TR74612399	Yurtiçi	2025-05-16	TESLIM_EDILDI
76	76	TR71027630	PTT	2025-05-17	YOLDA
77	77	TR02639255	PTT	2025-05-13	YOLDA
78	78	TR37691675	Yurtiçi	2025-05-14	TESLIM_EDILDI
79	79	TR24311532	Yurtiçi	2025-05-12	YOLDA
80	80	TR91648377	MNG	2025-05-12	TESLIM_EDILDI
81	81	TR61898830	Yurtiçi	2025-05-12	TESLIM_EDILDI
82	82	TR93772717	Sürat	2025-05-12	TESLIM_EDILDI
83	83	TR89081573	MNG	2025-05-18	TESLIM_EDILDI
84	84	TR18059746	Yurtiçi	2025-05-20	TESLIM_EDILDI
85	85	TR23719532	Yurtiçi	2025-05-12	YOLDA
86	86	TR44426522	PTT	2025-05-20	YOLDA
87	87	TR71532499	Yurtiçi	2025-05-20	TESLIM_EDILDI
88	88	TR63490496	Aras	2025-05-12	TESLIM_EDILDI
89	89	TR96452769	Yurtiçi	2025-05-14	YOLDA
90	90	TR91738143	Aras	2025-05-18	YOLDA
91	91	TR88467562	Sürat	2025-05-17	TESLIM_EDILDI
92	92	TR64797643	PTT	2025-05-19	YOLDA
93	93	TR47997331	MNG	2025-05-12	YOLDA
94	94	TR39084141	PTT	2025-05-13	TESLIM_EDILDI
95	95	TR06186999	PTT	2025-05-16	TESLIM_EDILDI
96	96	TR52725523	PTT	2025-05-16	TESLIM_EDILDI
97	97	TR51948190	Yurtiçi	2025-05-14	YOLDA
98	98	TR17101701	Yurtiçi	2025-05-19	YOLDA
99	99	TR62416794	MNG	2025-05-16	YOLDA
100	100	TR16676424	Yurtiçi	2025-05-16	TESLIM_EDILDI
101	101	TR97838434	MNG	2025-05-20	YOLDA
102	102	TR35775447	PTT	2025-05-20	TESLIM_EDILDI
103	103	TR79829192	MNG	2025-05-14	TESLIM_EDILDI
104	104	TR06437004	Sürat	2025-05-16	YOLDA
105	105	TR92241797	Yurtiçi	2025-05-14	YOLDA
106	106	TR10056576	Aras	2025-05-14	TESLIM_EDILDI
107	107	TR44556396	Sürat	2025-05-16	TESLIM_EDILDI
108	108	TR93343056	PTT	2025-05-16	YOLDA
109	109	TR43770799	Aras	2025-05-19	YOLDA
110	110	TR47978733	PTT	2025-05-18	TESLIM_EDILDI
111	111	TR52338785	Aras	2025-05-19	TESLIM_EDILDI
112	112	TR33058835	Yurtiçi	2025-05-16	TESLIM_EDILDI
113	113	TR37965040	MNG	2025-05-14	YOLDA
114	114	TR00125486	MNG	2025-05-15	TESLIM_EDILDI
115	115	TR00230333	MNG	2025-05-17	YOLDA
116	116	TR50089350	MNG	2025-05-18	YOLDA
117	117	TR86342865	PTT	2025-05-12	YOLDA
118	118	TR17579370	MNG	2025-05-17	TESLIM_EDILDI
119	119	TR26642422	Aras	2025-05-12	YOLDA
120	120	TR36032045	Sürat	2025-05-14	TESLIM_EDILDI
121	121	TR02196229	MNG	2025-05-16	TESLIM_EDILDI
122	122	TR68466129	Yurtiçi	2025-05-17	TESLIM_EDILDI
123	123	TR72889938	Yurtiçi	2025-05-15	TESLIM_EDILDI
124	124	TR26325867	MNG	2025-05-12	TESLIM_EDILDI
125	125	TR67241902	MNG	2025-05-18	TESLIM_EDILDI
126	126	TR78016843	MNG	2025-05-20	YOLDA
127	127	TR34420991	Yurtiçi	2025-05-16	TESLIM_EDILDI
128	128	TR76559240	Yurtiçi	2025-05-18	TESLIM_EDILDI
129	129	TR73292117	Sürat	2025-05-18	YOLDA
130	130	TR55357220	MNG	2025-05-12	TESLIM_EDILDI
131	131	TR44362144	Sürat	2025-05-13	TESLIM_EDILDI
132	132	TR58097800	Sürat	2025-05-18	YOLDA
133	133	TR42495065	MNG	2025-05-12	TESLIM_EDILDI
134	134	TR28317967	MNG	2025-05-16	TESLIM_EDILDI
135	135	TR13653412	PTT	2025-05-20	YOLDA
136	136	TR98888208	Aras	2025-05-15	TESLIM_EDILDI
137	137	TR92709353	Aras	2025-05-19	TESLIM_EDILDI
138	138	TR59305130	Sürat	2025-05-12	TESLIM_EDILDI
139	139	TR26398389	Sürat	2025-05-19	YOLDA
140	140	TR20093105	Yurtiçi	2025-05-12	YOLDA
141	141	TR60301253	Aras	2025-05-14	YOLDA
142	142	TR89901590	Yurtiçi	2025-05-13	TESLIM_EDILDI
143	143	TR96608436	Sürat	2025-05-16	TESLIM_EDILDI
144	144	TR64824931	MNG	2025-05-19	YOLDA
145	145	TR76581093	PTT	2025-05-20	TESLIM_EDILDI
146	146	TR59914946	MNG	2025-05-16	TESLIM_EDILDI
147	147	TR77276269	MNG	2025-05-16	YOLDA
148	148	TR52933126	Sürat	2025-05-16	TESLIM_EDILDI
149	149	TR82119093	Aras	2025-05-13	YOLDA
150	150	TR10713572	Yurtiçi	2025-05-14	TESLIM_EDILDI
151	151	TR68984389	Sürat	2025-05-15	TESLIM_EDILDI
152	152	TR85336559	Yurtiçi	2025-05-13	TESLIM_EDILDI
153	153	TR83977504	Sürat	2025-05-20	YOLDA
154	154	TR36262159	MNG	2025-05-12	YOLDA
155	155	TR49978706	PTT	2025-05-15	YOLDA
156	156	TR32435350	Aras	2025-05-20	TESLIM_EDILDI
157	157	TR18742618	Sürat	2025-05-17	TESLIM_EDILDI
158	158	TR27857370	Aras	2025-05-16	TESLIM_EDILDI
159	159	TR79711951	Yurtiçi	2025-05-13	TESLIM_EDILDI
160	160	TR87482272	Aras	2025-05-14	TESLIM_EDILDI
161	161	TR02447084	PTT	2025-05-12	TESLIM_EDILDI
162	162	TR20198449	PTT	2025-05-16	YOLDA
163	163	TR55022850	Aras	2025-05-19	TESLIM_EDILDI
164	164	TR81906928	PTT	2025-05-14	TESLIM_EDILDI
165	165	TR31878952	MNG	2025-05-19	TESLIM_EDILDI
166	166	TR30831745	MNG	2025-05-13	YOLDA
167	167	TR55990719	PTT	2025-05-12	TESLIM_EDILDI
168	168	TR35884680	MNG	2025-05-17	TESLIM_EDILDI
169	169	TR26462668	Sürat	2025-05-17	YOLDA
170	170	TR03688965	Yurtiçi	2025-05-14	YOLDA
171	171	TR11649994	PTT	2025-05-20	TESLIM_EDILDI
172	172	TR44202305	PTT	2025-05-13	YOLDA
173	173	TR36714903	Sürat	2025-05-18	YOLDA
174	174	TR73754450	MNG	2025-05-15	YOLDA
175	175	TR53812238	PTT	2025-05-15	YOLDA
176	176	TR58027596	Sürat	2025-05-14	YOLDA
177	177	TR80931896	PTT	2025-05-13	TESLIM_EDILDI
178	178	TR11147546	Yurtiçi	2025-05-15	TESLIM_EDILDI
179	179	TR58802998	Sürat	2025-05-12	YOLDA
180	180	TR15973128	MNG	2025-05-15	TESLIM_EDILDI
181	181	TR24888168	PTT	2025-05-17	TESLIM_EDILDI
182	182	TR20330801	Yurtiçi	2025-05-19	TESLIM_EDILDI
183	183	TR52885353	PTT	2025-05-14	TESLIM_EDILDI
184	184	TR72537566	Sürat	2025-05-13	TESLIM_EDILDI
185	185	TR10439606	MNG	2025-05-19	TESLIM_EDILDI
186	186	TR75583467	Yurtiçi	2025-05-19	TESLIM_EDILDI
187	187	TR24034170	Aras	2025-05-14	TESLIM_EDILDI
188	188	TR90778579	MNG	2025-05-19	TESLIM_EDILDI
189	189	TR66445214	MNG	2025-05-20	TESLIM_EDILDI
190	190	TR20155734	PTT	2025-05-16	TESLIM_EDILDI
191	191	TR22881142	Sürat	2025-05-13	TESLIM_EDILDI
192	192	TR61477862	Yurtiçi	2025-05-15	YOLDA
193	193	TR53073438	Yurtiçi	2025-05-19	YOLDA
194	194	TR49519315	PTT	2025-05-16	YOLDA
195	195	TR71200492	Sürat	2025-05-16	YOLDA
196	196	TR57573386	Aras	2025-05-17	TESLIM_EDILDI
197	197	TR09864677	Yurtiçi	2025-05-13	YOLDA
198	198	TR87561752	PTT	2025-05-20	TESLIM_EDILDI
199	199	TR62304991	Yurtiçi	2025-05-19	TESLIM_EDILDI
200	200	TR67108247	Aras	2025-05-13	TESLIM_EDILDI
201	201	TR85000975	Yurtiçi	2025-05-16	YOLDA
202	202	TR16789421	Sürat	2025-05-18	YOLDA
203	203	TR38371789	Sürat	2025-05-13	YOLDA
204	204	TR30433185	MNG	2025-05-14	YOLDA
205	205	TR52467508	Yurtiçi	2025-05-13	TESLIM_EDILDI
206	206	TR09128946	Sürat	2025-05-15	TESLIM_EDILDI
207	207	TR24519594	Sürat	2025-05-14	TESLIM_EDILDI
208	208	TR44393965	Yurtiçi	2025-05-12	YOLDA
209	209	TR46127852	PTT	2025-05-15	YOLDA
210	210	TR24518755	PTT	2025-05-15	TESLIM_EDILDI
211	211	TR13514752	Sürat	2025-05-20	TESLIM_EDILDI
212	212	TR92519742	MNG	2025-05-20	YOLDA
213	213	TR50471456	PTT	2025-05-16	TESLIM_EDILDI
214	214	TR20189787	Yurtiçi	2025-05-16	YOLDA
215	215	TR61062524	MNG	2025-05-16	YOLDA
216	216	TR39301743	Yurtiçi	2025-05-18	YOLDA
217	217	TR52005179	Yurtiçi	2025-05-17	TESLIM_EDILDI
218	218	TR74214539	Aras	2025-05-19	YOLDA
219	219	TR28862478	Aras	2025-05-19	YOLDA
220	220	TR08658041	Yurtiçi	2025-05-15	YOLDA
221	221	TR51978257	Yurtiçi	2025-05-19	YOLDA
222	222	TR02214914	Yurtiçi	2025-05-19	YOLDA
223	223	TR07737378	Yurtiçi	2025-05-20	TESLIM_EDILDI
224	224	TR94878884	PTT	2025-05-12	TESLIM_EDILDI
225	225	TR30609932	Sürat	2025-05-18	TESLIM_EDILDI
226	226	TR70700120	Aras	2025-05-16	YOLDA
227	227	TR66602886	Aras	2025-05-14	TESLIM_EDILDI
228	228	TR95045695	Sürat	2025-05-12	YOLDA
229	229	TR98955557	MNG	2025-05-14	YOLDA
230	230	TR52308429	Aras	2025-05-13	YOLDA
231	231	TR63559184	Yurtiçi	2025-05-16	YOLDA
232	232	TR39463468	Aras	2025-05-16	YOLDA
233	233	TR36521135	Aras	2025-05-16	YOLDA
234	234	TR21193806	Aras	2025-05-16	YOLDA
235	235	TR07922818	Aras	2025-05-17	TESLIM_EDILDI
236	236	TR97538842	PTT	2025-05-14	YOLDA
237	237	TR38946142	Aras	2025-05-13	TESLIM_EDILDI
238	238	TR46240148	Yurtiçi	2025-05-17	YOLDA
239	239	TR08441052	Yurtiçi	2025-05-16	TESLIM_EDILDI
240	240	TR38363779	PTT	2025-05-17	YOLDA
241	241	TR32174721	Aras	2025-05-20	TESLIM_EDILDI
242	242	TR76974726	PTT	2025-05-16	TESLIM_EDILDI
243	243	TR29145039	Yurtiçi	2025-05-13	TESLIM_EDILDI
244	244	TR14903272	PTT	2025-05-19	TESLIM_EDILDI
245	245	TR74557761	PTT	2025-05-20	YOLDA
246	246	TR21885840	PTT	2025-05-16	YOLDA
247	247	TR11314254	MNG	2025-05-17	TESLIM_EDILDI
248	248	TR15530947	Sürat	2025-05-12	TESLIM_EDILDI
249	249	TR95269523	Aras	2025-05-15	YOLDA
250	250	TR85452752	Yurtiçi	2025-05-12	TESLIM_EDILDI
251	251	TR72295175	Sürat	2025-05-15	TESLIM_EDILDI
252	252	TR53327918	MNG	2025-05-14	YOLDA
253	253	TR94975384	Aras	2025-05-20	TESLIM_EDILDI
254	254	TR70020233	MNG	2025-05-15	YOLDA
255	255	TR12739624	Yurtiçi	2025-05-17	YOLDA
256	256	TR28051560	PTT	2025-05-12	YOLDA
257	257	TR17287673	PTT	2025-05-15	TESLIM_EDILDI
258	258	TR47589081	Aras	2025-05-12	TESLIM_EDILDI
259	259	TR84672723	Aras	2025-05-13	YOLDA
260	260	TR75929883	PTT	2025-05-19	YOLDA
261	261	TR49365720	Aras	2025-05-12	YOLDA
262	262	TR35668107	Sürat	2025-05-18	TESLIM_EDILDI
263	263	TR26472170	MNG	2025-05-16	YOLDA
264	264	TR81420131	Yurtiçi	2025-05-16	YOLDA
265	265	TR37687713	MNG	2025-05-12	TESLIM_EDILDI
266	266	TR09641840	Sürat	2025-05-15	YOLDA
267	267	TR14643318	Yurtiçi	2025-05-12	YOLDA
268	268	TR49516756	Aras	2025-05-17	YOLDA
269	269	TR48528446	MNG	2025-05-17	TESLIM_EDILDI
270	270	TR73238235	Yurtiçi	2025-05-12	TESLIM_EDILDI
271	271	TR10657322	MNG	2025-05-15	TESLIM_EDILDI
272	272	TR79877385	PTT	2025-05-20	TESLIM_EDILDI
273	273	TR81893101	Sürat	2025-05-19	YOLDA
274	274	TR37736243	PTT	2025-05-12	TESLIM_EDILDI
275	275	TR16087410	Yurtiçi	2025-05-19	YOLDA
276	276	TR84506493	Sürat	2025-05-19	TESLIM_EDILDI
277	277	TR69074858	Aras	2025-05-15	YOLDA
278	278	TR92324537	Sürat	2025-05-13	YOLDA
279	279	TR67784291	MNG	2025-05-13	YOLDA
280	280	TR83904677	PTT	2025-05-15	YOLDA
281	281	TR07088853	PTT	2025-05-19	TESLIM_EDILDI
282	282	TR68189042	Yurtiçi	2025-05-15	YOLDA
283	283	TR03515357	Aras	2025-05-14	YOLDA
284	284	TR51029054	Sürat	2025-05-19	TESLIM_EDILDI
285	285	TR12468984	MNG	2025-05-13	TESLIM_EDILDI
286	286	TR29494010	Aras	2025-05-14	YOLDA
287	287	TR00774373	PTT	2025-05-17	TESLIM_EDILDI
288	288	TR75083452	Yurtiçi	2025-05-16	YOLDA
289	289	TR95140653	Aras	2025-05-14	TESLIM_EDILDI
290	290	TR04870954	Yurtiçi	2025-05-15	TESLIM_EDILDI
291	291	TR88278900	MNG	2025-05-13	TESLIM_EDILDI
292	292	TR84179711	MNG	2025-05-19	YOLDA
293	293	TR98457915	MNG	2025-05-15	TESLIM_EDILDI
294	294	TR57818158	Yurtiçi	2025-05-12	TESLIM_EDILDI
295	295	TR56742929	MNG	2025-05-12	YOLDA
296	296	TR98232590	PTT	2025-05-15	YOLDA
297	297	TR71764674	PTT	2025-05-13	YOLDA
298	298	TR34909113	MNG	2025-05-16	TESLIM_EDILDI
299	299	TR44381486	PTT	2025-05-17	TESLIM_EDILDI
300	300	TR06326029	PTT	2025-05-20	TESLIM_EDILDI
301	301	TR40687700	Aras	2025-05-12	YOLDA
302	302	TR12864952	Aras	2025-05-17	YOLDA
303	303	TR01328013	MNG	2025-05-13	TESLIM_EDILDI
304	304	TR56720038	PTT	2025-05-17	TESLIM_EDILDI
305	305	TR21421555	Aras	2025-05-16	YOLDA
306	306	TR76363697	Sürat	2025-05-15	YOLDA
307	307	TR90063404	Sürat	2025-05-12	TESLIM_EDILDI
308	308	TR34112310	MNG	2025-05-14	YOLDA
309	309	TR82790287	Yurtiçi	2025-05-16	YOLDA
310	310	TR37140406	Yurtiçi	2025-05-14	YOLDA
311	311	TR37026519	PTT	2025-05-19	YOLDA
312	312	TR35025681	PTT	2025-05-16	TESLIM_EDILDI
313	313	TR29273761	Yurtiçi	2025-05-14	YOLDA
314	314	TR86642177	PTT	2025-05-14	TESLIM_EDILDI
315	315	TR76358137	MNG	2025-05-15	TESLIM_EDILDI
316	316	TR81617204	Yurtiçi	2025-05-13	YOLDA
317	317	TR30541923	Aras	2025-05-18	TESLIM_EDILDI
318	318	TR30321085	Yurtiçi	2025-05-20	YOLDA
319	319	TR05087534	Yurtiçi	2025-05-15	YOLDA
320	320	TR58393539	Yurtiçi	2025-05-18	YOLDA
321	321	TR03031839	PTT	2025-05-13	TESLIM_EDILDI
322	322	TR22914404	PTT	2025-05-15	TESLIM_EDILDI
323	323	TR60543559	Aras	2025-05-12	TESLIM_EDILDI
324	324	TR77255564	MNG	2025-05-18	TESLIM_EDILDI
325	325	TR68114693	Aras	2025-05-13	YOLDA
326	326	TR30026315	Sürat	2025-05-18	TESLIM_EDILDI
327	327	TR09911128	Aras	2025-05-12	TESLIM_EDILDI
328	328	TR96158283	Sürat	2025-05-17	TESLIM_EDILDI
329	329	TR60534506	Aras	2025-05-14	TESLIM_EDILDI
330	330	TR77599399	PTT	2025-05-14	YOLDA
331	331	TR23528327	Aras	2025-05-20	YOLDA
332	332	TR38046544	Yurtiçi	2025-05-18	TESLIM_EDILDI
333	333	TR74340859	Yurtiçi	2025-05-20	YOLDA
334	334	TR70417762	Aras	2025-05-18	TESLIM_EDILDI
335	335	TR91997640	MNG	2025-05-13	TESLIM_EDILDI
336	336	TR43681189	Sürat	2025-05-14	TESLIM_EDILDI
337	337	TR13801252	Sürat	2025-05-17	TESLIM_EDILDI
338	338	TR94544965	Yurtiçi	2025-05-14	TESLIM_EDILDI
339	339	TR74617901	Yurtiçi	2025-05-15	YOLDA
340	340	TR98729425	Sürat	2025-05-19	TESLIM_EDILDI
341	341	TR78548721	PTT	2025-05-12	YOLDA
342	342	TR63745378	PTT	2025-05-20	YOLDA
343	343	TR52172997	PTT	2025-05-19	YOLDA
344	344	TR80099306	Yurtiçi	2025-05-15	TESLIM_EDILDI
345	345	TR84656205	PTT	2025-05-14	YOLDA
346	346	TR60770423	Yurtiçi	2025-05-15	TESLIM_EDILDI
347	347	TR28716464	Aras	2025-05-18	YOLDA
348	348	TR25685894	Aras	2025-05-13	TESLIM_EDILDI
349	349	TR94295628	MNG	2025-05-14	TESLIM_EDILDI
350	350	TR59760315	Yurtiçi	2025-05-19	TESLIM_EDILDI
351	351	TR23657476	PTT	2025-05-16	TESLIM_EDILDI
352	352	TR82048249	Aras	2025-05-18	TESLIM_EDILDI
353	353	TR44313206	Sürat	2025-05-13	YOLDA
354	354	TR98408286	MNG	2025-05-19	YOLDA
355	355	TR18402601	MNG	2025-05-13	YOLDA
356	356	TR80175157	Sürat	2025-05-19	TESLIM_EDILDI
357	357	TR90356554	PTT	2025-05-14	TESLIM_EDILDI
358	358	TR51049706	Yurtiçi	2025-05-12	TESLIM_EDILDI
359	359	TR23887770	MNG	2025-05-17	TESLIM_EDILDI
360	360	TR69672372	PTT	2025-05-17	TESLIM_EDILDI
361	361	TR13879282	Sürat	2025-05-20	TESLIM_EDILDI
362	362	TR08745520	Yurtiçi	2025-05-19	TESLIM_EDILDI
363	363	TR60631278	Yurtiçi	2025-05-15	TESLIM_EDILDI
364	364	TR10603214	Sürat	2025-05-14	TESLIM_EDILDI
365	365	TR57363740	Yurtiçi	2025-05-15	YOLDA
366	366	TR26811646	Aras	2025-05-18	YOLDA
367	367	TR79250765	MNG	2025-05-13	YOLDA
368	368	TR79796769	PTT	2025-05-17	TESLIM_EDILDI
369	369	TR12577036	Sürat	2025-05-17	YOLDA
370	370	TR24505002	MNG	2025-05-15	YOLDA
371	371	TR05790889	Aras	2025-05-16	TESLIM_EDILDI
372	372	TR55911282	PTT	2025-05-12	YOLDA
373	373	TR71541746	Aras	2025-05-20	YOLDA
374	374	TR90349839	Aras	2025-05-17	YOLDA
375	375	TR70485352	Aras	2025-05-18	TESLIM_EDILDI
376	376	TR62026875	PTT	2025-05-12	TESLIM_EDILDI
377	377	TR20363568	PTT	2025-05-13	TESLIM_EDILDI
378	378	TR47217338	Aras	2025-05-13	YOLDA
379	379	TR84850514	Yurtiçi	2025-05-20	TESLIM_EDILDI
380	380	TR63574597	MNG	2025-05-12	TESLIM_EDILDI
381	381	TR25718590	Sürat	2025-05-16	YOLDA
382	382	TR68184445	Yurtiçi	2025-05-16	TESLIM_EDILDI
383	383	TR00086370	PTT	2025-05-15	YOLDA
384	384	TR44312228	Sürat	2025-05-20	TESLIM_EDILDI
385	385	TR52484611	Sürat	2025-05-18	YOLDA
386	386	TR25697079	Yurtiçi	2025-05-20	TESLIM_EDILDI
387	387	TR04047123	PTT	2025-05-19	YOLDA
388	388	TR70397016	PTT	2025-05-19	YOLDA
389	389	TR58794607	MNG	2025-05-16	TESLIM_EDILDI
390	390	TR00847399	Sürat	2025-05-17	TESLIM_EDILDI
391	391	TR23786928	MNG	2025-05-13	TESLIM_EDILDI
392	392	TR50995431	Sürat	2025-05-14	YOLDA
393	393	TR17265273	PTT	2025-05-13	TESLIM_EDILDI
394	394	TR87346924	PTT	2025-05-15	YOLDA
395	395	TR14697687	PTT	2025-05-15	TESLIM_EDILDI
396	396	TR92231829	Yurtiçi	2025-05-15	YOLDA
397	397	TR57608103	Aras	2025-05-12	YOLDA
398	398	TR62326769	Yurtiçi	2025-05-17	TESLIM_EDILDI
399	399	TR67299631	MNG	2025-05-20	TESLIM_EDILDI
400	400	TR06867775	Yurtiçi	2025-05-16	TESLIM_EDILDI
401	401	TR91673734	Aras	2025-05-14	TESLIM_EDILDI
402	402	TR61548162	PTT	2025-05-13	YOLDA
403	403	TR02896157	PTT	2025-05-20	TESLIM_EDILDI
404	404	TR67580575	PTT	2025-05-18	YOLDA
405	405	TR75139998	Aras	2025-05-18	TESLIM_EDILDI
406	406	TR94694586	PTT	2025-05-17	YOLDA
407	407	TR83316486	Aras	2025-05-12	YOLDA
408	408	TR32457880	Sürat	2025-05-16	YOLDA
409	409	TR99571826	Aras	2025-05-14	TESLIM_EDILDI
410	410	TR35229314	PTT	2025-05-19	TESLIM_EDILDI
411	411	TR98669012	MNG	2025-05-18	TESLIM_EDILDI
412	412	TR81562941	Aras	2025-05-14	YOLDA
413	413	TR80993312	MNG	2025-05-19	TESLIM_EDILDI
414	414	TR24866361	Yurtiçi	2025-05-20	TESLIM_EDILDI
415	415	TR41131730	Sürat	2025-05-17	YOLDA
416	416	TR26778300	MNG	2025-05-20	YOLDA
417	417	TR53841727	Sürat	2025-05-14	YOLDA
418	418	TR44071361	PTT	2025-05-17	TESLIM_EDILDI
419	419	TR07968697	PTT	2025-05-14	TESLIM_EDILDI
420	420	TR99261682	Sürat	2025-05-16	YOLDA
421	421	TR94731780	Yurtiçi	2025-05-20	TESLIM_EDILDI
422	422	TR38109505	Aras	2025-05-17	YOLDA
423	423	TR17929811	Yurtiçi	2025-05-15	TESLIM_EDILDI
424	424	TR55825359	Aras	2025-05-17	TESLIM_EDILDI
425	425	TR90915967	PTT	2025-05-14	YOLDA
426	426	TR07364121	Aras	2025-05-19	YOLDA
427	427	TR10243533	MNG	2025-05-15	YOLDA
428	428	TR99270497	Yurtiçi	2025-05-14	YOLDA
429	429	TR13399683	Yurtiçi	2025-05-19	TESLIM_EDILDI
430	430	TR64362947	Yurtiçi	2025-05-16	TESLIM_EDILDI
431	431	TR08324563	MNG	2025-05-19	TESLIM_EDILDI
432	432	TR43405672	PTT	2025-05-15	YOLDA
433	433	TR71262273	PTT	2025-05-18	TESLIM_EDILDI
434	434	TR70820336	Sürat	2025-05-16	TESLIM_EDILDI
435	435	TR72237026	Aras	2025-05-12	TESLIM_EDILDI
436	436	TR61796853	Yurtiçi	2025-05-16	YOLDA
437	437	TR17790648	Sürat	2025-05-12	YOLDA
438	438	TR87001196	Yurtiçi	2025-05-18	YOLDA
439	439	TR11630122	Yurtiçi	2025-05-19	YOLDA
440	440	TR81403026	Sürat	2025-05-12	YOLDA
441	441	TR94803698	MNG	2025-05-16	TESLIM_EDILDI
442	442	TR07255929	MNG	2025-05-15	YOLDA
443	443	TR54329003	PTT	2025-05-18	YOLDA
444	444	TR98308227	PTT	2025-05-19	TESLIM_EDILDI
445	445	TR73999453	MNG	2025-05-17	TESLIM_EDILDI
446	446	TR85437089	MNG	2025-05-12	YOLDA
447	447	TR27752020	Yurtiçi	2025-05-14	YOLDA
448	448	TR16042451	Aras	2025-05-15	TESLIM_EDILDI
449	449	TR37236054	Sürat	2025-05-16	TESLIM_EDILDI
450	450	TR56592951	Sürat	2025-05-16	TESLIM_EDILDI
451	451	TR55417458	Yurtiçi	2025-05-15	YOLDA
452	452	TR73024326	Sürat	2025-05-16	TESLIM_EDILDI
453	453	TR13741248	Sürat	2025-05-18	TESLIM_EDILDI
454	454	TR53408651	MNG	2025-05-20	TESLIM_EDILDI
455	455	TR69709919	Yurtiçi	2025-05-17	TESLIM_EDILDI
456	456	TR80944724	PTT	2025-05-19	TESLIM_EDILDI
457	457	TR45312231	Yurtiçi	2025-05-16	YOLDA
458	458	TR39729205	Sürat	2025-05-18	TESLIM_EDILDI
459	459	TR29527755	Sürat	2025-05-15	TESLIM_EDILDI
460	460	TR17456400	Aras	2025-05-13	YOLDA
461	461	TR52950035	Yurtiçi	2025-05-15	TESLIM_EDILDI
462	462	TR34202149	Sürat	2025-05-13	YOLDA
463	463	TR06309944	Yurtiçi	2025-05-19	YOLDA
464	464	TR82892227	Yurtiçi	2025-05-12	TESLIM_EDILDI
465	465	TR71522086	MNG	2025-05-13	TESLIM_EDILDI
466	466	TR14448482	PTT	2025-05-19	YOLDA
467	467	TR75305562	Sürat	2025-05-20	YOLDA
468	468	TR44067425	Sürat	2025-05-20	YOLDA
469	469	TR81503851	MNG	2025-05-15	YOLDA
470	470	TR53767551	MNG	2025-05-13	TESLIM_EDILDI
471	471	TR89019096	MNG	2025-05-16	YOLDA
472	472	TR38525981	PTT	2025-05-13	YOLDA
473	473	TR18213685	Aras	2025-05-20	TESLIM_EDILDI
474	474	TR62226640	PTT	2025-05-19	TESLIM_EDILDI
475	475	TR82450122	Aras	2025-05-14	YOLDA
476	476	TR17774063	PTT	2025-05-14	TESLIM_EDILDI
477	477	TR93526105	MNG	2025-05-20	YOLDA
478	478	TR99201066	PTT	2025-05-17	TESLIM_EDILDI
479	479	TR34694051	Aras	2025-05-16	TESLIM_EDILDI
480	480	TR31658861	Sürat	2025-05-17	TESLIM_EDILDI
481	481	TR68291461	PTT	2025-05-19	TESLIM_EDILDI
482	482	TR91448977	MNG	2025-05-14	TESLIM_EDILDI
483	483	TR91563423	PTT	2025-05-18	TESLIM_EDILDI
484	484	TR03301147	Aras	2025-05-12	YOLDA
485	485	TR18770280	Yurtiçi	2025-05-18	TESLIM_EDILDI
486	486	TR86479974	Sürat	2025-05-14	TESLIM_EDILDI
487	487	TR84700808	MNG	2025-05-14	TESLIM_EDILDI
488	488	TR74406613	Sürat	2025-05-14	YOLDA
489	489	TR28536352	Sürat	2025-05-20	TESLIM_EDILDI
490	490	TR04573925	MNG	2025-05-12	TESLIM_EDILDI
491	491	TR00395673	PTT	2025-05-12	YOLDA
492	492	TR91298157	Aras	2025-05-18	YOLDA
493	493	TR01743755	Yurtiçi	2025-05-13	YOLDA
494	494	TR31654924	Aras	2025-05-14	YOLDA
495	495	TR85097939	Yurtiçi	2025-05-15	TESLIM_EDILDI
496	496	TR16039814	Sürat	2025-05-17	YOLDA
497	497	TR07647160	Sürat	2025-05-18	TESLIM_EDILDI
498	498	TR03859748	Yurtiçi	2025-05-16	TESLIM_EDILDI
499	499	TR10917589	Aras	2025-05-18	YOLDA
500	500	TR19054046	PTT	2025-05-19	YOLDA
501	501	TR61003566	Sürat	2025-05-12	TESLIM_EDILDI
502	502	TR23674752	MNG	2025-05-17	YOLDA
503	503	TR98602840	Sürat	2025-05-14	YOLDA
504	504	TR17061304	PTT	2025-05-18	TESLIM_EDILDI
505	505	TR47223255	Sürat	2025-05-18	TESLIM_EDILDI
506	506	TR93277267	Sürat	2025-05-18	YOLDA
507	507	TR98092901	Yurtiçi	2025-05-18	TESLIM_EDILDI
508	508	TR44567616	Sürat	2025-05-20	TESLIM_EDILDI
509	509	TR00788687	Aras	2025-05-15	TESLIM_EDILDI
510	510	TR49764369	Aras	2025-05-20	TESLIM_EDILDI
511	511	TR37775052	Aras	2025-05-19	TESLIM_EDILDI
512	512	TR36425639	Yurtiçi	2025-05-15	TESLIM_EDILDI
513	513	TR46536619	Sürat	2025-05-12	TESLIM_EDILDI
514	514	TR06162778	Aras	2025-05-17	YOLDA
515	515	TR06469838	PTT	2025-05-17	YOLDA
516	516	TR96786523	MNG	2025-05-14	YOLDA
517	517	TR05224072	Aras	2025-05-20	TESLIM_EDILDI
518	518	TR17565149	PTT	2025-05-13	TESLIM_EDILDI
519	519	TR45726406	PTT	2025-05-13	YOLDA
520	520	TR91256501	Sürat	2025-05-15	TESLIM_EDILDI
521	521	TR51007605	MNG	2025-05-17	TESLIM_EDILDI
522	522	TR06452380	Yurtiçi	2025-05-14	YOLDA
523	523	TR38877841	Aras	2025-05-17	YOLDA
524	524	TR10767696	Yurtiçi	2025-05-15	TESLIM_EDILDI
525	525	TR01995007	MNG	2025-05-12	TESLIM_EDILDI
526	526	TR87383761	Aras	2025-05-13	TESLIM_EDILDI
527	527	TR78201868	PTT	2025-05-15	YOLDA
528	528	TR58463478	PTT	2025-05-17	TESLIM_EDILDI
529	529	TR33842760	Sürat	2025-05-12	TESLIM_EDILDI
530	530	TR57507421	Yurtiçi	2025-05-13	YOLDA
531	531	TR88336600	Yurtiçi	2025-05-14	TESLIM_EDILDI
532	532	TR86077283	MNG	2025-05-14	YOLDA
533	533	TR80991036	Sürat	2025-05-12	YOLDA
534	534	TR70527870	Sürat	2025-05-15	YOLDA
535	535	TR98600646	PTT	2025-05-16	YOLDA
536	536	TR21456156	MNG	2025-05-16	YOLDA
537	537	TR24714324	Sürat	2025-05-19	TESLIM_EDILDI
538	538	TR30132930	Sürat	2025-05-13	TESLIM_EDILDI
539	539	TR20383194	Aras	2025-05-13	TESLIM_EDILDI
540	540	TR53842998	MNG	2025-05-15	TESLIM_EDILDI
541	541	TR38636172	Aras	2025-05-14	TESLIM_EDILDI
542	542	TR21292710	MNG	2025-05-13	YOLDA
543	543	TR84672399	Yurtiçi	2025-05-20	TESLIM_EDILDI
544	544	TR86494941	Aras	2025-05-15	TESLIM_EDILDI
545	545	TR01237555	MNG	2025-05-15	TESLIM_EDILDI
546	546	TR27355880	Aras	2025-05-19	YOLDA
547	547	TR64784319	PTT	2025-05-19	YOLDA
548	548	TR99885317	Aras	2025-05-17	YOLDA
549	549	TR33681261	Sürat	2025-05-19	YOLDA
550	550	TR15647836	Aras	2025-05-18	TESLIM_EDILDI
551	551	TR09045549	Aras	2025-05-14	TESLIM_EDILDI
552	552	TR99583072	MNG	2025-05-16	YOLDA
553	553	TR36882497	PTT	2025-05-17	YOLDA
554	554	TR40989077	MNG	2025-05-17	YOLDA
555	555	TR95432445	MNG	2025-05-20	YOLDA
556	556	TR06537094	Yurtiçi	2025-05-16	YOLDA
557	557	TR46722645	PTT	2025-05-16	TESLIM_EDILDI
558	558	TR56030767	Yurtiçi	2025-05-20	TESLIM_EDILDI
559	559	TR18819651	Aras	2025-05-20	TESLIM_EDILDI
560	560	TR03382544	Yurtiçi	2025-05-17	YOLDA
561	561	TR99300264	Yurtiçi	2025-05-18	YOLDA
562	562	TR78755056	Aras	2025-05-15	YOLDA
563	563	TR09271120	MNG	2025-05-14	TESLIM_EDILDI
564	564	TR62587943	Yurtiçi	2025-05-18	YOLDA
565	565	TR22313463	PTT	2025-05-15	YOLDA
566	566	TR46216756	MNG	2025-05-13	YOLDA
567	567	TR74257150	Sürat	2025-05-13	TESLIM_EDILDI
568	568	TR14736244	Aras	2025-05-16	TESLIM_EDILDI
569	569	TR09198244	Sürat	2025-05-19	TESLIM_EDILDI
570	570	TR76740771	PTT	2025-05-13	YOLDA
571	571	TR34148307	Yurtiçi	2025-05-16	TESLIM_EDILDI
572	572	TR99651346	Aras	2025-05-14	TESLIM_EDILDI
573	573	TR88679190	Sürat	2025-05-16	YOLDA
574	574	TR67916995	Aras	2025-05-13	TESLIM_EDILDI
575	575	TR86356049	MNG	2025-05-14	YOLDA
576	576	TR88690795	PTT	2025-05-12	YOLDA
577	577	TR36555104	Yurtiçi	2025-05-18	TESLIM_EDILDI
578	578	TR54981670	Yurtiçi	2025-05-17	TESLIM_EDILDI
579	579	TR43705013	PTT	2025-05-18	YOLDA
580	580	TR02592568	Aras	2025-05-20	YOLDA
581	581	TR70987103	MNG	2025-05-13	TESLIM_EDILDI
582	582	TR69353286	Sürat	2025-05-14	YOLDA
583	583	TR82495099	PTT	2025-05-18	YOLDA
584	584	TR81774096	Yurtiçi	2025-05-17	TESLIM_EDILDI
585	585	TR47994980	PTT	2025-05-20	TESLIM_EDILDI
586	586	TR29300784	Aras	2025-05-16	TESLIM_EDILDI
587	587	TR36689430	Yurtiçi	2025-05-17	TESLIM_EDILDI
588	588	TR06839656	Yurtiçi	2025-05-14	YOLDA
589	589	TR63932305	Sürat	2025-05-12	YOLDA
590	590	TR80707534	Aras	2025-05-14	YOLDA
591	591	TR39942703	Aras	2025-05-18	YOLDA
592	592	TR01198302	PTT	2025-05-15	YOLDA
593	593	TR06101053	Sürat	2025-05-20	TESLIM_EDILDI
594	594	TR63935372	MNG	2025-05-15	TESLIM_EDILDI
595	595	TR85698947	Sürat	2025-05-15	YOLDA
596	596	TR84806278	MNG	2025-05-13	TESLIM_EDILDI
597	597	TR16868711	Sürat	2025-05-17	YOLDA
598	598	TR73934713	Aras	2025-05-14	TESLIM_EDILDI
599	599	TR69578804	MNG	2025-05-19	TESLIM_EDILDI
600	600	TR30026980	Yurtiçi	2025-05-18	TESLIM_EDILDI
601	601	TR53088538	Aras	2025-05-17	YOLDA
602	602	TR91941208	Aras	2025-05-16	TESLIM_EDILDI
603	603	TR42069614	Sürat	2025-05-19	YOLDA
604	604	TR26457484	Yurtiçi	2025-05-12	TESLIM_EDILDI
605	605	TR96055021	PTT	2025-05-14	TESLIM_EDILDI
606	606	TR76322861	Sürat	2025-05-14	TESLIM_EDILDI
607	607	TR20764751	PTT	2025-05-14	TESLIM_EDILDI
608	608	TR19301244	MNG	2025-05-19	TESLIM_EDILDI
609	609	TR05626755	Yurtiçi	2025-05-14	YOLDA
610	610	TR81796627	Aras	2025-05-16	TESLIM_EDILDI
611	611	TR26864814	Aras	2025-05-20	YOLDA
612	612	TR86516666	Aras	2025-05-15	YOLDA
613	613	TR42231825	MNG	2025-05-20	YOLDA
614	614	TR11942693	PTT	2025-05-14	YOLDA
615	615	TR67266467	Yurtiçi	2025-05-19	YOLDA
616	616	TR83598694	PTT	2025-05-12	TESLIM_EDILDI
617	617	TR71329419	PTT	2025-05-15	YOLDA
618	618	TR04223593	PTT	2025-05-14	YOLDA
619	619	TR19857778	Sürat	2025-05-16	YOLDA
620	620	TR91552331	PTT	2025-05-20	TESLIM_EDILDI
621	621	TR04455527	Yurtiçi	2025-05-18	TESLIM_EDILDI
622	622	TR72927142	Yurtiçi	2025-05-13	YOLDA
623	623	TR72982058	Yurtiçi	2025-05-16	YOLDA
624	624	TR05886945	Aras	2025-05-16	YOLDA
625	625	TR99468451	Sürat	2025-05-20	TESLIM_EDILDI
626	626	TR89313579	PTT	2025-05-17	TESLIM_EDILDI
627	627	TR89454403	PTT	2025-05-19	YOLDA
628	628	TR81048461	Yurtiçi	2025-05-17	TESLIM_EDILDI
629	629	TR88729846	Sürat	2025-05-12	TESLIM_EDILDI
630	630	TR55867024	Aras	2025-05-18	TESLIM_EDILDI
631	631	TR80397768	MNG	2025-05-13	YOLDA
632	632	TR24822762	Yurtiçi	2025-05-14	TESLIM_EDILDI
633	633	TR47342330	Yurtiçi	2025-05-20	TESLIM_EDILDI
634	634	TR53467915	Aras	2025-05-13	YOLDA
635	635	TR88350792	Aras	2025-05-14	TESLIM_EDILDI
636	636	TR42020141	Sürat	2025-05-15	TESLIM_EDILDI
637	637	TR59724457	Sürat	2025-05-14	TESLIM_EDILDI
638	638	TR25503792	MNG	2025-05-14	TESLIM_EDILDI
639	639	TR69007920	MNG	2025-05-15	TESLIM_EDILDI
640	640	TR40711092	Sürat	2025-05-19	TESLIM_EDILDI
641	641	TR86086060	PTT	2025-05-19	TESLIM_EDILDI
642	642	TR83814717	Aras	2025-05-14	YOLDA
643	643	TR71975896	Sürat	2025-05-18	YOLDA
644	644	TR51023026	MNG	2025-05-19	TESLIM_EDILDI
645	645	TR95393253	PTT	2025-05-18	TESLIM_EDILDI
646	646	TR69131924	PTT	2025-05-20	TESLIM_EDILDI
647	647	TR73804341	Aras	2025-05-16	YOLDA
648	648	TR31778764	Sürat	2025-05-20	YOLDA
649	649	TR74542675	Aras	2025-05-20	TESLIM_EDILDI
650	650	TR38310005	Aras	2025-05-18	TESLIM_EDILDI
651	651	TR63039868	MNG	2025-05-18	YOLDA
652	652	TR75569466	Aras	2025-05-12	TESLIM_EDILDI
653	653	TR67155694	Sürat	2025-05-15	TESLIM_EDILDI
654	654	TR96169322	MNG	2025-05-20	YOLDA
655	655	TR49872012	PTT	2025-05-17	YOLDA
656	656	TR63387814	PTT	2025-05-12	YOLDA
657	657	TR16320544	MNG	2025-05-19	TESLIM_EDILDI
658	658	TR23877328	MNG	2025-05-15	TESLIM_EDILDI
659	659	TR77471373	Aras	2025-05-18	YOLDA
660	660	TR69910107	MNG	2025-05-19	TESLIM_EDILDI
661	661	TR98056395	PTT	2025-05-12	YOLDA
662	662	TR21077348	Sürat	2025-05-19	TESLIM_EDILDI
663	663	TR48485785	MNG	2025-05-14	TESLIM_EDILDI
664	664	TR56548246	Sürat	2025-05-20	TESLIM_EDILDI
665	665	TR07408938	MNG	2025-05-16	TESLIM_EDILDI
666	666	TR52223152	PTT	2025-05-19	TESLIM_EDILDI
667	667	TR88472972	MNG	2025-05-13	TESLIM_EDILDI
668	668	TR01021539	Yurtiçi	2025-05-16	TESLIM_EDILDI
669	669	TR95817647	MNG	2025-05-20	YOLDA
670	670	TR93610546	Yurtiçi	2025-05-14	YOLDA
671	671	TR55011214	PTT	2025-05-20	YOLDA
672	672	TR26201400	Yurtiçi	2025-05-16	YOLDA
673	673	TR12013491	PTT	2025-05-13	YOLDA
674	674	TR16365379	PTT	2025-05-12	TESLIM_EDILDI
675	675	TR36776553	Aras	2025-05-18	TESLIM_EDILDI
676	676	TR35000869	PTT	2025-05-16	YOLDA
677	677	TR58342228	MNG	2025-05-16	YOLDA
678	678	TR44485380	MNG	2025-05-19	YOLDA
679	679	TR12530778	Sürat	2025-05-16	YOLDA
680	680	TR82182247	Yurtiçi	2025-05-20	YOLDA
681	681	TR55719610	Yurtiçi	2025-05-17	TESLIM_EDILDI
682	682	TR29474593	Sürat	2025-05-15	TESLIM_EDILDI
683	683	TR19527934	Yurtiçi	2025-05-12	YOLDA
684	684	TR73639697	MNG	2025-05-18	YOLDA
685	685	TR86072200	PTT	2025-05-20	TESLIM_EDILDI
686	686	TR35943614	Aras	2025-05-14	TESLIM_EDILDI
687	687	TR84353122	PTT	2025-05-17	YOLDA
688	688	TR55510902	Yurtiçi	2025-05-20	TESLIM_EDILDI
689	689	TR21523279	Sürat	2025-05-19	TESLIM_EDILDI
690	690	TR95514912	Aras	2025-05-14	TESLIM_EDILDI
691	691	TR60709858	Aras	2025-05-12	YOLDA
692	692	TR95266203	MNG	2025-05-15	YOLDA
693	693	TR48057764	Aras	2025-05-19	YOLDA
694	694	TR92885391	MNG	2025-05-18	YOLDA
695	695	TR68651883	Aras	2025-05-16	TESLIM_EDILDI
696	696	TR11553846	Aras	2025-05-13	TESLIM_EDILDI
697	697	TR25732184	Aras	2025-05-20	TESLIM_EDILDI
698	698	TR28246646	Aras	2025-05-17	TESLIM_EDILDI
699	699	TR09777123	Yurtiçi	2025-05-15	YOLDA
700	700	TR68934671	MNG	2025-05-17	TESLIM_EDILDI
701	701	TR43831868	PTT	2025-05-13	TESLIM_EDILDI
702	702	TR97821156	Sürat	2025-05-13	TESLIM_EDILDI
703	703	TR62060587	Aras	2025-05-15	YOLDA
704	704	TR78495538	PTT	2025-05-17	TESLIM_EDILDI
705	705	TR76152804	Sürat	2025-05-20	TESLIM_EDILDI
706	706	TR53295678	Sürat	2025-05-14	TESLIM_EDILDI
707	707	TR09851220	MNG	2025-05-14	YOLDA
708	708	TR00469841	MNG	2025-05-19	YOLDA
709	709	TR60816467	MNG	2025-05-20	YOLDA
710	710	TR71796780	MNG	2025-05-17	YOLDA
711	711	TR51904820	Sürat	2025-05-16	YOLDA
712	712	TR78552703	Aras	2025-05-16	YOLDA
713	713	TR05706908	Sürat	2025-05-20	YOLDA
714	714	TR43362577	Aras	2025-05-16	TESLIM_EDILDI
715	715	TR75902643	Aras	2025-05-20	YOLDA
716	716	TR53435238	MNG	2025-05-17	TESLIM_EDILDI
717	717	TR71893352	PTT	2025-05-15	TESLIM_EDILDI
718	718	TR86603297	Yurtiçi	2025-05-17	TESLIM_EDILDI
719	719	TR55327153	Yurtiçi	2025-05-13	YOLDA
720	720	TR45723804	MNG	2025-05-18	TESLIM_EDILDI
721	721	TR42507239	Aras	2025-05-17	YOLDA
722	722	TR23640500	Aras	2025-05-18	TESLIM_EDILDI
723	723	TR50701331	MNG	2025-05-14	YOLDA
724	724	TR36589088	Yurtiçi	2025-05-13	TESLIM_EDILDI
725	725	TR58647477	Aras	2025-05-19	TESLIM_EDILDI
726	726	TR71681409	PTT	2025-05-12	YOLDA
727	727	TR65244141	MNG	2025-05-14	YOLDA
728	728	TR14690560	Sürat	2025-05-18	TESLIM_EDILDI
729	729	TR95484605	PTT	2025-05-14	TESLIM_EDILDI
730	730	TR49334263	PTT	2025-05-14	TESLIM_EDILDI
731	731	TR45936734	Yurtiçi	2025-05-14	YOLDA
732	732	TR39310137	Sürat	2025-05-12	YOLDA
733	733	TR88083803	Aras	2025-05-14	TESLIM_EDILDI
734	734	TR59379949	Aras	2025-05-16	TESLIM_EDILDI
735	735	TR84337092	Aras	2025-05-18	TESLIM_EDILDI
736	736	TR31204548	PTT	2025-05-17	TESLIM_EDILDI
737	737	TR45252564	MNG	2025-05-13	YOLDA
738	738	TR98373174	Yurtiçi	2025-05-14	TESLIM_EDILDI
739	739	TR62543418	Aras	2025-05-13	TESLIM_EDILDI
740	740	TR76026662	MNG	2025-05-16	YOLDA
741	741	TR90263530	Yurtiçi	2025-05-14	YOLDA
742	742	TR48222224	Yurtiçi	2025-05-18	YOLDA
743	743	TR03726143	PTT	2025-05-20	YOLDA
744	744	TR28257586	Yurtiçi	2025-05-20	YOLDA
745	745	TR93498835	PTT	2025-05-12	YOLDA
746	746	TR16210777	Yurtiçi	2025-05-16	YOLDA
747	747	TR60984024	MNG	2025-05-14	TESLIM_EDILDI
748	748	TR57846371	Sürat	2025-05-20	TESLIM_EDILDI
749	749	TR80223343	Yurtiçi	2025-05-20	YOLDA
750	750	TR13590289	MNG	2025-05-16	TESLIM_EDILDI
751	751	TR22518375	PTT	2025-05-16	TESLIM_EDILDI
752	752	TR60505775	Yurtiçi	2025-05-12	YOLDA
753	753	TR11810367	MNG	2025-05-20	TESLIM_EDILDI
754	754	TR91055083	Aras	2025-05-16	YOLDA
755	755	TR41837418	Aras	2025-05-16	TESLIM_EDILDI
756	756	TR41109166	Aras	2025-05-15	TESLIM_EDILDI
757	757	TR07720245	Sürat	2025-05-20	YOLDA
758	758	TR57458857	Sürat	2025-05-12	TESLIM_EDILDI
759	759	TR05028878	PTT	2025-05-19	YOLDA
760	760	TR15516056	Sürat	2025-05-20	YOLDA
761	761	TR88169687	Aras	2025-05-12	YOLDA
762	762	TR01682609	PTT	2025-05-20	YOLDA
763	763	TR58112364	MNG	2025-05-18	YOLDA
764	764	TR57162904	Sürat	2025-05-12	YOLDA
765	765	TR81918698	PTT	2025-05-13	TESLIM_EDILDI
766	766	TR69200948	Sürat	2025-05-15	TESLIM_EDILDI
767	767	TR57455397	Aras	2025-05-20	TESLIM_EDILDI
768	768	TR60822305	PTT	2025-05-17	TESLIM_EDILDI
769	769	TR94744610	MNG	2025-05-19	TESLIM_EDILDI
770	770	TR42852015	PTT	2025-05-15	YOLDA
771	771	TR48280741	Aras	2025-05-19	YOLDA
772	772	TR38213494	Sürat	2025-05-17	TESLIM_EDILDI
773	773	TR13579005	Yurtiçi	2025-05-18	TESLIM_EDILDI
774	774	TR89014745	MNG	2025-05-12	TESLIM_EDILDI
775	775	TR38917175	Sürat	2025-05-19	YOLDA
776	776	TR13491531	Sürat	2025-05-15	YOLDA
777	777	TR60919739	Sürat	2025-05-14	TESLIM_EDILDI
778	778	TR48484734	Yurtiçi	2025-05-14	YOLDA
779	779	TR17556431	Aras	2025-05-14	YOLDA
780	780	TR08349220	PTT	2025-05-16	TESLIM_EDILDI
781	781	TR58148798	Sürat	2025-05-16	YOLDA
782	782	TR02954237	Sürat	2025-05-19	TESLIM_EDILDI
783	783	TR26008690	MNG	2025-05-15	YOLDA
784	784	TR60828478	Yurtiçi	2025-05-14	YOLDA
785	785	TR66802407	MNG	2025-05-13	TESLIM_EDILDI
786	786	TR25452626	PTT	2025-05-13	TESLIM_EDILDI
787	787	TR08985810	Aras	2025-05-18	TESLIM_EDILDI
788	788	TR98929323	Yurtiçi	2025-05-19	YOLDA
789	789	TR88249482	Yurtiçi	2025-05-20	YOLDA
790	790	TR08726344	Yurtiçi	2025-05-17	TESLIM_EDILDI
791	791	TR30833772	MNG	2025-05-19	TESLIM_EDILDI
792	792	TR33098665	MNG	2025-05-19	TESLIM_EDILDI
793	793	TR14920615	MNG	2025-05-18	YOLDA
794	794	TR56855171	PTT	2025-05-19	TESLIM_EDILDI
795	795	TR07867436	Yurtiçi	2025-05-18	TESLIM_EDILDI
796	796	TR16108010	MNG	2025-05-18	TESLIM_EDILDI
797	797	TR53897034	Aras	2025-05-19	TESLIM_EDILDI
798	798	TR15186421	Yurtiçi	2025-05-20	TESLIM_EDILDI
799	799	TR36435432	PTT	2025-05-19	YOLDA
800	800	TR83047820	Aras	2025-05-15	YOLDA
801	801	TR32236880	Aras	2025-05-20	YOLDA
802	802	TR45496087	MNG	2025-05-15	YOLDA
803	803	TR08643931	MNG	2025-05-13	YOLDA
804	804	TR37762462	PTT	2025-05-16	TESLIM_EDILDI
805	805	TR95647865	MNG	2025-05-14	TESLIM_EDILDI
806	806	TR68857009	Aras	2025-05-12	YOLDA
807	807	TR54667172	MNG	2025-05-15	YOLDA
808	808	TR03564202	Sürat	2025-05-14	YOLDA
809	809	TR04906462	PTT	2025-05-12	TESLIM_EDILDI
810	810	TR15422684	Sürat	2025-05-18	TESLIM_EDILDI
811	811	TR75993845	MNG	2025-05-13	TESLIM_EDILDI
812	812	TR92659815	PTT	2025-05-17	YOLDA
813	813	TR83764953	MNG	2025-05-17	YOLDA
814	814	TR54403400	MNG	2025-05-17	TESLIM_EDILDI
815	815	TR67567825	PTT	2025-05-13	TESLIM_EDILDI
816	816	TR21231624	MNG	2025-05-16	YOLDA
817	817	TR18895806	MNG	2025-05-19	YOLDA
818	818	TR52985654	PTT	2025-05-17	TESLIM_EDILDI
819	819	TR80565284	MNG	2025-05-19	YOLDA
820	820	TR02966852	Aras	2025-05-19	YOLDA
821	821	TR12883479	MNG	2025-05-15	YOLDA
822	822	TR49253626	PTT	2025-05-18	YOLDA
823	823	TR98045245	PTT	2025-05-13	TESLIM_EDILDI
824	824	TR12384008	PTT	2025-05-15	YOLDA
825	825	TR67050144	Aras	2025-05-17	TESLIM_EDILDI
826	826	TR00183522	Sürat	2025-05-16	TESLIM_EDILDI
827	827	TR00480425	MNG	2025-05-19	TESLIM_EDILDI
828	828	TR20013499	MNG	2025-05-15	TESLIM_EDILDI
829	829	TR17746532	Yurtiçi	2025-05-14	YOLDA
830	830	TR53856578	Sürat	2025-05-20	TESLIM_EDILDI
831	831	TR75375971	Yurtiçi	2025-05-14	YOLDA
832	832	TR72030501	MNG	2025-05-14	YOLDA
833	833	TR34347302	MNG	2025-05-19	YOLDA
834	834	TR73444965	MNG	2025-05-19	TESLIM_EDILDI
835	835	TR14893791	MNG	2025-05-16	TESLIM_EDILDI
836	836	TR33339090	Aras	2025-05-15	TESLIM_EDILDI
837	837	TR10576370	Yurtiçi	2025-05-15	YOLDA
838	838	TR61632254	Aras	2025-05-19	TESLIM_EDILDI
839	839	TR37979619	Sürat	2025-05-13	TESLIM_EDILDI
840	840	TR28983960	Aras	2025-05-14	TESLIM_EDILDI
841	841	TR47381521	Yurtiçi	2025-05-15	TESLIM_EDILDI
842	842	TR71035349	PTT	2025-05-16	YOLDA
843	843	TR58877361	PTT	2025-05-18	YOLDA
844	844	TR95529791	MNG	2025-05-13	YOLDA
845	845	TR00725230	PTT	2025-05-17	TESLIM_EDILDI
846	846	TR34119611	PTT	2025-05-20	YOLDA
847	847	TR05077693	Sürat	2025-05-17	YOLDA
848	848	TR84983896	PTT	2025-05-14	YOLDA
849	849	TR11308305	MNG	2025-05-14	YOLDA
850	850	TR85335195	PTT	2025-05-20	TESLIM_EDILDI
851	851	TR41740534	PTT	2025-05-17	TESLIM_EDILDI
852	852	TR89638882	Aras	2025-05-19	YOLDA
853	853	TR29935581	PTT	2025-05-13	YOLDA
854	854	TR05900709	Sürat	2025-05-17	TESLIM_EDILDI
855	855	TR98845202	Aras	2025-05-15	YOLDA
856	856	TR70928409	Sürat	2025-05-13	YOLDA
857	857	TR66536445	Yurtiçi	2025-05-15	TESLIM_EDILDI
858	858	TR07668453	MNG	2025-05-18	TESLIM_EDILDI
859	859	TR91619418	PTT	2025-05-17	TESLIM_EDILDI
860	860	TR84191554	Yurtiçi	2025-05-12	TESLIM_EDILDI
861	861	TR44494078	Aras	2025-05-15	YOLDA
862	862	TR11750258	Sürat	2025-05-20	TESLIM_EDILDI
863	863	TR49408978	Yurtiçi	2025-05-15	YOLDA
864	864	TR97406144	Sürat	2025-05-16	TESLIM_EDILDI
865	865	TR88515505	Sürat	2025-05-20	TESLIM_EDILDI
866	866	TR20553411	Yurtiçi	2025-05-17	YOLDA
867	867	TR91204408	Aras	2025-05-15	YOLDA
868	868	TR50007287	PTT	2025-05-20	TESLIM_EDILDI
869	869	TR67878183	Yurtiçi	2025-05-12	YOLDA
870	870	TR27580671	Sürat	2025-05-16	TESLIM_EDILDI
871	871	TR03075802	PTT	2025-05-12	TESLIM_EDILDI
872	872	TR47809808	Aras	2025-05-15	TESLIM_EDILDI
873	873	TR91910914	Aras	2025-05-15	TESLIM_EDILDI
874	874	TR36897615	PTT	2025-05-17	TESLIM_EDILDI
875	875	TR53418345	PTT	2025-05-15	TESLIM_EDILDI
876	876	TR22243091	MNG	2025-05-17	YOLDA
877	877	TR90389215	Yurtiçi	2025-05-16	YOLDA
878	878	TR77874848	Sürat	2025-05-18	YOLDA
879	879	TR15252221	Aras	2025-05-13	YOLDA
880	880	TR56854690	MNG	2025-05-13	YOLDA
881	881	TR39349131	Aras	2025-05-17	YOLDA
882	882	TR26620156	Aras	2025-05-17	YOLDA
883	883	TR84237684	Aras	2025-05-17	TESLIM_EDILDI
884	884	TR23139885	PTT	2025-05-14	TESLIM_EDILDI
885	885	TR67453034	Sürat	2025-05-16	TESLIM_EDILDI
886	886	TR81565125	PTT	2025-05-13	TESLIM_EDILDI
887	887	TR56234126	Sürat	2025-05-19	YOLDA
888	888	TR26500500	MNG	2025-05-12	TESLIM_EDILDI
889	889	TR06478026	Sürat	2025-05-16	YOLDA
890	890	TR74284647	Yurtiçi	2025-05-12	YOLDA
891	891	TR09911008	PTT	2025-05-17	TESLIM_EDILDI
892	892	TR59257122	Yurtiçi	2025-05-12	YOLDA
893	893	TR04118102	MNG	2025-05-14	TESLIM_EDILDI
894	894	TR39449091	Yurtiçi	2025-05-13	YOLDA
895	895	TR18249044	MNG	2025-05-18	YOLDA
896	896	TR16582058	MNG	2025-05-15	YOLDA
897	897	TR93933146	Aras	2025-05-12	YOLDA
898	898	TR82430406	MNG	2025-05-18	TESLIM_EDILDI
899	899	TR50709116	Yurtiçi	2025-05-20	TESLIM_EDILDI
900	900	TR05748836	Aras	2025-05-13	TESLIM_EDILDI
901	901	TR54051094	MNG	2025-05-14	YOLDA
902	902	TR09908982	Sürat	2025-05-16	YOLDA
903	903	TR25113986	Aras	2025-05-19	YOLDA
904	904	TR27073369	Sürat	2025-05-14	TESLIM_EDILDI
905	905	TR08524874	Sürat	2025-05-14	YOLDA
906	906	TR59549958	Yurtiçi	2025-05-13	YOLDA
907	907	TR89182122	MNG	2025-05-14	TESLIM_EDILDI
908	908	TR12130841	Aras	2025-05-15	YOLDA
909	909	TR88535949	Yurtiçi	2025-05-18	YOLDA
910	910	TR87318254	Yurtiçi	2025-05-13	YOLDA
911	911	TR57245977	PTT	2025-05-19	TESLIM_EDILDI
912	912	TR90604817	Sürat	2025-05-16	TESLIM_EDILDI
913	913	TR28397690	PTT	2025-05-15	TESLIM_EDILDI
914	914	TR99947993	Sürat	2025-05-17	TESLIM_EDILDI
915	915	TR81593824	Sürat	2025-05-17	YOLDA
916	916	TR26348868	PTT	2025-05-16	YOLDA
917	917	TR59330013	Aras	2025-05-14	YOLDA
918	918	TR54777692	Sürat	2025-05-13	YOLDA
919	919	TR09083381	Aras	2025-05-18	TESLIM_EDILDI
920	920	TR97843643	Sürat	2025-05-14	YOLDA
921	921	TR17326181	Sürat	2025-05-15	YOLDA
922	922	TR48977302	Yurtiçi	2025-05-15	YOLDA
923	923	TR57497555	Yurtiçi	2025-05-13	YOLDA
924	924	TR69770167	Aras	2025-05-16	TESLIM_EDILDI
925	925	TR78002598	PTT	2025-05-17	TESLIM_EDILDI
926	926	TR19041256	PTT	2025-05-13	YOLDA
927	927	TR75128879	Sürat	2025-05-16	YOLDA
928	928	TR19630956	PTT	2025-05-20	TESLIM_EDILDI
929	929	TR12208141	Aras	2025-05-15	YOLDA
930	930	TR41052175	Aras	2025-05-19	TESLIM_EDILDI
931	931	TR54131861	PTT	2025-05-15	TESLIM_EDILDI
932	932	TR63227156	MNG	2025-05-17	YOLDA
933	933	TR26742774	Yurtiçi	2025-05-14	TESLIM_EDILDI
934	934	TR42101791	Aras	2025-05-20	YOLDA
935	935	TR15076705	Sürat	2025-05-13	TESLIM_EDILDI
936	936	TR50418634	Yurtiçi	2025-05-15	TESLIM_EDILDI
937	937	TR13081486	PTT	2025-05-16	TESLIM_EDILDI
938	938	TR95571108	MNG	2025-05-13	TESLIM_EDILDI
939	939	TR17131269	Yurtiçi	2025-05-19	TESLIM_EDILDI
940	940	TR57706171	Yurtiçi	2025-05-12	TESLIM_EDILDI
941	941	TR02993451	Aras	2025-05-17	TESLIM_EDILDI
942	942	TR59546840	PTT	2025-05-18	YOLDA
943	943	TR72097048	Aras	2025-05-15	TESLIM_EDILDI
944	944	TR99164816	Aras	2025-05-14	YOLDA
945	945	TR57912880	Sürat	2025-05-16	TESLIM_EDILDI
946	946	TR90155203	PTT	2025-05-13	YOLDA
947	947	TR10483305	Aras	2025-05-14	YOLDA
948	948	TR79103191	MNG	2025-05-15	TESLIM_EDILDI
949	949	TR70088310	Yurtiçi	2025-05-17	TESLIM_EDILDI
950	950	TR97814937	Aras	2025-05-12	YOLDA
951	951	TR12724499	PTT	2025-05-15	YOLDA
952	952	TR71625020	MNG	2025-05-13	YOLDA
953	953	TR28878069	Yurtiçi	2025-05-12	TESLIM_EDILDI
954	954	TR96946856	MNG	2025-05-14	TESLIM_EDILDI
955	955	TR74128418	MNG	2025-05-16	TESLIM_EDILDI
956	956	TR47592681	Sürat	2025-05-20	TESLIM_EDILDI
957	957	TR72876849	MNG	2025-05-18	TESLIM_EDILDI
958	958	TR10373907	Aras	2025-05-20	YOLDA
959	959	TR63896270	MNG	2025-05-19	TESLIM_EDILDI
960	960	TR86416221	PTT	2025-05-13	TESLIM_EDILDI
961	961	TR80909881	Sürat	2025-05-12	TESLIM_EDILDI
962	962	TR67259801	Sürat	2025-05-14	TESLIM_EDILDI
963	963	TR12071629	MNG	2025-05-13	YOLDA
964	964	TR83262681	Yurtiçi	2025-05-18	YOLDA
965	965	TR19554182	MNG	2025-05-19	TESLIM_EDILDI
966	966	TR11100832	MNG	2025-05-12	YOLDA
967	967	TR48826617	MNG	2025-05-14	TESLIM_EDILDI
968	968	TR61249946	MNG	2025-05-19	YOLDA
969	969	TR51047641	Aras	2025-05-16	TESLIM_EDILDI
970	970	TR22567098	MNG	2025-05-13	YOLDA
971	971	TR51547946	Sürat	2025-05-17	TESLIM_EDILDI
972	972	TR91726222	PTT	2025-05-14	YOLDA
973	973	TR02947355	Sürat	2025-05-19	YOLDA
974	974	TR77969998	Yurtiçi	2025-05-19	YOLDA
975	975	TR83408997	Aras	2025-05-20	TESLIM_EDILDI
976	976	TR11910255	Aras	2025-05-20	YOLDA
977	977	TR29981442	Aras	2025-05-13	YOLDA
978	978	TR35716915	Yurtiçi	2025-05-19	YOLDA
979	979	TR80351911	Yurtiçi	2025-05-15	YOLDA
980	980	TR01203747	MNG	2025-05-20	TESLIM_EDILDI
981	981	TR62353118	Aras	2025-05-13	TESLIM_EDILDI
982	982	TR85156660	PTT	2025-05-20	YOLDA
983	983	TR78091890	MNG	2025-05-20	TESLIM_EDILDI
984	984	TR81995042	Sürat	2025-05-18	TESLIM_EDILDI
985	985	TR25588884	Aras	2025-05-17	TESLIM_EDILDI
986	986	TR75166260	PTT	2025-05-12	YOLDA
987	987	TR61852754	Yurtiçi	2025-05-15	YOLDA
988	988	TR25757323	MNG	2025-05-13	YOLDA
989	989	TR39488758	Aras	2025-05-19	TESLIM_EDILDI
990	990	TR15627647	PTT	2025-05-15	TESLIM_EDILDI
991	991	TR46773970	Sürat	2025-05-15	YOLDA
992	992	TR23779821	MNG	2025-05-12	TESLIM_EDILDI
993	993	TR83279403	Aras	2025-05-12	YOLDA
994	994	TR83553639	Yurtiçi	2025-05-19	YOLDA
995	995	TR39502772	Sürat	2025-05-18	TESLIM_EDILDI
996	996	TR74767726	PTT	2025-05-18	YOLDA
997	997	TR47798888	PTT	2025-05-16	TESLIM_EDILDI
998	998	TR01218675	Sürat	2025-05-20	YOLDA
999	999	TR57468976	Yurtiçi	2025-05-16	TESLIM_EDILDI
1000	1000	TR23278345	Yurtiçi	2025-05-17	TESLIM_EDILDI
1001	1001	TR06894705	Yurtiçi	2025-05-14	TESLIM_EDILDI
1002	1002	TR84884527	MNG	2025-05-16	YOLDA
1003	1003	TR86840689	PTT	2025-05-14	TESLIM_EDILDI
1004	1004	TR43862742	PTT	2025-05-20	YOLDA
1005	1005	TR64426404	Sürat	2025-05-20	TESLIM_EDILDI
1006	1006	TR91306663	Aras	2025-05-13	TESLIM_EDILDI
1007	1007	TR20452679	Aras	2025-05-13	YOLDA
1008	1008	TR93770671	Aras	2025-05-19	TESLIM_EDILDI
1009	1009	TR29309346	Aras	2025-05-17	YOLDA
1010	1010	TR57602217	Sürat	2025-05-15	YOLDA
1011	1011	TR25816303	Yurtiçi	2025-05-12	TESLIM_EDILDI
1012	1012	TR85773466	Aras	2025-05-17	YOLDA
1013	1013	TR49587468	PTT	2025-05-18	YOLDA
1014	1014	TR88707898	Yurtiçi	2025-05-19	TESLIM_EDILDI
1015	1015	TR60385439	MNG	2025-05-18	YOLDA
1016	1016	TR33373396	Sürat	2025-05-12	TESLIM_EDILDI
1017	1017	TR47990438	PTT	2025-05-14	TESLIM_EDILDI
1018	1018	TR60306898	Yurtiçi	2025-05-18	TESLIM_EDILDI
1019	1019	TR84954403	Sürat	2025-05-16	TESLIM_EDILDI
1020	1020	TR95377057	Yurtiçi	2025-05-19	TESLIM_EDILDI
1021	1021	TR47444077	MNG	2025-05-12	YOLDA
1022	1022	TR87773045	Yurtiçi	2025-05-14	TESLIM_EDILDI
1023	1023	TR72057327	Yurtiçi	2025-05-16	YOLDA
1024	1024	TR07979846	Yurtiçi	2025-05-14	TESLIM_EDILDI
1025	1025	TR42699964	Yurtiçi	2025-05-12	YOLDA
1026	1026	TR55624597	Sürat	2025-05-15	YOLDA
1027	1027	TR33860397	Yurtiçi	2025-05-16	TESLIM_EDILDI
1028	1028	TR54457515	Aras	2025-05-17	YOLDA
1029	1029	TR07824796	Aras	2025-05-19	YOLDA
1030	1030	TR14587744	PTT	2025-05-15	TESLIM_EDILDI
1031	1031	TR31937855	Aras	2025-05-19	YOLDA
1032	1032	TR19544692	Aras	2025-05-19	YOLDA
1033	1033	TR75366880	Aras	2025-05-15	YOLDA
1034	1034	TR58581924	MNG	2025-05-16	TESLIM_EDILDI
1035	1035	TR68203444	Sürat	2025-05-17	TESLIM_EDILDI
1036	1036	TR18928760	PTT	2025-05-18	YOLDA
1037	1037	TR61349617	Aras	2025-05-16	TESLIM_EDILDI
1038	1038	TR34212057	PTT	2025-05-14	TESLIM_EDILDI
1039	1039	TR47551862	Sürat	2025-05-16	YOLDA
1040	1040	TR56181102	Yurtiçi	2025-05-16	YOLDA
1041	1041	TR05397456	Aras	2025-05-17	YOLDA
1042	1042	TR18513090	Yurtiçi	2025-05-20	YOLDA
1043	1043	TR07053320	Aras	2025-05-20	TESLIM_EDILDI
1044	1044	TR14594407	PTT	2025-05-12	YOLDA
1045	1045	TR93122055	MNG	2025-05-14	YOLDA
1046	1046	TR64612203	Sürat	2025-05-20	TESLIM_EDILDI
1047	1047	TR08059620	Sürat	2025-05-12	TESLIM_EDILDI
1048	1048	TR08950371	PTT	2025-05-13	TESLIM_EDILDI
1049	1049	TR38738330	Sürat	2025-05-17	YOLDA
1050	1050	TR69107903	Sürat	2025-05-12	YOLDA
1051	1051	TR99636316	Aras	2025-05-14	TESLIM_EDILDI
1052	1052	TR12756266	Sürat	2025-05-18	YOLDA
1053	1053	TR03965054	MNG	2025-05-16	TESLIM_EDILDI
1054	1054	TR85896779	MNG	2025-05-14	YOLDA
1055	1055	TR94529331	Aras	2025-05-13	TESLIM_EDILDI
1056	1056	TR01217212	Aras	2025-05-16	YOLDA
1057	1057	TR59044342	PTT	2025-05-14	YOLDA
1058	1058	TR01893379	Sürat	2025-05-17	TESLIM_EDILDI
1059	1059	TR00103746	Aras	2025-05-16	YOLDA
1060	1060	TR50048598	PTT	2025-05-16	YOLDA
1061	1061	TR89660901	Yurtiçi	2025-05-12	YOLDA
1062	1062	TR75837975	Aras	2025-05-13	TESLIM_EDILDI
1063	1063	TR41735394	MNG	2025-05-16	YOLDA
1064	1064	TR58687700	Sürat	2025-05-14	TESLIM_EDILDI
1065	1065	TR63883790	MNG	2025-05-17	YOLDA
1066	1066	TR70970160	PTT	2025-05-13	TESLIM_EDILDI
1067	1067	TR52304058	PTT	2025-05-12	TESLIM_EDILDI
1068	1068	TR17092152	MNG	2025-05-17	TESLIM_EDILDI
1069	1069	TR66546690	MNG	2025-05-18	TESLIM_EDILDI
1070	1070	TR57740269	Sürat	2025-05-20	TESLIM_EDILDI
1071	1071	TR02763303	Yurtiçi	2025-05-16	TESLIM_EDILDI
1072	1072	TR61243201	Yurtiçi	2025-05-14	YOLDA
1073	1073	TR87002314	MNG	2025-05-12	YOLDA
1074	1074	TR33341527	Yurtiçi	2025-05-14	YOLDA
1075	1075	TR39478667	MNG	2025-05-12	TESLIM_EDILDI
1076	1076	TR63916592	MNG	2025-05-19	YOLDA
1077	1077	TR91487606	MNG	2025-05-20	TESLIM_EDILDI
1078	1078	TR99711031	PTT	2025-05-13	YOLDA
1079	1079	TR17714325	Aras	2025-05-12	YOLDA
1080	1080	TR20289461	Yurtiçi	2025-05-13	YOLDA
1081	1081	TR48949679	PTT	2025-05-13	TESLIM_EDILDI
1082	1082	TR70801981	PTT	2025-05-15	YOLDA
1083	1083	TR28137783	MNG	2025-05-16	YOLDA
1084	1084	TR75289308	Aras	2025-05-16	TESLIM_EDILDI
1085	1085	TR37432679	Aras	2025-05-17	YOLDA
1086	1086	TR17467380	Yurtiçi	2025-05-12	YOLDA
1087	1087	TR33838440	Yurtiçi	2025-05-19	TESLIM_EDILDI
1088	1088	TR24418939	MNG	2025-05-14	YOLDA
1089	1089	TR54687085	PTT	2025-05-14	YOLDA
1090	1090	TR17624501	PTT	2025-05-17	TESLIM_EDILDI
1091	1091	TR03904976	MNG	2025-05-20	YOLDA
1092	1092	TR45086046	Aras	2025-05-20	TESLIM_EDILDI
1093	1093	TR63321660	Yurtiçi	2025-05-20	TESLIM_EDILDI
1094	1094	TR19585101	Sürat	2025-05-15	YOLDA
1095	1095	TR23226542	MNG	2025-05-12	YOLDA
1096	1096	TR05048023	Sürat	2025-05-20	YOLDA
1097	1097	TR61185016	PTT	2025-05-19	TESLIM_EDILDI
1098	1098	TR16057831	Aras	2025-05-17	TESLIM_EDILDI
1099	1099	TR23944465	Sürat	2025-05-14	TESLIM_EDILDI
1100	1100	TR38244697	MNG	2025-05-12	YOLDA
1101	1101	TR34247773	MNG	2025-05-13	YOLDA
1102	1102	TR42066099	PTT	2025-05-16	TESLIM_EDILDI
1103	1103	TR23900833	Aras	2025-05-20	YOLDA
1104	1104	TR88229402	Sürat	2025-05-19	YOLDA
1105	1105	TR76541068	PTT	2025-05-17	YOLDA
1106	1106	TR15499213	PTT	2025-05-13	TESLIM_EDILDI
1107	1107	TR16660300	MNG	2025-05-20	YOLDA
1108	1108	TR69471820	Sürat	2025-05-20	TESLIM_EDILDI
1109	1109	TR79060015	PTT	2025-05-12	TESLIM_EDILDI
1110	1110	TR14868900	Yurtiçi	2025-05-14	YOLDA
1111	1111	TR43777527	Yurtiçi	2025-05-13	TESLIM_EDILDI
1112	1112	TR08377299	Sürat	2025-05-13	TESLIM_EDILDI
1113	1113	TR25595408	PTT	2025-05-20	TESLIM_EDILDI
1114	1114	TR58048235	PTT	2025-05-12	TESLIM_EDILDI
1115	1115	TR44804953	Sürat	2025-05-19	YOLDA
1116	1116	TR05738660	Yurtiçi	2025-05-18	TESLIM_EDILDI
1117	1117	TR88874870	Sürat	2025-05-16	YOLDA
1118	1118	TR71753951	MNG	2025-05-14	TESLIM_EDILDI
1119	1119	TR67853006	Sürat	2025-05-19	YOLDA
1120	1120	TR54333262	MNG	2025-05-20	TESLIM_EDILDI
1121	1121	TR44277207	MNG	2025-05-20	YOLDA
1122	1122	TR66036660	MNG	2025-05-16	YOLDA
1123	1123	TR86242076	Aras	2025-05-16	YOLDA
1124	1124	TR40644173	Sürat	2025-05-13	YOLDA
1125	1125	TR13804164	Yurtiçi	2025-05-15	YOLDA
1126	1126	TR24480254	Sürat	2025-05-12	YOLDA
1127	1127	TR46910490	PTT	2025-05-13	TESLIM_EDILDI
1128	1128	TR53807392	Yurtiçi	2025-05-20	TESLIM_EDILDI
1129	1129	TR49424898	MNG	2025-05-17	YOLDA
1130	1130	TR58145659	Aras	2025-05-19	YOLDA
1131	1131	TR83798634	MNG	2025-05-18	TESLIM_EDILDI
1132	1132	TR69655943	Sürat	2025-05-15	YOLDA
1133	1133	TR44756252	Sürat	2025-05-19	YOLDA
1134	1134	TR77156209	Aras	2025-05-12	YOLDA
1135	1135	TR98885217	Yurtiçi	2025-05-19	YOLDA
1136	1136	TR10486280	Sürat	2025-05-13	TESLIM_EDILDI
1137	1137	TR53190909	PTT	2025-05-12	YOLDA
1138	1138	TR34180853	Aras	2025-05-12	YOLDA
1139	1139	TR28559757	PTT	2025-05-19	TESLIM_EDILDI
1140	1140	TR54236359	MNG	2025-05-14	YOLDA
1141	1141	TR56176889	PTT	2025-05-20	TESLIM_EDILDI
1142	1142	TR62304251	MNG	2025-05-15	TESLIM_EDILDI
1143	1143	TR50054275	MNG	2025-05-17	YOLDA
1144	1144	TR04075204	Yurtiçi	2025-05-16	YOLDA
1145	1145	TR13002995	Yurtiçi	2025-05-15	TESLIM_EDILDI
1146	1146	TR01238268	Sürat	2025-05-15	YOLDA
1147	1147	TR37569726	PTT	2025-05-17	TESLIM_EDILDI
1148	1148	TR70455658	MNG	2025-05-14	TESLIM_EDILDI
1149	1149	TR19307612	PTT	2025-05-19	TESLIM_EDILDI
1150	1150	TR17998240	PTT	2025-05-17	YOLDA
1151	1151	TR82909392	Yurtiçi	2025-05-17	YOLDA
1152	1152	TR06150880	Yurtiçi	2025-05-19	TESLIM_EDILDI
1153	1153	TR61648194	PTT	2025-05-16	YOLDA
1154	1154	TR07385378	Sürat	2025-05-14	TESLIM_EDILDI
1155	1155	TR79459168	Sürat	2025-05-13	YOLDA
1156	1156	TR97611182	MNG	2025-05-17	TESLIM_EDILDI
1157	1157	TR79476482	PTT	2025-05-20	YOLDA
1158	1158	TR25497320	MNG	2025-05-17	YOLDA
1159	1159	TR36917257	Sürat	2025-05-17	YOLDA
1160	1160	TR07212473	Yurtiçi	2025-05-16	YOLDA
1161	1161	TR06293432	MNG	2025-05-13	TESLIM_EDILDI
1162	1162	TR26758216	MNG	2025-05-15	YOLDA
1163	1163	TR63455515	PTT	2025-05-15	YOLDA
1164	1164	TR47455764	MNG	2025-05-14	YOLDA
1165	1165	TR27821149	Yurtiçi	2025-05-15	YOLDA
1166	1166	TR24434643	Aras	2025-05-13	TESLIM_EDILDI
1167	1167	TR43437697	MNG	2025-05-14	TESLIM_EDILDI
1168	1168	TR94455051	Aras	2025-05-18	TESLIM_EDILDI
1169	1169	TR99093400	Yurtiçi	2025-05-15	YOLDA
1170	1170	TR94532098	Sürat	2025-05-18	YOLDA
1171	1171	TR50442521	Yurtiçi	2025-05-16	TESLIM_EDILDI
1172	1172	TR98532416	MNG	2025-05-19	YOLDA
1173	1173	TR06848703	Aras	2025-05-17	TESLIM_EDILDI
1174	1174	TR67644369	Yurtiçi	2025-05-13	YOLDA
1175	1175	TR01030412	Aras	2025-05-20	TESLIM_EDILDI
1176	1176	TR74283869	Sürat	2025-05-13	TESLIM_EDILDI
1177	1177	TR98524787	PTT	2025-05-13	TESLIM_EDILDI
1178	1178	TR50188993	MNG	2025-05-19	YOLDA
1179	1179	TR74578741	PTT	2025-05-17	YOLDA
1180	1180	TR60926695	Yurtiçi	2025-05-15	TESLIM_EDILDI
1181	1181	TR30682922	Aras	2025-05-19	YOLDA
1182	1182	TR11924293	MNG	2025-05-15	TESLIM_EDILDI
1183	1183	TR73285866	PTT	2025-05-12	YOLDA
1184	1184	TR88090362	MNG	2025-05-15	YOLDA
1185	1185	TR28282633	MNG	2025-05-17	YOLDA
1186	1186	TR21658111	Aras	2025-05-16	YOLDA
1187	1187	TR97562318	Aras	2025-05-19	YOLDA
1188	1188	TR32825394	Yurtiçi	2025-05-12	TESLIM_EDILDI
1189	1189	TR92180989	Yurtiçi	2025-05-16	TESLIM_EDILDI
1190	1190	TR18028084	Yurtiçi	2025-05-15	YOLDA
1191	1191	TR90449573	Sürat	2025-05-12	TESLIM_EDILDI
1192	1192	TR60233634	PTT	2025-05-19	TESLIM_EDILDI
1193	1193	TR16566202	Aras	2025-05-18	YOLDA
1194	1194	TR92308572	Aras	2025-05-12	TESLIM_EDILDI
1195	1195	TR89196903	Aras	2025-05-17	YOLDA
1196	1196	TR03898132	Aras	2025-05-13	TESLIM_EDILDI
1197	1197	TR46457838	Yurtiçi	2025-05-16	TESLIM_EDILDI
1198	1198	TR41782954	PTT	2025-05-20	YOLDA
1199	1199	TR07996968	Aras	2025-05-18	TESLIM_EDILDI
1200	1200	TR69632362	Aras	2025-05-16	TESLIM_EDILDI
1201	1201	TR99458682	MNG	2025-05-15	TESLIM_EDILDI
1202	1202	TR52775400	MNG	2025-05-20	YOLDA
1203	1203	TR40458698	Aras	2025-05-12	TESLIM_EDILDI
1204	1204	TR90816070	Aras	2025-05-15	YOLDA
1205	1205	TR04619380	PTT	2025-05-12	YOLDA
1206	1206	TR84375308	Yurtiçi	2025-05-18	YOLDA
1207	1207	TR43046534	MNG	2025-05-16	YOLDA
1208	1208	TR59456637	PTT	2025-05-16	YOLDA
1209	1209	TR89444985	Yurtiçi	2025-05-17	TESLIM_EDILDI
1210	1210	TR37439726	Sürat	2025-05-16	YOLDA
1211	1211	TR97681992	MNG	2025-05-12	TESLIM_EDILDI
1212	1212	TR51299946	Yurtiçi	2025-05-17	YOLDA
1213	1213	TR96537437	MNG	2025-05-17	TESLIM_EDILDI
1214	1214	TR95293790	Sürat	2025-05-12	YOLDA
1215	1215	TR55218451	Aras	2025-05-20	TESLIM_EDILDI
1216	1216	TR44087280	Sürat	2025-05-18	TESLIM_EDILDI
1217	1217	TR67778393	PTT	2025-05-15	YOLDA
1218	1218	TR44271004	Yurtiçi	2025-05-15	TESLIM_EDILDI
1219	1219	TR28085618	Sürat	2025-05-19	TESLIM_EDILDI
1220	1220	TR32001763	Aras	2025-05-19	YOLDA
1221	1221	TR33809468	Sürat	2025-05-14	TESLIM_EDILDI
1222	1222	TR69981318	MNG	2025-05-14	YOLDA
1223	1223	TR61521578	Sürat	2025-05-15	TESLIM_EDILDI
1224	1224	TR78786516	Yurtiçi	2025-05-18	YOLDA
1225	1225	TR32091587	PTT	2025-05-19	TESLIM_EDILDI
1226	1226	TR41618034	Aras	2025-05-17	YOLDA
1227	1227	TR80483319	Sürat	2025-05-12	YOLDA
1228	1228	TR11730283	Aras	2025-05-13	YOLDA
1229	1229	TR26816210	MNG	2025-05-12	YOLDA
1230	1230	TR16949149	Sürat	2025-05-18	TESLIM_EDILDI
1231	1231	TR69321968	Aras	2025-05-17	YOLDA
1232	1232	TR37822928	Aras	2025-05-17	YOLDA
1233	1233	TR37668665	Sürat	2025-05-18	YOLDA
1234	1234	TR34442363	Aras	2025-05-16	YOLDA
1235	1235	TR64888569	MNG	2025-05-18	TESLIM_EDILDI
1236	1236	TR43959885	Yurtiçi	2025-05-17	TESLIM_EDILDI
1237	1237	TR98965053	Yurtiçi	2025-05-20	YOLDA
1238	1238	TR18790895	MNG	2025-05-18	TESLIM_EDILDI
1239	1239	TR20250623	Aras	2025-05-15	TESLIM_EDILDI
1240	1240	TR08697763	Sürat	2025-05-19	YOLDA
1241	1241	TR17683348	Aras	2025-05-20	TESLIM_EDILDI
1242	1242	TR93974235	PTT	2025-05-13	TESLIM_EDILDI
1243	1243	TR70671598	Sürat	2025-05-16	YOLDA
1244	1244	TR71693412	Sürat	2025-05-13	YOLDA
1245	1245	TR83716084	MNG	2025-05-20	YOLDA
1246	1246	TR64343027	Sürat	2025-05-12	TESLIM_EDILDI
1247	1247	TR11273823	Yurtiçi	2025-05-14	TESLIM_EDILDI
1248	1248	TR19168820	Yurtiçi	2025-05-15	YOLDA
1249	1249	TR20355618	Aras	2025-05-16	TESLIM_EDILDI
1250	1250	TR55783977	Yurtiçi	2025-05-13	YOLDA
1251	1251	TR74617436	Aras	2025-05-20	TESLIM_EDILDI
1252	1252	TR67366831	PTT	2025-05-18	TESLIM_EDILDI
1253	1253	TR87085331	Sürat	2025-05-19	YOLDA
1254	1254	TR85318756	Aras	2025-05-13	YOLDA
1255	1255	TR49812110	PTT	2025-05-20	YOLDA
1256	1256	TR85516261	Yurtiçi	2025-05-18	TESLIM_EDILDI
1257	1257	TR84805178	Yurtiçi	2025-05-15	YOLDA
1258	1258	TR39446397	PTT	2025-05-18	YOLDA
1259	1259	TR14815859	Sürat	2025-05-16	TESLIM_EDILDI
1260	1260	TR19395055	MNG	2025-05-14	TESLIM_EDILDI
1261	1261	TR33411281	MNG	2025-05-12	TESLIM_EDILDI
1262	1262	TR20292781	Yurtiçi	2025-05-16	TESLIM_EDILDI
1263	1263	TR35654315	Sürat	2025-05-19	TESLIM_EDILDI
1264	1264	TR98967869	Yurtiçi	2025-05-20	TESLIM_EDILDI
1265	1265	TR28496616	Aras	2025-05-12	TESLIM_EDILDI
1266	1266	TR79079189	PTT	2025-05-19	TESLIM_EDILDI
1267	1267	TR60874414	Aras	2025-05-19	TESLIM_EDILDI
1268	1268	TR98411231	PTT	2025-05-18	YOLDA
1269	1269	TR11492635	Yurtiçi	2025-05-12	YOLDA
1270	1270	TR93197656	Yurtiçi	2025-05-14	YOLDA
1271	1271	TR81278717	Sürat	2025-05-14	YOLDA
1272	1272	TR12106981	Yurtiçi	2025-05-17	YOLDA
1273	1273	TR83255897	MNG	2025-05-19	TESLIM_EDILDI
1274	1274	TR05618817	Aras	2025-05-19	TESLIM_EDILDI
1275	1275	TR83233979	MNG	2025-05-14	YOLDA
1276	1276	TR26693150	Sürat	2025-05-20	TESLIM_EDILDI
1277	1277	TR78295603	Yurtiçi	2025-05-12	TESLIM_EDILDI
1278	1278	TR29588317	PTT	2025-05-20	YOLDA
1279	1279	TR07490614	PTT	2025-05-13	TESLIM_EDILDI
1280	1280	TR33810624	Yurtiçi	2025-05-12	YOLDA
1281	1281	TR81651854	Yurtiçi	2025-05-20	TESLIM_EDILDI
1282	1282	TR31466240	Sürat	2025-05-16	TESLIM_EDILDI
1283	1283	TR06612915	MNG	2025-05-17	YOLDA
1284	1284	TR76566769	Sürat	2025-05-17	YOLDA
1285	1285	TR97673404	Yurtiçi	2025-05-14	TESLIM_EDILDI
1286	1286	TR99548937	MNG	2025-05-13	TESLIM_EDILDI
1287	1287	TR15293223	PTT	2025-05-13	TESLIM_EDILDI
1288	1288	TR92096651	PTT	2025-05-19	YOLDA
1289	1289	TR01850564	Sürat	2025-05-19	YOLDA
1290	1290	TR54140206	PTT	2025-05-20	YOLDA
1291	1291	TR85809884	Aras	2025-05-16	YOLDA
1292	1292	TR15228519	Yurtiçi	2025-05-18	TESLIM_EDILDI
1293	1293	TR10790704	Sürat	2025-05-12	TESLIM_EDILDI
1294	1294	TR25358534	MNG	2025-05-17	YOLDA
1295	1295	TR84347756	MNG	2025-05-19	TESLIM_EDILDI
1296	1296	TR66810833	Aras	2025-05-14	TESLIM_EDILDI
1297	1297	TR57749510	Sürat	2025-05-20	TESLIM_EDILDI
1298	1298	TR69224765	PTT	2025-05-17	TESLIM_EDILDI
1299	1299	TR00457465	Aras	2025-05-15	YOLDA
1300	1300	TR60243991	Aras	2025-05-14	TESLIM_EDILDI
1301	1301	TR24980813	Yurtiçi	2025-05-17	YOLDA
1302	1302	TR51188159	Aras	2025-05-13	YOLDA
1303	1303	TR55155623	MNG	2025-05-19	YOLDA
1304	1304	TR91529173	PTT	2025-05-17	TESLIM_EDILDI
1305	1305	TR45146718	MNG	2025-05-16	YOLDA
1306	1306	TR15149273	Sürat	2025-05-17	YOLDA
1307	1307	TR40200857	Aras	2025-05-20	TESLIM_EDILDI
1308	1308	TR07926817	MNG	2025-05-15	TESLIM_EDILDI
1309	1309	TR84510125	PTT	2025-05-19	YOLDA
1310	1310	TR86678996	Aras	2025-05-15	YOLDA
1311	1311	TR85293294	Sürat	2025-05-14	YOLDA
1312	1312	TR97869062	PTT	2025-05-12	YOLDA
1313	1313	TR22244667	MNG	2025-05-19	TESLIM_EDILDI
1314	1314	TR03125413	PTT	2025-05-19	TESLIM_EDILDI
1315	1315	TR60842291	Aras	2025-05-14	YOLDA
1316	1316	TR96657758	PTT	2025-05-12	YOLDA
1317	1317	TR05115769	PTT	2025-05-13	YOLDA
1318	1318	TR77824765	MNG	2025-05-16	YOLDA
1319	1319	TR27455320	Aras	2025-05-12	TESLIM_EDILDI
1320	1320	TR35911016	PTT	2025-05-14	YOLDA
1321	1321	TR44586274	Aras	2025-05-14	YOLDA
1322	1322	TR89080476	MNG	2025-05-13	TESLIM_EDILDI
1323	1323	TR30647549	Sürat	2025-05-17	TESLIM_EDILDI
1324	1324	TR90061182	Sürat	2025-05-17	YOLDA
1325	1325	TR70428062	Yurtiçi	2025-05-17	TESLIM_EDILDI
1326	1326	TR50044153	MNG	2025-05-13	YOLDA
1327	1327	TR12762075	Aras	2025-05-14	YOLDA
1328	1328	TR52706963	PTT	2025-05-15	TESLIM_EDILDI
1329	1329	TR60696890	Aras	2025-05-16	YOLDA
1330	1330	TR50740107	Sürat	2025-05-19	TESLIM_EDILDI
1331	1331	TR15633568	MNG	2025-05-14	YOLDA
1332	1332	TR17497092	Aras	2025-05-16	TESLIM_EDILDI
1333	1333	TR46071207	MNG	2025-05-19	YOLDA
1334	1334	TR38039439	PTT	2025-05-18	TESLIM_EDILDI
1335	1335	TR04106205	PTT	2025-05-16	YOLDA
1336	1336	TR69556682	Yurtiçi	2025-05-15	TESLIM_EDILDI
1337	1337	TR36386875	Sürat	2025-05-16	TESLIM_EDILDI
1338	1338	TR33003595	Yurtiçi	2025-05-17	TESLIM_EDILDI
1339	1339	TR63181984	Sürat	2025-05-16	YOLDA
1340	1340	TR15864813	Aras	2025-05-14	TESLIM_EDILDI
1341	1341	TR24468652	PTT	2025-05-14	YOLDA
1342	1342	TR99313862	Yurtiçi	2025-05-17	TESLIM_EDILDI
1343	1343	TR76566299	Sürat	2025-05-15	YOLDA
1344	1344	TR83887386	Yurtiçi	2025-05-19	TESLIM_EDILDI
1345	1345	TR03309987	Yurtiçi	2025-05-20	YOLDA
1346	1346	TR98635136	MNG	2025-05-17	TESLIM_EDILDI
1347	1347	TR28262778	Aras	2025-05-20	TESLIM_EDILDI
1348	1348	TR05224747	Yurtiçi	2025-05-20	YOLDA
1349	1349	TR04512085	Yurtiçi	2025-05-13	YOLDA
1350	1350	TR33053658	Yurtiçi	2025-05-13	YOLDA
1351	1351	TR19970601	MNG	2025-05-13	YOLDA
1352	1352	TR06544668	MNG	2025-05-13	YOLDA
1353	1353	TR72155630	Yurtiçi	2025-05-19	TESLIM_EDILDI
1354	1354	TR79117996	MNG	2025-05-19	YOLDA
1355	1355	TR18284058	Aras	2025-05-14	TESLIM_EDILDI
1356	1356	TR00827953	Aras	2025-05-18	TESLIM_EDILDI
1357	1357	TR82774687	MNG	2025-05-13	TESLIM_EDILDI
1358	1358	TR45300575	MNG	2025-05-12	YOLDA
1359	1359	TR53486598	Aras	2025-05-17	YOLDA
1360	1360	TR41052456	Aras	2025-05-14	YOLDA
1361	1361	TR27312904	PTT	2025-05-18	TESLIM_EDILDI
1362	1362	TR70119716	Sürat	2025-05-13	TESLIM_EDILDI
1363	1363	TR60143926	Aras	2025-05-19	TESLIM_EDILDI
1364	1364	TR09757973	PTT	2025-05-20	TESLIM_EDILDI
1365	1365	TR57000207	Yurtiçi	2025-05-15	YOLDA
1366	1366	TR55234401	MNG	2025-05-18	YOLDA
1367	1367	TR19731667	MNG	2025-05-13	YOLDA
1368	1368	TR07272748	Aras	2025-05-13	TESLIM_EDILDI
1369	1369	TR87182634	Sürat	2025-05-18	YOLDA
1370	1370	TR00279329	Yurtiçi	2025-05-12	TESLIM_EDILDI
1371	1371	TR29613391	Sürat	2025-05-15	TESLIM_EDILDI
1372	1372	TR58360505	MNG	2025-05-12	TESLIM_EDILDI
1373	1373	TR91365823	Yurtiçi	2025-05-14	TESLIM_EDILDI
1374	1374	TR11984309	Aras	2025-05-14	YOLDA
1375	1375	TR42904434	MNG	2025-05-13	YOLDA
1376	1376	TR91863295	PTT	2025-05-12	YOLDA
1377	1377	TR29458126	Sürat	2025-05-16	YOLDA
1378	1378	TR04810115	Aras	2025-05-13	YOLDA
1379	1379	TR37093269	Sürat	2025-05-14	YOLDA
1380	1380	TR39421727	Yurtiçi	2025-05-15	TESLIM_EDILDI
1381	1381	TR11076703	Sürat	2025-05-18	TESLIM_EDILDI
1382	1382	TR36247204	Aras	2025-05-16	YOLDA
1383	1383	TR32093243	MNG	2025-05-15	YOLDA
1384	1384	TR70243244	PTT	2025-05-15	YOLDA
1385	1385	TR40997058	Sürat	2025-05-12	YOLDA
1386	1386	TR27594860	PTT	2025-05-15	YOLDA
1387	1387	TR74480375	Sürat	2025-05-17	YOLDA
1388	1388	TR49716290	Aras	2025-05-18	TESLIM_EDILDI
1389	1389	TR56299815	Aras	2025-05-18	TESLIM_EDILDI
1390	1390	TR12781700	Sürat	2025-05-18	YOLDA
1391	1391	TR55681061	Sürat	2025-05-12	TESLIM_EDILDI
1392	1392	TR57854570	PTT	2025-05-13	TESLIM_EDILDI
1393	1393	TR94806932	Sürat	2025-05-14	TESLIM_EDILDI
1394	1394	TR56686998	Sürat	2025-05-19	TESLIM_EDILDI
1395	1395	TR69159155	Sürat	2025-05-15	YOLDA
1396	1396	TR91670099	Aras	2025-05-14	YOLDA
1397	1397	TR94076246	Yurtiçi	2025-05-14	TESLIM_EDILDI
1398	1398	TR13993067	Aras	2025-05-15	TESLIM_EDILDI
1399	1399	TR84226291	Yurtiçi	2025-05-14	TESLIM_EDILDI
1400	1400	TR36349488	Sürat	2025-05-19	YOLDA
1401	1401	TR31011869	Sürat	2025-05-19	YOLDA
1402	1402	TR09973238	Yurtiçi	2025-05-18	TESLIM_EDILDI
1403	1403	TR75471610	PTT	2025-05-16	TESLIM_EDILDI
1404	1404	TR37896632	MNG	2025-05-15	TESLIM_EDILDI
1405	1405	TR39636449	Aras	2025-05-14	TESLIM_EDILDI
1406	1406	TR72640184	PTT	2025-05-20	TESLIM_EDILDI
1407	1407	TR51440536	MNG	2025-05-14	TESLIM_EDILDI
1408	1408	TR06791324	Yurtiçi	2025-05-16	TESLIM_EDILDI
1409	1409	TR90620409	PTT	2025-05-13	TESLIM_EDILDI
1410	1410	TR62984611	Yurtiçi	2025-05-16	TESLIM_EDILDI
1411	1411	TR29045477	PTT	2025-05-19	YOLDA
1412	1412	TR06536805	Sürat	2025-05-13	TESLIM_EDILDI
1413	1413	TR64659555	Aras	2025-05-15	YOLDA
1414	1414	TR69784805	Yurtiçi	2025-05-15	YOLDA
1415	1415	TR22278293	MNG	2025-05-20	TESLIM_EDILDI
1416	1416	TR42425534	Yurtiçi	2025-05-15	TESLIM_EDILDI
1417	1417	TR21670806	PTT	2025-05-16	TESLIM_EDILDI
1418	1418	TR52826571	Sürat	2025-05-19	TESLIM_EDILDI
1419	1419	TR99816051	MNG	2025-05-13	TESLIM_EDILDI
1420	1420	TR25744212	Aras	2025-05-20	TESLIM_EDILDI
1421	1421	TR16872879	Aras	2025-05-16	TESLIM_EDILDI
1422	1422	TR60842892	PTT	2025-05-15	TESLIM_EDILDI
1423	1423	TR51710007	Yurtiçi	2025-05-14	TESLIM_EDILDI
1424	1424	TR16138182	Yurtiçi	2025-05-12	YOLDA
1425	1425	TR77943452	PTT	2025-05-12	TESLIM_EDILDI
1426	1426	TR24854428	Sürat	2025-05-19	TESLIM_EDILDI
1427	1427	TR53567224	Aras	2025-05-16	YOLDA
1428	1428	TR27096968	Sürat	2025-05-13	TESLIM_EDILDI
1429	1429	TR82998728	MNG	2025-05-13	YOLDA
1430	1430	TR45011902	Sürat	2025-05-19	YOLDA
1431	1431	TR00846370	Sürat	2025-05-17	TESLIM_EDILDI
1432	1432	TR73224943	PTT	2025-05-20	TESLIM_EDILDI
1433	1433	TR14080082	Aras	2025-05-14	TESLIM_EDILDI
1434	1434	TR22138133	MNG	2025-05-17	YOLDA
1435	1435	TR65900228	Yurtiçi	2025-05-12	YOLDA
1436	1436	TR92425982	MNG	2025-05-14	TESLIM_EDILDI
1437	1437	TR28955165	PTT	2025-05-17	YOLDA
1438	1438	TR79881754	PTT	2025-05-15	TESLIM_EDILDI
1439	1439	TR75893588	Yurtiçi	2025-05-18	TESLIM_EDILDI
1440	1440	TR14619044	Aras	2025-05-13	YOLDA
1441	1441	TR83683289	Aras	2025-05-15	TESLIM_EDILDI
1442	1442	TR31517142	Sürat	2025-05-19	TESLIM_EDILDI
1443	1443	TR00008382	PTT	2025-05-20	TESLIM_EDILDI
1444	1444	TR83563755	Aras	2025-05-14	YOLDA
1445	1445	TR52504793	Yurtiçi	2025-05-19	TESLIM_EDILDI
1446	1446	TR44464947	Sürat	2025-05-13	TESLIM_EDILDI
1447	1447	TR15963137	Sürat	2025-05-20	YOLDA
1448	1448	TR32196409	MNG	2025-05-19	YOLDA
1449	1449	TR79958978	Yurtiçi	2025-05-16	TESLIM_EDILDI
1450	1450	TR91325503	Aras	2025-05-18	YOLDA
1451	1451	TR12059711	Yurtiçi	2025-05-18	YOLDA
1452	1452	TR17091564	Aras	2025-05-12	TESLIM_EDILDI
1453	1453	TR39884610	Yurtiçi	2025-05-17	TESLIM_EDILDI
1454	1454	TR06940202	Aras	2025-05-15	YOLDA
1455	1455	TR82905218	PTT	2025-05-14	YOLDA
1456	1456	TR08214302	MNG	2025-05-17	TESLIM_EDILDI
1457	1457	TR52478683	Aras	2025-05-19	YOLDA
1458	1458	TR70955066	PTT	2025-05-14	YOLDA
1459	1459	TR64480293	Yurtiçi	2025-05-12	TESLIM_EDILDI
1460	1460	TR79602690	PTT	2025-05-13	TESLIM_EDILDI
1461	1461	TR10738870	MNG	2025-05-20	TESLIM_EDILDI
1462	1462	TR62641137	MNG	2025-05-14	YOLDA
1463	1463	TR19155136	Yurtiçi	2025-05-12	TESLIM_EDILDI
1464	1464	TR83983724	PTT	2025-05-18	TESLIM_EDILDI
1465	1465	TR15323577	Yurtiçi	2025-05-19	YOLDA
1466	1466	TR23957503	Aras	2025-05-18	YOLDA
1467	1467	TR26720751	PTT	2025-05-18	TESLIM_EDILDI
1468	1468	TR28029129	MNG	2025-05-14	TESLIM_EDILDI
1469	1469	TR73816274	Aras	2025-05-17	TESLIM_EDILDI
1470	1470	TR62843374	MNG	2025-05-14	TESLIM_EDILDI
1471	1471	TR68351474	MNG	2025-05-15	TESLIM_EDILDI
1472	1472	TR50599019	Aras	2025-05-15	TESLIM_EDILDI
1473	1473	TR38311303	PTT	2025-05-17	TESLIM_EDILDI
1474	1474	TR79618884	PTT	2025-05-18	TESLIM_EDILDI
1475	1475	TR29799268	Yurtiçi	2025-05-20	YOLDA
1476	1476	TR70667536	Aras	2025-05-13	YOLDA
1477	1477	TR57373537	MNG	2025-05-17	YOLDA
1478	1478	TR52413906	Sürat	2025-05-12	YOLDA
1479	1479	TR42071986	Sürat	2025-05-19	YOLDA
1480	1480	TR41774460	PTT	2025-05-18	YOLDA
1481	1481	TR13056600	Sürat	2025-05-20	TESLIM_EDILDI
1482	1482	TR96289885	MNG	2025-05-19	TESLIM_EDILDI
1483	1483	TR20858436	Sürat	2025-05-14	YOLDA
1484	1484	TR78468985	Aras	2025-05-12	YOLDA
1485	1485	TR12698573	PTT	2025-05-18	YOLDA
1486	1486	TR26017443	PTT	2025-05-13	YOLDA
1487	1487	TR86509208	Aras	2025-05-19	TESLIM_EDILDI
1488	1488	TR46557670	MNG	2025-05-19	YOLDA
1489	1489	TR52244923	Sürat	2025-05-17	YOLDA
1490	1490	TR18238877	PTT	2025-05-12	TESLIM_EDILDI
1491	1491	TR61495043	PTT	2025-05-18	TESLIM_EDILDI
1492	1492	TR13808199	Sürat	2025-05-13	YOLDA
1493	1493	TR19786347	Yurtiçi	2025-05-19	YOLDA
1494	1494	TR53712735	MNG	2025-05-17	TESLIM_EDILDI
1495	1495	TR54910138	Aras	2025-05-20	YOLDA
1496	1496	TR11069415	Sürat	2025-05-15	TESLIM_EDILDI
1497	1497	TR08078902	PTT	2025-05-13	TESLIM_EDILDI
1498	1498	TR69695793	MNG	2025-05-17	YOLDA
1499	1499	TR45150669	Yurtiçi	2025-05-18	YOLDA
1500	1500	TR30341777	Yurtiçi	2025-05-20	YOLDA
1501	1501	TR94633161	Yurtiçi	2025-05-15	TESLIM_EDILDI
1502	1502	TR40908056	Aras	2025-05-12	YOLDA
1503	1503	TR17684836	Aras	2025-05-12	YOLDA
1504	1504	TR13077466	MNG	2025-05-13	TESLIM_EDILDI
1505	1505	TR94699047	Sürat	2025-05-13	TESLIM_EDILDI
1506	1506	TR07366106	MNG	2025-05-16	TESLIM_EDILDI
1507	1507	TR27988573	Aras	2025-05-13	TESLIM_EDILDI
1508	1508	TR71071450	Sürat	2025-05-14	TESLIM_EDILDI
1509	1509	TR22203996	Sürat	2025-05-13	YOLDA
1510	1510	TR76223761	Sürat	2025-05-14	TESLIM_EDILDI
1511	1511	TR74114039	MNG	2025-05-17	TESLIM_EDILDI
1512	1512	TR52800566	Sürat	2025-05-16	TESLIM_EDILDI
1513	1513	TR88253227	PTT	2025-05-16	TESLIM_EDILDI
1514	1514	TR69591824	PTT	2025-05-14	YOLDA
1515	1515	TR52724791	Yurtiçi	2025-05-14	TESLIM_EDILDI
1516	1516	TR23349890	Aras	2025-05-16	TESLIM_EDILDI
1517	1517	TR40235985	MNG	2025-05-16	YOLDA
1518	1518	TR43894246	PTT	2025-05-12	YOLDA
1519	1519	TR25673665	Sürat	2025-05-13	YOLDA
1520	1520	TR98261205	Aras	2025-05-19	TESLIM_EDILDI
1521	1521	TR73506147	PTT	2025-05-18	TESLIM_EDILDI
1522	1522	TR37171671	MNG	2025-05-19	TESLIM_EDILDI
1523	1523	TR38756226	Sürat	2025-05-15	YOLDA
1524	1524	TR77854549	Yurtiçi	2025-05-17	YOLDA
1525	1525	TR53234862	Yurtiçi	2025-05-18	TESLIM_EDILDI
1526	1526	TR71451823	Aras	2025-05-16	TESLIM_EDILDI
1527	1527	TR24753002	Sürat	2025-05-12	YOLDA
1528	1528	TR06258489	Aras	2025-05-13	TESLIM_EDILDI
1529	1529	TR94502334	Yurtiçi	2025-05-13	TESLIM_EDILDI
1530	1530	TR11314070	Yurtiçi	2025-05-15	TESLIM_EDILDI
1531	1531	TR02372748	Yurtiçi	2025-05-12	TESLIM_EDILDI
1532	1532	TR82893315	MNG	2025-05-16	TESLIM_EDILDI
1533	1533	TR39265170	PTT	2025-05-12	YOLDA
1534	1534	TR48667869	PTT	2025-05-13	YOLDA
1535	1535	TR62611952	Aras	2025-05-14	TESLIM_EDILDI
1536	1536	TR19336889	PTT	2025-05-12	YOLDA
1537	1537	TR42465522	PTT	2025-05-12	TESLIM_EDILDI
1538	1538	TR73255590	Sürat	2025-05-19	YOLDA
1539	1539	TR57344915	PTT	2025-05-17	TESLIM_EDILDI
1540	1540	TR15168989	Yurtiçi	2025-05-16	TESLIM_EDILDI
1541	1541	TR20617470	Aras	2025-05-15	TESLIM_EDILDI
1542	1542	TR35116041	Sürat	2025-05-15	YOLDA
1543	1543	TR42646385	MNG	2025-05-17	YOLDA
1544	1544	TR42826833	Aras	2025-05-16	YOLDA
1545	1545	TR74047649	Aras	2025-05-20	TESLIM_EDILDI
1546	1546	TR41106865	Aras	2025-05-17	YOLDA
1547	1547	TR57386073	MNG	2025-05-20	YOLDA
1548	1548	TR56209251	PTT	2025-05-17	TESLIM_EDILDI
1549	1549	TR12534635	Yurtiçi	2025-05-18	YOLDA
1550	1550	TR75133088	MNG	2025-05-15	TESLIM_EDILDI
1551	1551	TR75338554	MNG	2025-05-14	YOLDA
1552	1552	TR40602683	Sürat	2025-05-18	TESLIM_EDILDI
1553	1553	TR35951785	Yurtiçi	2025-05-18	YOLDA
1554	1554	TR69908810	Yurtiçi	2025-05-17	YOLDA
1555	1555	TR51240275	Sürat	2025-05-17	TESLIM_EDILDI
1556	1556	TR05538751	Yurtiçi	2025-05-13	TESLIM_EDILDI
1557	1557	TR59187480	PTT	2025-05-15	YOLDA
1558	1558	TR10488472	PTT	2025-05-15	TESLIM_EDILDI
1559	1559	TR57463086	Yurtiçi	2025-05-16	TESLIM_EDILDI
1560	1560	TR37199694	Sürat	2025-05-15	YOLDA
1561	1561	TR58028728	Yurtiçi	2025-05-12	TESLIM_EDILDI
1562	1562	TR53628532	Aras	2025-05-18	YOLDA
1563	1563	TR18393700	Yurtiçi	2025-05-13	YOLDA
1564	1564	TR87136134	PTT	2025-05-17	TESLIM_EDILDI
1565	1565	TR23702100	Yurtiçi	2025-05-15	TESLIM_EDILDI
1566	1566	TR05450308	Sürat	2025-05-15	TESLIM_EDILDI
1567	1567	TR78668882	MNG	2025-05-20	TESLIM_EDILDI
1568	1568	TR71130425	MNG	2025-05-18	YOLDA
1569	1569	TR85837962	MNG	2025-05-15	YOLDA
1570	1570	TR95478802	Yurtiçi	2025-05-19	TESLIM_EDILDI
1571	1571	TR16059527	Aras	2025-05-17	YOLDA
1572	1572	TR90704526	Aras	2025-05-18	TESLIM_EDILDI
1573	1573	TR99049120	MNG	2025-05-16	YOLDA
1574	1574	TR58606086	MNG	2025-05-15	YOLDA
1575	1575	TR74766814	Aras	2025-05-17	TESLIM_EDILDI
1576	1576	TR20479659	Yurtiçi	2025-05-15	TESLIM_EDILDI
1577	1577	TR81132571	MNG	2025-05-17	YOLDA
1578	1578	TR40138402	PTT	2025-05-16	TESLIM_EDILDI
1579	1579	TR35752492	Sürat	2025-05-13	TESLIM_EDILDI
1580	1580	TR20535781	Sürat	2025-05-12	YOLDA
1581	1581	TR19985234	Sürat	2025-05-19	YOLDA
1582	1582	TR54579846	Sürat	2025-05-17	TESLIM_EDILDI
1583	1583	TR81160694	Yurtiçi	2025-05-16	YOLDA
1584	1584	TR44790939	Sürat	2025-05-15	TESLIM_EDILDI
1585	1585	TR13481743	Sürat	2025-05-14	YOLDA
1586	1586	TR39782261	Aras	2025-05-19	YOLDA
1587	1587	TR41028101	PTT	2025-05-15	TESLIM_EDILDI
1588	1588	TR97477623	PTT	2025-05-19	TESLIM_EDILDI
1589	1589	TR50589057	Sürat	2025-05-15	TESLIM_EDILDI
1590	1590	TR68547028	Yurtiçi	2025-05-16	TESLIM_EDILDI
1591	1591	TR37034656	MNG	2025-05-19	YOLDA
1592	1592	TR79964371	Aras	2025-05-20	YOLDA
1593	1593	TR69643905	Aras	2025-05-17	TESLIM_EDILDI
1594	1594	TR50813047	Yurtiçi	2025-05-18	YOLDA
1595	1595	TR28364253	PTT	2025-05-19	TESLIM_EDILDI
1596	1596	TR44979875	Aras	2025-05-15	TESLIM_EDILDI
1597	1597	TR67760051	Aras	2025-05-13	TESLIM_EDILDI
1598	1598	TR98436636	Sürat	2025-05-17	YOLDA
1599	1599	TR82270201	PTT	2025-05-14	TESLIM_EDILDI
1600	1600	TR38328167	Aras	2025-05-20	YOLDA
1601	1601	TR08369209	Sürat	2025-05-18	YOLDA
1602	1602	TR31311837	PTT	2025-05-19	YOLDA
1603	1603	TR77106006	PTT	2025-05-20	YOLDA
1604	1604	TR95390090	Aras	2025-05-19	YOLDA
1605	1605	TR17415163	Aras	2025-05-12	TESLIM_EDILDI
1606	1606	TR45276168	Yurtiçi	2025-05-17	TESLIM_EDILDI
1607	1607	TR67714330	Aras	2025-05-14	TESLIM_EDILDI
1608	1608	TR07798771	Sürat	2025-05-19	TESLIM_EDILDI
1609	1609	TR22182131	Yurtiçi	2025-05-20	YOLDA
1610	1610	TR63240490	Sürat	2025-05-15	YOLDA
1611	1611	TR18956109	PTT	2025-05-13	TESLIM_EDILDI
1612	1612	TR48626964	MNG	2025-05-20	TESLIM_EDILDI
1613	1613	TR80002563	PTT	2025-05-17	TESLIM_EDILDI
1614	1614	TR96871881	Yurtiçi	2025-05-17	YOLDA
1615	1615	TR77399042	MNG	2025-05-20	TESLIM_EDILDI
1616	1616	TR89819957	Sürat	2025-05-13	YOLDA
1617	1617	TR93317529	MNG	2025-05-13	TESLIM_EDILDI
1618	1618	TR84216992	Aras	2025-05-17	YOLDA
1619	1619	TR60682077	Yurtiçi	2025-05-20	YOLDA
1620	1620	TR69684481	Yurtiçi	2025-05-18	YOLDA
1621	1621	TR63474894	PTT	2025-05-12	YOLDA
1622	1622	TR52902589	Yurtiçi	2025-05-18	TESLIM_EDILDI
1623	1623	TR45704638	MNG	2025-05-18	YOLDA
1624	1624	TR42176742	MNG	2025-05-15	YOLDA
1625	1625	TR57282747	Aras	2025-05-20	YOLDA
1626	1626	TR05347971	Sürat	2025-05-16	TESLIM_EDILDI
1627	1627	TR38676550	PTT	2025-05-16	TESLIM_EDILDI
1628	1628	TR29878802	Aras	2025-05-14	TESLIM_EDILDI
1629	1629	TR05032619	Aras	2025-05-15	TESLIM_EDILDI
1630	1630	TR35737100	Sürat	2025-05-18	YOLDA
1631	1631	TR32483337	MNG	2025-05-13	YOLDA
1632	1632	TR57279152	Yurtiçi	2025-05-14	TESLIM_EDILDI
1633	1633	TR86747080	PTT	2025-05-17	TESLIM_EDILDI
1634	1634	TR27724403	MNG	2025-05-18	TESLIM_EDILDI
1635	1635	TR72659658	Sürat	2025-05-14	YOLDA
1636	1636	TR40852885	PTT	2025-05-13	TESLIM_EDILDI
1637	1637	TR95582996	MNG	2025-05-19	YOLDA
1638	1638	TR53640757	MNG	2025-05-18	YOLDA
1639	1639	TR87074713	Yurtiçi	2025-05-20	TESLIM_EDILDI
1640	1640	TR01511856	Sürat	2025-05-20	YOLDA
1641	1641	TR47503770	MNG	2025-05-13	TESLIM_EDILDI
1642	1642	TR55198464	PTT	2025-05-14	TESLIM_EDILDI
1643	1643	TR97737786	Sürat	2025-05-19	YOLDA
1644	1644	TR34416867	MNG	2025-05-20	TESLIM_EDILDI
1645	1645	TR02411806	Yurtiçi	2025-05-17	TESLIM_EDILDI
1646	1646	TR10339272	PTT	2025-05-16	YOLDA
1647	1647	TR17722433	Sürat	2025-05-19	YOLDA
1648	1648	TR74610790	Sürat	2025-05-13	TESLIM_EDILDI
1649	1649	TR79121970	Aras	2025-05-19	YOLDA
1650	1650	TR23369571	PTT	2025-05-13	YOLDA
1651	1651	TR00552826	Sürat	2025-05-17	YOLDA
1652	1652	TR94980572	PTT	2025-05-19	TESLIM_EDILDI
1653	1653	TR71504993	Yurtiçi	2025-05-20	YOLDA
1654	1654	TR97212531	PTT	2025-05-16	TESLIM_EDILDI
1655	1655	TR11813420	Aras	2025-05-19	YOLDA
1656	1656	TR89296729	PTT	2025-05-18	TESLIM_EDILDI
1657	1657	TR35881652	MNG	2025-05-15	TESLIM_EDILDI
1658	1658	TR52803066	Sürat	2025-05-14	YOLDA
1659	1659	TR84672977	PTT	2025-05-20	TESLIM_EDILDI
1660	1660	TR45113630	Sürat	2025-05-14	TESLIM_EDILDI
1661	1661	TR67506640	Sürat	2025-05-14	YOLDA
1662	1662	TR49707417	Sürat	2025-05-15	YOLDA
1663	1663	TR59451384	MNG	2025-05-16	TESLIM_EDILDI
1664	1664	TR08915157	Aras	2025-05-18	TESLIM_EDILDI
1665	1665	TR27439901	Yurtiçi	2025-05-13	YOLDA
1666	1666	TR37363620	Yurtiçi	2025-05-13	YOLDA
1667	1667	TR32020721	Sürat	2025-05-19	TESLIM_EDILDI
1668	1668	TR25138406	Aras	2025-05-15	YOLDA
1669	1669	TR53335953	Sürat	2025-05-12	TESLIM_EDILDI
1670	1670	TR87420704	Sürat	2025-05-15	YOLDA
1671	1671	TR78630430	PTT	2025-05-18	YOLDA
1672	1672	TR75829491	Sürat	2025-05-12	YOLDA
1673	1673	TR16855857	MNG	2025-05-18	YOLDA
1674	1674	TR89191164	Sürat	2025-05-14	YOLDA
1675	1675	TR22638130	PTT	2025-05-17	TESLIM_EDILDI
1676	1676	TR38149330	MNG	2025-05-18	TESLIM_EDILDI
1677	1677	TR73498581	Aras	2025-05-19	TESLIM_EDILDI
1678	1678	TR25345757	Yurtiçi	2025-05-19	TESLIM_EDILDI
1679	1679	TR20320953	Aras	2025-05-15	YOLDA
1680	1680	TR97809853	PTT	2025-05-16	YOLDA
1681	1681	TR33780678	PTT	2025-05-13	TESLIM_EDILDI
1682	1682	TR46261270	Sürat	2025-05-17	TESLIM_EDILDI
1683	1683	TR61202168	Aras	2025-05-16	TESLIM_EDILDI
1684	1684	TR20731113	MNG	2025-05-19	TESLIM_EDILDI
1685	1685	TR70505756	Sürat	2025-05-20	TESLIM_EDILDI
1686	1686	TR20504956	MNG	2025-05-12	TESLIM_EDILDI
1687	1687	TR70511286	Sürat	2025-05-18	YOLDA
1688	1688	TR92506687	Yurtiçi	2025-05-12	YOLDA
1689	1689	TR31297003	Sürat	2025-05-14	YOLDA
1690	1690	TR14031839	Sürat	2025-05-20	YOLDA
1691	1691	TR33402020	Yurtiçi	2025-05-14	YOLDA
1692	1692	TR01917812	Aras	2025-05-13	TESLIM_EDILDI
1693	1693	TR67658640	Yurtiçi	2025-05-14	YOLDA
1694	1694	TR54683649	MNG	2025-05-20	TESLIM_EDILDI
1695	1695	TR14832043	Aras	2025-05-20	YOLDA
1696	1696	TR37025931	Aras	2025-05-18	TESLIM_EDILDI
1697	1697	TR47369146	Aras	2025-05-20	TESLIM_EDILDI
1698	1698	TR61259121	Aras	2025-05-12	TESLIM_EDILDI
1699	1699	TR91634612	Aras	2025-05-12	TESLIM_EDILDI
1700	1700	TR92670396	Aras	2025-05-12	YOLDA
1701	1701	TR17801045	Sürat	2025-05-20	TESLIM_EDILDI
1702	1702	TR12901116	PTT	2025-05-18	YOLDA
1703	1703	TR89472010	MNG	2025-05-12	TESLIM_EDILDI
1704	1704	TR74952671	Sürat	2025-05-13	TESLIM_EDILDI
1705	1705	TR43928761	Sürat	2025-05-20	YOLDA
1706	1706	TR73056320	PTT	2025-05-15	TESLIM_EDILDI
1707	1707	TR38331572	Yurtiçi	2025-05-19	YOLDA
1708	1708	TR19159890	Aras	2025-05-13	YOLDA
1709	1709	TR81584613	PTT	2025-05-20	YOLDA
1710	1710	TR54654062	PTT	2025-05-13	TESLIM_EDILDI
1711	1711	TR47526849	Aras	2025-05-15	YOLDA
1712	1712	TR51538943	Aras	2025-05-19	YOLDA
1713	1713	TR38829805	MNG	2025-05-12	TESLIM_EDILDI
1714	1714	TR65351788	Yurtiçi	2025-05-15	TESLIM_EDILDI
1715	1715	TR20713819	Yurtiçi	2025-05-16	TESLIM_EDILDI
1716	1716	TR42992514	Sürat	2025-05-18	TESLIM_EDILDI
1717	1717	TR83313949	MNG	2025-05-18	YOLDA
1718	1718	TR96581129	Sürat	2025-05-19	YOLDA
1719	1719	TR68245361	Yurtiçi	2025-05-17	YOLDA
1720	1720	TR33739625	Yurtiçi	2025-05-15	YOLDA
1721	1721	TR91785976	Aras	2025-05-12	YOLDA
1722	1722	TR69103306	Aras	2025-05-15	TESLIM_EDILDI
1723	1723	TR05864624	Aras	2025-05-20	YOLDA
1724	1724	TR63958786	Aras	2025-05-20	TESLIM_EDILDI
1725	1725	TR58847275	Aras	2025-05-16	TESLIM_EDILDI
1726	1726	TR48236345	MNG	2025-05-18	TESLIM_EDILDI
1727	1727	TR76020895	Aras	2025-05-12	YOLDA
1728	1728	TR10016112	Yurtiçi	2025-05-16	TESLIM_EDILDI
1729	1729	TR08608323	Yurtiçi	2025-05-15	TESLIM_EDILDI
1730	1730	TR02273009	PTT	2025-05-17	YOLDA
1731	1731	TR41713887	Yurtiçi	2025-05-18	YOLDA
1732	1732	TR66643465	MNG	2025-05-15	YOLDA
1733	1733	TR11238736	Aras	2025-05-19	YOLDA
1734	1734	TR97930615	PTT	2025-05-17	YOLDA
1735	1735	TR36084346	Sürat	2025-05-20	TESLIM_EDILDI
1736	1736	TR65149102	Aras	2025-05-13	YOLDA
1737	1737	TR30253977	MNG	2025-05-15	TESLIM_EDILDI
1738	1738	TR29864472	Aras	2025-05-13	TESLIM_EDILDI
1739	1739	TR16631477	Yurtiçi	2025-05-15	YOLDA
1740	1740	TR29959250	Sürat	2025-05-14	TESLIM_EDILDI
1741	1741	TR57682168	Sürat	2025-05-19	TESLIM_EDILDI
1742	1742	TR12432573	Sürat	2025-05-20	YOLDA
1743	1743	TR83906318	PTT	2025-05-15	TESLIM_EDILDI
1744	1744	TR62737098	Sürat	2025-05-16	YOLDA
1745	1745	TR44187546	Yurtiçi	2025-05-18	YOLDA
1746	1746	TR52246137	PTT	2025-05-12	YOLDA
1747	1747	TR45931256	Aras	2025-05-13	YOLDA
1748	1748	TR63552583	Aras	2025-05-15	TESLIM_EDILDI
1749	1749	TR06231409	PTT	2025-05-16	TESLIM_EDILDI
1750	1750	TR95401692	PTT	2025-05-17	TESLIM_EDILDI
1751	1751	TR59058664	Yurtiçi	2025-05-20	YOLDA
1752	1752	TR10648378	Aras	2025-05-16	TESLIM_EDILDI
1753	1753	TR67114682	PTT	2025-05-13	YOLDA
1754	1754	TR68767758	Yurtiçi	2025-05-14	YOLDA
1755	1755	TR80955686	Yurtiçi	2025-05-17	TESLIM_EDILDI
1756	1756	TR70530057	PTT	2025-05-14	YOLDA
1757	1757	TR28254796	Yurtiçi	2025-05-17	YOLDA
1758	1758	TR67724974	Yurtiçi	2025-05-17	YOLDA
1759	1759	TR90259217	Sürat	2025-05-18	TESLIM_EDILDI
1760	1760	TR20595831	PTT	2025-05-19	TESLIM_EDILDI
1761	1761	TR06936227	PTT	2025-05-18	YOLDA
1762	1762	TR18544485	Sürat	2025-05-16	TESLIM_EDILDI
1763	1763	TR72148035	Yurtiçi	2025-05-15	YOLDA
1764	1764	TR06996046	MNG	2025-05-13	YOLDA
1765	1765	TR15009252	MNG	2025-05-12	YOLDA
1766	1766	TR24231460	PTT	2025-05-15	TESLIM_EDILDI
1767	1767	TR46890106	Aras	2025-05-19	TESLIM_EDILDI
1768	1768	TR79644976	MNG	2025-05-13	TESLIM_EDILDI
1769	1769	TR75440347	Sürat	2025-05-15	TESLIM_EDILDI
1770	1770	TR86103863	Sürat	2025-05-13	YOLDA
1771	1771	TR35357433	Yurtiçi	2025-05-16	TESLIM_EDILDI
1772	1772	TR39097208	Sürat	2025-05-15	YOLDA
1773	1773	TR21117758	Sürat	2025-05-14	YOLDA
1774	1774	TR36139266	PTT	2025-05-17	YOLDA
1775	1775	TR43142646	MNG	2025-05-12	TESLIM_EDILDI
1776	1776	TR66087607	PTT	2025-05-15	TESLIM_EDILDI
1777	1777	TR36448006	PTT	2025-05-17	YOLDA
1778	1778	TR16665608	Aras	2025-05-14	YOLDA
1779	1779	TR97597120	MNG	2025-05-18	TESLIM_EDILDI
1780	1780	TR02334337	Aras	2025-05-15	YOLDA
1781	1781	TR80317872	Aras	2025-05-12	TESLIM_EDILDI
1782	1782	TR43851369	Aras	2025-05-16	YOLDA
1783	1783	TR20051779	Aras	2025-05-14	TESLIM_EDILDI
1784	1784	TR79182448	Yurtiçi	2025-05-17	YOLDA
1785	1785	TR45263077	Sürat	2025-05-14	YOLDA
1786	1786	TR43421376	Aras	2025-05-12	TESLIM_EDILDI
1787	1787	TR33209407	PTT	2025-05-18	TESLIM_EDILDI
1788	1788	TR10837712	Sürat	2025-05-13	TESLIM_EDILDI
1789	1789	TR67728317	Aras	2025-05-15	TESLIM_EDILDI
1790	1790	TR53968618	Aras	2025-05-14	YOLDA
1791	1791	TR35321214	Aras	2025-05-15	YOLDA
1792	1792	TR48541984	MNG	2025-05-20	TESLIM_EDILDI
1793	1793	TR97428643	Sürat	2025-05-18	TESLIM_EDILDI
1794	1794	TR99274550	Aras	2025-05-17	YOLDA
1795	1795	TR54148214	Yurtiçi	2025-05-19	YOLDA
1796	1796	TR94629228	PTT	2025-05-12	TESLIM_EDILDI
1797	1797	TR74686329	Sürat	2025-05-16	YOLDA
1798	1798	TR18259543	Sürat	2025-05-16	YOLDA
1799	1799	TR09632770	Aras	2025-05-12	TESLIM_EDILDI
1800	1800	TR71233386	Sürat	2025-05-15	YOLDA
1801	1801	TR86285992	PTT	2025-05-19	TESLIM_EDILDI
1802	1802	TR25283298	Yurtiçi	2025-05-18	YOLDA
1803	1803	TR35593685	MNG	2025-05-14	YOLDA
1804	1804	TR27621047	MNG	2025-05-16	TESLIM_EDILDI
1805	1805	TR83381376	Aras	2025-05-20	TESLIM_EDILDI
1806	1806	TR33412243	Aras	2025-05-19	TESLIM_EDILDI
1807	1807	TR09373092	Yurtiçi	2025-05-14	TESLIM_EDILDI
1808	1808	TR42386374	Aras	2025-05-17	YOLDA
1809	1809	TR71559350	Sürat	2025-05-13	TESLIM_EDILDI
1810	1810	TR66976737	PTT	2025-05-17	TESLIM_EDILDI
1811	1811	TR57653814	MNG	2025-05-12	YOLDA
1812	1812	TR51496073	Sürat	2025-05-16	YOLDA
1813	1813	TR92084229	MNG	2025-05-12	YOLDA
1814	1814	TR14945789	Sürat	2025-05-16	YOLDA
1815	1815	TR06343718	MNG	2025-05-19	TESLIM_EDILDI
1816	1816	TR79988459	PTT	2025-05-15	YOLDA
1817	1817	TR30803943	Aras	2025-05-17	YOLDA
1818	1818	TR62055060	MNG	2025-05-14	YOLDA
1819	1819	TR95911507	Aras	2025-05-15	YOLDA
1820	1820	TR37153728	Aras	2025-05-15	TESLIM_EDILDI
1821	1821	TR00372964	Sürat	2025-05-20	YOLDA
1822	1822	TR19260062	Yurtiçi	2025-05-15	TESLIM_EDILDI
1823	1823	TR51569823	Yurtiçi	2025-05-12	YOLDA
1824	1824	TR40770094	PTT	2025-05-12	YOLDA
1825	1825	TR00954803	PTT	2025-05-19	YOLDA
1826	1826	TR39183870	Yurtiçi	2025-05-17	TESLIM_EDILDI
1827	1827	TR12119450	Yurtiçi	2025-05-12	TESLIM_EDILDI
1828	1828	TR20370093	Sürat	2025-05-16	TESLIM_EDILDI
1829	1829	TR48481056	Aras	2025-05-13	TESLIM_EDILDI
1830	1830	TR67874777	Yurtiçi	2025-05-16	TESLIM_EDILDI
1831	1831	TR41941879	PTT	2025-05-18	YOLDA
1832	1832	TR18890156	MNG	2025-05-18	TESLIM_EDILDI
1833	1833	TR92449360	Sürat	2025-05-18	YOLDA
1834	1834	TR57445662	Yurtiçi	2025-05-20	TESLIM_EDILDI
1835	1835	TR58759606	Yurtiçi	2025-05-16	YOLDA
1836	1836	TR67877687	Sürat	2025-05-13	YOLDA
1837	1837	TR75869460	MNG	2025-05-13	YOLDA
1838	1838	TR80195868	Sürat	2025-05-15	YOLDA
1839	1839	TR51363514	Sürat	2025-05-16	YOLDA
1840	1840	TR16591920	Sürat	2025-05-13	TESLIM_EDILDI
1841	1841	TR31243490	Sürat	2025-05-20	TESLIM_EDILDI
1842	1842	TR44615396	Sürat	2025-05-20	YOLDA
1843	1843	TR83345267	Aras	2025-05-18	TESLIM_EDILDI
1844	1844	TR01788460	MNG	2025-05-20	YOLDA
1845	1845	TR68194972	Aras	2025-05-15	YOLDA
1846	1846	TR98853595	Yurtiçi	2025-05-18	TESLIM_EDILDI
1847	1847	TR13676643	PTT	2025-05-16	YOLDA
1848	1848	TR46736466	Aras	2025-05-13	TESLIM_EDILDI
1849	1849	TR97040537	Aras	2025-05-12	YOLDA
1850	1850	TR23661262	PTT	2025-05-14	TESLIM_EDILDI
1851	1851	TR22170033	PTT	2025-05-13	YOLDA
1852	1852	TR31613263	Aras	2025-05-17	TESLIM_EDILDI
1853	1853	TR38513340	Yurtiçi	2025-05-17	YOLDA
1854	1854	TR09214058	MNG	2025-05-16	YOLDA
1855	1855	TR82780975	PTT	2025-05-12	TESLIM_EDILDI
1856	1856	TR36318836	Sürat	2025-05-17	YOLDA
1857	1857	TR50341728	Yurtiçi	2025-05-20	YOLDA
1858	1858	TR61836329	Sürat	2025-05-16	YOLDA
1859	1859	TR24269633	Sürat	2025-05-20	TESLIM_EDILDI
1860	1860	TR93465339	Sürat	2025-05-12	YOLDA
1861	1861	TR24220812	PTT	2025-05-20	YOLDA
1862	1862	TR38502648	MNG	2025-05-19	TESLIM_EDILDI
1863	1863	TR73339014	MNG	2025-05-19	YOLDA
1864	1864	TR20451522	PTT	2025-05-16	YOLDA
1865	1865	TR74076548	MNG	2025-05-14	TESLIM_EDILDI
1866	1866	TR20028037	Sürat	2025-05-16	TESLIM_EDILDI
1867	1867	TR05607117	Yurtiçi	2025-05-16	YOLDA
1868	1868	TR76517595	Yurtiçi	2025-05-16	TESLIM_EDILDI
1869	1869	TR88428829	Aras	2025-05-19	TESLIM_EDILDI
1870	1870	TR03773276	Yurtiçi	2025-05-14	TESLIM_EDILDI
1871	1871	TR35038428	Aras	2025-05-14	TESLIM_EDILDI
1872	1872	TR63332561	Yurtiçi	2025-05-18	YOLDA
1873	1873	TR20893995	MNG	2025-05-14	TESLIM_EDILDI
1874	1874	TR74070462	Yurtiçi	2025-05-17	TESLIM_EDILDI
1875	1875	TR52942841	Yurtiçi	2025-05-13	TESLIM_EDILDI
1876	1876	TR03076372	MNG	2025-05-17	YOLDA
1877	1877	TR47212959	Aras	2025-05-12	TESLIM_EDILDI
1878	1878	TR31655472	MNG	2025-05-18	TESLIM_EDILDI
1879	1879	TR68821816	Aras	2025-05-20	TESLIM_EDILDI
1880	1880	TR90586986	PTT	2025-05-12	YOLDA
1881	1881	TR33979003	Yurtiçi	2025-05-12	TESLIM_EDILDI
1882	1882	TR91206955	Aras	2025-05-12	YOLDA
1883	1883	TR28075107	MNG	2025-05-16	YOLDA
1884	1884	TR09305929	Sürat	2025-05-19	YOLDA
1885	1885	TR22636370	Sürat	2025-05-16	TESLIM_EDILDI
1886	1886	TR49712674	Aras	2025-05-19	YOLDA
1887	1887	TR19431728	PTT	2025-05-12	TESLIM_EDILDI
1888	1888	TR02259929	Yurtiçi	2025-05-14	YOLDA
1889	1889	TR47101632	Sürat	2025-05-14	TESLIM_EDILDI
1890	1890	TR15137598	MNG	2025-05-13	YOLDA
1891	1891	TR99165801	Sürat	2025-05-12	TESLIM_EDILDI
1892	1892	TR60135560	PTT	2025-05-14	TESLIM_EDILDI
1893	1893	TR24009961	PTT	2025-05-16	YOLDA
1894	1894	TR39060648	PTT	2025-05-18	YOLDA
1895	1895	TR87240383	PTT	2025-05-15	YOLDA
1896	1896	TR10446432	Yurtiçi	2025-05-13	YOLDA
1897	1897	TR05471174	Sürat	2025-05-20	TESLIM_EDILDI
1898	1898	TR25266403	Yurtiçi	2025-05-17	TESLIM_EDILDI
1899	1899	TR65893604	MNG	2025-05-15	TESLIM_EDILDI
1900	1900	TR77274802	Yurtiçi	2025-05-17	YOLDA
1901	1901	TR47022630	MNG	2025-05-13	YOLDA
1902	1902	TR96058039	Yurtiçi	2025-05-15	YOLDA
1903	1903	TR74205592	PTT	2025-05-14	TESLIM_EDILDI
1904	1904	TR65848759	Sürat	2025-05-15	TESLIM_EDILDI
1905	1905	TR43083166	MNG	2025-05-18	TESLIM_EDILDI
1906	1906	TR96182481	MNG	2025-05-12	TESLIM_EDILDI
1907	1907	TR57427812	Yurtiçi	2025-05-13	TESLIM_EDILDI
1908	1908	TR34927915	Aras	2025-05-14	TESLIM_EDILDI
1909	1909	TR52799182	PTT	2025-05-20	YOLDA
1910	1910	TR72648767	PTT	2025-05-15	TESLIM_EDILDI
1911	1911	TR41279792	MNG	2025-05-20	YOLDA
1912	1912	TR69856470	Sürat	2025-05-14	YOLDA
1913	1913	TR10696259	Aras	2025-05-19	YOLDA
1914	1914	TR91252851	Aras	2025-05-19	TESLIM_EDILDI
1915	1915	TR43697050	PTT	2025-05-18	YOLDA
1916	1916	TR90977210	Sürat	2025-05-16	TESLIM_EDILDI
1917	1917	TR65961703	Yurtiçi	2025-05-19	TESLIM_EDILDI
1918	1918	TR57163510	Sürat	2025-05-19	TESLIM_EDILDI
1919	1919	TR34189461	PTT	2025-05-13	TESLIM_EDILDI
1920	1920	TR29660826	Sürat	2025-05-17	YOLDA
1921	1921	TR49665730	MNG	2025-05-13	TESLIM_EDILDI
1922	1922	TR36888846	Sürat	2025-05-14	YOLDA
1923	1923	TR54259892	Aras	2025-05-20	YOLDA
1924	1924	TR15102873	Sürat	2025-05-20	YOLDA
1925	1925	TR22961676	Sürat	2025-05-16	TESLIM_EDILDI
1926	1926	TR00192782	PTT	2025-05-16	YOLDA
1927	1927	TR78893731	MNG	2025-05-18	TESLIM_EDILDI
1928	1928	TR98778130	Yurtiçi	2025-05-15	YOLDA
1929	1929	TR14901167	PTT	2025-05-20	TESLIM_EDILDI
1930	1930	TR67623933	Sürat	2025-05-19	TESLIM_EDILDI
1931	1931	TR87181320	Sürat	2025-05-19	YOLDA
1932	1932	TR59455451	Sürat	2025-05-12	TESLIM_EDILDI
1933	1933	TR61014308	Aras	2025-05-14	TESLIM_EDILDI
1934	1934	TR41781996	MNG	2025-05-14	TESLIM_EDILDI
1935	1935	TR78178807	Sürat	2025-05-19	TESLIM_EDILDI
1936	1936	TR24690038	Yurtiçi	2025-05-14	TESLIM_EDILDI
1937	1937	TR47908271	Sürat	2025-05-19	TESLIM_EDILDI
1938	1938	TR40191379	Aras	2025-05-19	TESLIM_EDILDI
1939	1939	TR57613457	MNG	2025-05-19	TESLIM_EDILDI
1940	1940	TR28829551	Sürat	2025-05-15	TESLIM_EDILDI
1941	1941	TR15247292	PTT	2025-05-12	YOLDA
1942	1942	TR89860432	PTT	2025-05-18	YOLDA
1943	1943	TR94851742	PTT	2025-05-15	YOLDA
1944	1944	TR57111167	PTT	2025-05-16	TESLIM_EDILDI
1945	1945	TR19441081	Sürat	2025-05-18	TESLIM_EDILDI
1946	1946	TR59707922	MNG	2025-05-20	YOLDA
1947	1947	TR63314048	Yurtiçi	2025-05-19	YOLDA
1948	1948	TR04689615	MNG	2025-05-15	TESLIM_EDILDI
1949	1949	TR69853628	MNG	2025-05-12	YOLDA
1950	1950	TR57228154	Yurtiçi	2025-05-17	YOLDA
1951	1951	TR63692334	Yurtiçi	2025-05-12	TESLIM_EDILDI
1952	1952	TR97263153	MNG	2025-05-19	TESLIM_EDILDI
1953	1953	TR66641325	Yurtiçi	2025-05-20	TESLIM_EDILDI
1954	1954	TR97812237	Sürat	2025-05-13	TESLIM_EDILDI
1955	1955	TR19807392	PTT	2025-05-17	YOLDA
1956	1956	TR54256289	PTT	2025-05-18	YOLDA
1957	1957	TR70098052	PTT	2025-05-15	TESLIM_EDILDI
1958	1958	TR16189559	Aras	2025-05-20	YOLDA
1959	1959	TR03372379	Sürat	2025-05-12	YOLDA
1960	1960	TR59643563	Aras	2025-05-20	YOLDA
1961	1961	TR39298781	Aras	2025-05-20	YOLDA
1962	1962	TR65988761	Sürat	2025-05-13	TESLIM_EDILDI
1963	1963	TR82144122	Yurtiçi	2025-05-12	YOLDA
1964	1964	TR17873232	Yurtiçi	2025-05-15	TESLIM_EDILDI
1965	1965	TR86733750	MNG	2025-05-14	YOLDA
1966	1966	TR99601953	PTT	2025-05-20	YOLDA
1967	1967	TR42764482	PTT	2025-05-14	TESLIM_EDILDI
1968	1968	TR80712007	Aras	2025-05-18	TESLIM_EDILDI
1969	1969	TR45076861	Aras	2025-05-20	YOLDA
1970	1970	TR41709254	Aras	2025-05-16	YOLDA
1971	1971	TR82959039	Yurtiçi	2025-05-20	TESLIM_EDILDI
1972	1972	TR95405273	Yurtiçi	2025-05-18	YOLDA
1973	1973	TR76609507	Aras	2025-05-16	TESLIM_EDILDI
1974	1974	TR49275578	MNG	2025-05-18	TESLIM_EDILDI
1975	1975	TR19069090	Yurtiçi	2025-05-12	YOLDA
1976	1976	TR98740385	Aras	2025-05-18	TESLIM_EDILDI
1977	1977	TR56912514	Yurtiçi	2025-05-12	TESLIM_EDILDI
1978	1978	TR06023737	PTT	2025-05-15	YOLDA
1979	1979	TR45607731	PTT	2025-05-14	TESLIM_EDILDI
1980	1980	TR84718055	PTT	2025-05-19	YOLDA
1981	1981	TR24478966	Yurtiçi	2025-05-20	YOLDA
1982	1982	TR91973048	Aras	2025-05-17	YOLDA
1983	1983	TR22783703	Aras	2025-05-12	TESLIM_EDILDI
1984	1984	TR37921631	Aras	2025-05-14	YOLDA
1985	1985	TR76072907	Aras	2025-05-14	TESLIM_EDILDI
1986	1986	TR81042934	Yurtiçi	2025-05-19	YOLDA
1987	1987	TR81477757	Aras	2025-05-20	TESLIM_EDILDI
1988	1988	TR18317739	PTT	2025-05-17	YOLDA
1989	1989	TR10181115	Sürat	2025-05-13	TESLIM_EDILDI
1990	1990	TR97078867	Yurtiçi	2025-05-12	TESLIM_EDILDI
1991	1991	TR51823088	Sürat	2025-05-20	TESLIM_EDILDI
1992	1992	TR39224000	PTT	2025-05-20	YOLDA
1993	1993	TR06462212	Aras	2025-05-19	YOLDA
1994	1994	TR87057501	Sürat	2025-05-12	YOLDA
1995	1995	TR41063016	PTT	2025-05-16	YOLDA
1996	1996	TR88057973	PTT	2025-05-18	YOLDA
1997	1997	TR92972791	MNG	2025-05-14	TESLIM_EDILDI
1998	1998	TR54619042	MNG	2025-05-18	TESLIM_EDILDI
1999	1999	TR18145798	MNG	2025-05-12	TESLIM_EDILDI
2000	2000	TR81486847	Aras	2025-05-15	YOLDA
2001	2001	TR43104813	Aras	2025-05-15	YOLDA
2002	2002	TR67298137	MNG	2025-05-13	TESLIM_EDILDI
2003	2003	TR54327154	Aras	2025-05-17	TESLIM_EDILDI
2004	2004	TR31074206	MNG	2025-05-17	TESLIM_EDILDI
2005	2005	TR45025450	Yurtiçi	2025-05-13	TESLIM_EDILDI
2006	2006	TR03914888	Yurtiçi	2025-05-19	TESLIM_EDILDI
2007	2007	TR89745638	MNG	2025-05-14	YOLDA
2008	2008	TR54762155	PTT	2025-05-12	TESLIM_EDILDI
2009	2009	TR62439469	PTT	2025-05-13	YOLDA
2010	2010	TR46243754	Sürat	2025-05-14	YOLDA
2011	2011	TR46156633	MNG	2025-05-20	YOLDA
2012	2012	TR10320300	PTT	2025-05-13	TESLIM_EDILDI
2013	2013	TR22914625	MNG	2025-05-17	YOLDA
2014	2014	TR49855060	Yurtiçi	2025-05-15	TESLIM_EDILDI
2015	2015	TR27005567	PTT	2025-05-15	YOLDA
2016	2016	TR45587551	Aras	2025-05-15	TESLIM_EDILDI
2017	2017	TR20078486	Yurtiçi	2025-05-19	TESLIM_EDILDI
2018	2018	TR78190984	Aras	2025-05-19	TESLIM_EDILDI
2019	2019	TR32100347	Aras	2025-05-18	TESLIM_EDILDI
2020	2020	TR57075702	Sürat	2025-05-20	YOLDA
2021	2021	TR86505336	Yurtiçi	2025-05-14	YOLDA
2022	2022	TR58012436	Yurtiçi	2025-05-19	YOLDA
2023	2023	TR70436953	MNG	2025-05-19	TESLIM_EDILDI
2024	2024	TR78473559	Aras	2025-05-12	TESLIM_EDILDI
2025	2025	TR58410798	Aras	2025-05-19	TESLIM_EDILDI
2026	2026	TR13056951	Aras	2025-05-19	TESLIM_EDILDI
2027	2027	TR53952640	Sürat	2025-05-13	TESLIM_EDILDI
2028	2028	TR25961665	PTT	2025-05-14	TESLIM_EDILDI
2029	2029	TR99789446	Aras	2025-05-16	YOLDA
2030	2030	TR70994891	MNG	2025-05-19	TESLIM_EDILDI
2031	2031	TR66635512	Yurtiçi	2025-05-13	YOLDA
2032	2032	TR81779922	Yurtiçi	2025-05-19	TESLIM_EDILDI
2033	2033	TR15628215	Aras	2025-05-12	YOLDA
2034	2034	TR33924687	MNG	2025-05-20	TESLIM_EDILDI
2035	2035	TR91946105	Yurtiçi	2025-05-17	TESLIM_EDILDI
2036	2036	TR21877743	Aras	2025-05-18	YOLDA
2037	2037	TR01121147	MNG	2025-05-16	TESLIM_EDILDI
2038	2038	TR55565206	MNG	2025-05-17	YOLDA
2039	2039	TR74380174	Sürat	2025-05-18	TESLIM_EDILDI
2040	2040	TR86714408	Sürat	2025-05-14	TESLIM_EDILDI
2041	2041	TR81975331	Aras	2025-05-17	YOLDA
2042	2042	TR90408441	PTT	2025-05-13	TESLIM_EDILDI
2043	2043	TR28450167	PTT	2025-05-15	YOLDA
2044	2044	TR67548199	Yurtiçi	2025-05-16	YOLDA
2045	2045	TR77426043	PTT	2025-05-20	TESLIM_EDILDI
2046	2046	TR83472384	Sürat	2025-05-12	TESLIM_EDILDI
2047	2047	TR85979394	Sürat	2025-05-19	YOLDA
2048	2048	TR52096149	MNG	2025-05-20	TESLIM_EDILDI
2049	2049	TR68312427	Sürat	2025-05-13	YOLDA
2050	2050	TR09769578	Sürat	2025-05-12	TESLIM_EDILDI
2051	2051	TR05916018	MNG	2025-05-13	TESLIM_EDILDI
2052	2052	TR72878019	Aras	2025-05-13	TESLIM_EDILDI
2053	2053	TR80334837	PTT	2025-05-12	YOLDA
2054	2054	TR32818221	Yurtiçi	2025-05-15	TESLIM_EDILDI
2055	2055	TR96637993	Sürat	2025-05-20	YOLDA
2056	2056	TR86572346	PTT	2025-05-17	YOLDA
2057	2057	TR26014796	Sürat	2025-05-18	TESLIM_EDILDI
2058	2058	TR06681602	PTT	2025-05-16	YOLDA
2059	2059	TR25400297	Aras	2025-05-14	TESLIM_EDILDI
2060	2060	TR15512526	Aras	2025-05-13	TESLIM_EDILDI
2061	2061	TR75460881	MNG	2025-05-14	TESLIM_EDILDI
2062	2062	TR08343464	Yurtiçi	2025-05-20	YOLDA
2063	2063	TR32351044	Sürat	2025-05-14	TESLIM_EDILDI
2064	2064	TR62254938	PTT	2025-05-17	YOLDA
2065	2065	TR87017924	MNG	2025-05-18	TESLIM_EDILDI
2066	2066	TR37567542	Yurtiçi	2025-05-15	YOLDA
2067	2067	TR09036132	PTT	2025-05-20	TESLIM_EDILDI
2068	2068	TR41262711	Aras	2025-05-12	TESLIM_EDILDI
2069	2069	TR24001789	Aras	2025-05-17	TESLIM_EDILDI
2070	2070	TR96483318	Aras	2025-05-15	YOLDA
2071	2071	TR46752195	PTT	2025-05-15	TESLIM_EDILDI
2072	2072	TR87068358	Yurtiçi	2025-05-18	TESLIM_EDILDI
2073	2073	TR18634546	Sürat	2025-05-20	YOLDA
2074	2074	TR90721978	Sürat	2025-05-20	TESLIM_EDILDI
2075	2075	TR96708007	PTT	2025-05-18	YOLDA
2076	2076	TR99211530	MNG	2025-05-14	TESLIM_EDILDI
2077	2077	TR71108830	Yurtiçi	2025-05-12	YOLDA
2078	2078	TR31344381	MNG	2025-05-13	YOLDA
2079	2079	TR76415905	MNG	2025-05-20	YOLDA
2080	2080	TR22144993	MNG	2025-05-13	TESLIM_EDILDI
2081	2081	TR45937244	Sürat	2025-05-18	YOLDA
2082	2082	TR61809251	Yurtiçi	2025-05-19	TESLIM_EDILDI
2083	2083	TR02996999	Yurtiçi	2025-05-19	TESLIM_EDILDI
2084	2084	TR96976716	Sürat	2025-05-17	YOLDA
2085	2085	TR42762770	Aras	2025-05-17	YOLDA
2086	2086	TR06481660	PTT	2025-05-12	TESLIM_EDILDI
2087	2087	TR23159456	Aras	2025-05-20	TESLIM_EDILDI
2088	2088	TR51889579	PTT	2025-05-18	YOLDA
2089	2089	TR81339102	Sürat	2025-05-19	YOLDA
2090	2090	TR77860899	Yurtiçi	2025-05-12	TESLIM_EDILDI
2091	2091	TR80672851	Sürat	2025-05-13	TESLIM_EDILDI
2092	2092	TR26232367	PTT	2025-05-18	YOLDA
2093	2093	TR10658335	PTT	2025-05-18	TESLIM_EDILDI
2094	2094	TR85721351	Sürat	2025-05-12	YOLDA
2095	2095	TR53258518	MNG	2025-05-18	TESLIM_EDILDI
2096	2096	TR29554384	MNG	2025-05-16	TESLIM_EDILDI
2097	2097	TR59615860	PTT	2025-05-15	YOLDA
2098	2098	TR09559120	PTT	2025-05-18	YOLDA
2099	2099	TR05974449	Yurtiçi	2025-05-15	TESLIM_EDILDI
2100	2100	TR42489037	MNG	2025-05-15	TESLIM_EDILDI
2101	2101	TR72044487	Aras	2025-05-17	TESLIM_EDILDI
2102	2102	TR88008988	Yurtiçi	2025-05-15	TESLIM_EDILDI
2103	2103	TR02605816	Aras	2025-05-15	YOLDA
2104	2104	TR01164546	Sürat	2025-05-16	YOLDA
2105	2105	TR79180363	Yurtiçi	2025-05-16	YOLDA
2106	2106	TR40869168	Sürat	2025-05-13	YOLDA
2107	2107	TR82128269	MNG	2025-05-19	YOLDA
2108	2108	TR03938639	MNG	2025-05-18	TESLIM_EDILDI
2109	2109	TR07317800	PTT	2025-05-13	TESLIM_EDILDI
2110	2110	TR16920261	Aras	2025-05-12	TESLIM_EDILDI
2111	2111	TR94195289	Aras	2025-05-16	YOLDA
2112	2112	TR05828655	Yurtiçi	2025-05-15	YOLDA
2113	2113	TR26078405	Yurtiçi	2025-05-12	YOLDA
2114	2114	TR53134347	Sürat	2025-05-13	YOLDA
2115	2115	TR85299780	Sürat	2025-05-18	TESLIM_EDILDI
2116	2116	TR81486208	Aras	2025-05-14	YOLDA
2117	2117	TR21257174	MNG	2025-05-17	TESLIM_EDILDI
2118	2118	TR98707569	Sürat	2025-05-12	TESLIM_EDILDI
2119	2119	TR51792339	MNG	2025-05-20	YOLDA
2120	2120	TR45094100	Yurtiçi	2025-05-13	TESLIM_EDILDI
2121	2121	TR67769288	Yurtiçi	2025-05-13	YOLDA
2122	2122	TR25000831	MNG	2025-05-12	TESLIM_EDILDI
2123	2123	TR22668621	MNG	2025-05-16	YOLDA
2124	2124	TR76916302	Aras	2025-05-15	YOLDA
2125	2125	TR41308824	Yurtiçi	2025-05-18	YOLDA
2126	2126	TR55590355	Sürat	2025-05-17	TESLIM_EDILDI
2127	2127	TR69489034	PTT	2025-05-12	YOLDA
2128	2128	TR21477445	PTT	2025-05-17	TESLIM_EDILDI
2129	2129	TR05704128	Sürat	2025-05-13	TESLIM_EDILDI
2130	2130	TR71737929	MNG	2025-05-19	TESLIM_EDILDI
2131	2131	TR41269680	Sürat	2025-05-18	TESLIM_EDILDI
2132	2132	TR38652007	PTT	2025-05-17	YOLDA
2133	2133	TR22253888	Yurtiçi	2025-05-14	YOLDA
2134	2134	TR27755071	Yurtiçi	2025-05-12	YOLDA
2135	2135	TR40617872	Yurtiçi	2025-05-18	YOLDA
2136	2136	TR09555704	Yurtiçi	2025-05-17	YOLDA
2137	2137	TR83445498	Aras	2025-05-20	TESLIM_EDILDI
2138	2138	TR88828249	Sürat	2025-05-18	YOLDA
2139	2139	TR51608079	Yurtiçi	2025-05-14	TESLIM_EDILDI
2140	2140	TR87631478	Aras	2025-05-12	YOLDA
2141	2141	TR99933178	Aras	2025-05-18	TESLIM_EDILDI
2142	2142	TR58001261	Sürat	2025-05-18	YOLDA
2143	2143	TR53891358	Sürat	2025-05-16	TESLIM_EDILDI
2144	2144	TR59999076	Aras	2025-05-14	YOLDA
2145	2145	TR86039282	Sürat	2025-05-19	YOLDA
2146	2146	TR63439795	Sürat	2025-05-19	YOLDA
2147	2147	TR85710980	MNG	2025-05-15	YOLDA
2148	2148	TR81447780	Sürat	2025-05-17	TESLIM_EDILDI
2149	2149	TR96229291	Sürat	2025-05-15	TESLIM_EDILDI
2150	2150	TR75240461	Sürat	2025-05-14	YOLDA
2151	2151	TR23898535	Yurtiçi	2025-05-12	TESLIM_EDILDI
2152	2152	TR39356037	MNG	2025-05-17	YOLDA
2153	2153	TR85691333	Yurtiçi	2025-05-15	TESLIM_EDILDI
2154	2154	TR65896907	MNG	2025-05-19	TESLIM_EDILDI
2155	2155	TR70887139	Aras	2025-05-16	YOLDA
2156	2156	TR40645074	MNG	2025-05-14	YOLDA
2157	2157	TR69967690	MNG	2025-05-15	TESLIM_EDILDI
2158	2158	TR68269827	PTT	2025-05-16	YOLDA
2159	2159	TR83186395	Aras	2025-05-15	YOLDA
2160	2160	TR37414455	PTT	2025-05-12	YOLDA
2161	2161	TR75539705	PTT	2025-05-16	YOLDA
2162	2162	TR18124362	Aras	2025-05-20	TESLIM_EDILDI
2163	2163	TR59419118	Yurtiçi	2025-05-17	TESLIM_EDILDI
2164	2164	TR76095004	Yurtiçi	2025-05-20	TESLIM_EDILDI
2165	2165	TR05831606	MNG	2025-05-19	TESLIM_EDILDI
2166	2166	TR02378307	Yurtiçi	2025-05-13	YOLDA
2167	2167	TR43138552	Yurtiçi	2025-05-14	YOLDA
2168	2168	TR12420252	MNG	2025-05-20	TESLIM_EDILDI
2169	2169	TR89205951	PTT	2025-05-13	YOLDA
2170	2170	TR36304222	Sürat	2025-05-12	YOLDA
2171	2171	TR48190808	MNG	2025-05-12	YOLDA
2172	2172	TR63490170	MNG	2025-05-15	TESLIM_EDILDI
2173	2173	TR56230884	Sürat	2025-05-15	TESLIM_EDILDI
2174	2174	TR01761424	Yurtiçi	2025-05-15	TESLIM_EDILDI
2175	2175	TR85296363	Sürat	2025-05-20	TESLIM_EDILDI
2176	2176	TR01111258	Yurtiçi	2025-05-16	TESLIM_EDILDI
2177	2177	TR55563227	Sürat	2025-05-20	YOLDA
2178	2178	TR49883840	Sürat	2025-05-18	YOLDA
2179	2179	TR79422903	Yurtiçi	2025-05-18	TESLIM_EDILDI
2180	2180	TR22604209	Sürat	2025-05-19	TESLIM_EDILDI
2181	2181	TR21039699	PTT	2025-05-18	YOLDA
2182	2182	TR33310716	Yurtiçi	2025-05-15	TESLIM_EDILDI
2183	2183	TR44350814	Sürat	2025-05-14	TESLIM_EDILDI
2184	2184	TR58440512	Aras	2025-05-16	TESLIM_EDILDI
2185	2185	TR95774617	Yurtiçi	2025-05-19	YOLDA
2186	2186	TR24230834	PTT	2025-05-15	TESLIM_EDILDI
2187	2187	TR43536860	PTT	2025-05-14	YOLDA
2188	2188	TR40433344	Yurtiçi	2025-05-19	YOLDA
2189	2189	TR20192628	Yurtiçi	2025-05-20	YOLDA
2190	2190	TR13383030	MNG	2025-05-19	TESLIM_EDILDI
2191	2191	TR57867717	Aras	2025-05-13	YOLDA
2192	2192	TR85571977	Yurtiçi	2025-05-19	TESLIM_EDILDI
2193	2193	TR23067808	Sürat	2025-05-20	TESLIM_EDILDI
2194	2194	TR07603015	PTT	2025-05-13	TESLIM_EDILDI
2195	2195	TR96694824	Aras	2025-05-16	TESLIM_EDILDI
2196	2196	TR56354129	Aras	2025-05-12	TESLIM_EDILDI
2197	2197	TR64165649	Yurtiçi	2025-05-13	TESLIM_EDILDI
2198	2198	TR13602777	MNG	2025-05-13	TESLIM_EDILDI
2199	2199	TR22326057	PTT	2025-05-12	YOLDA
2200	2200	TR97685652	Sürat	2025-05-17	TESLIM_EDILDI
2201	2201	TR40264556	Sürat	2025-05-15	YOLDA
2202	2202	TR91960458	Sürat	2025-05-19	YOLDA
2203	2203	TR99204228	Sürat	2025-05-17	YOLDA
2204	2204	TR47996938	Aras	2025-05-12	YOLDA
2205	2205	TR86078754	Yurtiçi	2025-05-20	TESLIM_EDILDI
2206	2206	TR48135899	Sürat	2025-05-17	TESLIM_EDILDI
2207	2207	TR60224693	PTT	2025-05-20	YOLDA
2208	2208	TR52270902	Aras	2025-05-20	YOLDA
2209	2209	TR77763148	MNG	2025-05-18	YOLDA
2210	2210	TR08555651	PTT	2025-05-12	YOLDA
2211	2211	TR58751717	Yurtiçi	2025-05-16	YOLDA
2212	2212	TR22363739	Yurtiçi	2025-05-15	YOLDA
2213	2213	TR85007320	Sürat	2025-05-18	TESLIM_EDILDI
2214	2214	TR85663493	MNG	2025-05-15	TESLIM_EDILDI
2215	2215	TR61901499	Sürat	2025-05-13	TESLIM_EDILDI
2216	2216	TR90570429	Yurtiçi	2025-05-14	YOLDA
2217	2217	TR58517554	Aras	2025-05-13	YOLDA
2218	2218	TR12297582	PTT	2025-05-13	TESLIM_EDILDI
2219	2219	TR20403198	Yurtiçi	2025-05-12	TESLIM_EDILDI
2220	2220	TR05822314	Sürat	2025-05-17	YOLDA
2221	2221	TR79409861	MNG	2025-05-20	TESLIM_EDILDI
2222	2222	TR71090623	MNG	2025-05-13	YOLDA
2223	2223	TR38820405	Aras	2025-05-13	TESLIM_EDILDI
2224	2224	TR72123347	Aras	2025-05-12	YOLDA
2225	2225	TR81591157	Yurtiçi	2025-05-12	TESLIM_EDILDI
2226	2226	TR90616196	Yurtiçi	2025-05-20	TESLIM_EDILDI
2227	2227	TR23405929	MNG	2025-05-13	YOLDA
2228	2228	TR70939869	Aras	2025-05-13	YOLDA
2229	2229	TR93887687	Sürat	2025-05-17	YOLDA
2230	2230	TR11914499	Yurtiçi	2025-05-12	TESLIM_EDILDI
2231	2231	TR82512353	PTT	2025-05-18	TESLIM_EDILDI
2232	2232	TR95451600	Sürat	2025-05-17	YOLDA
2233	2233	TR01370029	Sürat	2025-05-13	TESLIM_EDILDI
2234	2234	TR36270172	Sürat	2025-05-17	YOLDA
2235	2235	TR83570289	Aras	2025-05-15	YOLDA
2236	2236	TR32199365	Yurtiçi	2025-05-20	YOLDA
2237	2237	TR14620650	MNG	2025-05-19	YOLDA
2238	2238	TR75150640	Aras	2025-05-12	TESLIM_EDILDI
2239	2239	TR01050272	Aras	2025-05-19	TESLIM_EDILDI
2240	2240	TR68384663	PTT	2025-05-17	TESLIM_EDILDI
2241	2241	TR15883833	PTT	2025-05-15	YOLDA
2242	2242	TR38141077	Aras	2025-05-15	TESLIM_EDILDI
2243	2243	TR10054560	Aras	2025-05-14	TESLIM_EDILDI
2244	2244	TR28546382	PTT	2025-05-12	YOLDA
2245	2245	TR32883077	Sürat	2025-05-18	YOLDA
2246	2246	TR67593930	MNG	2025-05-13	TESLIM_EDILDI
2247	2247	TR19534263	PTT	2025-05-12	YOLDA
2248	2248	TR95238880	Sürat	2025-05-12	YOLDA
2249	2249	TR22125155	Aras	2025-05-20	YOLDA
2250	2250	TR65412096	Aras	2025-05-19	TESLIM_EDILDI
2251	2251	TR34690545	Sürat	2025-05-12	TESLIM_EDILDI
2252	2252	TR57177088	Yurtiçi	2025-05-13	TESLIM_EDILDI
2253	2253	TR86412110	Aras	2025-05-13	YOLDA
2254	2254	TR66324092	PTT	2025-05-13	TESLIM_EDILDI
2255	2255	TR69034222	Sürat	2025-05-15	YOLDA
2256	2256	TR96644427	Yurtiçi	2025-05-12	TESLIM_EDILDI
2257	2257	TR70105747	PTT	2025-05-15	TESLIM_EDILDI
2258	2258	TR43612421	Aras	2025-05-13	TESLIM_EDILDI
2259	2259	TR18820795	MNG	2025-05-18	TESLIM_EDILDI
2260	2260	TR50571608	MNG	2025-05-20	YOLDA
2261	2261	TR31786411	Aras	2025-05-18	YOLDA
2262	2262	TR53326440	Yurtiçi	2025-05-14	YOLDA
2263	2263	TR70690384	PTT	2025-05-19	YOLDA
2264	2264	TR81840402	PTT	2025-05-19	TESLIM_EDILDI
2265	2265	TR94724403	Yurtiçi	2025-05-12	TESLIM_EDILDI
2266	2266	TR48657525	PTT	2025-05-20	YOLDA
2267	2267	TR72175841	Sürat	2025-05-19	YOLDA
2268	2268	TR02446454	Yurtiçi	2025-05-17	TESLIM_EDILDI
2269	2269	TR05087723	Aras	2025-05-20	TESLIM_EDILDI
2270	2270	TR14007959	Aras	2025-05-19	TESLIM_EDILDI
2271	2271	TR59383142	Aras	2025-05-19	YOLDA
2272	2272	TR98806233	Aras	2025-05-20	YOLDA
2273	2273	TR76779758	Aras	2025-05-17	YOLDA
2274	2274	TR55626946	Aras	2025-05-20	YOLDA
2275	2275	TR53111728	PTT	2025-05-14	TESLIM_EDILDI
2276	2276	TR66657837	PTT	2025-05-19	TESLIM_EDILDI
2277	2277	TR72551548	Aras	2025-05-16	YOLDA
2278	2278	TR19509963	MNG	2025-05-19	TESLIM_EDILDI
2279	2279	TR11066152	Aras	2025-05-15	YOLDA
2280	2280	TR38975826	Yurtiçi	2025-05-16	YOLDA
2281	2281	TR94826631	Aras	2025-05-13	TESLIM_EDILDI
2282	2282	TR09604598	Aras	2025-05-16	YOLDA
2283	2283	TR40654326	Yurtiçi	2025-05-17	TESLIM_EDILDI
2284	2284	TR62324969	PTT	2025-05-13	TESLIM_EDILDI
2285	2285	TR13128586	Yurtiçi	2025-05-15	TESLIM_EDILDI
2286	2286	TR47148350	PTT	2025-05-15	TESLIM_EDILDI
2287	2287	TR88078552	PTT	2025-05-20	TESLIM_EDILDI
2288	2288	TR28037024	Yurtiçi	2025-05-14	TESLIM_EDILDI
2289	2289	TR43340719	Aras	2025-05-12	YOLDA
2290	2290	TR88224641	MNG	2025-05-17	YOLDA
2291	2291	TR99948094	Sürat	2025-05-18	TESLIM_EDILDI
2292	2292	TR96358396	Yurtiçi	2025-05-16	YOLDA
2293	2293	TR35887603	MNG	2025-05-18	TESLIM_EDILDI
2294	2294	TR17423453	Aras	2025-05-18	YOLDA
2295	2295	TR08235732	Aras	2025-05-12	TESLIM_EDILDI
2296	2296	TR61089741	PTT	2025-05-15	TESLIM_EDILDI
2297	2297	TR32325481	MNG	2025-05-15	YOLDA
2298	2298	TR70313753	Yurtiçi	2025-05-20	YOLDA
2299	2299	TR91993334	Yurtiçi	2025-05-15	TESLIM_EDILDI
2300	2300	TR03485889	PTT	2025-05-15	TESLIM_EDILDI
2301	2301	TR28509050	Yurtiçi	2025-05-18	TESLIM_EDILDI
2302	2302	TR69190506	Sürat	2025-05-18	TESLIM_EDILDI
2303	2303	TR91232713	MNG	2025-05-12	TESLIM_EDILDI
2304	2304	TR02521261	MNG	2025-05-20	YOLDA
2305	2305	TR93100960	Yurtiçi	2025-05-14	YOLDA
2306	2306	TR37593783	PTT	2025-05-13	TESLIM_EDILDI
2307	2307	TR59683477	MNG	2025-05-18	YOLDA
2308	2308	TR16715291	Yurtiçi	2025-05-17	TESLIM_EDILDI
2309	2309	TR18869281	Yurtiçi	2025-05-12	TESLIM_EDILDI
2310	2310	TR43331715	MNG	2025-05-16	YOLDA
2311	2311	TR48744279	MNG	2025-05-16	TESLIM_EDILDI
2312	2312	TR25085673	Aras	2025-05-14	YOLDA
2313	2313	TR70017225	Sürat	2025-05-18	YOLDA
2314	2314	TR95158101	Aras	2025-05-20	TESLIM_EDILDI
2315	2315	TR88556345	Sürat	2025-05-17	TESLIM_EDILDI
2316	2316	TR11041150	Aras	2025-05-14	TESLIM_EDILDI
2317	2317	TR28461476	Sürat	2025-05-12	YOLDA
2318	2318	TR45561991	Aras	2025-05-18	TESLIM_EDILDI
2319	2319	TR96898060	MNG	2025-05-12	TESLIM_EDILDI
2320	2320	TR84993864	PTT	2025-05-14	TESLIM_EDILDI
2321	2321	TR01051394	MNG	2025-05-13	TESLIM_EDILDI
2322	2322	TR68296829	MNG	2025-05-17	YOLDA
2323	2323	TR36953552	Yurtiçi	2025-05-16	TESLIM_EDILDI
2324	2324	TR02271495	PTT	2025-05-15	YOLDA
2325	2325	TR06529355	Aras	2025-05-20	YOLDA
2326	2326	TR66145009	MNG	2025-05-16	YOLDA
2327	2327	TR36846987	PTT	2025-05-14	YOLDA
2328	2328	TR08543691	PTT	2025-05-16	YOLDA
2329	2329	TR83701365	Sürat	2025-05-14	TESLIM_EDILDI
2330	2330	TR88719496	Sürat	2025-05-12	YOLDA
2331	2331	TR22125894	PTT	2025-05-13	YOLDA
2332	2332	TR34779186	Yurtiçi	2025-05-18	TESLIM_EDILDI
2333	2333	TR67140375	PTT	2025-05-19	YOLDA
2334	2334	TR69357938	PTT	2025-05-17	YOLDA
2335	2335	TR20415189	MNG	2025-05-18	TESLIM_EDILDI
2336	2336	TR74516513	MNG	2025-05-16	TESLIM_EDILDI
2337	2337	TR93692207	Yurtiçi	2025-05-20	TESLIM_EDILDI
2338	2338	TR48886195	PTT	2025-05-13	YOLDA
2339	2339	TR22327743	Yurtiçi	2025-05-13	YOLDA
2340	2340	TR28720324	Aras	2025-05-18	TESLIM_EDILDI
2341	2341	TR70699250	Aras	2025-05-15	TESLIM_EDILDI
2342	2342	TR49427404	PTT	2025-05-14	YOLDA
2343	2343	TR70174536	PTT	2025-05-18	TESLIM_EDILDI
2344	2344	TR20217107	Sürat	2025-05-15	YOLDA
2345	2345	TR26634021	Sürat	2025-05-19	TESLIM_EDILDI
2346	2346	TR39569395	Sürat	2025-05-20	TESLIM_EDILDI
2347	2347	TR07132837	PTT	2025-05-12	TESLIM_EDILDI
2348	2348	TR46575218	Sürat	2025-05-16	TESLIM_EDILDI
2349	2349	TR79735592	Aras	2025-05-13	YOLDA
2350	2350	TR63926601	Sürat	2025-05-15	TESLIM_EDILDI
2351	2351	TR41477610	PTT	2025-05-13	TESLIM_EDILDI
2352	2352	TR73898900	Sürat	2025-05-13	TESLIM_EDILDI
2353	2353	TR29816117	Sürat	2025-05-19	TESLIM_EDILDI
2354	2354	TR11411156	Sürat	2025-05-16	YOLDA
2355	2355	TR21316331	MNG	2025-05-16	TESLIM_EDILDI
2356	2356	TR45697456	PTT	2025-05-15	YOLDA
2357	2357	TR98164857	MNG	2025-05-13	TESLIM_EDILDI
2358	2358	TR71797064	Sürat	2025-05-20	YOLDA
2359	2359	TR26986953	MNG	2025-05-14	TESLIM_EDILDI
2360	2360	TR30454280	Yurtiçi	2025-05-18	TESLIM_EDILDI
2361	2361	TR09522591	Sürat	2025-05-17	YOLDA
2362	2362	TR57193532	PTT	2025-05-15	YOLDA
2363	2363	TR02324820	Yurtiçi	2025-05-18	TESLIM_EDILDI
2364	2364	TR39667031	Aras	2025-05-13	TESLIM_EDILDI
2365	2365	TR90213271	Yurtiçi	2025-05-19	TESLIM_EDILDI
2366	2366	TR96605300	MNG	2025-05-17	YOLDA
2367	2367	TR39294273	Sürat	2025-05-14	TESLIM_EDILDI
2368	2368	TR86934955	MNG	2025-05-12	YOLDA
2369	2369	TR37916459	Yurtiçi	2025-05-12	YOLDA
2370	2370	TR27552009	MNG	2025-05-12	YOLDA
2371	2371	TR16949244	Aras	2025-05-14	TESLIM_EDILDI
2372	2372	TR03368794	MNG	2025-05-12	TESLIM_EDILDI
2373	2373	TR48790926	Aras	2025-05-16	YOLDA
2374	2374	TR72504432	Sürat	2025-05-18	YOLDA
2375	2375	TR97207408	Aras	2025-05-15	YOLDA
2376	2376	TR73149410	MNG	2025-05-18	YOLDA
2377	2377	TR70194429	PTT	2025-05-18	TESLIM_EDILDI
2378	2378	TR12923648	Sürat	2025-05-13	TESLIM_EDILDI
2379	2379	TR21688555	Yurtiçi	2025-05-18	TESLIM_EDILDI
2380	2380	TR28925518	Yurtiçi	2025-05-15	YOLDA
2381	2381	TR77134176	Aras	2025-05-18	YOLDA
2382	2382	TR82801539	MNG	2025-05-17	YOLDA
2383	2383	TR31122889	Yurtiçi	2025-05-20	YOLDA
2384	2384	TR91599867	Yurtiçi	2025-05-20	TESLIM_EDILDI
2385	2385	TR23530438	Yurtiçi	2025-05-13	TESLIM_EDILDI
2386	2386	TR42894510	Yurtiçi	2025-05-15	TESLIM_EDILDI
2387	2387	TR35401246	MNG	2025-05-15	YOLDA
2388	2388	TR10846056	Sürat	2025-05-20	YOLDA
2389	2389	TR75432681	Aras	2025-05-16	YOLDA
2390	2390	TR77960543	MNG	2025-05-14	YOLDA
2391	2391	TR36359249	Aras	2025-05-16	TESLIM_EDILDI
2392	2392	TR53512161	Sürat	2025-05-18	YOLDA
2393	2393	TR57306180	Yurtiçi	2025-05-14	YOLDA
2394	2394	TR70612670	Yurtiçi	2025-05-14	YOLDA
2395	2395	TR69261842	Yurtiçi	2025-05-12	TESLIM_EDILDI
2396	2396	TR05920681	Sürat	2025-05-16	YOLDA
2397	2397	TR46253133	PTT	2025-05-20	YOLDA
2398	2398	TR00891857	PTT	2025-05-12	TESLIM_EDILDI
2399	2399	TR65039404	PTT	2025-05-15	YOLDA
2400	2400	TR39973243	Sürat	2025-05-16	YOLDA
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_tickets (id, message, status, subject, user_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role, created_at) FROM stdin;
2	Tartış Gül	akyildiz21@example.com	J4HF3@ut$i	ADMIN	2025-05-10 03:51:12.371056
3	Zülbiye Ürper Güçlü	nurcan66@example.com	!9Hr8(fgI_	ADMIN	2025-05-10 03:51:12.371056
4	Oliver Ramadan Demir	sezginavunc@example.org	RG)D0SdVEi	ADMIN	2025-05-10 03:51:12.371056
5	Aclan Akdeniz	qhancer@example.org	%2BNWSLsPa	ADMIN	2025-05-10 03:51:12.371056
6	Doç. Şerman Şener Seven	dulker@example.com	&#lAwSim3^	SELLER	2025-05-10 03:51:12.371056
7	Emrullah Demir	einonu@example.org	N3*Zm8Tr^t	SELLER	2025-05-10 03:51:12.371056
8	Mukbile Bilir	dsener@example.net	*_)2Pq&b%Y	SELLER	2025-05-10 03:51:12.371056
9	Huban Durdu	sevcan60@example.net	eA*6*Ul$fi	SELLER	2025-05-10 03:51:12.371056
10	Çaltı Çorlu	hancerbirsan@example.net	ksR0NSkl+_	SELLER	2025-05-10 03:51:12.371056
11	Çeviköz Kısakürek	bdemir@example.org	7C9JWzyA(9	SELLER	2025-05-10 03:51:12.371056
12	Uludağ Tanhan Şafak Aksu	geraslan@example.net	m3FdKdb6)J	SELLER	2025-05-10 03:51:12.371056
13	Öğr. Memili Jankat Hançer	nasufsezgin@example.org	_aUT!wEgr6	SELLER	2025-05-10 03:51:12.371056
14	Nurseda Şama	gulkadinsensoy@example.org	Y*6&4zTkGE	SELLER	2025-05-10 03:51:12.371056
15	Okseven Tarhan	sadatdurdu@example.net	@^1feWZt6C	SELLER	2025-05-10 03:51:12.371056
16	Mülâyim Müzekker Soylu	deger18@example.org	r4KTiqhy(3	SELLER	2025-05-10 03:51:12.371056
17	Başok Ertaş	ozdil73@example.com	#+M&N9Cv*2	SELLER	2025-05-10 03:51:12.371056
18	Öğr. Yaşattin Akçay	gulsevilbilge@example.com	B(9rTejZ*F	SELLER	2025-05-10 03:51:12.371056
19	Güçlüer Demir	soyler37@example.net	uuAI02PGJ%	SELLER	2025-05-10 03:51:12.371056
20	Alsoy Şener	bturk@example.org	(70iC%vDbK	SELLER	2025-05-10 03:51:12.371056
21	İde Yüksel	arsoyozbilek@example.com	_HA7eDoT+%	SELLER	2025-05-10 03:51:12.371056
22	Ezgütekin Tarhan	lalemdar@example.net	x6oEz@z*#7	SELLER	2025-05-10 03:51:12.371056
23	Çev. Musaffa Gülüs Sezgin	nili20@example.net	_0KJ3lqgLr	SELLER	2025-05-10 03:51:12.371056
24	Deha Enfes Çorlu Türk	bbilgin@example.org	&253DSCiYS	SELLER	2025-05-10 03:51:12.371056
25	Artan Nasuf Gül Akgündüz	bilginberkal@example.com	XF%2uRQmv&	SELLER	2025-05-10 03:51:12.371056
26	Günşen Türk	cantez20@example.org	%ppWKwke$7	SELLER	2025-05-10 03:51:12.371056
27	Edaviye Akça	sezgindincsu@example.com	zs&1LjXf%+	SELLER	2025-05-10 03:51:12.371056
28	Musafet Dalan Hayrioğlu Çorlu	bilkay58@example.org	HhxKDyb@!8	SELLER	2025-05-10 03:51:12.371056
29	Öğr. Biltaş Yalın Akgündüz	ilperalemdar@example.com	*8CdYgKT^C	SELLER	2025-05-10 03:51:12.371056
30	Saydam Haluk Sezer Mansız	inonupiran@example.com	uSub@Hqy^4	SELLER	2025-05-10 03:51:12.371056
31	Alaz Nurser Ertaş Yılmaz	doguhan36@example.com	+RTr&6QmOa	SELLER	2025-05-10 03:51:12.371056
32	Merba Gürten Yorulmaz Demirel	hanimsensoy@example.com	70Mumkhq^H	SELLER	2025-05-10 03:51:12.371056
33	Armahan Bilgin	alemdarturabi@example.net	0e1Dbgfd)F	SELLER	2025-05-10 03:51:12.371056
34	Arş. Gör. Gülay Risalet Akçay	saydam70@example.org	4tZ^#5tG+$	SELLER	2025-05-10 03:51:12.371056
35	İlsu Gülen	dogannur59@example.com	VrxxnuDc@1	SELLER	2025-05-10 03:51:12.371056
36	Öğr. Nazende Dumanlı Şafak	yavuzcetin@example.net	1)h2xIm3Wv	SELLER	2025-05-10 03:51:12.371056
37	Doç. Çağlar Sezen Hayrioğlu Bilir	akcabay23@example.net	(Z3Cid$w#$	SELLER	2025-05-10 03:51:12.371056
38	Mahter Demirel	akarmuslum@example.org	FhUaCj(0(1	SELLER	2025-05-10 03:51:12.371056
39	Mübetcel Çamurcuoğlu	ozteksafak@example.org	H#_90YsZS^	SELLER	2025-05-10 03:51:12.371056
40	Şenkal Çorlu	vaysalyorulmaz@example.com	qIXvsZ(0#6	SELLER	2025-05-10 03:51:12.371056
41	Tahir Türk	sabihegul@example.net	PE8X9OIc#5	SELLER	2025-05-10 03:51:12.371056
42	Toğan Bilir	ertastayyibe@example.org	#6Kkt9To+v	SELLER	2025-05-10 03:51:12.371056
43	Cercis Manço	abdissener@example.com	%#FmphysX6	SELLER	2025-05-10 03:51:12.371056
44	Temime Demirel	tarhannazende@example.net	#39Pz&QCeC	SELLER	2025-05-10 03:51:12.371056
45	Özinal Kiramettin Sezer	qarsoy@example.com	KiOE9KLn1#	SELLER	2025-05-10 03:51:12.371056
46	Prof. Müferrih Yaman Demir	durmustunckilic@example.net	(JlQ3If02c	SELLER	2025-05-10 03:51:12.371056
47	Akver Çorlu	ergulkarakucak@example.com	9_6bLbPxoJ	SELLER	2025-05-10 03:51:12.371056
48	Zihni Yılmaz	jdurdu@example.org	4zqWD(Rs$3	SELLER	2025-05-10 03:51:12.371056
49	Muvaffak Günver Demir	yukselcaga@example.com	85NoQZZv%4	SELLER	2025-05-10 03:51:12.371056
50	Bilgütay Ülker	vsezer@example.org	P(R8Lc!%9R	SELLER	2025-05-10 03:51:12.371056
51	Nuretdin Berkal Hançer Şama	zahfer32@example.org	_SShXOg3M7	SELLER	2025-05-10 03:51:12.371056
52	Dr. Sümeyye Demir	cetinsoykut@example.net	HBNy)gmk(7	SELLER	2025-05-10 03:51:12.371056
53	Sencar Denkel Akçay Şama	jseven@example.com	^p)A@zso6W	SELLER	2025-05-10 03:51:12.371056
54	Ümmahan Saçı Dumanlı	safakyargi@example.org	lc9)BJBy&I	SELLER	2025-05-10 03:51:12.371056
55	Özel Akar	yildiz26@example.com	)(J0UhZcTQ	SELLER	2025-05-10 03:51:12.371056
56	Öğr. Pekkan Büşranur Erdoğan Durmuş	yavuz23@example.org	2!GtTEbi%6	SELLER	2025-05-10 03:51:12.371056
57	Sabihe Bilgin Durdu	ocalanadviye@example.net	m!6Ddxlm9(	SELLER	2025-05-10 03:51:12.371056
58	Öğr. Fayize Umuşan Demirel	nurseda12@example.org	j@_h97LgI0	SELLER	2025-05-10 03:51:12.371056
59	Akgüneş Uğur Şama Sezer	kenter48@example.com	x2)1XE4o^h	SELLER	2025-05-10 03:51:12.371056
60	Öğr. Uyanser Bilir Tarhan	idumanli@example.org	^6&CYm*w#E	SELLER	2025-05-10 03:51:12.371056
61	Sayın Durmuş	sdurmus@example.org	Bu*S5@Ws_y	SELLER	2025-05-10 03:51:12.371056
62	Yrd. Doç. Dilhuş Ergül Arslan	vaksu@example.net	%$5)kXGecP	SELLER	2025-05-10 03:51:12.371056
63	Melihcan Manço	duhazorlu@example.org	^upUAKjW2g	SELLER	2025-05-10 03:51:12.371056
64	Av. Vecide Sakarya Duran	qsezgin@example.net	g4QuZn_o_p	SELLER	2025-05-10 03:51:12.371056
65	Okt. Nurseda Yüksel Gülen	gulsalinhancer@example.net	%3e0Stz6e+	SELLER	2025-05-10 03:51:12.371056
66	İlalmış Yüksel	vildanehancer@example.net	%&MK4uDQ)3	SELLER	2025-05-10 03:51:12.371056
67	Görsev Yorulmaz İhsanoğlu	xakcay@example.net	QJ9FboAb#m	SELLER	2025-05-10 03:51:12.371056
68	Nurhayet Korutürk	erensoybilir@example.com	*F9SHn+G20	SELLER	2025-05-10 03:51:12.371056
69	Çev. Celilay Çetinsu Akça	durancevikoz@example.net	^#0_0DTylo	SELLER	2025-05-10 03:51:12.371056
70	Bayan Armahan Cevale Durmuş	sezginseref@example.org	(EiXnH1rb3	SELLER	2025-05-10 03:51:12.371056
71	Öğr. Rafia Zeride Soylu	feyruz36@example.com	cRLj)6MkCZ	SELLER	2025-05-10 03:51:12.371056
72	Begim Nurey Bilir Sezgin	unsever82@example.net	+LG_XP4q9e	SELLER	2025-05-10 03:51:12.371056
73	Nihan Yüksel	iaksu@example.org	M2C0i1uJ^1	SELLER	2025-05-10 03:51:12.371056
74	Faize Yıldırım Seven	gungorendurmus@example.com	b6!KJ#Ju+#	SELLER	2025-05-10 03:51:12.371056
75	Arıkol Güçlü	akgunduznurullah@example.com	+1K7K+Gj7s	SELLER	2025-05-10 03:51:12.371056
76	Bayan Arıpınar Dilşat Erdoğan	xbilir@example.org	9r5I@Xsv!O	SELLER	2025-05-10 03:51:12.371056
77	Uyanser Güçlü	akgunduzbasriye@example.org	&Bx9WZCyeu	SELLER	2025-05-10 03:51:12.371056
78	Feremez Özkent Sezer Yaman	bilgerafia@example.com	!37TNmKmJW	SELLER	2025-05-10 03:51:12.371056
79	Çev. Seblâ Güldünya Eraslan	xsensoy@example.org	0_a9LAZv2z	SELLER	2025-05-10 03:51:12.371056
80	Serda Zehranur Hançer	yertanhancer@example.net	+A3)WvRw+M	SELLER	2025-05-10 03:51:12.371056
81	Kınel Türk	mujde95@example.net	4U)9W^sKs$	SELLER	2025-05-10 03:51:12.371056
82	Yrd. Doç. Türkalp Çamurcuoğlu	arsoyakcivan@example.com	R*B6#P*oJa	SELLER	2025-05-10 03:51:12.371056
83	Vezrife Akçay	isak74@example.net	*79BnH5w(C	SELLER	2025-05-10 03:51:12.371056
84	Berrin Yorulmaz Şener	baykan22@example.com	)yO1&POdEI	SELLER	2025-05-10 03:51:12.371056
85	Öğr. Evrim Çorlu Seven	tevetoglumemili@example.com	!!^76LtlSH	SELLER	2025-05-10 03:51:12.371056
86	Dr. Merva Demir Öcalan	bilgincannur@example.com	+sAvYEeg!4	SELLER	2025-05-10 03:51:12.371056
87	Cavit Akgündüz	yunt92@example.org	+#1mJKpoBC	SELLER	2025-05-10 03:51:12.371056
88	Ufukay Aksu Mansız	aykutalpfirat@example.com	Vd4BUuLRv(	SELLER	2025-05-10 03:51:12.371056
89	Nejdet Çetin	pirandurdu@example.net	igymsOe8_9	SELLER	2025-05-10 03:51:12.371056
90	Feden Ayçan Kısakürek Akgündüz	bedri82@example.com	$6xY1Lkl)K	SELLER	2025-05-10 03:51:12.371056
91	Öğr. Mucahit Durmuş	wbilgin@example.net	y)3KpFw*a#	SELLER	2025-05-10 03:51:12.371056
92	Umman Fahrullah Akar Zengin	cakdeniz@example.org	c$_)D2Zb36	SELLER	2025-05-10 03:51:12.371056
93	Prof. Şahat Nas Yorulmaz	kguclu@example.com	Q)2&$Ixsu^	SELLER	2025-05-10 03:51:12.371056
94	Tuğçe Musaffa Zorlu Zengin	samaergonul@example.net	G!T6D^&m(j	SELLER	2025-05-10 03:51:12.371056
95	Öğr. Cedide Şensoy Demirel	baba84@example.org	c8YVoUFl+4	SELLER	2025-05-10 03:51:12.371056
96	Sağıt Ülker	bengibayguclu@example.org	s8NG96Eu^+	SELLER	2025-05-10 03:51:12.371056
97	Ayçan Sarya Çorlu Zorlu	koncagultarhan@example.org	*p1P0mJt3j	SELLER	2025-05-10 03:51:12.371056
98	Öğr. Ümray Ergül Çorlu	alemdaryurttas@example.net	zDtoMP7k!9	SELLER	2025-05-10 03:51:12.371056
99	Özel Eraslan	esenbay24@example.org	^pG%pdoi2q	SELLER	2025-05-10 03:51:12.371056
100	Öğr. Saire Ayşenur Eraslan Fırat	arslanatilgan@example.org	)mAel#sW$7	SELLER	2025-05-10 03:51:12.371056
101	Yıldır Dağistan İhsanoğlu Akdeniz	selvidurmus@example.org	tM$3FxVklg	BUYER	2025-05-10 03:51:12.371056
102	Süha Şavki Çetin	gunkurt59@example.org	T)4LZA6dn5	BUYER	2025-05-10 03:51:12.371056
103	Mehmed Çorlu	zorlucetinsu@example.com	#pr)q9Gprp	BUYER	2025-05-10 03:51:12.371056
104	Dr. Nasiba Alsoy Sezgin	akgunduztemime@example.com	%BZ@9NNuOo	BUYER	2025-05-10 03:51:12.371056
105	Gökçebalan Gül	feremez01@example.com	S2$9VTjp+k	BUYER	2025-05-10 03:51:12.371056
106	Dr. Dirican Duran	tevsturk@example.com	8*2XeL&uPy	BUYER	2025-05-10 03:51:12.371056
107	Şabettin İhsanoğlu	ugul@example.net	8hDF97UF)q	BUYER	2025-05-10 03:51:12.371056
108	Bayan Nades Gül Durmuş	arsoyrabih@example.org	W7TPQRds!L	BUYER	2025-05-10 03:51:12.371056
109	Dr. Ayçan Hançer Yorulmaz	bortecin02@example.net	29g5RvAh_x	BUYER	2025-05-10 03:51:12.371056
110	Aşhan Ergül	tayaydin80@example.net	JeQb$6XxcA	BUYER	2025-05-10 03:51:12.371056
111	Arş. Gör. Günver Gökay Manço	koruturkfenni@example.com	uprLy5s%%1	BUYER	2025-05-10 03:51:12.371056
112	Fatigül Birgül Bilir	miray78@example.net	IZ*0R#8n@9	BUYER	2025-05-10 03:51:12.371056
113	Emin Gözel Kısakürek Demir	asalet08@example.com	(pSJAGLU(9	BUYER	2025-05-10 03:51:12.371056
114	Öğr. Teber Emrullah Ergül	gurteninonu@example.org	sn$yW4Ml*3	BUYER	2025-05-10 03:51:12.371056
115	Akgüneş Şener	nerdogan@example.com	!+Vnakgq24	BUYER	2025-05-10 03:51:12.371056
116	Arş. Gör. Gümüştekin Şafak	lezize42@example.com	H#YYa7I@Te	BUYER	2025-05-10 03:51:12.371056
117	Türkmen Okgüçlü Ertaş Yorulmaz	aslannazidil@example.net	8aZXuMam$T	BUYER	2025-05-10 03:51:12.371056
118	Oğurata Durmuş	akarhazrat@example.com	#A1gKtklmV	BUYER	2025-05-10 03:51:12.371056
119	Arş. Gör. Türabi Sezer	dumanlifetullah@example.net	^4DEZ)f)TC	BUYER	2025-05-10 03:51:12.371056
120	Özlem Feyzin Ertaş Seven	sevgensezgin@example.net	U3UVm#OB&*	BUYER	2025-05-10 03:51:12.371056
121	Rafia Zengin	demirtanses@example.net	t$a6JawSj_	BUYER	2025-05-10 03:51:12.371056
122	Karanbay Şafak	tkisakurek@example.net	^MYlsV6BB5	BUYER	2025-05-10 03:51:12.371056
123	Yrd. Doç. Topuz Selaheddin Soylu	ycetin@example.org	1e7S9bKfY$	BUYER	2025-05-10 03:51:12.371056
124	Muratcan Bilge	xsoylu@example.org	B1Sx$9IO$O	BUYER	2025-05-10 03:51:12.371056
125	Dr. Yepelek Şeref Sezer Aksu	gulzadiye82@example.net	u*1yBAFu(6	BUYER	2025-05-10 03:51:12.371056
126	Yrd. Doç. Muhiye Beyhatun Ertaş	arslantulin@example.net	%KC2WEhyUm	BUYER	2025-05-10 03:51:12.371056
127	Hakikat Akça	ssoylu@example.com	Gv!1XPdZaw	BUYER	2025-05-10 03:51:12.371056
128	Uz. Güçal Erdoğan	mseven@example.org	@!rH4DkR5&	BUYER	2025-05-10 03:51:12.371056
129	Efser Gül	sanlikaradeniz@example.com	)9(Ge5DkVO	BUYER	2025-05-10 03:51:12.371056
130	Atilhan Demir	soyluhusnuhal@example.org	28n6NLXo_a	BUYER	2025-05-10 03:51:12.371056
131	Limon Akdeniz	tevetoglunafile@example.org	a$&JC8FrQ$	BUYER	2025-05-10 03:51:12.371056
132	Yeneral Sakarya	secmeseven@example.com	@_R9yCmXD+	BUYER	2025-05-10 03:51:12.371056
133	Doç. Tonguç Toy Korutürk	ertasdeger@example.org	Qv_2ikUs(O	BUYER	2025-05-10 03:51:12.371056
134	Bağdat Mahter Yüksel	huricancamurcuoglu@example.net	@U8mZUtDYD	BUYER	2025-05-10 03:51:12.371056
135	Razı Göksev Seven	sevensancak@example.org	*37Oqm88H!	BUYER	2025-05-10 03:51:12.371056
136	Andiç Sulhi Türk Manço	doguhankisakurek@example.org	^u492FdRC!	BUYER	2025-05-10 03:51:12.371056
137	Av. Zoral Manço	guldurgadin@example.org	(K9JomW3U8	BUYER	2025-05-10 03:51:12.371056
138	Dr. Nurseda Yılmaz Şener	esezer@example.net	^mU)BlhVr3	BUYER	2025-05-10 03:51:12.371056
139	Kiyasi Alemdar	yamin52@example.net	tGE#P8DugV	BUYER	2025-05-10 03:51:12.371056
140	Çavuldur Erten Zengin	sensoytanpinar@example.net	_0YWwG1n@k	BUYER	2025-05-10 03:51:12.371056
141	Dilhuş Sakarya	necdat05@example.net	)(1oDr!z1%	BUYER	2025-05-10 03:51:12.371056
142	Gabel Ergül Gülen	remazan40@example.org	in7Jg1Ysg*	BUYER	2025-05-10 03:51:12.371056
143	Çev. Mahnaz Işın Şensoy	seyhanarsoy@example.org	@hV^9*SfcB	BUYER	2025-05-10 03:51:12.371056
144	Ünal Yazgül Tarhan	cdemirel@example.com	^(_9a5Yf2e	BUYER	2025-05-10 03:51:12.371056
145	Uz. Ferinaz Akar İhsanoğlu	aysoyakgunduz@example.net	JE3RgdqLd%	BUYER	2025-05-10 03:51:12.371056
146	Saydam Yorulmaz	emirsandurmus@example.org	%8OekXR3%x	BUYER	2025-05-10 03:51:12.371056
147	Nehip Vafir Türk İnönü	sabettin98@example.org	D&8*PqMj)W	BUYER	2025-05-10 03:51:12.371056
148	Tülin Sezgin	obilge@example.net	)0ZuJM&sO4	BUYER	2025-05-10 03:51:12.371056
149	Muvaffak Şafak	mfirat@example.org	L%m0HGHF$r	BUYER	2025-05-10 03:51:12.371056
150	Mazlum Fırat	umutcan45@example.net	837HM^EmC*	BUYER	2025-05-10 03:51:12.371056
151	Ganiye Kifaye Dumanlı	adlanbilgin@example.com	Y5A!dYBx%Y	BUYER	2025-05-10 03:51:12.371056
152	Çeviköz İnönü	hgul@example.org	mJ5Fn3SrX*	BUYER	2025-05-10 03:51:12.371056
153	Özel Manço	ysensoy@example.org	OP1q6Xgm)a	BUYER	2025-05-10 03:51:12.371056
154	İmge İhsanoğlu Seven	kaksu@example.org	a#2Pd++p(7	BUYER	2025-05-10 03:51:12.371056
155	Taciddin Manço	sarpkinsafak@example.org	_TiVFu2s6h	BUYER	2025-05-10 03:51:12.371056
156	Çev. Gülgüzel Akgüneş Korutürk	teybetaksu@example.org	#QGxyzrqD6	BUYER	2025-05-10 03:51:12.371056
157	Cemalettin Yaman	rabbiyeakca@example.org	R45ENXJm@b	BUYER	2025-05-10 03:51:12.371056
158	Özay Demirel	aycagul29@example.org	SFV2r%kq!6	BUYER	2025-05-10 03:51:12.371056
159	Samurtay Yıldırım	gularifcan@example.net	T!7GLK#rxd	BUYER	2025-05-10 03:51:12.371056
160	Börteçin Yorulmaz	caglasinihsanoglu@example.com	!)^oSb_j2T	BUYER	2025-05-10 03:51:12.371056
161	Şemsettin Çağlasın Karadeniz Bilgin	aslanerik@example.com	+5RBe!zNqk	BUYER	2025-05-10 03:51:12.371056
162	Nafile Şama Şensoy	durrusehvarkaradeniz@example.net	wSC4vW3lm!	BUYER	2025-05-10 03:51:12.371056
163	Emiş Benek Akçay	eskinalp15@example.com	xb3V!ofY&f	BUYER	2025-05-10 03:51:12.371056
164	Dr. Hayali Oruç Eraslan	xzorlu@example.net	^3+1NMkQ6O	BUYER	2025-05-10 03:51:12.371056
165	Ildız Çetin	turceinduran@example.org	r!8HOpquJ5	BUYER	2025-05-10 03:51:12.371056
166	Uz. Aslanhan Uçan Tevetoğlu	akdenizokkas@example.com	_0Ft*8HaDb	BUYER	2025-05-10 03:51:12.371056
167	Gülağa Bali Yüksel	bguclu@example.com	(QF8kZ4S9+	BUYER	2025-05-10 03:51:12.371056
168	Bay Kürşad Ülker	mguclu@example.com	^6B7YLvW_3	BUYER	2025-05-10 03:51:12.371056
169	Erinçer Mansız	aslanhan12@example.net	K&2OlM9*_e	BUYER	2025-05-10 03:51:12.371056
170	Serda Gülsevil Ülker Bilge	hhancer@example.com	qD4N&09m*t	BUYER	2025-05-10 03:51:12.371056
171	Nurgil Korutürk	bilginmujde@example.org	$%PV)!!l%9	BUYER	2025-05-10 03:51:12.371056
172	Özlem Yorulmaz	hertas@example.com	(Y6PxRcf)h	BUYER	2025-05-10 03:51:12.371056
173	Kefser Demirel Duran	nirgulkaradeniz@example.org	E$i2GYtyZQ	BUYER	2025-05-10 03:51:12.371056
174	Hansultan Yaşar Karadeniz Arsoy	yamandilsitan@example.org	%Ih7CVEb+Y	BUYER	2025-05-10 03:51:12.371056
175	Alexandru Ergül	aytek87@example.net	!7J#5Uzonz	BUYER	2025-05-10 03:51:12.371056
176	Berksay Sançar Akça	baba38@example.org	ve0A5Sal@2	BUYER	2025-05-10 03:51:12.371056
177	Bayan Kitan Ümray Akdeniz	kkaradeniz@example.com	E(!4N$MjBh	BUYER	2025-05-10 03:51:12.371056
178	Milay Ercihan Durdu Durdu	pdemirel@example.com	KdOg9H(7+5	BUYER	2025-05-10 03:51:12.371056
179	Öğr. Mehdiye Yurtseven Sezgin Ertaş	islimesezgin@example.org	Q^n9Dk0fyn	BUYER	2025-05-10 03:51:12.371056
180	Doç. Sözer İlmafer Sezer	doganalp55@example.net	9uEvL2NrM$	BUYER	2025-05-10 03:51:12.371056
181	Merzuk Ergül	zcetin@example.org	7RbFkRWk#i	BUYER	2025-05-10 03:51:12.371056
182	Yaşar Yorulmaz	oocalan@example.net	@tTfI@+hs9	BUYER	2025-05-10 03:51:12.371056
183	Gürcüye Erdoğan Arslan	eraslanyurtseven@example.com	WK7f^NgR!O	BUYER	2025-05-10 03:51:12.371056
184	Çev. Pürçek Akçay Korutürk	ocorlu@example.net	_d83ndAjbK	BUYER	2025-05-10 03:51:12.371056
185	Yrd. Doç. Aşhan Cuheyna Ülker Bilge	xkaradeniz@example.org	pmE!L8Ok_6	BUYER	2025-05-10 03:51:12.371056
186	Nurcan Amaç Aksu Tevetoğlu	tekinerkisakurek@example.com	*^IAItx^O8	BUYER	2025-05-10 03:51:12.371056
187	Kahir Erdoğan	qseven@example.net	$4JAlHhlz_	BUYER	2025-05-10 03:51:12.371056
188	Arş. Gör. Karanbay Kısakürek	melulseven@example.net	&VhH6@Xchx	BUYER	2025-05-10 03:51:12.371056
189	Adasal Durdu	jsener@example.org	(cGx(^bSR8	BUYER	2025-05-10 03:51:12.371056
190	Prof. Zennun Duran	oarslan@example.org	vGKQaoBI$5	BUYER	2025-05-10 03:51:12.371056
191	Aycagül Ervaniye Arslan Çamurcuoğlu	tevetogluyahsikan@example.org	u6TMxXue!M	BUYER	2025-05-10 03:51:12.371056
192	Silanur Nurtaç Sezgin	dilsatduran@example.net	+ATNR(rT37	BUYER	2025-05-10 03:51:12.371056
193	Alaz Emiş Akar Sakarya	dbilge@example.com	+$8ii08uwZ	BUYER	2025-05-10 03:51:12.371056
194	Öğr. Abdülahat Ergül	kaygusuz86@example.net	Y)&J51Tb%k	BUYER	2025-05-10 03:51:12.371056
195	Öğr. Ticen Mahnaz Yaman	torel20@example.org	RhW9tPYn)a	BUYER	2025-05-10 03:51:12.371056
196	Teybet Bilir Korutürk	yarsoy@example.net	!W&IdYkab4	BUYER	2025-05-10 03:51:12.371056
197	Şeref Soylu Akçay	selvihancer@example.net	K8Lb5AoW)R	BUYER	2025-05-10 03:51:12.371056
198	Kader Mefharet Şama	lufensezgin@example.org	i!h7FRsc07	BUYER	2025-05-10 03:51:12.371056
199	Bellisan Durdu	daksu@example.net	NXBLvpV&@2	BUYER	2025-05-10 03:51:12.371056
200	Prof. Dalan Yorulmaz	rusen26@example.org	mVeGn7Nu)u	BUYER	2025-05-10 03:51:12.371056
201	Burç Eraslan	firatmeyhanim@example.org	@+6HqffxFW	BUYER	2025-05-10 03:51:12.371056
202	Gülşa Çorlu Türk	taylakfirat@example.org	V5vZ4Mcl_f	BUYER	2025-05-10 03:51:12.371056
203	Zaliha Tevetoğlu	bdemir@example.net	B^a5Rf7J^o	BUYER	2025-05-10 03:51:12.371056
204	Sıylıhan Nurcan Tarhan	wkoruturk@example.com	#nDQeu9#+1	BUYER	2025-05-10 03:51:12.371056
205	Alpsü Şinasi Manço	yukselsevican@example.org	fIo4o3ckK$	BUYER	2025-05-10 03:51:12.371056
206	Tezol Tunguç Akçay Demirel	stevetoglu@example.net	^6MkI+VLI_	BUYER	2025-05-10 03:51:12.371056
207	Dirlik Demir	gulabdulmenaf@example.com	Lt9N32kcA_	BUYER	2025-05-10 03:51:12.371056
208	Özbilge Afife Mansız Dumanlı	hoskadem80@example.org	$9zQ$f8X_P	BUYER	2025-05-10 03:51:12.371056
209	Canan Kısakürek	vacibe35@example.org	Y+%7vSg^87	BUYER	2025-05-10 03:51:12.371056
210	Öğr. Hazine Alemdar Alemdar	aulker@example.net	K&z4C@PrHr	BUYER	2025-05-10 03:51:12.371056
211	Av. Lutfi Mengi Yaman	tevetogluyasattin@example.org	$#hWEe7nl5	BUYER	2025-05-10 03:51:12.371056
212	Yekbun Kâzime Şensoy Tevetoğlu	hanbikentarhan@example.org	^4mKD5wdHu	BUYER	2025-05-10 03:51:12.371056
213	Lezize Korutürk	inonunarhanim@example.com	2*&6EpZi^x	BUYER	2025-05-10 03:51:12.371056
214	Doç. Enfes Altınçiçek Şener Zorlu	nazlim83@example.org	z*)9PfFRXT	BUYER	2025-05-10 03:51:12.371056
215	Beray Sakarya Demirel	unubolduran@example.com	2!%Ig2LtX(	BUYER	2025-05-10 03:51:12.371056
216	Serda Akçay Şama	xdurdu@example.com	@C*8vLtd88	BUYER	2025-05-10 03:51:12.371056
217	Perinur Karadeniz	kader97@example.org	)Y25zHuBU^	BUYER	2025-05-10 03:51:12.371056
218	Gökçe Durmuş	alemdarumray@example.net	b159Pem7(^	BUYER	2025-05-10 03:51:12.371056
219	Sayrak Durdu	camurcuoglusamiha@example.org	&3IVdyJV@F	BUYER	2025-05-10 03:51:12.371056
220	Onuker Güçlü	gertas@example.net	%6INw9GzMo	BUYER	2025-05-10 03:51:12.371056
221	Dinçkol Tevetoğlu	cercis37@example.net	%JfSWchyL6	BUYER	2025-05-10 03:51:12.371056
222	Tayyip Yaman	kiyasi90@example.com	OW2K+P$r%a	BUYER	2025-05-10 03:51:12.371056
223	Müşüre Duran	dilcanyilmaz@example.net	#O31U1Kdsu	BUYER	2025-05-10 03:51:12.371056
224	Tasvir Karadeniz Yorulmaz	durmussayan@example.com	UmeL4O8KE&	BUYER	2025-05-10 03:51:12.371056
225	Dorukhan Yıldırım	rarslan@example.com	)IGC7P@jd3	BUYER	2025-05-10 03:51:12.371056
226	Soyselçuk Korutürk	celikyurek90@example.com	%K9QCPTiqc	BUYER	2025-05-10 03:51:12.371056
227	Öğr. Tansığ Durmuş	gulensendogan@example.net	8FHIE5gr!3	BUYER	2025-05-10 03:51:12.371056
228	Onurcan Sezgin	alsoy58@example.org	Hl&t1WhoUN	BUYER	2025-05-10 03:51:12.371056
229	Öğr. Esentürk Köktaş Bilgin	otevetoglu@example.org	+91N^qAlOX	BUYER	2025-05-10 03:51:12.371056
230	Çev. Doğanalp Yekda Çorlu	fmansiz@example.org	h2dEZQiX)u	BUYER	2025-05-10 03:51:12.371056
231	Öğr. Firdevis Duran Kısakürek	sakaryasubutiye@example.com	TYvgT^aM)5	BUYER	2025-05-10 03:51:12.371056
232	Yrd. Doç. Seda Ergün Yüksel	ozgunakar@example.org	I6F4cttf&Y	BUYER	2025-05-10 03:51:12.371056
233	Buyrukhan Akçay	kadinanacorlu@example.com	s^A1SoqDv(	BUYER	2025-05-10 03:51:12.371056
234	Dr. Avunç Neyran Şensoy	kivilcim57@example.com	9TDOENxt@m	BUYER	2025-05-10 03:51:12.371056
388	Tamaydın Ergül	zorlugorgunay@example.net	^z0Ydr1WmY	BUYER	2025-05-10 03:51:12.371056
235	Arş. Gör. Paksu Manço Bilir	alemdarnurgil@example.com	SS9X8nah)S	BUYER	2025-05-10 03:51:12.371056
236	Akbaş Arslan	sdemir@example.com	0M!K@fzm*8	BUYER	2025-05-10 03:51:12.371056
237	Kutgün Akgüneş İhsanoğlu Yüksel	zyuksel@example.net	KRX9SLQhw&	BUYER	2025-05-10 03:51:12.371056
238	Arş. Gör. Şilan Canan Akçay Akar	samanevsale@example.org	B#2%wX(ab7	BUYER	2025-05-10 03:51:12.371056
239	Şerafeddin Tezcan Akgündüz	tugcan17@example.net	^qbHoC&aw2	BUYER	2025-05-10 03:51:12.371056
240	Dr. Melihcan Dalan Arsoy	tbilir@example.org	8@xYzX3H!P	BUYER	2025-05-10 03:51:12.371056
241	Eba Aypar İhsanoğlu	qbilir@example.org	yge7*6Pf)^	BUYER	2025-05-10 03:51:12.371056
242	Atilhan Sezer	temimesakarya@example.org	zCdNUk71*6	BUYER	2025-05-10 03:51:12.371056
243	Yetişal Tanak Akgündüz	insafkaradeniz@example.net	RJo2F53gM^	BUYER	2025-05-10 03:51:12.371056
244	Gençay Alemdar	tevetoglufayize@example.com	^3EcBt_Dzb	BUYER	2025-05-10 03:51:12.371056
245	Okt. Ayduru Soylu Alemdar	kisakurekcalti@example.org	%_l)2TfS3j	BUYER	2025-05-10 03:51:12.371056
246	İhsan Eraslan	oldag59@example.net	b@2M*dPqlO	BUYER	2025-05-10 03:51:12.371056
247	Fadıla Erdoğan	xakdeniz@example.org	)@MOovEq0+	BUYER	2025-05-10 03:51:12.371056
248	Abiye Emiş Bilge Tevetoğlu	badegul22@example.com	_zXT5Tb0Qg	BUYER	2025-05-10 03:51:12.371056
249	Vezrife Söyler Akar Seven	armahancetin@example.org	$3_G*T)a1w	BUYER	2025-05-10 03:51:12.371056
250	Kezban Şener	bilirfatigul@example.net	%!n1YdHeD8	BUYER	2025-05-10 03:51:12.371056
251	Okt. Mujde Öcalan Akçay	eraslantekecan@example.net	6h2*CxvZM(	BUYER	2025-05-10 03:51:12.371056
252	Nafile Paksu Seven Akgündüz	gucluabdulbekir@example.com	5YLnktEN!(	BUYER	2025-05-10 03:51:12.371056
253	Öğr. Banü Özlem Şafak Akgündüz	bahtinur97@example.org	)%w*4Mn!f_	BUYER	2025-05-10 03:51:12.371056
254	Bay Bellisan Ersel İnönü	doguhan63@example.com	72ICZc5y%)	BUYER	2025-05-10 03:51:12.371056
255	Akatay Yüksel	akcaayvas@example.com	XT1vGlt*)&	BUYER	2025-05-10 03:51:12.371056
256	Aybet Şeyda İnönü	sadeti23@example.org	AD6oFldk%i	BUYER	2025-05-10 03:51:12.371056
257	Okt. Değer Akdeniz Ülker	xertas@example.org	em($4yCh_t	BUYER	2025-05-10 03:51:12.371056
258	Gökçebalan Selâtin Akçay Bilge	eocalan@example.net	!n8Pw0k0)x	BUYER	2025-05-10 03:51:12.371056
259	Dr. Gülsü Arsoy Fırat	milaymanco@example.org	+wj9D2kv)+	BUYER	2025-05-10 03:51:12.371056
260	Mehdiye Semat Karadeniz Kısakürek	demireloge@example.org	x*iBD6Xr)g	BUYER	2025-05-10 03:51:12.371056
261	Çev. Tutkucan Mansız Aslan	cetindilder@example.com	XUvWOO3ui@	BUYER	2025-05-10 03:51:12.371056
262	Nürice Aynımah Demir	turabi70@example.net	#$S+cNZo3j	BUYER	2025-05-10 03:51:12.371056
263	Mutasım Fırat	soylubasay@example.com	YI&+8#QbuQ	BUYER	2025-05-10 03:51:12.371056
264	Bilgütay Akdeniz	iguclu@example.com	n$$m0RIvFS	BUYER	2025-05-10 03:51:12.371056
265	Arş. Gör. Hadrey Adila Bilgin İhsanoğlu	pcetin@example.org	X)V@9LtQgg	BUYER	2025-05-10 03:51:12.371056
266	Doğanşah Pehlil Bilir	dumanliaycan@example.net	qG*1RVDk*O	BUYER	2025-05-10 03:51:12.371056
267	Arş. Gör. İbrahim Asalet Yılmaz	linonu@example.net	!0KFkxyD68	BUYER	2025-05-10 03:51:12.371056
268	Öğr. Sarya Dursadiye Çamurcuoğlu Durmuş	dilhus58@example.com	$s7YkQccnd	BUYER	2025-05-10 03:51:12.371056
269	Aktemür Seven	zorluozkutlu@example.com	G_**Pfi4$6	BUYER	2025-05-10 03:51:12.371056
270	Bayan Şennur Dumanlı Gülen	ulfetdumanli@example.net	MY2N2&oxu_	BUYER	2025-05-10 03:51:12.371056
271	Yavuz Sağcan Bilge	cinonu@example.net	+6Ba7AjwEd	BUYER	2025-05-10 03:51:12.371056
272	Av. Gülsü Şafak Akçay	yukselpaye@example.com	Q&d3Pf^#O5	BUYER	2025-05-10 03:51:12.371056
273	Halenur Yorulmaz	yilmazmutluhan@example.net	q7gH(zO4^C	BUYER	2025-05-10 03:51:12.371056
274	Beste Öcalan Yorulmaz	ahancer@example.net	_mpAR7Dis2	BUYER	2025-05-10 03:51:12.371056
275	Bay Suat Şensoy	mansizezgin@example.org	3btiXGW&)K	BUYER	2025-05-10 03:51:12.371056
276	Gelengül Cevale Manço	ocetin@example.org	!Khx1W4yl7	BUYER	2025-05-10 03:51:12.371056
277	Prof. Lutfi Tecimer Durdu	akdenizrevza@example.net	FDh9FTw5)q	BUYER	2025-05-10 03:51:12.371056
278	Okt. Temime Zerafet Ergül Yorulmaz	uulker@example.com	)MEGuIBkL0	BUYER	2025-05-10 03:51:12.371056
279	Selime Selvi Mansız Arslan	ilgi08@example.com	999XMIy1$B	BUYER	2025-05-10 03:51:12.371056
280	Fitnat Evrim İnönü	esenturk16@example.com	*rTY2Ft^so	BUYER	2025-05-10 03:51:12.371056
281	Sanur Duran	gunser97@example.org	$Cn9YqXc)R	BUYER	2025-05-10 03:51:12.371056
282	Yrd. Doç. Armahan Azize Güçlü Ertaş	abdulcemaldurdu@example.net	zaNo7Kn2b)	BUYER	2025-05-10 03:51:12.371056
283	Prof. Umman Şama	alemdarbinay@example.org	p@0VoFeg@d	BUYER	2025-05-10 03:51:12.371056
284	Fitnat Bilir	jbilir@example.com	$VWLnsaz_5	BUYER	2025-05-10 03:51:12.371056
285	Burakhan Çamurcuoğlu	asakarya@example.net	u*62B8zm&v	BUYER	2025-05-10 03:51:12.371056
286	Ushan Tatu Tevetoğlu Ergül	ocamurcuoglu@example.net	^wU7OHTjR%	BUYER	2025-05-10 03:51:12.371056
287	Öğr. Rakide Gökperi Sakarya	mahnazdumanli@example.org	50ZE69Xu#w	BUYER	2025-05-10 03:51:12.371056
288	Uz. Ümray Koncagül Akar Akar	sakaryamaside@example.net	q#9YBAo0K@	BUYER	2025-05-10 03:51:12.371056
289	Bay Kocabaş Tevetoğlu	arikolakcay@example.net	xke4K6uf+b	BUYER	2025-05-10 03:51:12.371056
290	Şeref Tule Ergül	cetinbiltas@example.net	@(k#1oGc0n	BUYER	2025-05-10 03:51:12.371056
291	Nihai Mihin Yılmaz	mishatcetin@example.org	4!5enTUrcr	BUYER	2025-05-10 03:51:12.371056
292	Nalân Zengin	dmansiz@example.org	Rf%2GLcv%p	BUYER	2025-05-10 03:51:12.371056
293	Doç. Cuheyna Şendoğan Akgündüz Şener	altogan13@example.org	)J4Hjwo(jG	BUYER	2025-05-10 03:51:12.371056
294	Ledün Benol Türk	dolensoy83@example.com	@*5yU+yseE	BUYER	2025-05-10 03:51:12.371056
295	Dr. Nurhayet Hürmet Hançer Gül	sensoyyonetmen@example.org	xtKeYpAj_8	BUYER	2025-05-10 03:51:12.371056
296	Dr. Zaliha Ergül Bilge	jsezgin@example.org	$^w2FedNl!	BUYER	2025-05-10 03:51:12.371056
297	Özdil Kısakürek	oztekbilge@example.com	(xT6VdAq!(	BUYER	2025-05-10 03:51:12.371056
298	Öğr. Fatigül Beste Yıldırım Çamurcuoğlu	mishatsoylu@example.net	RqC90Nio#v	BUYER	2025-05-10 03:51:12.371056
299	Ulakbey Muvaffak İhsanoğlu Erdoğan	harizmansiz@example.org	S285Hgyca#	BUYER	2025-05-10 03:51:12.371056
300	Yrd. Doç. Altınbike Naide Zorlu	bilgingokcil@example.org	*1jIIvnbn^	BUYER	2025-05-10 03:51:12.371056
301	Umuşan Alemdar	akdenizoguzman@example.org	&87PEm9jFV	BUYER	2025-05-10 03:51:12.371056
302	Yolal Zülgarni Türk	oldagarslan@example.org	tX6*Byn_(8	BUYER	2025-05-10 03:51:12.371056
303	Semine Korutürk Zengin	bilirnezize@example.com	#EUFRulR7g	BUYER	2025-05-10 03:51:12.371056
304	Erenalp Gül	rafihakar@example.org	+1YNMM#d^_	BUYER	2025-05-10 03:51:12.371056
305	Uğurkan Durdu	gurardasener@example.net	IvUcYeKf$6	BUYER	2025-05-10 03:51:12.371056
306	Taçnur İhsanoğlu	asliye04@example.org	2TQFdfp1+2	BUYER	2025-05-10 03:51:12.371056
307	Okt. Nasiba Ufukay Tevetoğlu	ilgiihsanoglu@example.net	!*Oz&NkKE1	BUYER	2025-05-10 03:51:12.371056
308	Hafıza Emiş Öcalan	ayulkeryildirim@example.com	@7@OyYpJks	BUYER	2025-05-10 03:51:12.371056
309	Adak Akça	xakcay@example.org	%d7A&By*ZR	BUYER	2025-05-10 03:51:12.371056
310	Ümmahan Damlanur Arslan Şener	yepelek11@example.net	*mTxaZILe8	BUYER	2025-05-10 03:51:12.371056
311	Arş. Gör. Ergönül Demirel	ayvasseven@example.net	eE+8_KrF7X	BUYER	2025-05-10 03:51:12.371056
312	Zemzem Manço	koruturkozaslan@example.com	7B^X6GhjFT	BUYER	2025-05-10 03:51:12.371056
313	Semat Gülcegün Eraslan Akar	ekisakurek@example.org	sa^HP^T)#6	BUYER	2025-05-10 03:51:12.371056
314	Mükramin Cercis Demirel Karadeniz	fsoylu@example.org	$5yZC2Df)W	BUYER	2025-05-10 03:51:12.371056
315	Dr. Almast Nilcan Yorulmaz	ctarhan@example.org	*4gYxJaZrd	BUYER	2025-05-10 03:51:12.371056
316	Canberk Bilgin	sadimanyaman@example.net	hcgXDHvt)1	BUYER	2025-05-10 03:51:12.371056
317	İlkim Alanalp Bilir Sezgin	kocakaksu@example.net	RmqKuy1v!4	BUYER	2025-05-10 03:51:12.371056
318	Cuman Yaman	serfinazguclu@example.com	Q)5&1ZmfD#	BUYER	2025-05-10 03:51:12.371056
319	Ünal Akar Çetin	wmansiz@example.com	#0P(tkJXmS	BUYER	2025-05-10 03:51:12.371056
320	Öğr. Lüfen Gül Eraslan	tcorlu@example.org	Sh^mSB+o_2	BUYER	2025-05-10 03:51:12.371056
321	Yrd. Doç. Ramadan Alaaddin Çorlu	safakkoktas@example.net	*4X14__v&U	BUYER	2025-05-10 03:51:12.371056
322	Öğr. Okgüçlü Şafii Manço	ergulesim@example.com	z!8%P2&nK4	BUYER	2025-05-10 03:51:12.371056
323	Huzuri Seven	amac98@example.com	cXa7FUjR+p	BUYER	2025-05-10 03:51:12.371056
324	Dr. Maynur Akmaral Demir Sezer	demirsabih@example.com	+5Z)+Nv9Bb	BUYER	2025-05-10 03:51:12.371056
325	Milay Şensoy	bbilge@example.org	V8nSgVcv^2	BUYER	2025-05-10 03:51:12.371056
326	Gülev Nalân Yorulmaz	zsezgin@example.com	%l3RLaiwJ1	BUYER	2025-05-10 03:51:12.371056
327	Ayşenur Verde Akçay Çorlu	kivilcimbilgin@example.com	*jmVLBc#C2	BUYER	2025-05-10 03:51:12.371056
328	Emine. Naz Fırat	qcetin@example.org	@$3PDYzzq6	BUYER	2025-05-10 03:51:12.371056
329	Henife Akçay Soylu	nurey04@example.net	_hMhsThVa7	BUYER	2025-05-10 03:51:12.371056
330	Öğr. Necva Peren İhsanoğlu Akçay	rulker@example.org	%2MTWlcx14	BUYER	2025-05-10 03:51:12.371056
331	Delil Yüksel	ftevetoglu@example.org	2io$G)ew_9	BUYER	2025-05-10 03:51:12.371056
332	Gülay Demir Şafak	demirelgoli@example.org	_!3Gd0Dk+L	BUYER	2025-05-10 03:51:12.371056
333	Uzsoy Şafak	eraslanadasal@example.org	c1FrZLw3)Q	BUYER	2025-05-10 03:51:12.371056
334	Dr. Adlan Tevetoğlu	nomanocalan@example.net	d+3Qa4vTOH	BUYER	2025-05-10 03:51:12.371056
335	Efser Işıman Yüksel	tevetoglunefaret@example.net	#*fO2Jqg_4	BUYER	2025-05-10 03:51:12.371056
336	Müsemma Aykut Ergül Güçlü	bashan22@example.org	6se1F1Vc%V	BUYER	2025-05-10 03:51:12.371056
337	Dr. Abdulsemet Köktaş Bilgin	tcetin@example.com	T3sFbhfj%E	BUYER	2025-05-10 03:51:12.371056
338	Okt. Sevgen Avunç Şama	harbinaz44@example.com	BmzrqaXy&7	BUYER	2025-05-10 03:51:12.371056
339	Öğr. Rümeysa Kutun İnönü Zengin	dumanlimusafet@example.org	uhRI3kXd$9	BUYER	2025-05-10 03:51:12.371056
340	Piran Şama	ugurtan92@example.com	^o5DvOZsvs	BUYER	2025-05-10 03:51:12.371056
341	Ümray Rafia Soylu	ummahan65@example.net	L#7deB(jLd	BUYER	2025-05-10 03:51:12.371056
342	Aşhan Soylu	uraltayakar@example.net	70FNVDa+_8	BUYER	2025-05-10 03:51:12.371056
343	Taygan Şama	ikisakurek@example.net	N+g4!WZ&4b	BUYER	2025-05-10 03:51:12.371056
344	Canur Ertaş Sezgin	jankat77@example.com	+^oM)!cUW7	BUYER	2025-05-10 03:51:12.371056
345	Ensari Ülker	hanimihsanoglu@example.org	#9A5pB3Qz4	BUYER	2025-05-10 03:51:12.371056
346	Beyzade Sezer	sanavber16@example.com	NZ9NC5bm#x	BUYER	2025-05-10 03:51:12.371056
347	Öğr. Sidar Nurseda Sezgin Durdu	byilmaz@example.net	(#7StV&wCy	BUYER	2025-05-10 03:51:12.371056
348	Dr. Eröz Sıla Şafak	aysevimkoruturk@example.com	#1JdOcwNf8	BUYER	2025-05-10 03:51:12.371056
349	Ozansü Fersan Yaman Durdu	zuheyla60@example.org	FPTh(kUm#2	BUYER	2025-05-10 03:51:12.371056
350	Dilcan Doğannur Akdeniz	ttarhan@example.net	p_M0LTr8_M	BUYER	2025-05-10 03:51:12.371056
351	Meleknur Münezzer Sezgin	akgunduzkitan@example.net	rxyU6NjJ&#	BUYER	2025-05-10 03:51:12.371056
352	Çakar Yılmaz	ildem42@example.com	Or+8TFz$K^	BUYER	2025-05-10 03:51:12.371056
353	Güverçin Aslan Duran	fayize69@example.org	Q!29GIigTl	BUYER	2025-05-10 03:51:12.371056
354	Çev. Koçkan Yüksel	aran75@example.com	4*N5d7y!+)	BUYER	2025-05-10 03:51:12.371056
355	Mefarettin Karadeniz	yukselcemalettin@example.com	js4b4yD!K)	BUYER	2025-05-10 03:51:12.371056
356	Leyli Atiyye Eraslan Yorulmaz	bzengin@example.com	Jx6V*5i9#4	BUYER	2025-05-10 03:51:12.371056
357	Süheyda Seven Zengin	tarhansarya@example.net	p+j9u3*cOO	BUYER	2025-05-10 03:51:12.371056
358	Aliabbas Mansız	abdulmenafhancer@example.org	$6DC1YwhW4	BUYER	2025-05-10 03:51:12.371056
359	Av. Rebihat Gül Arslan	imrihandurdu@example.org	6u9Br0Mo^V	BUYER	2025-05-10 03:51:12.371056
360	Dr. Naide İldeş Arslan Hayrioğlu	bilginabiye@example.com	i*D4OLm7NR	BUYER	2025-05-10 03:51:12.371056
361	Sıylıhan Nurcan Yaman	taylakcamurcuoglu@example.org	^QGCya0U59	BUYER	2025-05-10 03:51:12.371056
362	Dr. Siti Kübran Arsoy Yüksel	nabil57@example.com	u)9Aw!&Jvp	BUYER	2025-05-10 03:51:12.371056
363	Okt. Çinerk Yılmaz	yildirimgorgunay@example.org	&1NLia&g$h	BUYER	2025-05-10 03:51:12.371056
364	Şelâle Hançer	seyyide38@example.org	o2W!bjRI^G	BUYER	2025-05-10 03:51:12.371056
365	Dr. Bellisan Akgündüz	hancersefi@example.com	6^5qdUAzml	BUYER	2025-05-10 03:51:12.371056
366	Gülgüzel Arslan	farslan@example.com	)#27Kwhv75	BUYER	2025-05-10 03:51:12.371056
367	Algış Ümray Öcalan Eraslan	savni45@example.com	%7A0BM8vMZ	BUYER	2025-05-10 03:51:12.371056
368	Öğr. Cannur Doğannur Şensoy	koruturkfazul@example.org	CcLZfwb7+6	BUYER	2025-05-10 03:51:12.371056
369	Av. Oymak Çeviköz Öcalan	koruturktopuz@example.org	&4D@m1s)nJ	BUYER	2025-05-10 03:51:12.371056
370	Gökten Sakarya	jdumanli@example.org	4p)0A@tzCk	BUYER	2025-05-10 03:51:12.371056
371	Yrd. Doç. Maşide Nurşan Hayrioğlu	karaerarslan@example.com	8#C50ZaURP	BUYER	2025-05-10 03:51:12.371056
372	Dr. Ticen Aydar Manço Bilgin	hurside04@example.net	ic^)2FihCS	BUYER	2025-05-10 03:51:12.371056
373	Nefiye Erdoğan	uzer27@example.org	FezVqtBB*1	BUYER	2025-05-10 03:51:12.371056
374	Nesip Ilgı Akar Şafak	barsen22@example.org	b3Fi4uTy$4	BUYER	2025-05-10 03:51:12.371056
375	Yavuz Sezer	fugen63@example.com	v1^Ojxmt#r	BUYER	2025-05-10 03:51:12.371056
376	Bayan Neslinur Tarhan Arslan	htarhan@example.com	)9dZO)ud+H	BUYER	2025-05-10 03:51:12.371056
377	Günden Yaman	aksubulunc@example.org	zd3W6wB3+q	BUYER	2025-05-10 03:51:12.371056
378	Av. Müslum Mansız	kisakurektaylak@example.com	hqO84X(m%8	BUYER	2025-05-10 03:51:12.371056
379	Rezzak Evcimen Bilir	senerbayruhan@example.net	YW6462Kj_)	BUYER	2025-05-10 03:51:12.371056
380	Meşhur Akçay	ozbilgesama@example.net	*vB6OoaU8r	BUYER	2025-05-10 03:51:12.371056
381	Dolun Öncel Sakarya	makcay@example.net	@Y9Sndkx&T	BUYER	2025-05-10 03:51:12.371056
382	Özlem Rakide İnönü	sezernezihi@example.com	^cZ2Hvk^&R	BUYER	2025-05-10 03:51:12.371056
383	Prof. Aynilhayat Behiza Akgündüz	tanbayaksu@example.com	t_9Rz5Mv5J	BUYER	2025-05-10 03:51:12.371056
384	Enginiz Bilgin	akcamutasim@example.net	7eRZKdEo$8	BUYER	2025-05-10 03:51:12.371056
385	Av. Işın Hayrioğlu Hançer	esezgin@example.com	A84rGeyG_)	BUYER	2025-05-10 03:51:12.371056
386	Zülgarni Boztaş Akçay	burcuhan35@example.com	((1Gk0stPH	BUYER	2025-05-10 03:51:12.371056
387	Çinerk Müzekker Akar Tevetoğlu	fatigulsensoy@example.org	adQQ*B7o+8	BUYER	2025-05-10 03:51:12.371056
389	Emin Birsen Akdeniz Öcalan	uakgunduz@example.net	^6F$$I1dH8	BUYER	2025-05-10 03:51:12.371056
390	Öğr. Saçı Nurser Çamurcuoğlu	inancliyuksel@example.net	nWo84LOx^y	BUYER	2025-05-10 03:51:12.371056
1	Ebubekir Sıddık Nazlı	ebu@gmail.com	13042003	ADMIN	2025-05-10 03:51:12.371056
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 579, true);


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 858, true);


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 1142, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_id_seq', 1617, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 5995, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 2400, true);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 3130, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 288, true);


--
-- Name: seller_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seller_details_id_seq', 95, true);


--
-- Name: shipping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_id_seq', 2400, true);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 390, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: seller_details seller_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_details
    ADD CONSTRAINT seller_details_pkey PRIMARY KEY (id);


--
-- Name: seller_details seller_details_tax_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_details
    ADD CONSTRAINT seller_details_tax_number_key UNIQUE (tax_number);


--
-- Name: seller_details seller_details_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_details
    ADD CONSTRAINT seller_details_user_id_key UNIQUE (user_id);


--
-- Name: shipping shipping_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_order_id_key UNIQUE (order_id);


--
-- Name: shipping shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_pkey PRIMARY KEY (id);


--
-- Name: shipping shipping_tracking_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_tracking_number_key UNIQUE (tracking_number);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart cart_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart cart_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: chat_messages chat_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: support_tickets fk4reg1h2465c00bg6dmqlv7ujv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT fk4reg1h2465c00bg6dmqlv7ujv FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: orders orders_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: product_reviews product_reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_reviews product_reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: products products_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: seller_details seller_details_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_details
    ADD CONSTRAINT seller_details_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: shipping shipping_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

