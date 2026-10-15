-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: brightcove_video uq_brightcove_video_id
-- Type: CONSTRAINT

-- Name: brightcove_video uq_brightcove_video_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brightcove_video
    ADD CONSTRAINT uq_brightcove_video_id UNIQUE (brightcove_video_id);


--
