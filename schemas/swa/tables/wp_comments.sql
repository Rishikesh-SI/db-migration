-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: wp_comments
-- Type: TABLE

-- Name: wp_comments; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.wp_comments (
    "comment_ID" bigint DEFAULT nextval('swa."wp_comments_comment_ID_seq"'::regclass) NOT NULL,
    "comment_post_ID" bigint NOT NULL,
    comment_author text NOT NULL,
    comment_author_email character varying(100) NOT NULL,
    comment_author_url character varying(200) NOT NULL,
    "comment_author_IP" character varying(100) NOT NULL,
    comment_date date NOT NULL,
    comment_date_gmt date NOT NULL,
    comment_content text NOT NULL,
    comment_karma integer NOT NULL,
    comment_approved character varying(20) NOT NULL,
    comment_agent character varying(255) NOT NULL,
    comment_type character varying(20) NOT NULL,
    comment_parent bigint NOT NULL,
    user_id bigint NOT NULL
);


--
