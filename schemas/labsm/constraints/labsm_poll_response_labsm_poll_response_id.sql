-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_poll_response labsm_poll_response_id
-- Type: CONSTRAINT

-- Name: labsm_poll_response labsm_poll_response_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_poll_response
    ADD CONSTRAINT labsm_poll_response_id PRIMARY KEY (poll_response_id);


--
