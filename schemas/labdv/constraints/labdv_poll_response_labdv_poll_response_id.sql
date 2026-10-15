-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_poll_response labdv_poll_response_id
-- Type: CONSTRAINT

-- Name: labdv_poll_response labdv_poll_response_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_poll_response
    ADD CONSTRAINT labdv_poll_response_id PRIMARY KEY (poll_response_id);


--
