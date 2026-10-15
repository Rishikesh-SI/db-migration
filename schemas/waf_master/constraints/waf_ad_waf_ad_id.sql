-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ad waf_ad_id
-- Type: CONSTRAINT

-- Name: waf_ad waf_ad_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_ad
    ADD CONSTRAINT waf_ad_id PRIMARY KEY (ad_id);


--
