-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_poll_response labwf_poll_response_id
-- Type: CONSTRAINT

-- Name: labwf_poll_response labwf_poll_response_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_poll_response
    ADD CONSTRAINT labwf_poll_response_id PRIMARY KEY (poll_response_id);


--
