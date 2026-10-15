-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_poll labpcm_poll_id
-- Type: CONSTRAINT

-- Name: labpcm_poll labpcm_poll_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_poll
    ADD CONSTRAINT labpcm_poll_id PRIMARY KEY (poll_id);


--
