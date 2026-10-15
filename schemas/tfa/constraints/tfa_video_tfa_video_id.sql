-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_video tfa_video_id
-- Type: CONSTRAINT

-- Name: tfa_video tfa_video_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_video
    ADD CONSTRAINT tfa_video_id PRIMARY KEY (video_id);


--
