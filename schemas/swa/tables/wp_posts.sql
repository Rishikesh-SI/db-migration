-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_posts
-- Type: TABLE

-- Name: wp_posts; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_posts (
    post_id bigint DEFAULT nextval('swa."wp_posts_ID_seq"'::regclass) NOT NULL,
    post_author bigint NOT NULL,
    post_date date NOT NULL,
    post_date_gmt date NOT NULL,
    post_content text NOT NULL,
    post_title text NOT NULL,
    post_excerpt text NOT NULL,
    post_status character varying(20) NOT NULL,
    comment_status character varying(20) NOT NULL,
    ping_status character varying(20) NOT NULL,
    post_password character varying(255) NOT NULL,
    post_name character varying(200) NOT NULL,
    to_ping text NOT NULL,
    pinged text NOT NULL,
    post_modified date NOT NULL,
    post_modified_gmt date NOT NULL,
    post_content_filtered text NOT NULL,
    post_parent bigint NOT NULL,
    guid character varying(255) NOT NULL,
    menu_order integer NOT NULL,
    post_type character varying(20) NOT NULL,
    post_mime_type character varying(100) NOT NULL,
    comment_count bigint NOT NULL,
    post_shortcodes character varying(4000)
);


--
