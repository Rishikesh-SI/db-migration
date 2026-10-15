-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_video waf_video_id
-- Type: CONSTRAINT

-- Name: waf_video waf_video_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_video
    ADD CONSTRAINT waf_video_id PRIMARY KEY (video_id);


--
