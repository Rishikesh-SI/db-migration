-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_rating_week pcm_rating_week_id
-- Type: CONSTRAINT

-- Name: pcm_rating_week pcm_rating_week_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_rating_week
    ADD CONSTRAINT pcm_rating_week_id PRIMARY KEY (rating_week_id);


--
