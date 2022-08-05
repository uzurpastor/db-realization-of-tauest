PGDMP                          z           tau_est_dev %   12.11 (Ubuntu 12.11-0ubuntu0.20.04.1) %   12.11 (Ubuntu 12.11-0ubuntu0.20.04.1) _    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    74413    tau_est_dev    DATABASE     }   CREATE DATABASE tau_est_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE tau_est_dev;
                tau_est    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            ,           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1255    82544    fn_unique_stars()    FUNCTION     b  CREATE FUNCTION public.fn_unique_stars() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      begin
        if exists ( select 1 from stars 
          where user_id = new.user_id and test_id = new.test_id )
        then 
          raise exception 'you cant like this becouse you already liked it';
        end if;
        return new;
      end
      $$;
 (   DROP FUNCTION public.fn_unique_stars();
       public          tau_est    false    3            �            1259    74448    active_admin_comments    TABLE     \  CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
 )   DROP TABLE public.active_admin_comments;
       public         heap    tau_est    false    3            �            1259    74446    active_admin_comments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.active_admin_comments_id_seq;
       public          tau_est    false    207    3            -           0    0    active_admin_comments_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;
          public          tau_est    false    206            �            1259    74433    admins    TABLE     �  CREATE TABLE public.admins (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.admins;
       public         heap    tau_est    false    3            �            1259    74431    admins_id_seq    SEQUENCE     v   CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.admins_id_seq;
       public          tau_est    false    3    205            .           0    0    admins_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;
          public          tau_est    false    204            �            1259    74505    answer_options    TABLE     �   CREATE TABLE public.answer_options (
    id bigint NOT NULL,
    question_id integer,
    "right" boolean DEFAULT false,
    name text
);
 "   DROP TABLE public.answer_options;
       public         heap    tau_est    false    3            �            1259    74503    answer_options_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.answer_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.answer_options_id_seq;
       public          tau_est    false    215    3            /           0    0    answer_options_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answer_options_id_seq OWNED BY public.answer_options.id;
          public          tau_est    false    214            �            1259    123824    answer_users    TABLE     �   CREATE TABLE public.answer_users (
    id bigint NOT NULL,
    answer_option_id integer,
    answer character varying,
    "right" boolean,
    passed_test_id integer NOT NULL
)
PARTITION BY RANGE (passed_test_id);
     DROP TABLE public.answer_users;
       public            tau_est    false    3            �            1259    74522    answer_users_old    TABLE       CREATE TABLE public.answer_users_old (
    id bigint NOT NULL,
    answer_option_id integer,
    answer character varying,
    "right" boolean,
    passed_test_id integer NOT NULL,
    CONSTRAINT answer_users_old CHECK (((passed_test_id > 0) AND (passed_test_id <= 100)))
);
ALTER TABLE ONLY public.answer_users ATTACH PARTITION public.answer_users_old FOR VALUES FROM (1) TO (100);
 $   DROP TABLE public.answer_users_old;
       public         heap    tau_est    false    222    3            �            1259    74520    answer_users_id_seq    SEQUENCE     |   CREATE SEQUENCE public.answer_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.answer_users_id_seq;
       public          tau_est    false    3    217            0           0    0    answer_users_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answer_users_id_seq OWNED BY public.answer_users_old.id;
          public          tau_est    false    216            �            1259    123829    answer_users_200    TABLE     �  CREATE TABLE public.answer_users_200 (
    id bigint DEFAULT nextval('public.answer_users_id_seq'::regclass) NOT NULL,
    answer_option_id integer,
    answer character varying,
    "right" boolean,
    passed_test_id integer NOT NULL,
    CONSTRAINT answer_users_200_passed_test_id_check CHECK (((passed_test_id > 100) AND (passed_test_id <= 200)))
);
ALTER TABLE ONLY public.answer_users ATTACH PARTITION public.answer_users_200 FOR VALUES FROM (101) TO (200);
 $   DROP TABLE public.answer_users_200;
       public         heap    tau_est    false    216    222    3            �            1259    74423    ar_internal_metadata    TABLE     �   CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         heap    tau_est    false    3            �            1259    82508    passed_tests    TABLE     �   CREATE TABLE public.passed_tests (
    id bigint NOT NULL,
    user_id integer,
    test_id integer,
    pass integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
     DROP TABLE public.passed_tests;
       public         heap    tau_est    false    3            �            1259    82506    passed_tests_id_seq    SEQUENCE     |   CREATE SEQUENCE public.passed_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.passed_tests_id_seq;
       public          tau_est    false    3    221            1           0    0    passed_tests_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.passed_tests_id_seq OWNED BY public.passed_tests.id;
          public          tau_est    false    220            �            1259    74489 	   questions    TABLE     k   CREATE TABLE public.questions (
    id bigint NOT NULL,
    test_id integer,
    name character varying
);
    DROP TABLE public.questions;
       public         heap    tau_est    false    3            �            1259    74487    questions_id_seq    SEQUENCE     y   CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.questions_id_seq;
       public          tau_est    false    213    3            2           0    0    questions_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;
          public          tau_est    false    212            �            1259    74415    schema_migrations    TABLE     R   CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         heap    tau_est    false    3            �            1259    74543    stars    TABLE     `   CREATE TABLE public.stars (
    id bigint NOT NULL,
    user_id integer,
    test_id integer
);
    DROP TABLE public.stars;
       public         heap    tau_est    false    3            �            1259    74541    stars_id_seq    SEQUENCE     u   CREATE SEQUENCE public.stars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.stars_id_seq;
       public          tau_est    false    3    219            3           0    0    stars_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stars_id_seq OWNED BY public.stars.id;
          public          tau_est    false    218            �            1259    74473    tests    TABLE     �   CREATE TABLE public.tests (
    id bigint NOT NULL,
    user_id integer,
    name text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.tests;
       public         heap    tau_est    false    3            �            1259    74471    tests_id_seq    SEQUENCE     u   CREATE SEQUENCE public.tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tests_id_seq;
       public          tau_est    false    211    3            4           0    0    tests_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;
          public          tau_est    false    210            �            1259    74462    users    TABLE     +  CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    password_digest character varying,
    is_author boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.users;
       public         heap    tau_est    false    3            �            1259    74460    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          tau_est    false    209    3            5           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          tau_est    false    208            `           2604    74451    active_admin_comments id    DEFAULT     �   ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);
 G   ALTER TABLE public.active_admin_comments ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    206    207    207            ]           2604    74436 	   admins id    DEFAULT     f   ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);
 8   ALTER TABLE public.admins ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    204    205    205            e           2604    74508    answer_options id    DEFAULT     v   ALTER TABLE ONLY public.answer_options ALTER COLUMN id SET DEFAULT nextval('public.answer_options_id_seq'::regclass);
 @   ALTER TABLE public.answer_options ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    215    214    215            k           2604    123827    answer_users id    DEFAULT     r   ALTER TABLE ONLY public.answer_users ALTER COLUMN id SET DEFAULT nextval('public.answer_users_id_seq'::regclass);
 >   ALTER TABLE public.answer_users ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    222    216    222            g           2604    74525    answer_users_old id    DEFAULT     v   ALTER TABLE ONLY public.answer_users_old ALTER COLUMN id SET DEFAULT nextval('public.answer_users_id_seq'::regclass);
 B   ALTER TABLE public.answer_users_old ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    216    217    217            j           2604    82511    passed_tests id    DEFAULT     r   ALTER TABLE ONLY public.passed_tests ALTER COLUMN id SET DEFAULT nextval('public.passed_tests_id_seq'::regclass);
 >   ALTER TABLE public.passed_tests ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    220    221    221            d           2604    74492    questions id    DEFAULT     l   ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
 ;   ALTER TABLE public.questions ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    213    212    213            i           2604    74546    stars id    DEFAULT     d   ALTER TABLE ONLY public.stars ALTER COLUMN id SET DEFAULT nextval('public.stars_id_seq'::regclass);
 7   ALTER TABLE public.stars ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    218    219    219            c           2604    74476    tests id    DEFAULT     d   ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);
 7   ALTER TABLE public.tests ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    211    210    211            a           2604    74465    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          tau_est    false    208    209    209                      0    74448    active_admin_comments 
   TABLE DATA           �   COPY public.active_admin_comments (id, namespace, body, resource_type, resource_id, author_type, author_id, created_at, updated_at) FROM stdin;
    public          tau_est    false    207   �r                 0    74433    admins 
   TABLE DATA           �   COPY public.admins (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at) FROM stdin;
    public          tau_est    false    205   �r                 0    74505    answer_options 
   TABLE DATA           H   COPY public.answer_options (id, question_id, "right", name) FROM stdin;
    public          tau_est    false    215   �r       %          0    123829    answer_users_200 
   TABLE DATA           a   COPY public.answer_users_200 (id, answer_option_id, answer, "right", passed_test_id) FROM stdin;
    public          tau_est    false    223   ĕ                  0    74522    answer_users_old 
   TABLE DATA           a   COPY public.answer_users_old (id, answer_option_id, answer, "right", passed_test_id) FROM stdin;
    public          tau_est    false    217   �                 0    74423    ar_internal_metadata 
   TABLE DATA           R   COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public          tau_est    false    203   ��       $          0    82508    passed_tests 
   TABLE DATA           Z   COPY public.passed_tests (id, user_id, test_id, pass, created_at, updated_at) FROM stdin;
    public          tau_est    false    221   �                 0    74489 	   questions 
   TABLE DATA           6   COPY public.questions (id, test_id, name) FROM stdin;
    public          tau_est    false    213   �                 0    74415    schema_migrations 
   TABLE DATA           4   COPY public.schema_migrations (version) FROM stdin;
    public          tau_est    false    202   �       "          0    74543    stars 
   TABLE DATA           5   COPY public.stars (id, user_id, test_id) FROM stdin;
    public          tau_est    false    219   S�                 0    74473    tests 
   TABLE DATA           J   COPY public.tests (id, user_id, name, created_at, updated_at) FROM stdin;
    public          tau_est    false    211   �                 0    74462    users 
   TABLE DATA           d   COPY public.users (id, name, email, password_digest, is_author, created_at, updated_at) FROM stdin;
    public          tau_est    false    209   ^�       6           0    0    active_admin_comments_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.active_admin_comments_id_seq', 1, false);
          public          tau_est    false    206            7           0    0    admins_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.admins_id_seq', 1, false);
          public          tau_est    false    204            8           0    0    answer_options_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.answer_options_id_seq', 3026, true);
          public          tau_est    false    214            9           0    0    answer_users_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.answer_users_id_seq', 854, true);
          public          tau_est    false    216            :           0    0    passed_tests_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.passed_tests_id_seq', 100, true);
          public          tau_est    false    220            ;           0    0    questions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.questions_id_seq', 631, true);
          public          tau_est    false    212            <           0    0    stars_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.stars_id_seq', 26, true);
          public          tau_est    false    218            =           0    0    tests_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tests_id_seq', 47, true);
          public          tau_est    false    210            >           0    0    users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.users_id_seq', 160, true);
          public          tau_est    false    208            w           2606    74456 0   active_admin_comments active_admin_comments_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.active_admin_comments DROP CONSTRAINT active_admin_comments_pkey;
       public            tau_est    false    207            s           2606    74443    admins admins_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.admins DROP CONSTRAINT admins_pkey;
       public            tau_est    false    205            �           2606    74514 "   answer_options answer_options_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.answer_options
    ADD CONSTRAINT answer_options_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.answer_options DROP CONSTRAINT answer_options_pkey;
       public            tau_est    false    215            �           2606    74530 "   answer_users_old answer_users_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.answer_users_old
    ADD CONSTRAINT answer_users_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.answer_users_old DROP CONSTRAINT answer_users_pkey;
       public            tau_est    false    217            q           2606    74430 .   ar_internal_metadata ar_internal_metadata_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public            tau_est    false    203            �           2606    82513    passed_tests passed_tests_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.passed_tests
    ADD CONSTRAINT passed_tests_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.passed_tests DROP CONSTRAINT passed_tests_pkey;
       public            tau_est    false    221            �           2606    74497    questions questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            tau_est    false    213            o           2606    74422 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public            tau_est    false    202            �           2606    74548    stars stars_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
       public            tau_est    false    219            ~           2606    74481    tests tests_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tests DROP CONSTRAINT tests_pkey;
       public            tau_est    false    211            |           2606    74470    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            tau_est    false    209            x           1259    74458 %   index_active_admin_comments_on_author    INDEX     y   CREATE INDEX index_active_admin_comments_on_author ON public.active_admin_comments USING btree (author_type, author_id);
 9   DROP INDEX public.index_active_admin_comments_on_author;
       public            tau_est    false    207    207            y           1259    74459 (   index_active_admin_comments_on_namespace    INDEX     o   CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);
 <   DROP INDEX public.index_active_admin_comments_on_namespace;
       public            tau_est    false    207            z           1259    74457 '   index_active_admin_comments_on_resource    INDEX        CREATE INDEX index_active_admin_comments_on_resource ON public.active_admin_comments USING btree (resource_type, resource_id);
 ;   DROP INDEX public.index_active_admin_comments_on_resource;
       public            tau_est    false    207    207            t           1259    74444    index_admins_on_email    INDEX     P   CREATE UNIQUE INDEX index_admins_on_email ON public.admins USING btree (email);
 )   DROP INDEX public.index_admins_on_email;
       public            tau_est    false    205            u           1259    74445 $   index_admins_on_reset_password_token    INDEX     n   CREATE UNIQUE INDEX index_admins_on_reset_password_token ON public.admins USING btree (reset_password_token);
 8   DROP INDEX public.index_admins_on_reset_password_token;
       public            tau_est    false    205            �           2620    82545    stars trg_unique_stars    TRIGGER     v   CREATE TRIGGER trg_unique_stars BEFORE INSERT ON public.stars FOR EACH ROW EXECUTE FUNCTION public.fn_unique_stars();
 /   DROP TRIGGER trg_unique_stars ON public.stars;
       public          tau_est    false    224    219            �           2606    123837     answer_users fk_rails_2007de8069    FK CONSTRAINT     �   ALTER TABLE public.answer_users
    ADD CONSTRAINT fk_rails_2007de8069 FOREIGN KEY (passed_test_id) REFERENCES public.passed_tests(id) ON DELETE CASCADE;
 E   ALTER TABLE public.answer_users DROP CONSTRAINT fk_rails_2007de8069;
       public          tau_est    false    2952    222    221            �           2606    74515 "   answer_options fk_rails_4d660e1508    FK CONSTRAINT     �   ALTER TABLE ONLY public.answer_options
    ADD CONSTRAINT fk_rails_4d660e1508 FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.answer_options DROP CONSTRAINT fk_rails_4d660e1508;
       public          tau_est    false    215    2944    213            �           2606    74549    stars fk_rails_510b95ed0a    FK CONSTRAINT     x   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT fk_rails_510b95ed0a FOREIGN KEY (user_id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.stars DROP CONSTRAINT fk_rails_510b95ed0a;
       public          tau_est    false    209    2940    219            �           2606    74554    stars fk_rails_65a3b07b2f    FK CONSTRAINT     �   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT fk_rails_65a3b07b2f FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.stars DROP CONSTRAINT fk_rails_65a3b07b2f;
       public          tau_est    false    2942    219    211            �           2606    82519     passed_tests fk_rails_a91d158a2b    FK CONSTRAINT     �   ALTER TABLE ONLY public.passed_tests
    ADD CONSTRAINT fk_rails_a91d158a2b FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.passed_tests DROP CONSTRAINT fk_rails_a91d158a2b;
       public          tau_est    false    211    221    2942            �           2606    123846     answer_users fk_rails_b59340e2f0    FK CONSTRAINT     �   ALTER TABLE public.answer_users
    ADD CONSTRAINT fk_rails_b59340e2f0 FOREIGN KEY (answer_option_id) REFERENCES public.answer_options(id) ON DELETE CASCADE;
 E   ALTER TABLE public.answer_users DROP CONSTRAINT fk_rails_b59340e2f0;
       public          tau_est    false    2946    222    215            �           2606    74498    questions fk_rails_cb4b358d50    FK CONSTRAINT     �   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_rails_cb4b358d50 FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.questions DROP CONSTRAINT fk_rails_cb4b358d50;
       public          tau_est    false    211    213    2942            �           2606    82514     passed_tests fk_rails_cf7a266e5c    FK CONSTRAINT     �   ALTER TABLE ONLY public.passed_tests
    ADD CONSTRAINT fk_rails_cf7a266e5c FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.passed_tests DROP CONSTRAINT fk_rails_cf7a266e5c;
       public          tau_est    false    209    2940    221            �           2606    74482    tests fk_rails_e0c5eb5e4a    FK CONSTRAINT     �   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT fk_rails_e0c5eb5e4a FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.tests DROP CONSTRAINT fk_rails_e0c5eb5e4a;
       public          tau_est    false    2940    209    211                  x������ � �            x������ � �            x�u��r�6���姨'� 	�t�mkb:b����}�7�R��I�Q�~���g&�޻�L�E�@��D&�i�w�[��=����?,Ӓ(������;EY��|}�/���eߎ��d7��;�j7�������r�^Η������_��R.p�>߶��~�������|~������gjV�|�^�������m?�'>������~����tz������A՟����W��Z��ɭ.�����Sy���r��)�����_@��|�3��6�P���Fn�U��zy���c�C�������G��{����p||�^���&/f]�����٨����������˫<�dT�@�CQ�t~���W
