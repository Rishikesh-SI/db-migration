-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_poll_response labwpl_poll_response_id
-- Type: CONSTRAINT

-- Name: labwpl_poll_response labwpl_poll_response_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_poll_response
    ADD CONSTRAINT labwpl_poll_response_id PRIMARY KEY (poll_response_id);


--
