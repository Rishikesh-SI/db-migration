-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: wp_comments
-- Type: TABLE

-- Name: wp_comments; Type: TABLE; Schema: gsf; Owner: -
--

CREATE TABLE gsf.wp_comments (
    comment_id bigint NOT NULL,
    comment_post_id bigint,
    comment_author text,
    comment_author_email character varying(100),
    comment_author_url character varying(200),
    comment_author_ip character varying(100),
    comment_date date,
    comment_date_gmt date,
    comment_content text,
    comment_karma integer,
    comment_approved character varying(20),
    comment_agent character varying(255),
    comment_type character varying(20),
    comment_parent bigint,
    user_id bigint
);


--
