-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_poll_response labrs_poll_response_id
-- Type: CONSTRAINT

-- Name: labrs_poll_response labrs_poll_response_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_poll_response
    ADD CONSTRAINT labrs_poll_response_id PRIMARY KEY (poll_response_id);


--
