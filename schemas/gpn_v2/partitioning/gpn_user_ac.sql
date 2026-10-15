-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_user_ac
-- Type: TABLE ATTACH

-- Name: gpn_user_ac; Type: TABLE ATTACH; Schema: gpn_v2; Owner: -
--

ALTER TABLE ONLY gpn_v2.gpn_user ATTACH PARTITION gpn_v2.gpn_user_ac FOR VALUES FROM ('28') TO ('31');


--