�
��yz��q3U2'��H��>˛=�nlϔ�&?�a�<�_^�?Q��G{���#��;*��/���pի:n���ډ
�
̻�U^�*�mۏ��=�� <=��x~.SDf�O�+������3�{���zگ�P�I[�_��;�u�Y�ί�Sy�r��i+���q�8���1��ˆ7w��5�N��W
W�����R������%e$/�v94!���k{W��B����#��R��)���^� ��vz*�	M���O���۱,}�8��uen_˄(�J7�/�/K��ݗ��*����(Z)�\;J/o�c�#�F�z��e��s匊Aeu-�b]R�^����{������K���}߫���������q��I�[�^Y�*����~�����o��X,#�
��״�����m/V���f����K����E��zyͯ�;�	CK���R,�����$/%�`q�ʌ/Ӟ��
�*e&<o�ǯ��y�n���Zf5島�tz<�os�RލL����Q��y{�Hv���8^R�l��u�p>�U�!O&�Zz���>��Y�9eקT�Sye�߾azQ���{8^O/��D�N��U�IW��<M*/������u�f��/��^E�q����a૞'G�~������ج��?��]�uݥ�ɫ�X�é�������4�'�6��қ�D�.�=�,�u�1un��97ϓ^�H˿��xz+���Yu\�;��a+OA%F �#���<;�h.��]�/e�٪�h��7�o��m��T����I�}��݅���u_��FuN��^l`�?`S|ݸ��eR�nD�3�{�U);��3�K鷇��\-�8�Ĵ�e��Ue47�ݜ�*���ɼ����m�3X��z�I/�������i{�j��~l�g-K�w�C( ~T���uDƧ��|�i��0�2*_�	⊞�~����|>_䵂�(��	Pw����Խ���"g UF��� ?��~5�3���z�Z�w~U���}�%h4�����Щ�@լ�:���=����r������i;�K��-��v_4��b!�]�L�"h�O�CeER����-s�I�e��nPP��ae��H���&> �rJ�
a������
��٠��7����D���s$�a��*��\ɇ�f�&�����&l6=�^�3�eP��ͯےRk>�a�(��SZ�9(Ы�*��T��I�����)��jf���m���DyY�}� @6+Y�n�iU�:kŉ�0`ؾ/�*�6�\�I	4�v�� ����0��vf����Y���5�_���T���a�������{:]J;mT������3���eby`�����W `Xl�p-����Ҝ�������s�D�R[^BY���Ԗ��ư���WI``p�Fl�.X``�G|z�^��l�C@�B3��W���l�*���������鰕YEU�J=~���d/�G�"U���}� RHi����x�`����P�@�+@G�3����9,˟���;��`�*��瑇L�Є������f���, :J��=Q1����D`�Ώ�2�\�1������ �r��z�2�J�R �
���l.������.�9JA e\N�.��}���4�.t�W���\@u���[�r!�-^�y� �B�]w��@�ƶ.�9J��kw�s�
��@bz}�~�9:_�x.`9��uF�`����7]��VP��"�`��e}����B��qAs���'��Q:8j��X�vQl������Xw-�����P�~/â� a�Q���k�eF]Vݏ5LQ1m�EXKl��`]�X������˲��E��c����N���1�b�^t4De�>�)���7�����o<��m��1�>�'�w-u&���ZW��A0/�ͨ`؆� ��j�7>H/��Q[�ze�}Z�zT \qܫ�����ޱ�{��t4����e�[��J��^�X��Cs���J?m����忨��p�J3��O�^�#7- �Hv��b�?h7�8����r�[@|i����T7��[@�Q��n��$#	����+������)��4XV�_�w~�n,	��_5�a�[)�5�z����^�bǿ��. `��1�K��`�D���m�P`RSgv �:W��� �&:tŶ	�tL�4�XCx0iԯM1 a���� ��o�m��^�p��;�05S*;7(0-�Y�
��?'���*6���:ڤ:N���tS��P�t{ Rm+ 0�j�q8u��Iܥ��-���ѵ�{��mOmhA~����C� 0ItK��0��C� ��%�� OD�AZHa��V�n\@��  �$>���/6����T�c�
L�|�-�'7��m�>�� S�L}uS�b
]��d)���
�XQn��E=�q`�$�*�	S��G��]l�S�sH߁٨E!:�� �T�p��Q��j:p1%�A�t�1�6���v F����@E
�:9�0��+)� �	6����0�q����R�����=�6e�J	#P��6�a�_�]��t>O����HT��vTfU~����)�Y_`�f̘�Cc�Ę��]��\h����d�����@�����!�?ʝ/f��2�U��@�y�n��+v�B���"�g�=�y�/��M�j�v�9�^�@�Yi�d����ޟ�Rt��v8&��$�d�PH9c�2������7IT�Ӏ��9�`�n6p AJ�^.2* �l�9�F�_��jA@�}�����ခy�5�����1![(�c��i;@_jI� ���r=�����`G�*��:9H�;���͉u���B� ����x�Ԭ�i'�2P@�oH�[��\��"�NZ8��,��������nV`u9�N�� �g�CC�|�o��F��a�E�1屩:k��9@^�X���.�.�w�+|�'!���=p����҉ShO4�ydw�a��(��^Si���?qUuEW0�O��x�#k������{�\A?\���&������&g���,��$bT̤a�=魒�k(�< 3Uc�O��b�[��f���'*04k��M,9���7r��Vm��̫�J�*�HEX��*��o�:�ԯs�]J�ڙL��)k�~�j ��I����,�d��˳ꄫ��z�#���'��Q��Q<u�^�k�5�����[z6C��#F�Сͩ�j4��L��M#��4��c5��N�ꋝ�6e����ݪ�G����:}���i���_��3���܌�:�dHeZ'��`���6Qk�~�ʿemWh$�yR���!����x���댁���Ym��������2y#�u���g���:�z�FK ])��n��[�
��ךְ���as�ւ���a%"����jE�.?a-��g�&;�c�� 4{u��M��v0�Q�Z�O��j]�kA>�^vs��]�)���!�.��FS�UV��d=t������Gu�J��R!/���	�pR�DS1��6H��RXx��^���v�0�ZD�a~�	�5o9\PO�FH��+�K��4��DM�M�e��M����V�F���	�w �_�]�XWmђg�D�^Blj��{"�2����H�3c�����D���򤏔UZ=�r@��(�@��#U��d(�8��̳f�y    �By�n	�U/���>q�-�kg}P���Gۓ�G��=!`�wJףּ�Y�S�Y�ř��>�^Β���H�1����~�R,fR��b���i"㢏�J?��U��l"�Y�85���2�P �ˤ�(^�E���#����y'���p����Fa4@�e���P�7�0�h����)m� ���F-M�b�1-�� �(�=�n Å�Z�q� �l\^��`������#�å�f'CGD�DUV����A(kŎ	몗�]dH!ª���*���DnD����S ��`8[��i�b}u������(D����e������6..��o�1������j��
��$�?5_��_2+��.�L��OYU?qT���(�8�D�?Vcrs6o�/Q9�$�E�9�6���r������Xk�=��?�cl}:�l�0P�]�X|+ (I�g��|0ņ�-�����DQ�@�3=�WqiE�aC�m8��õ�B�aAJ��^������c/R5�*�88z��\4��RNPKۂ��K9�m6�̉��N[��&���a��G7D�.�U�q\� �?o�`rC�k��`�������`*x)�`�ןK�.��G��=c������d�Q�Ճ(y:� ����X*1N����A m���:͚l� تF��d����	m������1�@?ga=���=ʰoԇ�9A@�6?@z�o�����sԌ�=��r[LO����Pu���< d����� ����A��`f���'¡���v_�������\z `�_�`��*�i���Yav	I��fUMk�1� A����~A[����0��>�ׯ!P!+A�M�%qx@�3��vVl� ��ə��C��:G	y�!�@�1�Gy�!K:��8�":I�F��Q
@�t,���2l������T�]<�p�Qq�	Y"gv�&�A�k�'^_��`A�3i	���}@d8���A)9�d�x� KE4C��<�e%����&�@�*g�ȫ�̓��!��K�.������Ub��̠&�G���5v�|,ը5&Jl��j����,�o�aQ'A+
\�Cは=x�j��5����,ݐ��"=�p]���� B��|��P끃��բ�灂�k�1����Op�ڎF�΃�b�j� �F�v8Ȧm����W��Ѻ]<H�F 9	@�,1��f^ 
�rl#�J�VG���%  Y���dFі0!�A~��0l j�GW���<1������9h(�}n�b\(U �y#L ��CAI/�*%�}��xHEu;��& �T��>���k��|���0�%�fm �:�Y���!�T��V.җ� �6�Ӱ�@���6w[��F�!+G�i���&�t2�jw+�P���ZV�`b�PԊSø����yIs�8�w�Ҳ�(��Hڹh $z=�ٺ �:�F��� <�
��D/�<�)�B�Z~,f1�����>�@�V'�|�'
W�?���B��8�ʃݾZ�.+2�Y��L�U#��$����+$�[�& ���Q�M �Z1b� 4�^gE�f�!�< 7Cz �vT\K`pP�F�킩H�}?Sj�/ Y�!q�ӀN� ���2R E/E�5g7��w��lH��%�J� 6dI��ײ0�|�rG��3z�U�-�c9�D�t�!� �r;&?����ގF��`AJ���"O�U*.��h�YX�vz�~r���ȃ�X��z�F��G�14�9�����دv���ѩzj�
J��� ͂u�Q ����:�L� hw���jDt��)��YP �7q��� �c!�rH@|RIB���'�`��YT@��y�����"�eB���R7�����;	p_�|BKb@>)����_�����t�� ������Vhtt�z����> ��D��5�@y,��,���r�{�Y���jx# ��Gq�Z# �!և�\ �MV)pjS���MgX�.�Xw �F�&��x �x};?՜� �c͆m�v x�<�W0$"���ʎ�%�Xg��ߝyF���3,�`�P?^���e��'�;����POv�p�b���*0P݉�`�د�c���)�zS��p.�D(~�D�\�h�`O"@�%z�l����r�53�p���jP2�(�w�"`.XN5�o#`�e�@�:���!��8)�@v��h`e�d�Fp���a���cM�>�:��w�W?6�[��D���A�Q͘U]��F��!G}`t|i'�6�@�����nQ}ZYR:)�nQ�����n�&iZ�'u�:��mR r��V��3_m�)����D���b58��4��#�-_y1''�ۢիU�<�X��� �ڢ$���.=L� 7V_���5�>��X�!�V;m��76�E��'��� �����S+Rk��pRh���n���.���;�I�C� ���=��j>ڿ����'�c�1�q���b;4��m�fd8Ƌ��Xkz�%���E���=��6���wPAo�ﰘ���E��iGo{�o�u	��Ƃ$�vK�Qa�D-E� �h�?���" .�!q��"�-��8XP,$�$l���?��Ȗ�[0&�G[Rb�5
dK5�w�	LD��mh�1��T6~�#ߒ}�@�Ѝ5:�h@nR�a1v	�D`[���'�ݨA���;�̸�oAn��ŧؖ����@5S	�z�S���6��b3�、�R%6;9���ԟb\�9��^+�ۦfKj��K���������o�T�bKç
�S�jc��P�q�'�I!�X��nTH���#�-Y=\?�oI��j��L�[�M�3O/�X�a���(k�/�	w�����~a�Q�E��0%�[�y+�{M�7�Ĕ�Ó p,��QNsj�0��x��tq��	�*��&��*dD�	��qI��2����r��P��tV�����K�Y,��I���'��	$Ga�d��DƱ��Zc1�	$gmI%@��y�i�I��鮯���}�*n�Dv}��z��ɂI 9�~t�>� [!;���c�DM��!�e�I��FDh�����0.�D�K�8*�umU$�\�d�$U=Xzk�Q$�Uw薀r�\��N�8�a��8�Ar,���E�%]�S�Z|�����n�L�;)�0KӌF��j;�K ���Ё-��#��\ԗ �c�G˔ӫ�x�oi�}��m�^� ��y���&@K3�UO�|��YK�l�]Zg�Q����y�+0,w�?�H@<j-%�U�Y�-��>���wR���I���@xY���FTI �m��wĳ���%,&0^��Z�O����� /�r��ZuU��v�Ѕ��/���S�;& _V�&/���CX�� �(� F?2�=�q|�-%<��P��0��.���x&R�0��T�0���d��|�h5@��^��8�˘]a=�����
�ٟt�Q*������æB}�e�n��T�/L��W����r�0L�������~�z���I�]v];5L1�7d �4Q���9H賫��,���X��6����Iɫ�c{� %�k�O���R�R"1j�R6Y���� �Ir2b[^Fn}�j��Sm3��~�
��S�J�S����H�-���Y�`��f̀N��TSO\�E�YU-�*O��b��Ӭ-����'��)H�z�Eb4���Մc�y򪖰=E�D��dʹyB��XB33�T�О.�H,%���xn[�Z��z�͚��ٰ_#yv*��v~^)��� g��^gGUߝe�9�%f���v.�X��UJũ�[�
�|����	�(��.T��-����\M4�i@�~��0׳��K���Bj�����oV�Y�����k�̑�w�����cXyA��'����D���򒵅l����T��s鞛UJ�^Ӱ�C�5�W�t���8;�UОi�2���.������f���`�p��n�KT!KIo�U`�/['�L_���uV���yE/�g^��Tso�̼�*j�z �  ��WO��U��y���7����Aw�qv�IU����yyͪ�`��~�n�!q�~�ƵM�ǰtG��w�#]8$�U!9̌��*D��D��*p$�^���X4�uQ7��������Q���z��Y&�^k��wf���Őt=�m����(��}���a�+$V������Я|�T��h��r8�T+UO�2hl���J�A����e����mz\ƚ��]8��!�A�`�e���1�Ad��9��2�d,��/��E���%�Ӑ4ȨQ�X8̖�OPY8%��X%�3�10��dK�	� d��f�8�iV-���e`�!�⣐�i��/��B3Pm�_��y0 �b_ϳ\���J��#L z[$��<���"�"V�AnRY1-d��R?����g����e �b�PNW20��81i؛Aq��+ϺY���]�f�sR��_�`8�Li�\���E>���W	�[�{�D�&�ܢa�.��c[��j���Ut��&�����F�"C��z��1�@QyU}�û"	*���>Ѹ(1I{��D�i��e��Ղ�@�� yVhх��bVE��sW.*t�g Z=�Ѡ�q��@����䎰4�P4^|�Tn+�\���-��ceCϷ?L�����{E����MQ^vxo���UE5�jH�4׷�ˠ8����"u&q��Pԫ�-�Fv���T��q�����M����?��(�_�      %      x������ � �          �  x�U�˵k+E������!���_��(�u-�t��Ƞ�.�����?���Ͽ���Y�����&� z�> F��`�)�V��Y�@�G�`=�X��S�w� 4}Zh 4}z�M�A�����
l���C�`��>k ��g��WN����
����t�0������
P(��X/8O�:^=B���W�>BӾ+@� �i?@���h���h�%��e h�˫G}�������/(B��@��S�д�	�!�!��� �8Kh���~%4�Q���,��վ�Pk�*� ��MW ��`
L�%���t�
�#�Yjh�V�E��o[ YT�SY�y dQw�dQgABk���@k�p�i� ZӲ�1�ִ�W�i�W��h�w����o��g ��:W/� 4�~�`p�#p^��jQl/�W���^�~?j9��W.f|�R�����<>z��z߿z	O��xk�Uf>v���#+{�����y?��_o�C��K��S���y�s����͂�>���"��(׭� ^���3��U E������W��pl���v<����Zo�h�i�aH@G�/|EGqH�(�@GqN ŉYd�u�cԮ]OM��H���@���C;%��3`8�O 9��Y�)!�0�ph�,�'� C�'	8�!p ~�4}8��g����`:u ;�c�# vD��E"#�[o��>2�*o����D	���D	� ��s�|�0K�	���n[i�=@hڮ�h�i;�#4��y,����1B�^�w�ݞ� 4�t�P:@X ����	���!7w�R@~nl 9�� ����Y�z�=�3 Ϻ���y |�; S.�����c�8�:/�{��U�Ο���쀙遀��Ck�	�?3�r���(��iu�z�tI@��)���钀lPBg,����:c�K	�-H(�������	 ��^J@v{�%�m�ᮩ����,�i˴��@BѾ��N봾~�K���pM��^��5��k� ��^S��5}g��0Yn% �e&�N�+����L��,�/4p�L	%���2�P�2�j5�3��e8C�p�r �e (CI�5`�l��B�2Y6`I�Z �}����,��\�S�q�8�C�9��M{ k: ���h*`M)��3kJ	7 ѭ��9��� :�w�tN��7�9M�7M�C�)�1��7����P��(���߯(����Am����?�
X�𣩀5� ?�
XS�"M+Ƙ?�
��Sb��#��4픰�7H�ؾ�m����}��BY`��'�=��`�� ��SS{�	E�k���@��p{� �m?�����Y��k���y>���� �)%~�T�gM����`����=B�qnY�[8���bT�S����pn�1�[�ctǨ�Mbڝ��K �Gn�AL{�<���iO�����
8�bŗ�	��z�����-�.b�kBӓ��@�fmj Ms��i�Si: ��s&$pNFS�;%��\���\��Ow��\�`�'a�Д0��J(�ΊO@��%T&d�o�2�b�Y+��l<�@�.�}��@B�.���]�:t�vpA3 ���� �ȥr)�w��G)r}����}5P�;�Ju��P�{`�� 7(h�(1Z�E��\���4gY|Ns��	��	�s�����
8g@b��v �ӉY��9��g~��G[R�]S��L��g�6���LZ@�f���
	�~�(�>�pQ��c�p.�2C1��,�P6�J���R@g�E��*z(u��l��5�����l?ϩ�l�7 i��"M$pn�g MӢ*�>��+'��pn�fub���T`��` /�9��T�� ����ܯh y����Ke�@�f4�M�j�H����4;5�4��
�Y�
�(z0��:��(�Hj�t#��ʘ�Ỏ�N�n��(�H�7ظ18�P|בePP�Td(�tAŨv-j}t���@)\����]�P
w�T� CP���t�d�c(F��������Q	 g��gO���O	����w������	�5�n��w (��+�q>�EQ�OTj\M�/�wM����uJ���<�Q��y�h ����w��/���x��B~j ϟ��w��a&w����*�S��ާ��i��Y?���90�2p.5�K8�/XΥ6@�%�A�-�A�-��l?���>jDm��! ۿ�
,Ԧ������P��wM�'J(�.�E1j_M~4�4�����`��68���vV'U�AE�o`M)���`}ϩ�v�P»� M������0�6��W ���W����+9�G��ͥ��4J8���`.ep��(̥
:�Υ�;Ka&m �1j�J� _�`�O	�� ��`�����	ZӅ1j�m�A���<n��ٙ0p֗;'��>����=�����a�ƬϠ��z>Z�Z�3a�fh�Rj�vJ���������(F�	Ũ��à��A�Ũ�ݗU(Fe�g��$��F�@���o �Í���1�vV'����d��ct�����U��=�"@�7��o V���߀U��hھA�M�j���e�7`.e�p�h�q�h�h
��hj�h:ޯ��ʛD�R�L��k: ����	FS�)$�f�Ħ?5�HxM$\��z����R��RmC�^j@���8��8�R�^��:Y�,�^�c(�fŷf��[���<��:��b�}e���@��(��_��gŷv ����_/%`�� ?�/`ۇ�bԞ�(��`ۧ�m ȟ^�?�a�(��C	��kQ���t]{�i ?*)Ï���^)�p�k���Wb?��7F}s)v&n���m��cT}%;�Q���۠ᑡ�:h�ps��.#��[��A;�ظ�38x'��u�A�+$��WH�:Z��~��:*g�9�L��u�`e�:�������
�� ��0��:
zV|�`�g`M7�5�Z��z}�`M������^_V'wkZ!�q#��g��Q�1ʀ��}Ǩ�ePp#a�e��π�����K0�2Xxk�������Υ ��KUH�NJ8�j�`gb�3p���/��pg��/e�΄�/��6�����~�/U ؗ2`.u��V����K0�2`���R���`�7p�o �PN��Ŭ��P'm�`����i֦�Z��M(F�����K�7Ѕ]��Q�B?|L�?zkM;�ċk� �'EY�ܛ
(F�̥
�M*^�4ܛ��3�@��e �ϛ3�~Z���4{��t`Ũ�e MӢ��~`�0�bԹ/�g ݝd��@w'�?.0��q��~)�^J�?�q�A��l�*p �~\�Y� �j�>*�ޗ��Xx3a����K�QfqU(�\*��{(������?U�E�         ?   x�K�+�,���M�+�LI-K��/ ����t�t-��L��L�L�M�Hq��qqq ��D      $   �  x�}�Q��(E��*f��^����}�NЪ�;H���DT��-�/�P>�}X�ڄ��C^�WUD� �X������!�v����Y\*�䣮ד	o`=¿-�W3�������zu��X�e��K)�6"7�@Ƈ��O�N�8�O+�^��E�~P=�sÊ�Y
�����w�Zs�\ht�ӈ�fѼ�d~�д�jHI
�ķ#���V��3u��:�i�8G��\��m�x"Qi;�G�U�d�r�%��#�� �B�D� �|��,�_�P��u��q� Ы���Ӊ�5k�/�Ȼ,�N2��C��WDgU��?D��J�J�5��?\����<�A�^�	�
�Y�����[Q��;�z��*��^jz�'5\4��J�h"�jYGКsօ_]C�}M#oʚ����)��A=QjM�h"���;���A�Hr�R� �8:)w`����:��#��Pc��*�2�������@2�{ތ��^d	���E��f�x����=�܁��\����8G�y
.R�P��H����L}�s��Y�V*�A �gΫ@'��._�e���l�1�'y�@���F!G�.��lg�4D��CJ���f�ϕ�Bb�Ϻ-�R���@ƍ��AH���;�]�xAsg�#�\Z�h�=t�Y&�.\�����yN�41�.Ĩ�ġ��Q���h��zV���A@�X�\�%��/���e�F���@W��?o�j���"����.3��~¯���u���9f��,�p!PR�E�ʛ��.��$RAW,-���A���'m<�jz���;!+�0��TnZ�CK���b���� �N��1���Mb�CІ ���奈7M�T��7aI�Ak�y�'a�g1�6p�'$�Z�e#*L��憠�x�$�iX���I+�!���f3�ϑ�^��E7���{�DrMF�o˓p!0��3	�)%~gi��� �X��+�i�&b�A`��0[��cP� 0��g#O+%H�모�	oZ5��q3�"�ފ�N���Ԥ_�$w��������K���<��U����,����*�ja�,�C�4����ӊB�$��D�Q�.�y!b���-� �>�(��K��A�ا���L3�y��M\�U�b}J�ey�ri!&��L�CN�	�k��DN���m�G�b�Y�\�~�C�!�1���f�SZ�w���z0�         �  x�mZێ�H}��
}�!�T�<�$���\'yڗj��`Y�%���!Y�.���c����C������n�T����u������y�n�C�\�킿�_���8��[�M]C�>t�����t�o����'����������^���/��_�r�ō�X��:H���O��M�x:�I`[��|�D��l��ks��.v����~mb��m.��6������y,�~�8�9�+���_�+�H���8/���ENO=N'�Nv��`w�|�!�Cf^���pJuġ��n˕�&�%��� �����Дx�;R��4�I�,�P�#��Ǥa���͟V[����=r���8H������y>��J�۳�K�C�~~I���N:�g:��CSC�[�rC�?�7n͒�i���^���.׎�BB�����������(Q<�J]��*�H��B�oJ��-ˋ���)(����T�,]v����wvz�-��Mc�z��}��K:<�[���,:@���n�Ɵ�H��D9�]�є��3��i#:oP��\x$���	���� �P~�{�=���T�b_k����Ó0�<D�~�����k�y�j$�J��m�������<~�������<M��Cޛ�6�n���|��|�� ���T?��|L��P|& 8��e$r(��H�)��z[
��2�f�J ݎ����/�틇�{�ӟ	d "��$�CRJi��=&�_���7K�.�� �/8�_*�}�ۄ�,H�m�^�D�L�� 蹜�7p�iet�ħT��?�@�J������$OR��d��䆖Ң�۟�T<�NۢQ����Ъ���,�Do��|������m��-)%��/���^�T���Y�](�m2��-@%$fl۲e���<*	�7,��q<��52��t�Uh�G-��>b7)�P8z���B��PK�O�� ���Ъ^��w�I��zW��_P��E#�ߝ��A�}Wq$����8j�` w�j�n��^/iHx?$��v5�$�.i��G{դ}��	��5�+B9+Vq����P� /��W�3 IcE0dA���r�v0�"�;���r�v��9h�x#`E̓� Ɔ����mt*=�z�'z���L�D�M4G,}ٸ��>���(!�"���g���8� ���4�����z�2hH������[�.eB{�f���b ��&tů�O�QC��X�hLZ*-��X��`�{fLW���*mƮ'�a+��\5D�Ň�t(�c��t�F��B�V�d%�ۑ�����M�2)J�F��A��|!&@\������D{�~�J͛X���O�d	�P��h�멼�}��d�)�Ț����NU�ΆF�^�r�1�F��j��@B�6:��)S"�Y,/7jkJ�r"�wEIFq�:�1��+KgHi/ih��N���1�%�
S�w	z��u`�i.)vb9fGvI����R��n�/n��f�,��"l��Bi��{�C-G�$���Y�X ruo�:������x����U��8^��<w��}#Ds����׌+�a��(�C�lT�W�L��)k�<�N?�J��5�4�G�A�\�܋�)h}�ah�W;�Ə��C�9D$���b�N)��d���nn,�B6�q�B�F��k�t2�a5e�c��ߘ	�Ys�3�k4Nh�){��1#�w�������g�@j�ȳ�E�����ʽ]���h�E���h�6UűG�!�z��`f�a�X�e*J���9����i8O�۾[����m:T�K�.�)1S5OC��	�B���o�@Sٟy�¡O4�P�<,q<Rl�$F|�^��*��T�2�����l�����}�#Ѳ!�Yj'0zS򖌴�3�����7�ZOǢ-��R��"?>4*h|ˁrY���<��I��.%#-�V��Y�<��y�5�H	�2���B�����H��,�-�?N\e�?٥���
�;���B�Ԅ���A/Ou�֜K�}��&*#zĮG�	@�)R<��>�O���®	��+�3���i��@CP��	�j��)B�8L�:�[(�EɆ�)�՝�g�}5�A"�"6uE43�7[�<Ɍ�c����bdl
2��˟��y2����)(�"H_�Q6@2�>W�cK���� �u�ރ�>A���!�} �V�o.>���~��1xQ��<������g��c����$\Ax�ұ)��;<��nPi(�R�Y���ҺOoCC{hj�ѐƝZ &U������?Z[��y�����d-ttr��;Eĳ]mZ(d4b[w���5s��tM'ϗF#�0��5F��L�C�k6LH@���}�d,:�C�_X^Mb�0}�Ɣ�@85����l5!ic*�]릉j��B�En(����^����$x�#;��H���nP5E��y���g�h��[��-S�r}c�p�*9@�����i	�Ix>�d՗Qhc:=0��q>���H���LR��Y��+�%"3&�A����;�wj��:���.L[B!��Zn�s�He��yYD����4����!�3��ɹ�dKi���L�\�!�	m9���zC6��5����4�;�)|6/>hh�m�Ǣ1P����-ds���D�o�m;A�8�N_pV�Qf׊p�C8�e&���6L�7|�쫿�?%V��m��J��/ �~D�OZ��&H�R�ɖ�N���a<E�.�MG�5wa*�{�ֳ�c�h!^�8ws,�� ������a���p.T!���@���xWRV��j�BA>��&_<3Õ��:��4�_V0��3p�T��z��KVn�ƿV0���E2����=�$WX|ξ��۸�ľ5�j�^��T�� ���5�\WȒ����j�0���+'�8����A��L_CE:?����=GO��o P�zu�$��'B�O����#[��|�1Gj�o!�(���B�i�b%��������"��}mI��U~�[�c\�f[LR���FFax�Ϊ�ٺ����}%�.,��}T��k�䏌=��*y�0�ŗ�E�Kw"Wf��#���.}���t9��L���I�G�����fO�7k��YĲN���5�=2>sg�^��ȹI����AEY{=�%xʸ��`>C��%0B�M\zC/���P�T�鹕�����v[sg�%�"c����,�dF����"���8hUВ�"kC.}��q'���kK�|���d��Mx��R˶���̄06Qc�(,�d��K��l���"�o�����S����a�p=#�E�+}m�rq��� �����y;h}��~��ӵ�S���!�s���օ"�z�=��C�"~�w��V%�?�攥A��ʮtE"{�صa�E8t)%�%.ٳ�zऒ}G�9?�[%��UCK�P�#"��;:�2�*۪�pt*��M�Y�F��xhQ	Ԡ��=l8Hyf�<YpcB��k��3m��	v��rϾ��2���r[�P�6��?�>-X?�[��oE$����~�}(!�S�SjĤ!�?.���j*?���z��定/��f?<�5��8��os��K����N����9�5ق2�lh}�_�����~�ķX�B�@6�u��T%⊣}h�0�NIU�7�#$�AD~��Έ�(�~��G�{}��Y0���E��Eƫ��a��r��� �uYTH=Izܷu	�lt
#u��֛;^R�8���$��R����M�������u��&         [   x�MϹ0C����!��%�ϑ4����g���@����!��io� 1�#���4���z/�D6�`"t���h^*_���Z��Z�t!*�      "      x�%��1�PL�B���%��t��,(

�Ld���(��gԃ��"5T!7c�z�Z�������kBa�_2���rߥ�)�):b��
<c������m*��U�9��!���         l  x��Uێ�0|���?@�[�oh� ��'^��]���%vV|>�vo�8�������93cFw���Y����2c���W��񤞭�oz�on\NAy���'7j��Վ�ޑ��0{"��W㼕blG��	[g�=|���Q���AOxp��5p
D][�bB�G�oz:�Y]�Kb����<����쮌�Q��c���g�4b����Fi�՜��� �q����]O"Y7�n@��@�y�R7����8��U �V/K�SS0��g�[���!� ��$��>iX�����5V!�O�.I;��'����f1y�LZ����^���W/�4hu\ �]+�4s�k#��1�jR&��*k��ēN���(��2�X����'8��^�>��5�n�f��ʋF��&2�8�M|Y���/�?�� K�{T�U���z]�B��<����
\HjTzV���eċK�['�T�U3_ �YT:ąV�gu���0>�/�P\�Z��#C����W��?7��1�&e}�P�hk��x̄�j�g����G��̗�k��׹�H��3C��X�np�h�Iw�x3��l�Q�ޮ�Q 5+(.C���|a�C�9i�Q�V�ϼ7��yX ��)fq	�}=�?�>):�����ٜ�o5e�[�!��hE{��N� �ߠ%��-�B�u�e�h�'8�x�վ7��5X�g2�Iq�luK�lA����w�7v�#�����+�lֆ��S������w��������_���诿`S�'t/dEyۊnB�=R��i[��r�n@H�Ǌ���\R���� W�CŠ��3݀$�C�jR�i߀�h)���TD�����AH�X�_>^w��M#��~V��贷            x��|Y��H��3�W��J����C=�<��}R�!�y6��7�9�i��f���j���\{��� �Y��8�G�Ҏ�j$
�ׅ~PO���b�B�,A����'���mc���=?;1���NA/�˪��Lf<�����f۵�l# ���c>qv�a�<���?��(��E	��(�D,0��G����a��1�M`v�y =����VV�Gb���º�zǞm�C%�LO3_ݘEZ��f�"�D�O�0�ϰ'h�F$/iR/m\!nJ��v�(A��x�U ESP��5m漷Hxe*ޛz#�2{�q�����<N��I��6N�}��ۭ�ܼ��'XJ�E2b`��Rtd�}��#��S6i
J�l� h�y�N�,� �*
_��G�.���w���H�h�Z��&U�,P�Z��=S�q��>����Y��>X�%H]0:�u�6�ة�������a܅���-�4L��]V���ߥ�c)Rr������Y����(��n�G�X�h�<1"���@%�<��!����=C7i5Z�H�z��:�����vYw�!�q�d�g����s�X�dW%�O�A�j�^��9�F���9�o.�>^;i���3T��PY
'>xd��eb��*;S�G`�mVVY:�>��N�O\qt��r�o{�P��<�K4m��T���:�g>f���\�,m�������1�8��?p1@�0F�S��?H'y�v�h��DD��S�`��>�t%��(��V�J�Z���w��Z�S�%J̲+xB��=���4ΰ��#B����!���·#d◐Vx�?��h������eƆ>o����Y�<):B�/���p�(g|Qj��Nl�s�P�?8�R4���N gۍ��� Wx��=�fA
���������:Wo�μyx�,Q¶�@���tװ�)6[Ȋ��כ�.w���g����y2	N!bc��L² Ϧ�~D%}xN�����3B��S�&8���Dœ���Y���rv����.�K�o�Za����/���2Ac��hD�+ЏD�+ĵ!�2E/�]Ǡ����(�^��O}��J`U׋��8.�Pݙ�YO�թ[�-���K\��ꉈ�÷��(F�,F~�� �]z#�N/Y�)2�=�\�� !�#�����_zN^��Δ�V<����Xhd��R��h�������r��v��뇿d�g��a,�s�^�
��Շu0�AH��$�ݵ!��|��͞/�"��t���C� ՠN�MP�#��5��R�������v�F.���gl�Cq��	H�� 2!(�j��boH\W�,A]O`�F��)A�� �Ӎ��Y~��1�8�->�6S���V�z���U������d��2����{��h��?�Kt$�Ps��뫚8��x0�N�x�ߘ<�b�`����M��2CA���v$�<�g��w���zj쯳��F�O�4d4GV�=Z���Uf7R٤hBF���OH���ZS��:-8^T2w�T�!�)���z+�k���I.�{�J~��B��!�(IaE}$�r��}f�2�/��$I�����:vJE�/�[������mC�F�q�r���Ji�e��ڭ��zM��H�߸�I��?
��6��A�5q��d�2Ť��(�*4��� W���q7s'
�a���|���"s�{��5�|r����B=L�}�@�Ϩ��#>�o
�(�o	c�F���&Pe4��x��4z+d�e�����C�Q���;ܼ�DF�
�2���	�^��/�@9����dn߷7�6Hjg�EmYC��~�Y�<�t�?yjR�s��&a�� e%�TP�vww#��f�Z����6���G���$�A�� *��Y����cڨה��li_�0�쳪~fT�ˮ+>sOM��.�D�Ƨ5s�=�u��*˫�|��yg��s�oS�2P�P��=��
k(v����F�����P}~����T�r�꽰Tg�r1�/]��l[U���.fk,��1�3��I�/�gyj�N�td�!��p�H ҲDv]��ҚfO��yJh�$�4k}H5�j'�j�Ō[}ï���~�O�
!�����D�$͑�AB.�*5A� ��i^`lVa��h�q5H��~�Hc�*qOc���k��6�x��rc)�?��m&�6�)�1^�%�����<AA9M�4�A��ǐ���g�H`x��xq�r^̇h%g6�։<5m�U��qP��
�%��'--���!��C����K��hm�ك�E�Um�����'+���I�L��7j_�i&ǳ��p�}:˘�)�J~Z�g��)k=w��^lU?O��]�r<Y����IX�Me������^�ppJ0�ϡYݲ.5W��t��������I�u��&����M�|p���%�`��~@#KP��`h��V�
 ?+ݻ������v�OB��ͻT@��~�ŉ�ew5�k{"���Q��)��D�ޗvr�7A!-��ޞ�1���� "��,�F3ȰY��a��AX������x:=A���A�z�;k���ak6ђ[4�9�w�n]��&lr��g'ƄE�}�,�,��{冪�ن4Гԣ�QHm$�ySz�$ q��)�����:������+�|��`�)�Zpy,�O�L���U1�����<�p,y�-�XPZ�u�u�4���V�<�`;��L�$�ׅ�^���n+�-ӻ����^3,_Kԋ��#�q(N1K~P2��Ǧ����@��O���1�)�E
�Gb�,��7�樷��o��n6f�]y[���h�1�QA�6�r(M@}H}P8b���Gj�)b�q~\�4�|���W%��N���Bo��,`�w������V-�tG���\�L�v�j�P�h����������1{�<���Ah@��� �oK<���F�������O��j^�Vv`�抎��l5ٹE��G�i�G	��(��"�i�A�1�@��V+�
�IgC>�>����Ǟ����ޏs|������t����Ո�%u�	q��A�8����(��P��
�-jR��H���zPʾ�K[]���.���j^�+.̮��`�|7uO��X��$�?�!~+N��]7Ib(���|P4�4n��`��3ZY�bAB+��M׏�����f�Ul&��cs���8/��6U��*�#��Ơ�HdZ�����QKA��1ۢ#q���\(1���;��Жg ��G�<��-���/�jC�������i͹���
ul���v�a�m�%���3k��A�As�A�Ўgt4�Z#횡���1�ު�3P�Sz�&g����C�,Et��M��4ZW�.<�-����+3�����s�y;TI���4�Aq�(g��`p^J��pK�������]��W�\������n*��E�R?Mb��1j��ײ�j_ed�+� ��<"���!�ۣ����\��O��Zxr/�I�g;�f2{g��XK�,��6��7av&7.�-�E���nP�� � yzM�����5M��C��үHM�����*�G/緡gZ}��W���ʏɰ!ќ�U+�Ƈ���L��Y _�(��Nڇ�u�?^*�� �]���*���x���=HJ��Oہ��S���E]�x:MdV��9����o{���!^�v��$���e��e�?��S�d�V�F�P�R���£�������Q�}���Ӽ�2��v"n�2�?�Wu��Up��E�9���t�΅�RA���c�(���IDz(�*�����W�Cj�[�5�|���No��F\oB{r�{�x���$!)��G��&��S<����V��ޟ�	<�'ar ���������$�R���*)<Q\����B�i��j}�J#�z.�Vŏ�;i��Y�|e��~�)�[���!�\fS��b
�P�#����E����9������ʾ�T䚲��}͋���9�M��8����V;b���(˛W�F��BDE�<�Q<�l��/u[ߑ
Z��F��Q�    &��Ӊ��ѳ�jVww�J�h�҉9�p$���v�G[]�N���JR�\��W..���9%z�0N`V�/�ry(\�鿫����L��bMb�]v�E܊rtq��j��>��|Ĭ�t|NC�pnW��VH����@v�� ٖ�Bxz� @�WA��j��e߂��6���M[��p�v�^M�+�ʣ��A+c��	��K/$�bG��M���l��	�\ʡ�7�W�`̺�ɹ/��Y�r�٦{���UG.Z6R��ֆ��D�/��G�,��^�.����@XPw����0�a���6��>��������X[e���33�镽�����o�dcl�o.(A����������#Ii����b���Fb�[	�k�L	��ܟNN��B�j[%��re��@����Jֻ�/�on�h�c�m�g]ּ��)���O�CB��4����a8m������ >Z�$����6�H��%	Z�F2/� :9�}Q6	JkEq�>tj@�.��$i����>hYfCD�\D���&�Cg���_��4���?�-h���$���}�S�ǷR�b{y)�Bs��_�aI�Ǹ{H�6�`Z�=�T��m˟�~lqj�G_�u���*��������>MI���&�/%��u�ͱ0�|�	�)��IĨA@f��֣���r�o��k�ߌ���XJ55�}>W6�7e{=�Y+�Ķ�<��fv������
�a�1dg�I�����A�ڿJS/l�nv�P�9m�m-3��:ݱ�Q���~6��"ST�~��g�/����A�!ѿ�5�i��j��Եӯ.&ȗ�v>3�f�S>oRX�[i��;�
ڜ�X��.�ɞK���b�zq��H�H���)�0g��?Z�(R���o��@ֲ����e+W�pz>�͙<ݜ��@6�-}��Ƥ��n�{��b��M�l����7�N�CsC�'q���D	�δ_�042 ��n�!G?�~��A�0�/��/8cs�n*e��s7=m6���].�Υ������[��nM�s�pR�o���(��?���\���~j�]��$���ܓf�R���ћ�P��F�F-��d��D���0�l	�?i|9�H��b��r���X��`(仝
�؆>.�ˢ��`�n S<\����|��g�zڞ�hޖ������O��r���طX@�=zY�����۬�[��0�"�c w�����h�]�E��������櫵�u����,(�12T9{���c�;���b�Kc|	�T�����}s����Af����QCi�DlwPڿ��S Ҟ�}�y���q&�|F����ZV�S�Y�/)�k��c��9?[I�%�_�x�X�J�
���#_y9C�ޮ�I�1��d�,��b��P]"�a�
�.Q�g���i�Q��o��&ח���O�(���7�!�P��@a�A���C.{C����~��׆.�|�\OU�ٻ��F E���z'שٲ�.�1�������]�T3T�?�ďz�`u`~.�`����0�ך-]�`(������L���4nq��%� �g�w���P�bX��`�F�rX:�h���$=
���I���s�E�&�k�-���&>��żYϏ�J\O��T3җEÞ*�$l/6�ϴwYBc���Gv��{;4)����~�г�1��~}~~Wӟō�M�w���97�xZh-�@�$���WYݭ�Ba����qv1��>>����@�Je�"�a�G�ط'W �aZ=ڡ-�$��1W��\�Ԫ��;ݳ[�d��Xnͥ\ݷ>����$��o��	�C���$b�C�FF�����0ASM�_��W���d���ȏW�u����Ss8Q@��ǽ!��D^�mQ��1��`�u��o��'X,�a�K!�]4�نC?��Z|@�q��B�H�/	�Z�y�'K�.���"ؕ@��������=ؤ�:�)s���j����_�g��7H#z��2�˒0��g��Y�OPz}�>/}��qD�rp��[�(a�Ęf��6� ��Ӫ���2����ƾ�R��o-�'T4E,��2�<��a�g�u�a!�������G9"��'X��A]s��J'��y��;PqcG���Kh�T�:*?�v�kQ�$��n�����xa���Mҏ��������t������
��X����V���H�ˍ�̢ؖ���}���aǨ�d��M �w)�28#�o?r(G`��.�,��{:������u4|r�mL"�?/�����1��4���&�������]��^��v�1[�qs뢕$���/]��D �=|�$���	#�	R���0���jR6i��V�3W�b�ª>=-���S�\������a��orL���u!x��LFA�����a�I&��}��p8��?L��9~�����������=�_�SL��//��qѨ4��z��UR0�s07}p�ߠ�)�?���<��G�zR��?z�gb����u�Gjc�J��6������z��4�m�R��n�K��G�]��q,��G<��W|5��N�8 � �p`��K���]g��aR��d6�+-�K���]��~5�W�����\p�۸h��*�� ���/�q:�w����gj{�� [�Ӕ�+٢^��y�=�z_���ǧ-�{(X����ؖ��%�2$�s�2)DΚ�NA�݅C�Aq|7�!s��P��g癕vDPR��Xj��~h��财�iPtÝ�K��1�rX��w5"��E�8����}�e�����7j�hB'��+x���W/�9Z?S1�'�dC�T#�y�P��m��⁞O��|����;-ɹ�6�2(E,#�A�&���я��f�&�J/����%ޞ==+ȴ^��\��V�r�X5����}���խ�\V�.���� ���>4���)$/&&��7���0<	�Cm��ӕ*7�p9��.�u�ֺr^�ysS��1�8r��ݾ���z���J(������U�y�e��Cv����)zТ 5cX���0M S�s�Z�sG_��z�-����;N��h��"6�3m5�3�U]�v��J� ������#����r�ՆVi�S�|[ܧ����\�G��a]I5>�� ��-���R���J��G:&�q�Fn��]B�M�8��cЏ��ag�K�f%�C�L���j��𥋵e��r�g��b�62CAP?�殗.��:nM�S�P��ܵ�_g~��ƛ&	�������m'�w�9(ah>�:|yh��as���3s����J��2--��?�<��'���r"��,�Q.��Iw����LЄC���<���(=����_͘���w��S��5w�s��o��!�i�91kj��P3hEz�yz����s;oYh�	�g��A����C#B�IU�"ׇd�|M<{�*��ץI���z�җ˭�r��/����y"f��tg.Ȭd��»Ur���3<�����ˡ�s�Ł)�{4�����؎~o<ŨsZ0e�

E��Р���+��PԿE�^��q0=�����(����t�hx�4�}����G�a��(����p����=�lثCC	�������	�����iO���ϼ��d&Ώ_��:���:M����na
��Ͻ�|�_T�hJ��Ѱ�5,�=I�)ۭ����߹ج�t���}��.��.+:4͓U��"�מ�@�-o�Ed`�����&Aaj�@�`���v�
��}�'��#��W�V��&�}?�ih6�o�Rc�I]�M����Hf1VR:y��)h�Y�'���4g���6=b��IT:�P 	�A�{���/�6�=le\æ����M��u�O��d7w���X�\>�wi��(�����1+�����c:,���l�eY��FJ�\]o�΅�i�_�"wl����Ǜ�I��M�ܧ9�YF|	���w�(���8��
�O�Mb�U9~d�0('�w8��D=�A��2�M�.:Z�7�d��.Sq����А�B󣵛z�����
E��O����7�e4-�����F'�
ʁt\��
    �u�W�Ra���J��!_��=u&̔��Nm�v��f�n��h��`�1h�Z�#*�a���$�~��^���)�Z-��nA6�ni^U���6>�����O���ya�j����!6��`���3�wJ"��S5�>�G�����-�Sx�U8Lh<W5����|}�R�	���P|�O5�'���
�ͷ�q��߮�S��C�K0�pW�pl�Y��
)��#�}2��~�_3�/��U�[.���eq����=��=�Vmq#n3kzm� Ks�q�ߣ�K�$�ш�~Uo7v��{��\Տ���S6�^�k7K��L��ֹ�U�I㚂�\��k�]&�Bk�{�\yju����)���İa�c�i�5�����C���Q6���eu�æ��_�1�1�aѬu6���)[�H��
۪Z�l�L�*s|QZƒՈU�zn������k1�ղ�<4�w�i�
��=$����p�es���];%�"��aR�K�[l���N�����g��>�
x�נ��xbQ�Az����܈�@�4��|:���۳�dB�D��X�ǚ���y�oc-ũ׭YD��0�`G�m�(h�v���1�e�����	+�vՒ��%�/n����vU���}�����-�o�IyX�����mf�1ot�A��c�<hl�;�f ���G`���{6�e��SI���y��En�rӈ�&c3[Ջ�"Ω���f���~��»J����fq��pG��|��Q�e�5��M��l�N ,��x��؏LU��MMqس�2V�#�,��ؘɸaR����=')H�(�s�����nX�y��ϯ��瓪�"_�&�Ҭ!�K�=���7AK�+#��n2�^Ɲ(Hd�W���_����q8	�,�F"��r�t0�c?'�CϞd�$@!�=W�2�-�7&��zK�Ʊµx��m������V����<̖�q�ĕp=��>����<�S���3�K{4��B⦅J{�.�������������j~��j٨s;�E�h*qUْۥ����'ҳc+Yu���R���Z�,E�K#�c�i$gw�#�)�a�7����@uVU��������]�6�t+��&�1�f���¸0������/���*�?��?��kΑ�o0���氋�u�O�@���ьG�.xٱukv-欐�'�se�p,����+�Ԅ������7�UJ����j����s�*!6�������W4L�i���0�1��s��i�;�:�3���VXq�	��mbH�:��1�G���ho�����Cf�nF���.̕`��˃{�u�������VW�z�NDS%�M��빜���p�o�Lb����N�<����@�b7� �r�z�m�����F�rZsr����f3w3l�1'&�Y�>*g��H""��1�������k��Q�����Ν=X_f����HY7-��\��(�q&�g�o��|<�ء��{U	�-揄a�t�BTo+������y �^u_y���|Q�0�i�<������B+@���c8�rs�K`����)������l��o�Rp����^��O=N�s��0�"�i⠣9T�.�W�ה��A\N������g��8�b]z���?��.�5q!���f`�|ƨ�GQ}��`��[�]��K|�t%HD��a���L׬������sM#b��i��z�-��X�3T��+�i��L?�,Y��6�"[`a�v#�ƿ�c��P�	��m`�Dr��?~F��񹝗�s��7G���G-U�Kw��C&j��d 2�,~��-�+�Yϼ}���hj�LX�ׯϯ�:s��`�r#0�� ���<�㧣��}��Kq����d��(g��8m�n�{��_��w�qn��%��À�9����}}�#�F��[ڐ<��8���K���R�0F�Um��"�����c��Q���@��Ƨ�$���ZN��I�;.)�|�現�|9�`C|�03����MΪa�e� �����s�zյ�*���Pm�NU�P浡���i���+�7�r&ޭ�����7��˅�|�˄����/@5��ko9D�p�c�]x�'��j���w�z}(]�ژ�F�:av�D \�j�����/����
����M!'o_)��434=q��ȢF��Z�2D�A�ALne���Xyq��ceJ���g��Q���M��Ks�A�Te����$�� �����$���ľ��K�$��! ����&�>��n�T�P� 7zR�g�22Ψ�$��
ӪN'�Q.�q1�����`q�2��]����N�0��8"d1tMb3k� w����-�>����7�n�͚�;�̪������t҈���k\��+z�ҟJ����u~��P��)�I 3hP����c��`���y�D�.�'�W*Q�eZe`���6��j|ٗ�Q�ͥ�#Ԏg�e����'��b��7�H�SA��1�q�G���������g��O�Kw��ԣ1%ӵ�isOJ��{�tb6W�wM�(́g嘵��m����{<I�;͠�@�N'_l���mz4X�ъO��+��k�*I�^!�̩�\����̻��i����r���b���c�1*�94� ��?����Ɂ�4�%'+�]�x�h�3��꠰^-T��f,M����W���u��	�a$7�.Q�
��N��v4�)|^0}����A����� ��`�;���gsm[Q6[J�
Qs��0]�չrN����ݝJ���+���82�e_o"��φ�G�'F<�t���.1���ϒ�zk�6iVB۬]-�j�sUn���F����A���p��m�à$ǒ��8�K�-A9���*��&�~M{����gB��<?;���ζ��6�i��&�zD:�u��+ؔ��{�NU�U������2�#,��Bq��Êm�$��_�-�3z�[-q��b:��Ľo��]���q�_Ez�T&Z������_?��t�P��Ga���P�>�z�v��_�>J񔂎��]��ug,�8�KM�t&6�m��Ϻx�M�5�nH��2��G��$�<�����|�HA ����0���M�&Ξ�jf5-f���s�i��(E�1mPm���r�0cK���N����:�85(kj(�߆!�_�͸��0>$��şg���9a�W����[:OW�6�k���m��s�r�����P��)��k�4��8��<DF�n���)��>&".�����m9��ml��mi�)���}�l�����[w���P��n;�
�̻�z�8O��}R�:�lXӋ�P�p<�!3��: ��^Gz�T��5O��~[��gԝr-�������F�SLXW|��Ό�so��<L�$M��H�cy�y7�N�j�f���K��9p�ƗgJ��nئ u}#�r�K������K�#��ݓ�����In��� �>�e���kG��G�㱢�]����%|���*ѻ�7.���J�ӻ��5���OKi^�\n�@��r�e��<�F�������A�J�񽊀� F#��ô�o�?u�s\L�As\
T���� ���fS=��Y�:�yJ
���ث��q��o�!������g�Ս����Ti7OҾf�L.�����}��6�E7��v��~"��*�9aZ��
s�_�:���h� ��Э	_M���%
xj� �_���a�ƪ�0�Z�ڑX�����f<��}�����GMWꄴ����F�)��
�Ɛ������;`Î���������(��M���޸��&�Ԭ���jw3�#V���ow��2���|@�0�~@¿�0�g�C�8��"�i�����w��
��u�%�����J�x��Q���Ş��&tkR��٭)DN����_;�T;�w�Ԥ���Q�'���4��!(K0�dY	๕5�����`�_Ox�
�Vg��HG�`�)�d�ƛ��~�ά{�\��5���l5��9i >���!��D;�@E"��ӣ_]D�a߲A��01=N��Oe���%#q���s+\S�Jq��E!�R���@��bI�Rv],�~l�\;�F�
�?�ׄ8�݈�.¾n:R�   5ô|g�S誯�d�����N�Z+S�L5��+���6)/�O�)h�`��iD5$����H�A�����q�'�8;#��:�l�P79��Cs7�鉼�^V����Y��I��i�`��r�����a���r��?F=��r�08UO�G��͆��/X�c�,�<+L��i�p�!�ΛT��+���JY`%���7s�s����ZK��ń! ���*����9���ˀv͝v�Ͻz�B�-3?7���������Ta�.�26_t��ݶ�Р�f9f(���~-O��
z�!�!�~�������I����')tA�����t����7����c�D�#b��Yy==˘Oпײ���8=��hf��4��lg(�-���<���0 7b$0P�[��y�(��&�b�<nsޝ{m#&�����D%rw�z���"תm�X�oN�?0qC��s�3e/ߣ��/�$���;''�R�+��(i�^o�&TTEc&5�8����CC���ՙ�����p�v��?����P�W�     