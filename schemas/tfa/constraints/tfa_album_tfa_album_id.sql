-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_album tfa_album_id
-- Type: CONSTRAINT

-- Name: tfa_album tfa_album_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_album
    ADD CONSTRAINT tfa_album_id PRIMARY KEY (album_id);


--
