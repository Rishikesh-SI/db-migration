-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_image waf_image_id
-- Type: CONSTRAINT

-- Name: waf_image waf_image_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_image
    ADD CONSTRAINT waf_image_id PRIMARY KEY (image_id);


--
