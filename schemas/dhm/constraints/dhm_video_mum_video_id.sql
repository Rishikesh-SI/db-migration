-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_video mum_video_id
-- Type: CONSTRAINT

-- Name: dhm_video mum_video_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_video
    ADD CONSTRAINT mum_video_id PRIMARY KEY (video_id);


--
