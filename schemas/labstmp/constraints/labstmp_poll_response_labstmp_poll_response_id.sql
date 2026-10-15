-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_poll_response labstmp_poll_response_id
-- Type: CONSTRAINT

-- Name: labstmp_poll_response labstmp_poll_response_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_poll_response
    ADD CONSTRAINT labstmp_poll_response_id PRIMARY KEY (poll_response_id);


--
