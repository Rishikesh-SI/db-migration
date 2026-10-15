-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_poll_response labgt_poll_response_id
-- Type: CONSTRAINT

-- Name: labgt_poll_response labgt_poll_response_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_poll_response
    ADD CONSTRAINT labgt_poll_response_id PRIMARY KEY (poll_response_id);


--
