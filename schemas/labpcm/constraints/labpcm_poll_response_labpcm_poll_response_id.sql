-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_poll_response labpcm_poll_response_id
-- Type: CONSTRAINT

-- Name: labpcm_poll_response labpcm_poll_response_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_poll_response
    ADD CONSTRAINT labpcm_poll_response_id PRIMARY KEY (poll_response_id);


--
