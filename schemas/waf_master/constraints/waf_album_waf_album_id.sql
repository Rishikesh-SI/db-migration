-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_album waf_album_id
-- Type: CONSTRAINT

-- Name: waf_album waf_album_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_album
    ADD CONSTRAINT waf_album_id PRIMARY KEY (album_id);


--
