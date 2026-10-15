-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_poll_response labpkl_poll_response_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_poll_response labpkl_poll_response_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_poll_response
    ADD CONSTRAINT labpkl_poll_response_id PRIMARY KEY (poll_response_id);


--
