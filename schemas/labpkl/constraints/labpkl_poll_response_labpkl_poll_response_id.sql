-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_poll_response labpkl_poll_response_id
-- Type: CONSTRAINT

-- Name: labpkl_poll_response labpkl_poll_response_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_poll_response
    ADD CONSTRAINT labpkl_poll_response_id PRIMARY KEY (poll_response_id);


--
