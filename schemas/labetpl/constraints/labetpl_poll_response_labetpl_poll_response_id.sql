-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_poll_response labetpl_poll_response_id
-- Type: CONSTRAINT

-- Name: labetpl_poll_response labetpl_poll_response_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_poll_response
    ADD CONSTRAINT labetpl_poll_response_id PRIMARY KEY (poll_response_id);


--
