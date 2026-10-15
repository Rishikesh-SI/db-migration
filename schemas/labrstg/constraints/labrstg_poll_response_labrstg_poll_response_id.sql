-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_poll_response labrstg_poll_response_id
-- Type: CONSTRAINT

-- Name: labrstg_poll_response labrstg_poll_response_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_poll_response
    ADD CONSTRAINT labrstg_poll_response_id PRIMARY KEY (poll_response_id);


--
