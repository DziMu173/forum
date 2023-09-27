--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18
-- Dumped by pg_dump version 11.18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: users_log(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.users_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if TG_OP = 'INSERT' then
	insert into user_log (type_event, user_id, old_val_password, old_val_username, new_val_password, new_val_username)
	values ('INSERT',NEW.id, NULL, NULL, NEW.password, NEW.name);
	elsif TG_OP = 'UPDATE' then
	insert into user_log (type_event, user_id, old_val_password, old_val_username, new_val_password, new_val_username)
	values ('UPDATE', OLD.id, OLD.password, OLD.name, NEW.password, NULL);
	elsif TG_OP = 'DELETE' then
	insert into user_log (type_event, user_id, old_val_password, old_val_username, new_val_password, new_val_username)
	values ('DELETE', OLD.id, OLD.password, OLD.name, NULL, NUll);
	end if;
	return NEW;
end;
$$;


ALTER FUNCTION public.users_log() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    content text NOT NULL,
    thread_id integer NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying,
    image text
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: threads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.threads (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    theme_id integer
);


ALTER TABLE public.threads OWNER TO postgres;

--
-- Name: messages_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.messages_view AS
 SELECT messages.id,
    messages.name,
    messages.content,
    messages.date,
    messages.thread_id,
    messages.image,
    threads.title
   FROM (public.messages
     JOIN public.threads ON ((messages.thread_id = threads.id)));


ALTER TABLE public.messages_view OWNER TO postgres;

--
-- Name: themes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.themes (
    id integer NOT NULL,
    theme_name character varying(50) NOT NULL
);


ALTER TABLE public.themes OWNER TO postgres;

--
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.themes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: threads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.threads ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.threads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_log (
    id integer NOT NULL,
    user_id integer,
    old_val_password character varying(65),
    old_val_username character varying(50),
    new_val_password character varying(65),
    new_val_username character varying(50),
    date time without time zone DEFAULT CURRENT_TIME,
    type_event character varying
);


ALTER TABLE public.user_log OWNER TO postgres;

--
-- Name: user_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_log ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_log_id_seq
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
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    password character varying(65) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (142, '', 1, '2023-06-10 20:02:05.301694', 'тест12', '1686416525298.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (143, 'тест тест тест', 1, '2023-06-10 20:02:14.967232', 'тест12', '1686416534964.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (144, '1', 1, '2023-06-10 20:07:41.15648', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (145, '2', 1, '2023-06-10 20:07:43.019232', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (146, '3', 1, '2023-06-10 20:07:47.240309', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (147, '4', 1, '2023-06-10 20:07:49.815575', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (148, '5', 1, '2023-06-10 20:07:51.656361', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (149, '6', 1, '2023-06-10 20:07:53.211546', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (150, '7', 1, '2023-06-10 20:07:55.072611', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (151, '8', 1, '2023-06-10 20:07:56.731529', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (152, '9', 1, '2023-06-10 20:07:58.554494', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (153, '10', 1, '2023-06-10 20:08:02.19115', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (154, '11', 1, '2023-06-10 20:08:06.77222', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (155, 'всем привет', 1, '2023-06-10 21:21:02.175591', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (156, 'привет, мир!', 1, '2023-06-11 01:00:38.052429', 'dsf', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (157, '', 1, '2023-06-11 01:03:08.178686', 'dsf', '1686434588175.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (158, 'ddrht', 44, '2023-06-11 01:08:02.691259', 'dsf', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (159, '', 2, '2023-06-11 11:43:05.764746', 'тест12', '1686472985762.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (160, '', 3, '2023-06-11 11:58:56.328702', 'тест12', '1686473936327.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (161, '', 3, '2023-06-11 12:13:34.054595', 'тест12', '1686474814024.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (162, 'sdfsfd', 3, '2023-06-11 12:14:55.345268', 'тест12', 'null');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (163, '', 3, '2023-06-11 12:15:01.554506', 'тест12', '1686474901552.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (164, '', 3, '2023-06-11 12:19:30.380592', 'тест12', '1686475170378.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (165, '', 3, '2023-06-11 12:22:37.964734', 'тест12', '1686475357963.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (166, '', 3, '2023-06-11 12:24:36.074386', 'тест12', '1686475476072.png');
INSERT INTO public.messages (id, content, thread_id, date, name, image) OVERRIDING SYSTEM VALUE VALUES (167, '', 2, '2023-06-11 12:27:42.594951', 'тест12', '1686475662593.png');


--
-- Data for Name: themes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.themes (id, theme_name) OVERRIDING SYSTEM VALUE VALUES (1, 'Разное');
INSERT INTO public.themes (id, theme_name) OVERRIDING SYSTEM VALUE VALUES (2, 'Продажа авто');
INSERT INTO public.themes (id, theme_name) OVERRIDING SYSTEM VALUE VALUES (3, 'Советы');
INSERT INTO public.themes (id, theme_name) OVERRIDING SYSTEM VALUE VALUES (4, 'Ремонт');
INSERT INTO public.themes (id, theme_name) OVERRIDING SYSTEM VALUE VALUES (5, 'Обслуживание');


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (1, 'Тестовая тема', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (2, 'Тестовая тема номер 2', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (3, 'Тестовая тема номер 3', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (4, '"Немецкие авто"', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (5, 'Российский автопром', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (6, 'Американский автопром', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (7, 'тест4', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (8, 'тест5', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (9, 'тест6', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (10, 'тест7', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (26, 'тест конец', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (27, 'тест конец2', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (28, 'тест конец3', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (29, 'тест конец4', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (30, 'тест конец5', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (31, 'тест', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (33, 'тест2', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (34, 'тест3', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (35, 'тест9', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (36, 'т1', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (37, 'т2', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (38, 'т3', 1);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (39, 'Продажа дисков', 2);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (40, 'Ремонт отечественных автомобилей', 4);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (41, 'Замена свечей', 5);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (42, 'Замена масла', 5);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (43, 'Продажа тонера', 2);
INSERT INTO public.threads (id, title, theme_id) OVERRIDING SYSTEM VALUE VALUES (44, 'zx', 3);


--
-- Data for Name: user_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (1, 28, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', NULL, '21:29:56.534864', 'UPDATE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (2, 28, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 'Роман', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, '21:31:43.672321', 'UPDATE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (3, 29, NULL, NULL, '21d99124e1ec95fb16a612e1231e5129a2a29cde0642cb532dbd5580b885e903', 'ффф', '23:42:19.343207', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (4, 30, NULL, NULL, 'e58f1e8c55fa105bdd3f40e5037eb0b039b5998d52c05e6cd98878dd2da5cab2', 'привет', '10:11:56.929738', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (5, 29, '21d99124e1ec95fb16a612e1231e5129a2a29cde0642cb532dbd5580b885e903', 'ффф', NULL, NULL, '18:09:27.376075', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (6, 31, NULL, NULL, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 'Влад', '20:19:29.280793', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (7, 31, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 'Влад', NULL, NULL, '20:20:28.876837', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (8, 32, NULL, NULL, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', 'влад', '20:20:41.32835', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (9, 32, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', 'влад', NULL, NULL, '20:20:44.893606', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (10, 33, NULL, NULL, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', '20:21:58.040048', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (11, 33, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', NULL, NULL, '20:22:04.133738', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (12, 34, NULL, NULL, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', '20:22:13.246934', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (13, 34, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', NULL, NULL, '20:22:40.399962', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (14, 35, NULL, NULL, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', '21:17:12.724688', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (15, 35, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '11', NULL, NULL, '21:17:39.425283', 'DELETE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (16, 36, NULL, NULL, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '1234', '21:18:47.82892', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (17, 37, NULL, NULL, '6460662e217c7a9f899208dd70a2c28abdea42f128666a9b78e6c0c064846493', 'dsf', '00:59:48.216702', 'INSERT');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (18, 37, '6460662e217c7a9f899208dd70a2c28abdea42f128666a9b78e6c0c064846493', 'dsf', '3e7008b59a6cd4ea4e7a26217c233e356e477d65c025630bcdcc7d727c8ca1fc', NULL, '01:01:18.129485', 'UPDATE');
INSERT INTO public.user_log (id, user_id, old_val_password, old_val_username, new_val_password, new_val_username, date, type_event) OVERRIDING SYSTEM VALUE VALUES (19, 38, NULL, NULL, '9834876dcfb05cb167a5c24953eba58c4ac89b1adf57f28f2f9d09af107ee8f0', 'aaa', '10:54:27.522845', 'INSERT');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (5, 'Роман2', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (6, 'Роман3', '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (7, 'тест', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (8, 'тест2', '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (9, 'тест3', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (10, 'тест4', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (11, 'тест5', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (12, 'тест6', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (13, 'тест7', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (14, 'Тест8', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (15, 'тест9', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (16, 'тест10', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (17, 'тест11', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (20, 'тест14', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (21, 'тест20', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (25, 'тест15', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (19, 'тест13', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (27, 'тест12', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (28, 'Роман', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (30, 'привет', 'e58f1e8c55fa105bdd3f40e5037eb0b039b5998d52c05e6cd98878dd2da5cab2');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (36, '1234', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (37, 'dsf', '3e7008b59a6cd4ea4e7a26217c233e356e477d65c025630bcdcc7d727c8ca1fc');
INSERT INTO public.users (id, name, password) OVERRIDING SYSTEM VALUE VALUES (38, 'aaa', '9834876dcfb05cb167a5c24953eba58c4ac89b1adf57f28f2f9d09af107ee8f0');


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 167, true);


--
-- Name: themes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.themes_id_seq', 5, true);


--
-- Name: threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.threads_id_seq', 44, true);


--
-- Name: user_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_log_id_seq', 19, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 38, true);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: users name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT name_unique UNIQUE (name);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- Name: threads title_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT title_unique UNIQUE (title);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users user_log_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_log_trigger AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.users_log();


--
-- PostgreSQL database dump complete
--

