-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_video pcm_video_id
-- Type: CONSTRAINT

-- Name: pcm_video pcm_video_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_video
    ADD CONSTRAINT pcm_video_id PRIMARY KEY (video_id);


--
