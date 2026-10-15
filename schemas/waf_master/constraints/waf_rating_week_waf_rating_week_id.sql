-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_rating_week waf_rating_week_id
-- Type: CONSTRAINT

-- Name: waf_rating_week waf_rating_week_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_rating_week
    ADD CONSTRAINT waf_rating_week_id PRIMARY KEY (rating_week_id);


--
