-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_album pcm_album_id
-- Type: CONSTRAINT

-- Name: pcm_album pcm_album_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_album
    ADD CONSTRAINT pcm_album_id PRIMARY KEY (album_id);


--
