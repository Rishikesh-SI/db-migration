-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: wp_posts
-- Type: TABLE

-- Name: wp_posts; Type: TABLE; Schema: elms; Owner: -
--

CREATE TABLE elms.wp_posts (
    post_id bigint NOT NULL,
    post_author bigint,
    post_date date,
    post_date_gmt date,
    post_content text,
    post_title text,
    post_excerpt text,
    post_status character varying(20),
    comment_status character varying(20),
    ping_status character varying(20),
    post_password character varying(255),
    post_name character varying(200),
    to_ping text,
    pinged text,
    post_modified date,
    post_modified_gmt date,
    post_content_filtered text,
    post_parent bigint,
    guid character varying(255),
    menu_order integer,
    post_type character varying(20),
    post_mime_type character varying(100),
    comment_count bigint,
    post_shortcodes character varying(4000)
);


--
